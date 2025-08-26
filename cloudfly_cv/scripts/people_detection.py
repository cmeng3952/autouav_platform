#!/home/orangepi/miniconda3/bin/python3
import time
import numpy as np
import queue
import threading
from copy import copy
import cv2
from rknnlite.api import RKNNLite
import subprocess as sp
import json
import paho.mqtt.client as mqtt
from config import Config as cfg
from utils import *
from detection_utils import *
from scipy.spatial.distance import pdist, squareform
from rknnpool import NPUOptimizedModel
#-----------------------------------------------------#
#   检测目标：人
#-----------------------------------------------------#
shutdown_flag=False #程序关闭标志
pipe = None # ffmpeg推流管道
enable_processing = True  # AI处理开关，默认开启
enable_lock = threading.Lock()  # 线程锁
ai_stream_warmup_frames = 1 # AI推流预热帧数初始值
last_screenshot_time = 0  # 全局变量用于记录上次截图时间
is_in_alarm_state = False  # 是否已经进入报警状态并完成截图
consecutive_alarm_frames=0
#清空模型的输入输出队列，防止复用旧帧
def clear_model_queues(model):
    
    try:
        while not model.input_queue.empty():  
            model.input_queue.get_nowait()
    except Exception:
        pass
    try:
        while not model.output_queue.empty():
            model.output_queue.get_nowait()        
    except Exception:
        pass

def on_mqtt_connect(client, userdata, flags, rc,properties):
    if rc == 0:
        print("Connected to MQTT Broker")
    else:
        print("Failed to connect, return code %d\n", rc)
    # 在连接成功后订阅主题
    client.subscribe(cfg.MQTT_TOPIC)

#mqtt消息处理函数
def on_mqtt_message(client, userdata, msg):
    # 全局变量
    global enable_processing,pipe,cap,shutdown_flag,ai_stream_warmup_frames 
    try:
        payload = msg.payload.decode('utf-8')
        data = json.loads(payload)
        
        if data.get("status") == "0":  
            with enable_lock:
                enable_processing = False #禁用AI处理
                print("[MQTT] AI识别已禁用")
        elif data.get("status") == "1":
            with enable_lock:
                if not enable_processing:
                    enable_processing = True
                    ai_stream_warmup_frames=cfg.AI_STREAM_WARMUP_FRAMES
                    print("[MQTT] AI识别已启用")
                    if 'model' in globals() and model is not None:
                        clear_model_queues(model)
                else:
                    print("[MQTT] AI识别已处于启动状态，无需重复启动")
            #如果当前没有推流管道，则创建一个新的
            if 'pipe' not in globals() or pipe is None or pipe.poll() is not None:
                if cap is not None:
                    fps = int(cap.get(cv2.CAP_PROP_FPS))
                    width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
                    height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
                    pipe = create_ffmpeg_pipe(width, height, fps, cfg.dst)
                else:
                    print("无法创建推流管道：摄像头未连接")     

        elif data.get("command") == "shutdown":  # 关闭程序
            print("[MQTT] 收到关闭指令")
            shutdown_flag=True #设置关闭标志
            client.disconnect() #断开MQTT连接
            client.loop_stop() #停止MQTT循环
            raise SystemExit("收到MQTT关闭指令") #退出程序
    except Exception as e:
        print("[MQTT] 消息处理错误:", e)
     
def init_camera(src, max_retries=3, retry_interval=2):
    """带重试机制的摄像头初始化"""
    for _ in range(max_retries):
        cap = cv2.VideoCapture(src)
        if cap.isOpened():
            return cap
        print(f"Camera connection failed. Retrying in {retry_interval} seconds...")
        time.sleep(retry_interval)
    return None

