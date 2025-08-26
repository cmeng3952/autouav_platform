import time
import cv2
import subprocess as sp
from config import Config as cfg
pipe = None 
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
        '-tune','zerolatency',
        '-x264-params','force-cfr=1:scenecut=0:aq-mode=3:aq-strength=1.2',
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
if __name__ == '__main__':
    try:     
        # 初始化摄像头
        cap = init_camera(cfg.src)
        if cap is not None:
            fps = int(cap.get(cv2.CAP_PROP_FPS))
            width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
            height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
            # 安全地关闭并清理当前的ffmpeg推流管道（pipe）
            if 'pipe' in globals() and pipe is not None:
                try:
                    pipe.stdin.close()#关闭管道输入端，表示不在向ffmpeg发送视频帧数据 
                    pipe.terminate() #发送终止信号
                    pipe.wait(timeout=1)
                except:
                    #捕获所有异常（如进程已关闭、超时等），不中断主流程。
                    pass
            pipe = create_ffmpeg_pipe(width, height, fps, cfg.dst)
        else:
            print("Failed to initialize camera after retries.")
            exit()
        while True:
            # 读取视频帧
            if cap.isOpened():
                ret, frame = cap.read()
            else:
                ret = False
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
                # 重连摄像头
                cap=init_camera(cfg.src)
                if cap is None:
                    print("Max reconnect attempts reached. Exiting.")
                    break
                # 初始化视频参数
                fps = int(cap.get(cv2.CAP_PROP_FPS))
                width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
                height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
                pipe = create_ffmpeg_pipe(width, height, fps, cfg.dst)      
            #添加时间戳
            current_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())       
            text_size=cv2.getTextSize(current_time, cv2.FONT_HERSHEY_SIMPLEX, 0.6, 2)
            text_width, text_height = text_size[0][0], text_size[0][1]
            text_x = width - text_width - 10
            text_y = 30
            frame = cv2.putText(frame, current_time, (text_x, text_y), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255, 255, 255), 2)
            if pipe is not None and pipe.poll() is None:
                try:
                    pipe.stdin.write(frame.tobytes()) #推原始帧
                except (BrokenPipeError, OSError) as e:
                    print("推流失败，管道可能已断开:", e)
                    pipe = None  # 标记为无效，等待下一次重建
            else:
                print("当前管道不可用，重新创建管道...")
                pipe = create_ffmpeg_pipe(width, height, fps, cfg.dst) 
    except KeyboardInterrupt:   
        print("System shutdown via Ctrl+C...")
    finally:
        print("开始清理资源...")
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
        print("系统已关闭")