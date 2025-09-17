#include <ros/ros.h>
#include <uavcontrol_msgs/UAVState.h>
#include <uavcontrol_msgs/UAVCommand.h>
#include "uav_estimator.h" 
#include <mqtt/client.h>
#include <nlohmann/json.hpp>
#include <string> 
#include <memory>
#include <unistd.h>
#include <cmath>
#include <std_msgs/Bool.h>
#include <mutex>  // 用于线程安全


using json = nlohmann::json;

class MQTTBridge : public virtual mqtt::callback {
private:
    // ROS节点相关
    ros::Subscriber ros_state_sub;           // ROS端无人机状态订阅者
    ros::Subscriber ros_waypoint_state_sub;  // ROS端航点状态订阅者
    ros::Timer publish_timer;                // 控制发布频率的定时器（1Hz）
    
    // 状态缓存（用于定时发布）
    uavcontrol_msgs::UAVState latest_state;  // 最新的无人机状态
    bool state_received = false;             // 是否已收到状态消息
    std::mutex state_mutex;                  // 保护状态缓存的线程锁
    
    // MQTT相关
    std::unique_ptr<mqtt::client> mqtt_client;
    std::string mqtt_state_topic;   // MQTT状态主题（ROS→MQTT）
    std::string mqtt_user;          // mqtt账号
    std::string mqtt_password;      // mqtt密码
    std::string mqtt_broker;        // mqtt服务器地址
    std::string uav_name;           // 无人机名称
    
    // 航点状态存储
    uavcontrol_msgs::UAVState latest_waypoint_state;  // 最新的航点状态
    bool waypoint_state_received = false;              // 是否已接收到航点状态


    // 字符串转FlightPhase枚举
    UAV_estimator::FlightPhase stringToFlightPhase(const std::string& phase_str) {
        if (phase_str == "READY") return UAV_estimator::FlightPhase::READY;
        else if (phase_str == "TAKING_OFF") return UAV_estimator::FlightPhase::TAKING_OFF;
        else if (phase_str == "FLYING") return UAV_estimator::FlightPhase::FLYING;
        else if (phase_str == "RETURN") return UAV_estimator::FlightPhase::RETURN;
        else if (phase_str == "LANDING") return UAV_estimator::FlightPhase::LANDING;
        else if (phase_str == "GROUND") return UAV_estimator::FlightPhase::GROUND;
        else if (phase_str == "DATA_ERR") return UAV_estimator::FlightPhase::DATA_ERR;
        else {
            ROS_WARN("Unknown flight phase string: %s", phase_str.c_str());
            return UAV_estimator::FlightPhase::DATA_ERR; // 未知状态默认返回错误
        }
    }


    // 实现mqtt::callback纯虚函数
    void connection_lost(const std::string& cause) override {
        ROS_WARN("MQTT connection lost: %s. Reconnecting...", cause.c_str());
    }

    void message_arrived(mqtt::const_message_ptr msg) override {
        ROS_DEBUG("Received MQTT message on %s: %s", 
                  msg->get_topic().c_str(), msg->to_string().c_str());
    }

    void delivery_complete(mqtt::delivery_token_ptr token) override {
        
    }

    // 定时器回调：每秒发布一次最新状态到MQTT
    void timerPublishCallback(const ros::TimerEvent& event) {
        if (!state_received) return;  // 未收到状态则不发布
        
        std::lock_guard<std::mutex> lock(state_mutex);  // 线程安全
        handleROSStateToMQTT(latest_state);  // 使用缓存的最新状态发布
    }