def create_ffmpeg_pipe(width,height,fps,dst):
   #清理旧管道
    global pipe
    if pipe is not None:
        try:
            if pipe.poll() is None:
                pipe.stdin.close()
            pipe.terminate()
            pipe.wait(timeout=1)
        except Exception as e:
            print(f"清理旧管道失败: {str(e)}")
        finally:
            pipe = None
    command = [
        'ffmpeg', #启动FFmpeg程序
        #'-nostats', #禁止显示统计信息
        #硬件加速相关参数
        "-hwaccel", "auto", #自动选择硬件加速类型（如 VAAPI/VDPAU/CUDA）
        "-hwaccel_device", "/dev/dri/renderD128",  #指定硬件加速设备GPU
        #输入参数
        '-y', #覆盖输出文件（若存在）
        '-f', 'rawvideo', #输入格式：原始未压缩视频帧
        '-vcodec', 'rawvideo', #输入编解码器：原始视频数据
        '-pix_fmt', 'bgr24', #输入像素格式：OpenCV 默认的 BGR 24bit 格式
        '-s', "{}x{}".format(width, height), #输入分辨率（从摄像头参数动态获取）
        '-r', f'{fps}', #输入帧率（从摄像头参数动态获取）
        '-i', '-', #输入流：标准输入（通过管道传递）
        
        #音频编码优化
        '-c:a', 'aac', #输出音频编码器：AAC
        '-b:a', '96k', #输出音频比特率：128kbps
        '-ac', '1', #输出音频通道数：2 通道（立体声）
        '-af', 'aresample=async=1:min_comp=0.1', #输出音频采样率：44.1kHz
        '-ar',  '44100',    
        #输出参数
        '-c:v', 'libx264', #输出编解码器：H.264
        '-pix_fmt', 'yuv420p',#输出像素格式
        '-preset', 'superfast', #编码速度预设
        '-f', 'flv', #输出格式：Flash Video
        '-flvflags', 'no_duration_filesize', #禁用 FLV 头部信息（时长/文件大小）
        '-rtsp_transport', 'tcp',#使用 TCP 传输
        '-g', '60',#关键帧间隔：60帧一个关键帧（2秒 @30fps，流媒体常用配置）
        '-keyint_min','60',
        # '-vf','scale=1920:1080',
        '-tune','zerolatency',
        '-x264-params','force-cfr=1:scenecut=0:threads=6',
        '-b:v','1500k',
        '-bufsize','3000k',
        '-maxrate','2000k',
        '-vsync','1',
        dst
    ]                    
    try:
        new_pipe=sp.Popen(command, stdin=sp.PIPE)
        return new_pipe
    except Exception as e:
        print(f"创建FFmpeg管道失败: {str(e)}")
        return None               

# 统计检测到的对象数量
def count_objects(classes):
    #初始化所有类别的计数为0
    class_counts={cls:0 for cls in cfg.CLASSES}
    #对检测到的类别进行计数
    for cls in classes:
        class_name=cfg.CLASSES[int(cls)]
        class_counts[class_name] += 1
    return class_counts
def get_default_counts(classes_list):
    """
    根据给定的类别列表生成默认计数字典，初始值为0
    """
    return {cls: 0 for cls in classes_list}

def count_gather_clusters(boxes, dist_thresh):
    """返回所有聚集区域的人数列表，每个区域内所有人距离都小于阈值"""
    if boxes is None or len(boxes) < 2:
        return []
    
    centers = np.array([[(box[0]+box[2])/2, (box[1]+box[3])/2] for box in boxes])
    #计算欧氏距离矩阵
    dists=squareform(pdist(centers, 'euclidean'))
    #使用numpy向量化查找满足条件的点对（i<j）
    mask = (dists < dist_thresh) & np.triu(np.ones_like(dists, dtype=bool), k=1)
    idxs = np.where(mask)
    adj = [[] for _ in range(len(centers))]
    for i,j in zip(*idxs):
        adj[i].append(j)
        adj[j].append(i)
    visited=[False] * len(centers)
    clusters = []  # 存储每个聚集区域的人数
    for i in range(len(centers)):
        if not visited[i]:
            stack = [i]
            group = []
            while stack:
                node = stack.pop()
                if not visited[node]:
                    visited[node] = True
                    group.append(node)
                    stack.extend(adj[node])
            if len(group) > 1:
                clusters.append(len(group))
    return clusters
