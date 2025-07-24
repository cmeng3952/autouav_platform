#include "ros/ros.h"
#include <uavcontrol_msgs/ShoutStates.h>
#include <shout_mqtt.hpp>
#include <nlohmann/json.hpp>
#include <thread>
#include <iostream>

class ShoutBridge : public MQTTBridge {
public:
    ShoutBridge(const std::string& broker,
                const std::string& username,
                const std::string& password,
                const std::string& pub_topic,
                const std::string& sub_topic)
        : MQTTBridge(broker, username, password, pub_topic, sub_topic) {}

    // 获取状态（非 const 成员函数，无需处理 const 互斥锁）
    void get_state(bool& is_shouting, std::string& state_msg) {
        std::lock_guard<std::mutex> lock(mtx);
        is_shouting = shout_state.is_shouting; // 直接使用基类的 shout_state
        state_msg = shout_state.state_msg;
    }
};

int main(int argc, char *argv[]) {
    setlocale(LC_ALL, "");
    ros::init(argc, argv, "shout_mqtt_bridge");
    ros::NodeHandle nh;

    std::string broker = "tcp://47.104.183.127:1983";
    std::string username = "pxtest";
    std::string password = "test2025@px";
    std::string pub_topic = "uavsensor/state/uav1";
    std::string sub_topic = "uavcontrol/command/uav1";

    ShoutBridge bridge(broker, username, password, pub_topic, sub_topic);
    ros::Publisher shout_pub = nh.advertise<uavcontrol_msgs::ShoutStates>("shout_state", 10);
    uavcontrol_msgs::ShoutStates shout_msg;

    ros::Rate rate(1);
    while (ros::ok()) {
        bool is_shouting;
        std::string state_msg;
        bridge.get_state(is_shouting, state_msg);

        shout_msg.is_active = is_shouting;
        shout_msg.state = state_msg;
        shout_pub.publish(shout_msg);

        nlohmann::json mqtt_msg;
        // mqtt_msg["shout_state"] = {
        //     {"active", is_shouting},
        //     {"message", state_msg}
        // };
        // bridge.publish(mqtt_msg.dump());
        // 构建MQTT消息，仅包含shout_state布尔值
        mqtt_msg["shout_state"] = is_shouting; // 直接赋值布尔值，生成{"shout_state": true/false}
        bridge.publish(mqtt_msg.dump()); // 发布JSON字符串

        ROS_INFO_THROTTLE(0.5, "反馈当前状态: %s", state_msg.c_str());

        ros::spinOnce();
        rate.sleep();
    }

    return 0;
}
