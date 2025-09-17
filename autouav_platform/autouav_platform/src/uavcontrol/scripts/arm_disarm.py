#!/usr/bin/env python3
import sys
import threading
import time

import rospy
from mavros_msgs.srv import CommandBool
from std_msgs.msg import Bool  # 简单布尔类型消息


# 核心状态变量
prop_folded_completed = False  # 桨叶状态
hold_until = 0.0               # 保持true的截止时间（时间戳）
uav_name = ""                  # 无人机名
prop_state_pub = None          # 独立话题发布器
is_holding = False             # 标记是否处于5秒保持阶段（新增）


def _build_service_name(service_ns: str) -> str:
    ns = (service_ns or "").strip()
    if not ns:
        return "/mavros/cmd/arming"
    if ns.startswith("/"):
        ns = ns[1:]
    return f"/{ns}/mavros/cmd/arming"


def publish_prop_state():
    """定时发布桨叶状态（独立话题），添加5秒后自动重置逻辑"""
    global prop_folded_completed, hold_until, is_holding
    while not rospy.is_shutdown():
        current_time = time.time()
        
        # 5秒保持阶段结束后，强制重置状态（核心修复）
        if is_holding and current_time >= hold_until:
            prop_folded_completed = False  # 重置为false
            is_holding = False  # 退出保持阶段
        
        # 确定当前状态
        current_state = True if current_time < hold_until else prop_folded_completed
        # 发布到独立话题
        prop_state_pub.publish(current_state)
        time.sleep(0.1)  # 10Hz发布频率


def call_arming(service_ns, arm, auto_flow=False):
    global prop_folded_completed, hold_until, is_holding
    service = _build_service_name(service_ns)

    try:
        rospy.wait_for_service(service, 5.0)
    except Exception:
        rospy.logerr("服务超时")
        return False

    try:
        proxy = rospy.ServiceProxy(service, CommandBool)
        resp = proxy(arm)
        if resp.success:
            if arm:
                # 解锁时：重置所有状态
                prop_folded_completed = False
                hold_until = 0.0
                is_holding = False
            elif auto_flow:
                # 自动上锁时：进入5秒保持阶段
                prop_folded_completed = True
                hold_until = time.time() + 5.0  # 5秒后过期
                is_holding = True  # 标记进入保持阶段
            return True
        return False
    except Exception as e:
        rospy.logerr(f"服务调用失败: {e}")
        return False


def auto_disarm(service_ns, delay=1.2):
    def _disarm():
        if not rospy.is_shutdown():
            call_arming(service_ns, False, True)
    threading.Timer(delay, _disarm).start()


def main():
    global prop_state_pub, uav_name
    rospy.init_node("arm_disarm_prop")
    
    uav_name = rospy.get_param("~uav_name", "uav2").strip('/')
    # 定义独立话题（专门用于传递桨叶状态）
    prop_topic = f"/{uav_name}/uavcontrol/prop_folded_state"
    
    # 初始化独立话题发布器（使用std_msgs/Bool类型）
    prop_state_pub = rospy.Publisher(prop_topic, Bool, queue_size=10)
    rospy.sleep(1)  # 等待发布器就绪

    # 启动独立线程持续发布状态
    publish_thread = threading.Thread(target=publish_prop_state, daemon=True)
    publish_thread.start()

    # 命令行参数处理
    args = sys.argv[1:]
    if len(args) >= 1:
        cmd = args[0].lower()
        if cmd == "arm":
            delay = 1.2
            if len(args) >= 2:
                try:
                    delay = float(args[1]) if float(args[1]) > 0 else 1.2
                except:
                    pass
            if call_arming(uav_name, True):
                auto_disarm(uav_name, delay)
                rospy.spin()
            return 0
        elif cmd == "disarm":
            call_arming(uav_name, False)
            return 0
        elif cmd == "check_prop":
            current_state = "已完成" if (time.time() < hold_until or prop_folded_completed) else "未完成"
            print(current_state)
            return 0

    # 交互模式
    print("支持命令:")
    print("  arm [秒数] → 解锁，延迟后自动上锁（默认1.2秒）")
    print("  disarm     → 手动上锁")
    print("  check_prop → 查看桨叶状态")
    print("  q          → 退出")

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
            delay = 1.2
            if len(parts) >= 2:
                try:
                    delay = float(parts[1]) if float(parts[1]) > 0 else 1.2
                except:
                    pass
            if call_arming(uav_name, True):
                auto_disarm(uav_name, delay)
        elif cmd == "disarm":
            call_arming(uav_name, False)
        elif cmd == "check_prop":
            current_state = "已完成" if (time.time() < hold_until or prop_folded_completed) else "未完成"
            print(current_state)
        else:
            print("无效命令")

    return 0


if __name__ == "__main__":
    sys.exit(main())
    