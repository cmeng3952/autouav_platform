#include <ros/ros.h>
#include <uavcontrol_msgs/UAVState.h>
#include <uavcontrol_msgs/UAVCommand.h>
#include <mqtt/client.h>
#include <nlohmann/json.hpp>
#include <string> 
#include <memory>
#include <unistd.h>
#include <cmath>

using json = nlohmann::json;

class MQTTBridge : public virtual mqtt::callback {
private:
    // ROS节点相关
    ros::Subscriber ros_state_sub;   // ROS端无人机状态（飞机的状态）

    // MQTT相关
    std::unique_ptr<mqtt::client> mqtt_client;
    std::string mqtt_state_topic;   // MQTT状态主题（ROS→MQTT）
    std::string mqtt_user;          // mqtt账号
    std::string mqtt_password;      // mqtt密码
    std::string mqtt_broker;        // mqtt服务器地址
    std::string uav_name = "uav1";  // 无人机名称

public:
    MQTTBridge(ros::NodeHandle& nh,
               const std::string& uav_name,
               const std::string& broker,
               const std::string& username,
               const std::string& password)
        : uav_name(uav_name),                          // 初始化无人机名称
          mqtt_broker(broker),                         // 初始化MQTT服务器地址
          mqtt_user(username),                         // 初始化MQTT账号
          mqtt_password(password),                     // 初始化MQTT密码
          mqtt_state_topic("uavcontrol/state/" + uav_name) // 初始化MQTT状态主题
  
    {
        // 初始化ROS和MQTT连接
        initROS(nh);
        initMQTT();  // 使用默认构造
    }

    // 初始化MQTT连接
    void initMQTT() {
        mqtt::connect_options opts;
        opts.set_clean_session(true);
        opts.set_automatic_reconnect(true);  // 启用自动重连
        opts.set_keep_alive_interval(60);    // 设置心跳间隔

        // 设置用户名密码（如果服务器需要）
        if (!mqtt_user.empty() && !mqtt_password.empty()) {
            opts.set_user_name(mqtt_user);
            opts.set_password(mqtt_password);
        }

        // 唯一Client ID生成
        mqtt_client = std::make_unique<mqtt::client>(mqtt_broker, "uav_bridge" + uav_name + std::to_string(ros::Time::now().sec % 100000));
        std::string client_id = "uav_bridge_" + uav_name + "_" +
        std::to_string(ros::Time::now().toNSec()) + "_" +
        std::to_string(getpid());
        
        try {
            mqtt_client->connect(opts);

            ROS_INFO("Connected to MQTT server %s", mqtt_broker.c_str());
        } catch (const mqtt::exception& e) {
            ROS_FATAL("MQTT Connection failed: %s", e.what());
            ros::shutdown();
        }
    }

    // 初始化ROS订阅/发布者
    void initROS(ros::NodeHandle& nh) {
        // 订阅无人机状态信息（强制全局路径）
        std::string state_topic = "/" + uav_name + "/prometheus/state";
        ros_state_sub = nh.subscribe<uavcontrol_msgs::UAVState>(
            state_topic, 10, &MQTTBridge::handleROSState, this
        );


    }

    // 无人机状态数据处理转发到MQTT服务器
    void handleROSState(const uavcontrol_msgs::UAVState::ConstPtr& msg) {
        json j;
        j["uav_id"] = msg->uav_id; //飞机id
        j["armed"] = msg->armed;//是否解锁
        j["mode"] = msg->mode;//飞行模式
        j["battery_v"] = msg->battery_state;//电池电压
        j["battery_b"] = msg->battery_percetage * 100;//电量％比
        
        // 无人机位置
        j["position"] = {msg->position[0], msg->position[1], msg->position[2]};

        //无人机速度  
        j["velocity"] = {msg->velocity[0], msg->velocity[1], msg->velocity[2]};


        //无人机经纬度  
        j["latitude"] = {msg->latitude};//经度
        j["longitude"] = {msg->longitude};//纬度
        j["altitude"] = {msg->altitude};//海拔高度

        // 无人机姿态欧拉角（单位：度）
        j["attitude_rpy"] = {msg->attitude_rpy[0], msg->attitude_rpy[1], msg->attitude_rpy[2]};


        // 无人机姿态欧拉角（单位：弧度）
        j["attitude"] = {msg->attitude[0], msg->attitude[1], msg->attitude[2]};

        // GPS状态／卫星数量
        j["gps_status"] = getGPSStatusString(msg->gps_status);
        j["gps_satellites"] = msg->gps_num;

        publishMQTT(mqtt_state_topic, j.dump());
    }
    std::string getGPSStatusString(uint8_t status) {
    switch (status) {
        case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_NO_GPS:return "NO_GPS";  // 无GPS

        case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_NO_FIX:return "NO_FIX";  // 无定位

        case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_2D_FIX:return "2D_FIX";  // 2D定位

        case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_3D_FIX:return "3D_FIX";  // 3D定位

        case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_DGPS:return "DGPS";    // 差分GPS

        case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_RTK_FLOATR:return "RTK_FLOAT";  // RTK浮点解

        case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_RTK_FIXEDR:return "RTK_FIXED";  // RTK固定解

        case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_STATIC:return "STATIC";  // 静态定位

        case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_PPP:return "PPP";     // 精密单点定位

        default:return "UNKNOWN";  // 未知状态
        }
    }



    //设置QoS级别
    void publishMQTT(const std::string& topic, const std::string& payload) {
        try {
            auto msg = mqtt::make_message(topic, payload);
            msg->set_qos(0); // 设置QoS级别
            mqtt_client->publish(msg);
        } catch (const mqtt::exception& e) {
            ROS_ERROR("Publish failed: %s", e.what());
        }
    }
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "uavstate_mqtt_bridge");
    ros::NodeHandle nh;  // 使用全局命名空间，而非私有（~）

    std::string uav_name, mqtt_broker, mqtt_user, mqtt_password;
    nh.param("uav_name", uav_name, std::string("uav1"));
    nh.param("mqtt_broker", mqtt_broker, std::string("tcp://47.104.183.127:1983"));
    nh.param("mqtt_user", mqtt_user, std::string("pxtest"));
    nh.param("mqtt_password", mqtt_password, std::string("test2025@px"));

    MQTTBridge bridge(nh, uav_name, mqtt_broker, mqtt_user, mqtt_password);
    ros::AsyncSpinner spinner(2);
    spinner.start();
    ros::waitForShutdown();

    return 0;
}
