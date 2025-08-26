import cv2
import numpy as np

from config import Config as cfg
#---------------------------------------------#
#工具类
#目标检测后处理模块，主要用于对 YOLOv8 模型的输出进行解析、过滤和绘制检测框
#
#
#---------------------------------------------#

#功能：目标框过滤 
def filter_boxes(boxes, box_confidences, box_class_probs):
    # 筛选出满足条件的框，根据置信度和类别概率筛选出有效的框。
    box_confidences = box_confidences.reshape(-1)
    # candidate, class_num = box_class_probs.shape

    class_max_score = np.max(box_class_probs, axis=-1)
    classes = np.argmax(box_class_probs, axis=-1)

    _class_pos = np.where(class_max_score * box_confidences >= cfg.CONFIDENCE)
    scores = (class_max_score * box_confidences)[_class_pos]

    boxes = boxes[_class_pos]
    classes = classes[_class_pos]
    return boxes, classes, scores
def nms_boxes(boxes, scores):
    if len(boxes)==0:
        return np.array([])
    # 转换boxes为(x,y,w,h)格式
    wh_boxes = [[x1, y1, x2-x1, y2-y1] for (x1, y1, x2, y2) in boxes]
    # 使用OpenCV的NMS实现（C++后端）
    indices = cv2.dnn.NMSBoxes(wh_boxes, scores.tolist(), 
                              score_threshold=cfg.CONFIDENCE,
                              nms_threshold=cfg.iou)
    return np.array(indices).flatten() if len(indices) > 0 else np.array([])
#功能：用来改进模型对目标边界框的回归预测
def dfl(position):
    
    n, c, h, w = position.shape
    p_num = 4
    mc = c // p_num
    y = position.reshape(n, p_num, mc, h, w)
    y = softmax(y, 2)
    acc_metrix = np.arange(mc).reshape(1, 1, mc, 1, 1)
    y = (y * acc_metrix).sum(2)
    return y
def softmax(data,axis):
    # # 使用 np.exp 和 np.sum 的原地计算方式，减少内存峰值
    exps=np.exp(data-np.max(data,axis=axis,keepdims=True))
    sum_exps=np.sum(exps,axis=axis,keepdims=True)
    np.divide(exps,sum_exps,out=exps)
    return exps
