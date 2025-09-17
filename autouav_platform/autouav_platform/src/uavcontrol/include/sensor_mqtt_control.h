#ifndef SENSOR_MQTT_CONTROL_H
#define SENSOR_MQTT_CONTROL_H

#include <ros/ros.h>
#include <mqtt/async_client.h>
#include <nlohmann/json.hpp>
#include <memory>
#include <mutex>
#include <atomic>
#include <condition_variable>
#include <string>
#include <vector>
#include <stdexcept>
#include <unistd.h>
#include <signal.h>  // 添加信号处理头文件

// 前向声明StatePublisherManager和UAVState
class StatePublisherManager;
struct UAVState;

using json = nlohmann::json;

// GPIO控制类
class GPIOCtrl {
public:
    explicit GPIOCtrl(int gpio_pin);  // 必须传入GPIO引脚
    GPIOCtrl() = delete;  // 禁止默认构造
    ~GPIOCtrl();
    
    void digitalWrite(bool state);
    
private:
    int pin;
    bool is_exported = false;
    void exportGPIO();
    void unexportGPIO();
    void setDirection(const std::string& direction);
};

// PWM舵机控制类
// class PWMCtrl {
// public:
//     explicit PWMCtrl(ros::NodeHandle& nh, int channel);
//     ~PWMCtrl();
    
//     void setPWMValue(int value); // 设置PWM值(1000-1600us)
//     void enable();               // 启用舵机
//     void disable();              // 禁用舵机
    
// private:
//     ros::NodeHandle& nh;
//     int channel;
//     ros::ServiceClient command_client;
// };

class PWMCtrl {
public:
    PWMCtrl(int gpio_pin);
    ~PWMCtrl();
    void setPWMValue(int pwm_value);
    void enable(int pwm_value);
    void disable();

private:
    int pin;
    bool is_exported;
    void exportGPIO();
    void unexportGPIO();
    void setDirection(const std::string& direction);
    void digitalWrite(bool state);
};

// 控制设备管理器
class ControlDeviceManager : public mqtt::callback {
public:
    ControlDeviceManager(
        const std::string& broker,
        const std::string& username,
        const std::string& password,
        const std::string& pub_topic,
        const std::string& sub_topic,
        const std::string& stream_url,
        ros::NodeHandle& nh,
        StatePublisherManager& state_manager,
        int parachute_gpio = 5,
        int police = 112);
    
    ~ControlDeviceManager() override;
    
    // MQTT回调函数
    void message_arrived(mqtt::const_message_ptr msg) override;
    void connection_lost(const std::string& cause) override;
    void delivery_complete(mqtt::delivery_token_ptr token) override;
    
    // 公共接口方法
    void wait_for_connection();
    
private:
    std::unique_ptr<mqtt::async_client> mqtt_client;
    std::string mqtt_sub_topic;
    std::string mqtt_pub_topic;
    std::string mqtt_user;
    std::string mqtt_password;
    std::string mqtt_broker;
    std::atomic<bool> is_connected{false};
    std::condition_variable cv;
    std::mutex mtx;
    ros::NodeHandle& nh_;  
    
    // 设备控制相关成员（需在构造函数中通过初始化列表传入GPIO引脚）
    pid_t audio_pgid = -1;  // 改为进程组ID
    std::mutex audio_mutex;
    GPIOCtrl searchlight_gpio;  // 对应实现中的searchlight_gpio(111)
    GPIOCtrl police_relay;      // 对应实现中的police_relay(police)
    const std::string STREAM_URL;
    
    // PWM控制
    std::vector<std::unique_ptr<PWMCtrl>> pwm_controllers;
    StatePublisherManager& state_manager;  // 引用状态发布管理器
    
    // 私有方法
    void initMQTT();
    void processCommand(const json& cmd);
    void setShoutState(bool new_state);
    void setLedState(bool new_state);
    void setPWMState(int channel, bool new_state);
    void setPoliceState(bool new_state);
    void startAudioStream();
    void stopAudioStream();
};

#endif // SENSOR_MQTT_CONTROL_H
