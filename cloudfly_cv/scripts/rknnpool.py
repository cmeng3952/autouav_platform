import time
import numpy as np
import queue
import threading
import cv2
from rknnlite.api import RKNNLite
from config import Config as cfg
from utils import *
from detection_utils import *

#预处理线程
class PreprocessWorker(threading.Thread):
    def __init__(self, in_queue, out_queue,co_helper, img_size):
        super().__init__()
        self.daemon = True
        self.in_queue = in_queue
        self.out_queue = out_queue
        self.co_helper = co_helper
        self.img_size = img_size
        self.active = True
    def run(self):
        while self.active:
            try:
                frame, frame_id = self.in_queue.get(timeout=1)
                # 预处理
                img = self.co_helper.letter_box(im=frame, new_shape=(self.img_size[0], self.img_size[1]))
                img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
                img = np.ascontiguousarray(img[None, :, :, :])
                #此处 frame用于推理结果的可视化，img用于模型推理
                self.out_queue.put((frame, img, frame_id))
            except queue.Empty:
                continue

#模型推理线程
class NPUWorker(threading.Thread):
# 核心逻辑：
#    1、从input_queue中获取预处理后的图像帧
#    2、使用RKNNLite模型进行推理，得到推理结果
#    3、将推理结果放入output_queue中
# 核心功能：    
#    支持多核负载均衡，每个Worker绑定一个NPU核
    def __init__(self, model_path, in_queue, out_queue, frame_pool, core_mask):
        super().__init__()
        self.daemon = True # 线程设置为守护线程，主线程退出时自动退出
        # 初始化模型
        self.model = self._init_model(model_path, core_mask)
        self.core_mask = core_mask 
        self.in_queue = in_queue
        self.out_queue = out_queue
        self.frame_pool = frame_pool
        self.active = True  #控制线程是否继续运行的标注
    #加载RKNN模型并初始化运行环境
    def _init_model(self, path, core,retries=3):
        for i in range(retries):
            try:
                model = RKNNLite()
                if model.load_rknn(path)!= 0:
                    raise RuntimeError("Load RKNN failed")
                if model.init_runtime(core_mask=core, async_mode=True)!= 0:
                    raise RuntimeError("Init runtime failed")
                return model
            except Exception as e:
                if i == retries-1:
                    raise 
                print(f"Init failed, retrying... ({i+1}/{retries})")
                time.sleep(1)
    #线程主循环，持续从input_queue中读取帧进行推理
    def run(self):
        while self.active:
            try:
                frame, img,frame_id = self.in_queue.get(timeout=1) #设置超时
                outputs = self.model.inference(
                    inputs=[img],
                    data_format='nhwc',
                    inputs_pass_through=[0]
                ) 
                 # 传给后处理线程
                self.out_queue.put((frame, outputs, frame_id))       
            except queue.Empty:
                continue
            except Exception as e:
                print(f"[Worker] 推理错误: {e}")
                self.model = self._init_model(cfg.MODEL_PATH, self.core_mask)  # 重新初始化模型


#后处理线程
class PostprocessWorker(threading.Thread):
    def __init__(self, in_queue, out_queue, frame_pool,co_helper):
        super().__init__()
        self.daemon = True
        self.in_queue = in_queue
        self.out_queue = out_queue
        self.frame_pool = frame_pool
        self.co_helper = co_helper
        self.active = True

    def run(self):
        while self.active:
            try:
                frame, outputs, frame_id = self.in_queue.get(timeout=1)
                # 后处理
                boxes, classes, scores = yolov8_post_process(outputs)
                if boxes is not None:
                    boxes = self.co_helper.get_real_box(boxes)
                # 回收帧
                self.frame_pool.put(frame)
                # 输出结果
                self.out_queue.put((frame.copy(), boxes, classes, scores, frame_id))
            except queue.Empty:
                continue


         
#主要线程
class NPUOptimizedModel:
    def __init__(self, model_path, num_workers=3):
        #input_queue：主线程向工作线程发送帧的队列
        self.input_queue = queue.Queue(maxsize=10)
        #预处理线程向推理线程发送预处理后的帧的队列
        self.preprocess_queue = queue.Queue(maxsize=10)
        #推理线程向输出线程发送推理结果
        self.inference_queue = queue.Queue(maxsize=10)
        #output_queue：工作线程返回检测结果的队列
        self.output_queue = queue.Queue(maxsize=10)
        #frame_pool: 预分配帧缓存，避免频繁的内存申请释放，提升性能
        self.frame_pool = queue.Queue(maxsize=20)
        self.workers = [] #存储创建的NPU工作线程
        #通过 self.npu_cores 控制用哪些核(多核调度)
        self.npu_cores = [RKNNLite.NPU_CORE_0, RKNNLite.NPU_CORE_1, RKNNLite.NPU_CORE_2]
        num_workers = min(num_workers, len(self.npu_cores))
        # 预分配帧内存
        for _ in range(20):
            self.frame_pool.put(np.zeros((720, 1280, 3), dtype=np.uint8))
        
        self.co_helper = COCO_test_helper(enable_letter_box=True)

        #创建预处理线程
        self.preprocessor = PreprocessWorker(self.input_queue, self.preprocess_queue, self.co_helper,cfg.IMG_SIZE)
        self.preprocessor.start()
        
        # 创建推理线程：对于指定的num_workers，创建NPUWorker实例
        for core_id in self.npu_cores[:num_workers]:
            worker = NPUWorker(model_path, self.preprocess_queue, 
                             self.inference_queue, self.frame_pool, core_id)
            self.workers.append(worker)
            worker.start()

        # 创建后处理线程
        self.postprocessor = PostprocessWorker(self.inference_queue, self.output_queue, self.frame_pool,self.co_helper)
        self.postprocessor.start()
    #将传入的帧放入工作线程队列中进行推理
    def put_frame(self, frame):
        try:
            # 尝试从预分配池中获取一个空闲帧缓存
            pooled_frame = self.frame_pool.get_nowait()
            # 复制传入帧到该缓存中
            np.copyto(pooled_frame, frame)
            frame_id=time.time()# 使用时间戳作为帧ID
            try:
                #尝试将帧和帧ID放入input_queue
                self.input_queue.put_nowait((pooled_frame, frame_id))
            except queue.Full:
            # 如果 input_queue 已满，归还预分配的帧
                self.frame_pool.put(pooled_frame)
        except queue.Empty:
            # 当预分配池不足时，尝试直接放入复制的帧
            try: 
                self.input_queue.put_nowait((frame.copy(), time.time()))
            except queue.Full:
                pass  # 丢弃当前帧
    def get_result(self):
        try:
            #尝试从output_queue中获取一个检测结果
            result = self.output_queue.get_nowait()
            return result
        except queue.Empty:
            
            return None
    def stop(self):
        self.preprocessor.active = False
        self.preprocessor.join()

        for worker in self.workers:
            worker.active = False
            worker.join()

        self.postprocessor.active = False
        self.postprocessor.join()

        if hasattr(self, 'model'):
            self.model.release()