#MQTT上报信息
def mqtt_publish_detections(mqtt_client,object_counts,boxes,classes,scores,frame,last_mqtt_publish_time):
    global last_screenshot_time,is_in_alarm_state,consecutive_alarm_frames
    mqtt_current_time=time.time()
    current_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())   
    alarm=False #默认不报警
    image_url="" #默认无图片链接
    # 检查是否需要发布MQTT消息（时间间隔）
    if mqtt_current_time -last_mqtt_publish_time>=cfg.mqtt_publish_interval:
        detections=[] #检测目标列表
        if boxes is not None and classes is not None and scores is not None:
            min_len = min(len(boxes), len(classes), len(scores))
            for i in range(min_len):
                detection={
                    "class_name":cfg.CLASSES[int(classes[i])],
                    "confidence":round(float(scores[i]),2),
                    "bbox":[int(coord) for coord in boxes[i]]
                }
                detections.append(detection)
        if not object_counts:
            object_counts=get_default_counts(cfg.CLASSES)
        # #人群阈值判断逻辑
        # people_count=object_counts.get("people",0)
        # alarm=people_count>cfg.PEOPLE_ALARM_THRESHOLD
        
        #人群目标框相邻程度逻辑
        clusters=count_gather_clusters(boxes,cfg.PEOPLE_DIST_THRESHOLD)
        if any(c >= cfg.PEOPLE_GATHER_THRESHOLD for c in clusters):
           consecutive_alarm_frames += 1
           if consecutive_alarm_frames >=cfg.ALARM_STABLE_FRAMES:
               alarm = True  # 满足聚集条件，触发报警
        else:
           consecutive_alarm_frames = 0
           alarm = False
           is_in_alarm_state = False  # 标记为未报警状态

        #只有报警首次发送或满足间隔时才截图，并上传到服务器
        if alarm:
            current_time_full=time.time()
            should_capture = False
            if not is_in_alarm_state:
                should_capture = True #首次报警
            elif current_time_full-last_screenshot_time>=cfg.ALERT_FRAME_SAVE_INTERVAL: 
                should_capture = True #持续报警且超过最小截图间隔时间
            if should_capture:
                try:
                    #生成JWT令牌
                    jwt_token = generate_jwt_token()
                    image_url=upload_image(frame,jwt_token)
                    last_screenshot_time = current_time_full #更新最后一次截图时间
                    is_in_alarm_state = True  # 标记为已报警状态   
                except Exception as e:
                    print(f"[ERROR] 截图失败: {e}")   
        else:
           is_in_alarm_state = False          
            
        # 发布MQTT消息
        msg=json.dumps({
            "ai_counts": object_counts,
            "ai_colors":cfg.MQTT_PEOPLE_COLORS,
            "detections":detections,
            "choose_id":1,
            "alarm":alarm,
            "warning_type":"人群聚集" if alarm else "",
            "warning_imageURL": image_url if image_url else "",
            "timestamp":current_time     
        })
        try:
            mqtt_client.publish(cfg.MQTT_TOPIC_OUTPUT, msg)
            last_mqtt_publish_time=mqtt_current_time
        except Exception as e:
            print(f"[MQTT] 发送检测结果失败: {e}")
    return last_mqtt_publish_time

#负责模型中的阈值更新
def load_config_from_file():
    try:
        with open('people_shared_config.json', 'r') as f:
            config = json.load(f)
        # 更新全局配置
        cfg.CONFIDENCE = float(config.get("CONFIDENCE", cfg.CONFIDENCE))
        cfg.PEOPLE_GATHER_THRESHOLD = int(config.get("PEOPLE_GATHER_THRESHOLD", cfg.PEOPLE_GATHER_THRESHOLD))
        cfg.PEOPLE_DIST_THRESHOLD = int(config.get("PEOPLE_DIST_THRESHOLD", cfg.PEOPLE_DIST_THRESHOLD))
        cfg.ALERT_FRAME_SAVE_INTERVAL = int(config.get("ALERT_FRAME_SAVE_INTERVAL", cfg.ALERT_FRAME_SAVE_INTERVAL))
        
    except Exception as e:
        print(f"[CONFIG] 读取 people_shared_config.json 失败: {e}，使用默认值")

