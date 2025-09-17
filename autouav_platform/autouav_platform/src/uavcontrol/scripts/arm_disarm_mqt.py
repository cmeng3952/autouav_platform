#!/usr/bin/env python3
import sys
import threading
import time
import json
from urllib.parse import urlparse

import rospy
from mavros_msgs.srv import CommandBool
from std_msgs.msg import Bool


# 核心状态变量
prop_folded = False  # 桨叶收纳状态
hold_until = 0.0     # 状态保持截止时间
uav_name = ""        # 无人机名
prop_state_pub = None
is_holding = False   # 保持阶段标记

# 配置常量
DEFAULT_PROP_DELAY = 1.2  # 收桨专用：解锁后自动上锁延迟(秒)
HOLD_TIME = 5.0           # 收桨状态保持时间(秒)

# 指令类型
CMD_ARM = "Arm"
CMD_PROP_FOLDED = "prop_folded"  # 收桨指令


# MQTT组件
mqtt_client = None
mqtt_enabled = False

try:
    import paho.mqtt.client as mqtt
except ImportError:
    mqtt = None


def _build_service_name(service_ns: str) -> str:
    ns = (service_ns or "").strip()
    if not ns:
        return "/mavros/cmd/arming"
    if ns.startswith("/"):
        ns = ns[1:]
    return f"/{ns}/mavros/cmd/arming"


def publish_prop_state():
    """10Hz发布桨叶状态，保持阶段结束后重置"""
    global prop_folded, hold_until, is_holding
    while not rospy.is_shutdown():
        current_time = time.time()
        
        if is_holding and current_time >= hold_until:
            prop_folded = False
            is_holding = False
        
        current_state = True if current_time < hold_until else prop_folded
        prop_state_pub.publish(current_state)
        time.sleep(0.1)


def call_arming(service_ns, arm, auto_flow=False):
    """调用解锁/上锁服务
    auto_flow: 是否是收桨流程中的自动上锁（用于状态标记）
    """
    global prop_folded, hold_until, is_holding
    service = _build_service_name(service_ns)

    try:
        rospy.wait_for_service(service, 5.0)
        proxy = rospy.ServiceProxy(service, CommandBool)
        resp = proxy(arm)
        
        if resp.success:
            if arm:
                # 解锁时重置收桨相关状态（无论哪种解锁）
                prop_folded = False
                hold_until = 0.0
                is_holding = False
            elif auto_flow:
                # 仅收桨流程的自动上锁会触发状态保持
                prop_folded = True
                hold_until = time.time() + HOLD_TIME
                is_holding = True
            return True
        return False
    except Exception as e:
        rospy.logerr(f"服务调用失败: {e}")
        return False


def start_prop_fold(service_ns, delay):
    """启动桨叶收纳流程（仅此流程有自动上锁）：解锁→延迟→自动上锁"""
    if not call_arming(service_ns, True):  # 收桨专用解锁
        rospy.logerr("桨叶收纳失败：解锁失败")
        return
    
    # 处理收桨延迟时间（≤1.2用默认，＞1.2用指定）
    actual_delay = DEFAULT_PROP_DELAY if delay <= DEFAULT_PROP_DELAY else delay
    global prop_folded
    prop_folded = True
    rospy.loginfo(f"桨叶收纳启动，{actual_delay}秒后自动上锁（收桨专用逻辑）")
    
    def _auto_disarm():
        # 收桨流程的自动上锁（带状态保持）
        if call_arming(service_ns, False, auto_flow=True):
            rospy.loginfo("桨叶收纳：自动上锁成功")
        else:
            rospy.logerr("桨叶收纳：自动上锁失败")
            global prop_folded
            prop_folded = False
    
    threading.Timer(actual_delay, _auto_disarm).start()


def _parse_broker(url: str):
    """解析MQTT broker地址"""
    try:
        parsed = urlparse(url)
        scheme = (parsed.scheme or "tcp").lower()
        host = parsed.hostname or "localhost"
        port = parsed.port or (8883 if scheme in ("ssl", "mqtts") else 1883)
        return scheme, host, port
    except Exception:
        return "tcp", url, 1883


def _extract_command(payload: str):
    """解析指令，支持：
    - {"command": {"Arm": 1}} 常规解锁（无自动上锁）
    - {"command": {"Arm": 0}} 常规上锁
    - {"command": {"prop_folded": 时间值}} 收桨（带自动上锁）
    """
    text = payload.strip()
    if not text:
        return None, None

    try:
        obj = json.loads(text)
    except json.JSONDecodeError:
        return None, None

    if "command" not in obj or not isinstance(obj["command"], dict):
        return None, None

    cmd_data = obj["command"]
    
    # 解析常规Arm指令（1=解锁，0=上锁，无自动逻辑）
    if CMD_ARM in cmd_data:
        try:
            val = int(cmd_data[CMD_ARM])
            if val in (0, 1):
                return CMD_ARM, val
        except Exception:
            pass

    # 解析收桨指令（带时间参数，有自动上锁）
    if CMD_PROP_FOLDED in cmd_data:
        try:
            val = float(cmd_data[CMD_PROP_FOLDED])
            return CMD_PROP_FOLDED, val
        except Exception:
            pass

    return None, None


