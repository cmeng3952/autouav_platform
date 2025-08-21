#include <ros/ros.h>
#include "sensor_mqtt_control.h"
#include "sensor_mqtt_state.h"

int main(int argc, char**argv) {
    ros::init(argc, argv, "uavsensor_control_node");
    ros::NodeHandle nh("~");
    
    // 从参数服务器获取配置（可通过launch文件修改）
    std::string broker = nh.param<std::string>("broker", "47.104.183.127:1983");
    std::string username = nh.param<std::string>("username", "pxtest");
    std::string password = nh.param<std::string>("password", "test2025@px");
    std::string pub_topic = nh.param<std::string>("pub_topic", "uavsensor/state/uav2");
    std::string sub_topic = nh.param<std::string>("sub_topic", "uavcontrol/command/uav2");
    std::string stream_url = nh.param<std::string>("stream_url", "rtmp://47.104.183.127/audio/uav2");
    std::string state_sync_topic = nh.param<std::string>("state_sync_topic", "uavsensor/state_sync/uav2");
    int parachute_pwm = nh.param<int>("parachute_pwm", 5);
    int police = nh.param<int>("police_gpio", 99);
    double publish_freq = nh.param<double>("publish_freq", 1.0);  // 状态发布频率

    ROS_INFO("UAV sensor control node is starting...");
    
    try {
        // 创建状态发布管理器（负责状态存储和发布）
        StatePublisherManager state_manager(
            nh,  // ROS节点句柄
            broker, username, password, pub_topic, 
            state_sync_topic,  // 状态同步指令主题
            publish_freq, 
            true  // 启用自动定时发布
        );
        
        // 等待状态管理器MQTT连接
        state_manager.waitForConnection();
        
        // 创建控制管理器（负责设备控制，依赖状态管理器）
        ControlDeviceManager manager(
            broker, username, password, pub_topic, sub_topic, 
            stream_url, nh, 
            state_manager,  // 状态管理器引用
            parachute_pwm, police
        );
        
        // 等待控制管理器连接
        manager.wait_for_connection();
        
        ROS_INFO("UAV sensor control node is ready，waiting instruction...");
        
        // 进入ROS主循环（处理回调）
        ros::spin();
    } catch (const std::exception& e) {
        ROS_FATAL("Node running error: %s", e.what());
        return 1;
    }
    
    return 0;
}