if __name__ == '__main__':
    try:
        load_config_from_file()  # 初始化时加载一次
        
        # 初始化MQTT客户端
        mqtt_client = mqtt.Client(callback_api_version=mqtt.CallbackAPIVersion.VERSION2)
        mqtt_client.username_pw_set(username=cfg.MQTT_USERNAME, password=cfg.MQTT_PASSWORD) # 设置用户名和密码
        mqtt_client.on_connect = on_mqtt_connect
        mqtt_client.on_message = on_mqtt_message
        mqtt_client.connect(cfg.MQTT_BROKER, cfg.MQTT_PORT, 60)
        mqtt_client.loop_start()
        #初始化参数
        config=cfg.MODEL_CONFIGS["people"]
        cfg.MODEL_PATH=config["path"]
        cfg.IMG_SIZE=config["img_size"]
        cfg.CLASSES=config["classes"]
        frame_count = 0 # 用于记录帧数，负责跳帧推理
        processing = True #  用于控制AI推理的开启
        last_mqtt_publish_time = time.time() # 记录MQTT消息发送时间
        pipe_recreate_count = 0 # 管道重建计数
        # 初始化检测模型
        model = NPUOptimizedModel(cfg.MODEL_PATH)
        # 初始化摄像头
        cap = init_camera(cfg.src)
        if cap is not None:
            fps = int(cap.get(cv2.CAP_PROP_FPS))
            width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
            height = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
            cap.set(cv2.CAP_PROP_FRAME_WIDTH,width)
            cap.set(cv2.CAP_PROP_FRAME_HEIGHT,height)
            # 若当前有推流管道，则先安全地关闭并清理当前的ffmpeg推流管道（pipe）
            if 'pipe' in globals() and pipe is not None:
                try:
                    pipe.stdin.close()#关闭管道输入端，表示不在向ffmpeg发送视频帧数据 
                    pipe.terminate() #发送终止信号
                    pipe.wait(timeout=1)
                except:
                    #捕获所有异常（如进程已关闭、超时等），不中断主流程。
                    pass
            # 创建ffmpeg推流管道
            pipe = create_ffmpeg_pipe(width, height, fps, cfg.dst)
        else:
            print("Failed to initialize camera after retries.")
            exit()
        
        # 启动主处理循环
        while not shutdown_flag:
            #检查是否收到关闭信号
            if shutdown_flag:
                break
            
            # 读取视频帧
            if cap.isOpened():
                ret, frame = cap.read()
            else:
                ret = False
                # modify
            if frame.shape[0] != 720 or frame.shape[1] != 1280:
                frame = cv2.resize(frame, (1280, 720))  # (width, height)
            # 处理异常情况(摄像头断开连接)
            if not ret:
                print("Camera disconnected. Attempting to reconnect...")
                # 清理资源
                cap.release()
                if pipe is not None:
                    try:
                        pipe.stdin.close()
                        pipe.wait()
                    except:
                        pass
                # 重连
                cap=init_camera(cfg.src)
                if cap is None:
                    print("Max reconnect attempts reached. Exiting.")
                    break
                # 重新初始化视频参数
                fps = int(cap.get(cv2.CAP_PROP_FPS))
                width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
                height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
                pipe = create_ffmpeg_pipe(width, height, fps, cfg.dst)    
            
            #在视频帧右上角添加时间戳
            current_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())       
            text_size=cv2.getTextSize(current_time, cv2.FONT_HERSHEY_SIMPLEX, 0.6, 2)
            text_width, text_height = text_size[0][0], text_size[0][1]
            text_x = width - text_width - 10
            text_y = 30 
            frame = cv2.putText(frame, current_time, (text_x, text_y), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255, 255, 255), 2)
            
            # 获取AI推理状态
            with enable_lock:
                processing = enable_processing 
            
            #AI流模式
            if processing:
                 # 检查是否达到帧间隔
                if frame_count % cfg.frame_interval == 0:
                    object_counts=get_default_counts(cfg.CLASSES) # 初始化计数器
                    boxes, classes, scores = None, None, None # 初始化检测结果
                    model.put_frame(frame) # 提交推理          
                    result = model.get_result()  # 获取检测结果
                    if result is not None:
                        infer_frame, boxes, classes, scores, _ = result
                        if boxes is not None:    
                            try:   
                                infer_frame = draw(infer_frame, boxes, scores, classes) # 绘制检测框
                                object_counts=count_objects(classes) # 统计检测到的对象数量
                            except Exception as e:
                                print(f"绘图错误: {str(e)}")
                                infer_frame = frame.copy()
                        # 确保格式正确 
                        if infer_frame.dtype != np.uint8:
                            infer_frame = (infer_frame * 255).astype(np.uint8)
                        if infer_frame.shape[:2] != (height, width):
                            # 如果尺寸不匹配，调整尺寸
                            infer_frame = cv2.resize(infer_frame, (width, height))                           
                    else:
                        #没有推理结果时使用原始帧推流
                        infer_frame = frame.copy()
                    #更新当前帧用于后续跳帧
                    last_infer_frame = infer_frame.copy()
                    # 发布MQTT消息
                    last_mqtt_publish_time=mqtt_publish_detections(mqtt_client,object_counts, boxes, classes, scores,last_infer_frame, last_mqtt_publish_time)
                    
                if pipe is not None and pipe.poll() is None:
                    try:
                        # 预热阶段跳过推流
                        if ai_stream_warmup_frames>0: 
                            ai_stream_warmup_frames-=1 
                            print(f"跳过第 {cfg.AI_STREAM_WARMUP_FRAMES - ai_stream_warmup_frames} 帧推流（预热阶段）")
                        else:
                            pipe.stdin.write(last_infer_frame.tobytes()) #推流    
                    except (BrokenPipeError, OSError) as e:
                        print("推流失败，管道可能已断开:", e)
                        pipe = None  # 标记为无效，等待下一次重建
                else:
                    if pipe_recreate_count < cfg.MAX_PIPE_RECREATE:
                        print("当前管道不可用，重新创建管道...")
                        pipe = create_ffmpeg_pipe(width, height, fps, cfg.dst)
                        pipe_recreate_count += 1  # 增加重建计数  
                    else:
                        print("管道重建次数达到上限，退出...")
                        break
                frame_count += 1 #增加帧计数器 
            
            #原始流模式       
            else:     
                if pipe is not None and pipe.poll() is None:
                    try:
                        pipe.stdin.write(frame.tobytes()) #推原始帧
                    except (BrokenPipeError, OSError) as e:
                        print("推流失败，管道可能已断开:", e)
                        pipe = None  # 标记为无效，等待下一次重建
                else:
                    if pipe_recreate_count < cfg.MAX_PIPE_RECREATE:
                        print("当前管道不可用，重新创建管道...")
                        pipe = create_ffmpeg_pipe(width, height, fps, cfg.dst)
                        pipe_recreate_count += 1  # 增加重建计数
                    else:
                        print("管道重建次数达到上限，退出...")
                        break 
    except KeyboardInterrupt:   
        print("System shutdown via Ctrl+C...")
    except SystemExit as e:
        print(f"System shutdown via MQTT... {str(e)}") 
    finally:
        print("开始清理资源...")
        # 通知所有Worker停止
        for worker in getattr(model, 'workers', []):
            if hasattr(worker, 'stop'):
                worker.stop()
        # 等待 Worker 线程退出（设置合理超时）
        for worker in getattr(model, 'workers', []):
            if worker.is_alive():
                worker.join(timeout=1)  # 最多等待1秒 

        # 释放摄像头资源
        if cap is not None and cap.isOpened():
            cap.release()
            print("Camera released.")
        # 关闭FFmpeg推流管道
        if pipe is not None:
            try:
                pipe.stdin.close()
                pipe.wait(timeout=1)
                print("FFmpeg pipe closed.")
            except:
                pass
        # 再次确认模型已释放
        for worker in getattr(model, 'workers', []):
            if hasattr(worker, 'model'):
                worker.model.release()
                print("NPU model released.")
        print("系统已关闭")
    
        
