#!/home/orangepi/miniconda3/bin/python3
import paho.mqtt.client as mqtt
import subprocess
import json
import os
import threading
from config import Config as cfg
import time
#------------------------------------------------#
#用于远程通过 MQTT 指令启动或停止 AI 视频推流脚本。
#实现了 动态切换不同版本的推流程序
#     "command": "start_script",
#     "choose": "0"  // 0: , 1: 
#
#
#------------------------------------------------#
script_process = None
script_lock = threading.Lock()
script_path=None #默认启动的脚本路径(普通视频流)
current_choose=None #记录当前运行的choose值
# Fisrt load conda envirnment
os.environ["PATH"] = "/home/orangepi/miniconda3/envs/ai_rk3588/bin:" + os.environ["PATH"]
script_map={
            "0":cfg.normal_script_path,
            "1":cfg.people_script_path,
            "2":cfg.vehicle_script_path,
            "3":cfg.helmet_script_path,
            "4":cfg.detect_script_path
            }

def on_mqtt_connect(client, userdata, flags, rc, properties):
    if rc == 0:
        print("Connected to MQTT Broker")
        client.subscribe(cfg.MQTT_TOPIC)
    else:
        print("Failed to connect, return code %d\n", rc)

def on_mqtt_message(client, userdata, msg):
    global script_process,script_path,current_choose
    if msg.topic == cfg.MQTT_TOPIC:
        try:  
            payload = json.loads(msg.payload.decode('utf-8'))
            command = payload.get("command")
            if command == "start_script":
                choose=payload.get("choose")
                #人群检测
                if choose=="1":
                    subprocess.run(["systemctl", "--user", "stop", "rtmp_stream.service"])
                    conf=payload.get("CONFIDENCE")
                    gather_threshold=payload.get("PEOPLE_GATHER_THRESHOLD")
                    dist_threshold=payload.get("PEOPLE_DIST_THRESHOLD")
                    alert_frame_save_interval=payload.get("ALERT_FRAME_SAVE_INTERVAL")
                    # 构建新配置
                    people_new_config = {
                        "CONFIDENCE": float(conf) if conf is not None else cfg.CONFIDENCE,
                        "PEOPLE_GATHER_THRESHOLD": int(gather_threshold) if gather_threshold is not None else cfg.PEOPLE_GATHER_THRESHOLD,
                        "PEOPLE_DIST_THRESHOLD": int(dist_threshold) if dist_threshold is not None else cfg.PEOPLE_DIST_THRESHOLD,
                        "ALERT_FRAME_SAVE_INTERVAL": int(alert_frame_save_interval) if alert_frame_save_interval is not None else cfg.ALERT_FRAME_SAVE_INTERVAL
                    }
                    # 写入共享配置文件
                    with open('people_shared_config.json', 'w') as f:
                        json.dump(people_new_config, f, indent=2)  
                #车辆检测
                if choose=="2":
                    subprocess.run(["systemctl", "--user", "stop", "rtmp_stream.service"])
                    conf=payload.get("CONFIDENCE") #车辆识别阈值
                    vehicle_congestion_threshold=payload.get("VEHICLE_CONGESTION_THRESHOLD") #车流量阈值
                    alert_frame_save_interval=payload.get("ALERT_FRAME_SAVE_INTERVAL") #报警帧保存时间间隔
                    #构建新配置
                    vehicle_new_config={
                          "CONFIDENCE": float(conf) if conf is not None else cfg.CONFIDENCE,
                          "VEHICLE_CONGESTION_THRESHOLD":int(vehicle_congestion_threshold) if vehicle_congestion_threshold is not None else cfg.VEHICLE_CONGESTION_THRESHOLD,
                          "ALERT_FRAME_SAVE_INTERVAL": int(alert_frame_save_interval) if alert_frame_save_interval is not None else cfg.ALERT_FRAME_SAVE_INTERVAL
                    }
                    with open('vehicle_shared_config.json', 'w') as f:
                        json.dump(vehicle_new_config, f, indent=2)
                #头盔检测
                if choose=="3":
                    subprocess.run(["systemctl", "--user", "stop", "rtmp_stream.service"])
                    conf=payload.get("CONFIDENCE")
                    without_helmet_count_threshold=payload.get("WITHOUT_HELMET_COUNT_THRESHOLD") #未戴头盔的预警阈值 
                    alert_frame_save_interval=payload.get("ALERT_FRAME_SAVE_INTERVAL") #报警帧保存时间间隔
                    helmet_new_config={
                        "CONFIDENCE": float(conf) if conf is not None else cfg.CONFIDENCE,
                        "WITHOUT_HELMET_COUNT_THRESHOLD":int(without_helmet_count_threshold) if without_helmet_count_threshold is not None else cfg.WITHOUT_HELMET_COUNT_THRESHOLD,
                        "ALERT_FRAME_SAVE_INTERVAL": int(alert_frame_save_interval) if alert_frame_save_interval is not None else cfg.ALERT_FRAME_SAVE_INTERVAL
                    }
                    with open('helmet_shared_config.json', 'w') as f:
                        json.dump(helmet_new_config, f, indent=2)  
                
                if choose==current_choose:
                    print(f"当前已经是{choose}版本，无需切换")
                    return
                if choose not in script_map:
                    print(f"未知的choose值: {choose}")
                    return  
                # Aruco Detect
                if choose=="4":
                    subprocess.run(["systemctl", "--user", "stop", "rtmp_stream.service"])
                    # state = payload.get("state")
                    marker_ids = payload.get("marker_ids")
                    marker_sizes = payload.get("marker_sizes")
                    if marker_ids is not None and marker_sizes is not None:
                        marker_id = marker_ids.split(',')
                        marker_size = marker_sizes.split(',')
                        try:
                            if(len(marker_id) == len(marker_size)): 
                                lines = []
                                for id,size in zip(marker_id,marker_size):
                                    lines.append(f"{id},{float(size)}\n")
                                with open("/home/orangepi/aruco_detect/src/cloudfly_cv/config/marker_sizes.txt",'w') as f:
                                    f.writelines(lines)
                            else:
                                raise ValueError("The size of marker_ids and marker_sizes is not equal,please re-input")
                        except Exception as e:
                            print("Please check your Input",e)
                            return
                    else:
                        print("Ignore Write")
  
                script_path=script_map[choose]
                with script_lock:
                    #如果已有脚本在运行，则先停止它
                    if script_process and script_process.poll() is None:
                        subprocess.run(["systemctl", "--user", "stop", "rtmp_stream.service"])
                        print("检测到已有脚本正在运行，正在停止...")
                        script_process.terminate()
                        script_process.wait(timeout=5)
                        print("已停止已有脚本")
                       
                    print(f"正在启动脚本...{script_path}")
                    try:
                        if choose =="999":
                            script_process=subprocess.Popen(
                                ["bash",script_path],
                                stdout=subprocess.PIPE,
                                stderr=subprocess.PIPE,
                                text=True,
                                encoding='utf-8'
                            )
                        else:
                            script_process = subprocess.Popen(
                                ["/home/orangepi/miniconda3/envs/ai_rk3588/bin/python3.8", script_path],
                                stdout=subprocess.PIPE,
                                stderr=subprocess.PIPE,
                                text=True,
                                encoding='utf-8', 
                            )
                            # if choose == "4":
                            #     time.sleep(7)
                            #     msg = {
                            #         "state":"landing"
                            #     }
                            #     message = json.dumps(msg)
                            #     client.publish(cfg.MQTT_TOPIC, message)
                        current_choose=choose # 更新当前选择
                    except Exception as e:
                        print(f"启动脚本失败: {e}")
                        current_choose=None #重置当前选择
                        return
                def read_output(stream, prefix):
                    try:
                        for line in iter(stream.readline, ''):
                            print(f"[{prefix}] {line.strip()}")
                    except Exception as e:
                        print(f"[{prefix}] 读取输出错误:", e)
                    finally:
                        stream.close()
                # 启动线程读取脚本输出
                threading.Thread(
                    target=read_output, 
                    args=(script_process.stdout, "STDOUT"),
                    daemon=True).start()
                threading.Thread(
                    target=read_output, 
                    args=(script_process.stderr, "STDERR"), 
                    daemon=True).start()
                
                threading.Thread(
                    target=monitor_script_process,
                    args=(script_path,script_process),
                    daemon=True
                ).start()
            elif command == "stop_script":
                with script_lock:
                    if current_choose == "4":  # 如果当前选择是4，不停止脚本
                        print("当前脚本（choose=4）不允许被停止")
                    elif script_process and script_process.poll() is None:
                        print("正在停止脚本...")
                        script_process.terminate()
                        script_process.wait(timeout=3)
                        print("脚本已终止")
                        current_choose=None #重置当前选择
                        print("等待新的指令...")
                    else:
                        print("没有正在运行的脚本")

        except Exception as e:
            print("消息处理错误:", e)