def _on_mqtt_message(client, userdata, msg):
    try:
        payload = msg.payload.decode("utf-8", errors="ignore")
    except Exception:
        return

    cmd_type, param = _extract_command(payload)
    if not cmd_type:
        rospy.logwarn(f"未识别指令: {payload[:50]}")
        return

    # 处理常规解锁/上锁（无自动上锁）
    if cmd_type == CMD_ARM:
        arm = (param == 1)
        action = "解锁" if arm else "上锁"
        if call_arming(uav_name, arm):  # 常规操作，auto_flow=False
            rospy.loginfo(f"MQTT {action}成功（常规操作，无自动上锁）")
        else:
            rospy.logerr(f"MQTT {action}失败")

    # 处理收桨指令（带自动上锁）
    elif cmd_type == CMD_PROP_FOLDED:
        start_prop_fold(uav_name, param)


def _on_mqtt_connect(client, userdata, flags, rc):
    sub_topic = userdata.get("sub_topic", "")
    if rc == 0 and sub_topic:
        client.subscribe(sub_topic, qos=1)
        rospy.loginfo(f"MQTT连接成功，订阅: {sub_topic}")
    else:
        rospy.logerr(f"MQTT连接失败，rc={rc}")


def start_mqtt_client_if_configured():
    global mqtt_client, mqtt_enabled
    if mqtt is None:
        return False

    broker = rospy.get_param("~mqtt_broker", "").strip()
    sub_topic = rospy.get_param("~mqtt_sub_topic", "").strip()
    if not broker or not sub_topic:
        return False

    username = rospy.get_param("~mqtt_user", "").strip()
    password = rospy.get_param("~mqtt_password", "").strip()
    ca_cert = rospy.get_param("~mqtt_ca_cert", "").strip()
    client_id = f"arm_disarm_{uav_name}" if uav_name else None

    scheme, host, port = _parse_broker(broker)
    try:
        mqtt_client = mqtt.Client(client_id=client_id, userdata={"sub_topic": sub_topic})
        if username:
            mqtt_client.username_pw_set(username, password)

        if scheme in ("ssl", "mqtts"):
            if ca_cert:
                mqtt_client.tls_set(ca_certs=ca_cert)
            else:
                mqtt_client.tls_set()

        mqtt_client.on_connect = _on_mqtt_connect
        mqtt_client.on_message = _on_mqtt_message
        mqtt_client.connect(host, port, keepalive=30)
        mqtt_client.loop_start()
        mqtt_enabled = True
        rospy.loginfo(f"MQTT连接到 {scheme}://{host}:{port}")
        return True
    except Exception as e:
        rospy.logerr(f"MQTT启动失败: {e}")
        return False


def main():
    global prop_state_pub, uav_name
    rospy.init_node("arm_disarm_prop")
    
    uav_name = rospy.get_param("~uav_name", "uav2").strip('/')
    prop_topic = f"/{uav_name}/uavcontrol/prop_folded_state"
    prop_state_pub = rospy.Publisher(prop_topic, Bool, queue_size=10)
    rospy.sleep(1)

    # 启动状态发布线程
    publish_thread = threading.Thread(target=publish_prop_state, daemon=True)
    publish_thread.start()

    # 启动MQTT
    mqtt_started = start_mqtt_client_if_configured()

    # 命令行参数处理
    args = sys.argv[1:]
    if len(args) >= 1:
        cmd = args[0].lower()
        if cmd == "arm":
            # 常规解锁（无自动上锁）
            if call_arming(uav_name, True):
                rospy.loginfo("常规解锁成功（无自动上锁）")
                rospy.spin()
            return 0
        elif cmd == "disarm":
            # 常规上锁
            call_arming(uav_name, False)
            return 0
        elif cmd == "prop_fold":
            # 收桨流程（带自动上锁）
            delay = DEFAULT_PROP_DELAY
            if len(args) >= 2:
                try:
                    delay = float(args[1]) if float(args[1]) > 0 else DEFAULT_PROP_DELAY
                except:
                    pass
            start_prop_fold(uav_name, delay)
            rospy.spin()
            return 0
        elif cmd == "check_prop":
            state = "已完成" if (time.time() < hold_until or prop_folded) else "未完成"
            print(state)
            return 0

    # 交互模式
    if mqtt_started:
        rospy.spin()
    else:
        print("支持命令:")
        print("  arm               → 常规解锁（无自动上锁）")
        print("  disarm            → 常规上锁")
        print("  prop_fold [秒数]  → 收桨（解锁后自动上锁，默认1.2秒）")
        print("  check_prop        → 查看桨叶状态")
        print("  q                 → 退出")

        while not rospy.is_shutdown():
            try:
                inp = input(">> ").strip()
            except EOFError:
                break
            if not inp:
                continue
            parts = inp.split()
            cmd = parts[0].lower()

            if cmd == "q":
                break
            elif cmd == "arm":
                # 常规解锁，无自动上锁
                if call_arming(uav_name, True):
                    rospy.loginfo("常规解锁成功（无自动上锁）")
            elif cmd == "disarm":
                # 常规上锁
                call_arming(uav_name, False)
            elif cmd == "prop_fold":
                # 收桨流程，带自动上锁
                delay = DEFAULT_PROP_DELAY
                if len(parts) >= 2:
                    try:
                        delay = float(parts[1]) if float(parts[1]) > 0 else DEFAULT_PROP_DELAY
                    except:
                        pass
                start_prop_fold(uav_name, delay)
            elif cmd == "check_prop":
                state = "已完成" if (time.time() < hold_until or prop_folded) else "未完成"
                print(state)
            else:
                print("无效命令")

    return 0


if __name__ == "__main__":
    sys.exit(main())
