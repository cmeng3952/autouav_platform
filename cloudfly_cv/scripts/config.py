class Config:
    #模型配置字典
    MODEL_CONFIGS = {
        "people":{
            "path":"/home/orangepi/aruco_detect/src/cloudfly_cv/scripts/model/train31_relu.rknn",
            "img_size":(1024,1024),
            "classes":['people']
        },
        "vehicle":{
            "path":"/home/orangepi/aruco_detect/src/cloudfly_cv/scripts/model/car_train.rknn",
            "img_size":(1280,1280),
            "classes":['car','van','truck','bus']
        },
        "helmet":{
            "path":"/home/orangepi/aruco_detect/src/cloudfly_cv/scripts/model/helmet_s.rknn",
            "img_size":(1280,1280),
            "classes":['helmet','without_helmet']
        }
    }
    #模型类别颜色（BGR格式）
    CLASS_COLORS={
        0: (0, 255, 0),
        1: (0, 0, 255),
        2: (255, 0, 0), 
        3: (0, 255, 255)
    }
    #固定向MQTT发布类别及颜色（RGB格式）
    MQTT_PEOPLE_COLORS={
        "people":"0.255.0"
    }
    MQTT_VEHICLE_COLORS={
        "car":"0.255.0",
        "van":"255.0.0",
        "truck":"0.0.255",
        "bus":"255.255.0"
    }
    MQTT_HELMET_COLORS={
        'helmet':"0.255.0",
        'without_helmet':"255.0.0"
    }
    AI_STREAM_WARMUP_FRAMES   = 8  # AI推理流预热帧数

    #fps相关参数
    avg_window = 10  # 取最近10帧计算平均FPS

    # 视频相关参数
    # src=0
    src = "rtsp://192.168.144.108"
    #src="rtsp://192.168.144.108:554/stream=1"
    dst="rtmp://47.104.183.127/live/uav3_cam3"
    frame_interval = 2  # 设置帧间隔，例如每3帧进行一次推理
    mqtt_publish_interval=1 #mqtt发布间隔(秒)
    MAX_PIPE_RECREATE = 10  # 管道最大重建次数
    
    #运行脚本地址
    normal_script_path = "/home/orangepi/aruco_detect/src/cloudfly_cv/scripts/normal_streaming.py"
    people_script_path = "/home/orangepi/aruco_detect/src/cloudfly_cv/scripts/people_detection.py"
    vehicle_script_path = "/home/orangepi/aruco_detect/src/cloudfly_cv/scripts/vehicle_detection.py"
    helmet_script_path="/home/orangepi/aruco_detect/src/cloudfly_cv/scripts/helmet_detection.py"
    detect_normal_stream_script_path = "/home/orangepi/stream_change/detect_normal_stream.py"
    detect_script_path = "/home/orangepi/stream_change/aruco_detect.py"
    #sh_script_path = "/home/test/video.sh"

    iou=0.45
    CONFIDENCE = 0.25  # 人员、车辆 检测置信度阈值（共用一个）
    ALERT_FRAME_SAVE_INTERVAL = 60  # 报警帧保存时间间隔(秒)
    ALARM_STABLE_FRAMES=5 # 报警稳定次数

    PEOPLE_GATHER_THRESHOLD = 5  # 聚集报警人数阈值
    PEOPLE_DIST_THRESHOLD=50 # 人群目标框相邻程度阈值(像素)
    
    VEHICLE_CONGESTION_THRESHOLD = 10  # 车辆拥堵检测阈值

    WITHOUT_HELMET_COUNT_THRESHOLD=2 #未戴头盔数量阈值

    #MQTT相关参数
    MQTT_BROKER="47.104.183.127"
    MQTT_PORT=1983
    MQTT_TOPIC="aicontrol/command/uav3"
    MQTT_TOPIC_OUTPUT="aicontrol/state/uav2" 
    MQTT_USERNAME = "pxtest"
    MQTT_PASSWORD = "test2025@px"
    #JWT配置
    SECRET_KEY="ai_secret_key_32chars_long"
    JWT_EXPIRATION_TIME=1800000 #JWT过期时间(秒) 30分钟
    JWT_subject="AI" #JWT主题

    #http上传参数
    upload_url='http://47.104.183.127/api/flight-sys/sys/common/uploadWithToken'
    
