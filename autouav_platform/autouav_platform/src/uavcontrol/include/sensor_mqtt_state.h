#ifndef SENSOR_MQTT_STATE_H
#define SENSOR_MQTT_STATE_H

#include <ros/ros.h>
#include <mqtt/async_client.h>
#include <memory>
#include <mutex>
#include <atomic>
#include <condition_variable>
#include <nlohmann/json.hpp>
using json = nlohmann::json; // 使用标准json类型

// UAV设备状态结构
struct UAVState {
    bool led_state = false;         // 探照灯状态    
    bool shout_state = false;       // 喊话器状态
    bool parachute_state = false;   // 降落伞状态
    bool police_state = false;      // 警灯状态
    bool pwm1_state = false;        // 抛投器1状态
    bool pwm2_state = false;        // 抛投器2状态
    bool pwm3_state = false;        // 抛投器3状态
    bool pwm4_state = false;        // 抛投器4状态    
    bool connected = false;         // MQTT连接状态
    double timestamp = 0.0;         // 状态时间戳

    json toJson() const {
        return json({
            {"uavstate", {
                {"led_state", led_state},
                {"shout_state", shout_state},
                {"parachute_state", parachute_state},
                {"police_state", police_state},
                {"left", {
                    {"pwm1_state", pwm1_state},
                    {"pwm2_state", pwm2_state}
                }},
                {"right", {
                    {"pwm3_state", pwm3_state},
                    {"pwm4_state", pwm4_state}
                }},
            }}
        });
    }
};

// 状态发布管理器
class StatePublisherManager : public mqtt::callback {
public:
    StatePublisherManager(
        ros::NodeHandle& nh,
        const std::string& broker,
        const std::string& username,
        const std::string& password,
        const std::string& pub_topic,
        const std::string& sync_topic,
        double publish_freq,
        bool auto_start = true
    );
    
    ~StatePublisherManager() override;
    
    // MQTT回调函数
    void connection_lost(const std::string& cause) override;
    void message_arrived(mqtt::const_message_ptr msg) override;
    void delivery_complete(mqtt::delivery_token_ptr token) override;
    
    // 状态管理接口
    void updateState(const UAVState& state);
    void updateStatePartial(const UAVState& partial_state);
    UAVState getCurrentState() const;
    
    // 发布控制
    void startPublishing();
    void stopPublishing();
    bool isConnected() const;
    void waitForConnection();
    
private:
    // MQTT相关成员
    std::unique_ptr<mqtt::async_client> mqtt_client_;
    std::string broker_;
    std::string username_;
    std::string password_;
    std::string pub_topic_;
    std::string sync_topic_;  // 状态同步主题
    std::atomic<bool> connected_{false};
    
    // ROS相关成员
    ros::NodeHandle& nh_;
    ros::Timer publish_timer_;
    double publish_freq_;
    
    // 状态相关成员
    UAVState current_state_;
    mutable std::mutex state_mutex_;
    std::condition_variable connection_cv_;
    std::mutex connection_mutex_;
    
    // 私有方法
    void initMqtt();
    void reconnect();
    void publishState();
};

#endif // SENSOR_MQTT_STATE_H
