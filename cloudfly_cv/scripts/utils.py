import jwt
from config import Config as cfg
import time
import requests
import cv2
#jwt令牌生成
def generate_jwt_token():
    now=int(time.time()*1000) # 获取当前时间戳（毫秒）
    payload = {
        'exp': now+ cfg.JWT_EXPIRATION_TIME,  # 设置过期时间
        'sub': cfg.JWT_subject  # 主题
    }
    token = jwt.encode(payload, cfg.SECRET_KEY, algorithm='HS256')
    return token


def upload_image(frame,jwt_token):
    try:
        success,img_bytes=cv2.imencode('.jpg', frame)
        img_bytes = img_bytes.tobytes()
        if not success: 
            print("[OSS] 图像编码失败")
            return None
        #设置请求头
        headers={
            'X-Auth-Token':jwt_token,
            'X-Source':"AI"
        }
        files={
            'file':('image.jpg', img_bytes, 'image/jpeg')
        }
        
        response=requests.post(cfg.upload_url,headers=headers,files=files)
        if response.status_code == 200:
            result=response.json()
            if result.get('success'):
                print(f"[上传] 成功，图片地址: {result['result']}")
                return result['result']
        else:
            print(f"[上传] 请求失败，状态码: {response.status_code}")
            return None
    except Exception as e:
        print(f"[上传] 请求异常: {e}")
        return None