def monitor_script_process(script_name, process):
    """监控子进程状态"""
    global script_process, current_choose

    print(f"[监控] 开始监控 {script_name} 进程 PID: {process.pid}")
    return_code = process.wait()  # 等待进程结束

    print(f"[监控] 子进程已退出，返回码: {return_code}")
    if return_code == -15:
            print("[监控] 子进程被主动终止 (SIGTERM)")
    else:
        print("[监控] 子进程意外退出")
        with script_lock:
            current_choose = None

if __name__ == "__main__":
    mqtt_client = mqtt.Client(callback_api_version=mqtt.CallbackAPIVersion.VERSION2)
    mqtt_client.username_pw_set(username=cfg.MQTT_USERNAME, password=cfg.MQTT_PASSWORD)
    mqtt_client.on_connect = on_mqtt_connect
    mqtt_client.on_message = on_mqtt_message
    
    mqtt_client.connect(cfg.MQTT_BROKER, cfg.MQTT_PORT, 60)
    print("Listening for MQTT messages...")
    try:
        mqtt_client.loop_forever()
    except KeyboardInterrupt:
        print("程序中断，正在关闭MQTT客户端和子进程...")
        with script_lock:
            if script_process and script_process.poll() is None:
                print("正在终止脚本进程...")
                script_process.terminate()
                script_process.wait(timeout=2)
                print("脚本进程已终止")
        mqtt_client.disconnect()