# 边界框解码，将网络输出的预测结果转换为实际图像的边界框。
def box_process(position):
    
    grid_h, grid_w = position.shape[2:4]
    col, row = np.meshgrid(np.arange(0, grid_w), np.arange(0, grid_h))
    col = col.reshape(1, 1, grid_h, grid_w)
    row = row.reshape(1, 1, grid_h, grid_w)
    grid = np.concatenate((col, row), axis=1)
    stride = np.array([cfg.IMG_SIZE[1] // grid_h, cfg.IMG_SIZE[0] // grid_w]).reshape(1, 2, 1, 1)

    position = dfl(position)
    box_xy = grid + 0.5 - position[:, 0:2, :, :]
    box_xy2 = grid + 0.5 + position[:, 2:4, :, :]
    xyxy = np.concatenate((box_xy * stride, box_xy2 * stride), axis=1)

    return xyxy
# 将输入张量 _in 重新排列并展平
def sp_flatten(_in):
    ch = _in.shape[1]  # 获取输入的通道数
    _in = _in.transpose(0, 2, 3, 1)  # 将通道维度移到最后
    return _in.reshape(-1, ch)  # 将张量展平为二维
def yolov8_post_process(input_data):
    # 模型输出的原始预测结果经过后处理，以生成最终的检测结果
    boxes, scores, classes_conf = [], [], []
    default_branch = 3  # ***输入数据分成三部分进行处理
    pair_per_branch = len(input_data) // default_branch

    # 处理每个分支数据
    for i in range(default_branch):
        boxes.append(box_process(input_data[pair_per_branch * i]))
        classes_conf.append(input_data[pair_per_branch * i + 1])
        scores.append(np.ones_like(input_data[pair_per_branch * i + 1][:, :1, :, :], dtype=np.float32))
    
    # 使用 sp_flatten 函数展平每个分支的 boxes、classes_conf 和 scores
    boxes = [sp_flatten(_v) for _v in boxes]
    classes_conf = [sp_flatten(_v) for _v in classes_conf]
    scores = [sp_flatten(_v) for _v in scores]

    # 将每个分支的展平数据连接成一个整体
    boxes = np.concatenate(boxes)
    scores = np.concatenate(scores)
    classes_conf = np.concatenate(classes_conf)

    # 过滤框
    boxes, classes, scores = filter_boxes(boxes, scores, classes_conf)

    # nms--非极大值抑制
    nboxes, nclasses, nscores = [], [], []
    for c in set(classes):
        inds = np.where(classes == c)
        b = boxes[inds]
        c = classes[inds]
        s = scores[inds]
        keep = nms_boxes(b, s)

        if len(keep) != 0:
            nboxes.append(b[keep])
            nclasses.append(c[keep])
            nscores.append(s[keep])

    if not nclasses and not nscores:
        return None, None, None

    boxes = np.concatenate(nboxes)
    classes = np.concatenate(nclasses)
    scores = np.concatenate(nscores)

    return boxes, classes, scores
def draw(image, boxes, scores, classes):
    if boxes is None or scores is None or classes is None:
        return image
    #读取类别的颜色（BGR格式）
    class_colors=cfg.CLASS_COLORS
    font=cv2.FONT_HERSHEY_SIMPLEX
    font_scale=0.5
    font_thickness=1
    line_thickness=1
    print("{:^12} {:^12}  {}".format('class', 'score', 'xmin, ymin, xmax, ymax'))
    print('-' * 50)
    for box, score, cl in zip(boxes, scores, classes):
        if cl < 0 or cl >= len(cfg.CLASSES):
            continue
        color=class_colors.get(cl, (255,255,255))
        x1, y1, x2, y2 = [int(_b) for _b in box]
        # 绘制边界框
        cv2.rectangle(image, (x1, y1), (x2, y2), color, line_thickness)
        #标签内容
        label=f"{cfg.CLASSES[cl]} {score:.2f}"
        (tw, th), baseline = cv2.getTextSize(label, font, font_scale, font_thickness)
        #标签背景
        cv2.rectangle(image, (x1, y1 - th - baseline), (x1 + tw, y1), color, -1)
        #标签文字
        cv2.putText(image, label, (x1, y1 - baseline), font, font_scale, (255, 255, 255), font_thickness,cv2.LINE_AA)
        # 打印检测结果
        print("{:^12} {:^12.3f} [{:>4}, {:>4}, {:>4}, {:>4}]".format(cfg.CLASSES[cl], score, x1, y1, x2, y2))
    return image
class Letter_Box_Info():
    def __init__(self, shape, new_shape, w_ratio, h_ratio, dw, dh, pad_color) -> None:
        self.origin_shape = shape
        self.new_shape = new_shape
        self.w_ratio = w_ratio
        self.h_ratio = h_ratio
        self.dw = dw 
        self.dh = dh
        self.pad_color = pad_color
    
class COCO_test_helper():
    def __init__(self, enable_letter_box = False) -> None:
        self.record_list = []
        self.enable_ltter_box = enable_letter_box
        if self.enable_ltter_box is True:
            self.letter_box_info_list = []
        else:
            self.letter_box_info_list = None

    # 调整图像大小并填充图像，同时满足步长-多重约束条件
    def letter_box(self, im, new_shape, pad_color=(0,0,0), info_need=False):
        
        shape = im.shape[:2]  # current shape [height, width]
        if isinstance(new_shape, int):
            new_shape = (new_shape, new_shape)
 
        # 缩小比例系数
        if shape[0] == 0 or shape[1] == 0:
            r = 1
        else:
            r = min(new_shape[0] / shape[0], new_shape[1] / shape[1])
 
        # Compute padding
        ratio = r  # width, height ratios
        new_unpad = int(round(shape[1] * r)), int(round(shape[0] * r))
        dw, dh = new_shape[1] - new_unpad[0], new_shape[0] - new_unpad[1]  # wh padding
 
        dw /= 2  # divide padding into 2 sides
        dh /= 2
 
        if shape[::-1] != new_unpad:  # resize
            im = cv2.resize(im, new_unpad, interpolation=cv2.INTER_LINEAR)
        top, bottom = int(round(dh - 0.1)), int(round(dh + 0.1))
        left, right = int(round(dw - 0.1)), int(round(dw + 0.1))
        im = cv2.copyMakeBorder(im, top, bottom, left, right, cv2.BORDER_CONSTANT, value=pad_color)  # add border
        
        if self.enable_ltter_box is True:
            self.letter_box_info_list.append(Letter_Box_Info(shape, new_shape, ratio, ratio, dw, dh, pad_color))
        if info_need is True:
            return im, ratio, (dw, dh)
        else:
            return im
        
    #强制缩放到目标尺寸
    def direct_resize(self, im, new_shape, info_need=False):
        shape = im.shape[:2]
        h_ratio = new_shape[0]/ shape[0]
        w_ratio = new_shape[1]/ shape[1]
        if self.enable_ltter_box:
            self.letter_box_info_list.append(Letter_Box_Info(shape, new_shape, w_ratio, h_ratio, 0, 0, (0,0,0)))
        im = cv2.resize(im, (new_shape[1], new_shape[0]))
        return im
    #将检测框坐标从网络输入尺寸还原到原图坐标
    def get_real_box(self, box, in_format='xyxy'):
        if not self.letter_box_info_list or self.letter_box_info_list[-1] is None:
            raise ValueError(
                "Error: `letter_box_info_list` is empty or not initialized. Please ensure `letter_box()` is called before `get_real_box()`.")
        bbox = np.copy(box)
        if self.enable_ltter_box == True:
            
        # unletter_box result
            if in_format=='xyxy':
                bbox[:,0] -= self.letter_box_info_list[-1].dw
                bbox[:,0] /= self.letter_box_info_list[-1].w_ratio
                bbox[:,0] = np.clip(bbox[:,0], 0, self.letter_box_info_list[-1].origin_shape[1])
    
                bbox[:,1] -= self.letter_box_info_list[-1].dh
                bbox[:,1] /= self.letter_box_info_list[-1].h_ratio
                bbox[:,1] = np.clip(bbox[:,1], 0, self.letter_box_info_list[-1].origin_shape[0])
 
                bbox[:,2] -= self.letter_box_info_list[-1].dw
                bbox[:,2] /= self.letter_box_info_list[-1].w_ratio
                bbox[:,2] = np.clip(bbox[:,2], 0, self.letter_box_info_list[-1].origin_shape[1])
 
                bbox[:,3] -= self.letter_box_info_list[-1].dh
                bbox[:,3] /= self.letter_box_info_list[-1].h_ratio
                bbox[:,3] = np.clip(bbox[:,3], 0, self.letter_box_info_list[-1].origin_shape[0])
        return bbox