    // 实际处理并发布到MQTT的函数（由定时器触发）
    void handleROSStateToMQTT(const uavcontrol_msgs::UAVState& msg) {
        UAV_estimator::FlightPhase phase = stringToFlightPhase(msg.flight_phase);
        json j;

        // 飞机id
        j["uav_id"] = msg.uav_id; 

        // 是否解锁
        j["armed"] = msg.armed;

        // 飞行模式
        j["mode"] = msg.mode;

        // 电池电压
        j["battery_v"] = msg.battery_state;

        // 电量％比
        j["battery_b"] = msg.battery_percetage * 100;
        
        // 起飞完成状态
        j["fly_state"] = msg.takeoff_completed; 

        // 降落完成状态
        j["land_state"] = msg.landing_completed;  

        // 桨叶收纳完成状态
        j["prop_folded"] = msg.prop_folded_state;

        // 飞行阶段状态(READY/TAKING_OFF等状态)
        j["flight_state"] = UAV_estimator::flightPhaseToString(phase); 
        
        // 无人机位置
        j["position"] = {msg.position[0], msg.position[1], msg.position[2]};

        // 无人机速度  
        j["velocity"] = {msg.velocity[0], msg.velocity[1], msg.velocity[2]};

        // 无人机经纬度
        j["latitude"] = {msg.latitude};//经度
        j["longitude"] = {msg.longitude};//纬度
        j["altitude"] = {msg.altitude};//海拔高度

        // 无人机姿态欧拉角（单位：度）
        j["attitude_rpy"] = {msg.attitude_rpy[0], msg.attitude_rpy[1], msg.attitude_rpy[2]};

        // 无人机姿态欧拉角（单位：弧度）
        j["attitude"] = {msg.attitude[0], msg.attitude[1], msg.attitude[2]};

        // GPS状态／卫星数量
        j["gps_status"] = getGPSStatusString(msg.gps_status);
        j["gps_satellites"] = msg.gps_num;
        
        // 航点任务状态
        if (waypoint_state_received) {
            j["mission_active"] = latest_waypoint_state.mission_active;
            j["mission_state"] = latest_waypoint_state.mission_state;
            j["current_waypoint"] = latest_waypoint_state.current_waypoint;
            j["total_waypoints"] = latest_waypoint_state.total_waypoints;
            j["last_reached_waypoint"] = latest_waypoint_state.last_reached_waypoint;
        } else {
            // 没有收到航点状态时的默认值
            j["mission_active"] = false;
            j["mission_state"] = "NO_MISSION_DATA";
            j["current_waypoint"] = 65535;  // -1的无符号表示
            j["total_waypoints"] = 0;
            j["last_reached_waypoint"] = 65535;  // -1的无符号表示
        }

        publishMQTT(mqtt_state_topic, j.dump());
    }

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
        initROS(nh);
        initMQTT();  
    }

    // 初始化MQTT连接
    void initMQTT() {
        mqtt::connect_options opts;
        opts.set_clean_session(true);
        opts.set_automatic_reconnect(true);  // 启用自动重连
        opts.set_keep_alive_interval(60);    // 设置心跳间隔

        // 设置用户名密码
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
        // 订阅无人机状态信息（仅缓存，不直接发布）
        std::string state_topic = "/" + uav_name + "/prometheus/state";
        ros_state_sub = nh.subscribe<uavcontrol_msgs::UAVState>(
            state_topic, 10, &MQTTBridge::cacheROSState, this
        );

        // 订阅航点状态信息
        std::string waypoint_state_topic = "/" + uav_name + "/prometheus/state_waypoint";
        ros_waypoint_state_sub = nh.subscribe<uavcontrol_msgs::UAVState>(
            waypoint_state_topic, 10, &MQTTBridge::handleWaypointState, this
        );

        // 初始化定时器：1秒触发一次（控制发布频率）
        publish_timer = nh.createTimer(ros::Duration(1.0), &MQTTBridge::timerPublishCallback, this);
    }

    // 仅缓存最新状态，不直接发布
    void cacheROSState(const uavcontrol_msgs::UAVState::ConstPtr& msg) {
        std::lock_guard<std::mutex> lock(state_mutex);  // 线程安全
        latest_state = *msg;  // 缓存最新状态
        state_received = true;
    }
    
    // 航点状态数据处理
    void handleWaypointState(const uavcontrol_msgs::UAVState::ConstPtr& msg) {
        latest_waypoint_state = *msg;
        waypoint_state_received = true;
    }

    std::string getGPSStatusString(uint8_t status) {
        switch (status) {
            case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_NO_GPS:return "NO_GPS";
            case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_NO_FIX:return "NO_FIX";
            case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_2D_FIX:return "2D_FIX";
            case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_3D_FIX:return "3D_FIX";
            case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_DGPS:return "DGPS";
            case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_RTK_FLOATR:return "RTK_FLOAT";
            case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_RTK_FIXEDR:return "RTK_FIXED";
            case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_STATIC:return "STATIC";
            case uavcontrol_msgs::UAVState::GPS_FIX_TYPE_PPP:return "PPP";
            default:return "UNKNOWN";
        }
    }

    // 设置QoS级别并发布
    void publishMQTT(const std::string& topic, const std::string& payload) {
        try {
            auto msg = mqtt::make_message(topic, payload);
            msg->set_qos(0);
            mqtt_client->publish(msg);
        } catch (const mqtt::exception& e) {
            ROS_ERROR("Publish failed: %s", e.what());
        }
    }
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "uavstate_mqtt_bridge");
    ros::NodeHandle nh;

    std::string uav_name, mqtt_broker, mqtt_user, mqtt_password;
    nh.param("uav_name", uav_name, std::string("uav2"));
    nh.param("mqtt_broker", mqtt_broker, std::string("tcp://47.104.183.127:1983"));
    nh.param("mqtt_user", mqtt_user, std::string("pxtest"));
    nh.param("mqtt_password", mqtt_password, std::string("test2025@px"));

    MQTTBridge bridge(nh, uav_name, mqtt_broker, mqtt_user, mqtt_password);
    ros::AsyncSpinner spinner(2);
    spinner.start();
    ros::waitForShutdown();

    return 0;
}
    