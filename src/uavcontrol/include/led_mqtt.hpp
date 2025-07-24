#ifndef USR_MQTT_HPP
#define USR_MQTT_HPP

#include <mqtt/async_client.h>
#include <mutex>
#include <atomic>
#include <thread>
#include <chrono>
#include <condition_variable>
#include <nlohmann/json.hpp>
#include <ros/ros.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fstream>
#include <string>
#include <fcntl.h>      // 添加文件控制头文件
#include <sys/stat.h>   // 添加文件状态头文件

using json = nlohmann::json;

// 定义GPIO控制类（使用sysfs接口）
class GPIOCtrl {
private:
    int pin;
    std::string gpio_path;
    int value_fd;  // 文件描述符，用于快速写入

public:
    GPIOCtrl(int gpio_pin) : pin(gpio_pin), value_fd(-1) {
        gpio_path = "/sys/class/gpio/gpio" + std::to_string(pin) + "/";
        
        // 检查GPIO是否已导出
        struct stat st;
        if (stat(gpio_path.c_str(), &st) != 0) {
            // GPIO未导出，尝试导出
            std::ofstream export_file("/sys/class/gpio/export");
            if (export_file.is_open()) {
                export_file << pin;
                export_file.close();
                ROS_INFO("Exported GPIO %d", pin);
                
                // 等待内核创建目录（最多等待1秒）
                for (int i = 0; i < 10; i++) {
                    if (stat(gpio_path.c_str(), &st) == 0) break;
                    std::this_thread::sleep_for(std::chrono::milliseconds(100));
                }
            } else {
                ROS_ERROR("Failed to export GPIO %d: Permission denied. Try running with sudo or setup udev rules.", pin);
                return;
            }
        }
        
        // 设置为输出模式
        std::ofstream direction_file(gpio_path + "direction");
        if (direction_file.is_open()) {
            direction_file << "out";
            direction_file.close();
            ROS_INFO("Set GPIO %d direction to out", pin);
        } else {
            ROS_ERROR("Failed to set direction for GPIO %d", pin);
        }
        
        // 打开value文件用于快速写入
        std::string value_path = gpio_path + "value";
        value_fd = open(value_path.c_str(), O_WRONLY);
        if (value_fd < 0) {
            ROS_ERROR("Failed to open %s for writing", value_path.c_str());
        }
    }

    ~GPIOCtrl() {
        if (value_fd >= 0) {
            close(value_fd);
        }
    }

    void digitalWrite(bool state) {
        // state=true 表示开灯（低电平 0），state=false 表示关灯（高电平 1）
        if (value_fd >= 0) {
            const char val = state ? '0' : '1';
            if (write(value_fd, &val, 1) != 1) {
                ROS_ERROR("Write to GPIO %d failed", pin);
            }
        } else {
            // 回退到文件流方式
            std::ofstream value_file(gpio_path + "value");
            if (value_file.is_open()) {
                value_file << (state ? "1" : "0");
                value_file.close();
            } else {
                ROS_ERROR("Failed to write to GPIO %d", pin);
            }
        }
    }
};

class MQTTBridge : public mqtt::callback {
protected:
    nlohmann::json j;
    std::mutex mtx;

    std::unique_ptr<mqtt::async_client> mqtt_client;
    std::string mqtt_sub_topic;
    std::string mqtt_pub_topic;
    std::string mqtt_user;
    std::string mqtt_password;
    std::string mqtt_broker;
    std::string client_id;
    std::atomic<bool> is_connected{false};
    std::condition_variable cv;

    struct AnnunciatorControl {
        bool lamp_switch = false;
        std::string last_command;
        std::string state_msg;
        std::chrono::system_clock::time_point last_update;
    } led_state;

    GPIOCtrl gpio;  // GPIO控制器实例

    void reconnect() {
        while (!is_connected) {
            try {
                mqtt_client->connect()->wait();
                is_connected = true;
                ROS_INFO("Reconnected to MQTT server: %s", mqtt_broker.c_str());
                publishstate();
            } catch (const mqtt::exception& e) {
                ROS_ERROR("Reconnection failed: %s", e.what());
                std::this_thread::sleep_for(std::chrono::seconds(5));
            }
        }
    }

    json generatestateJson() const {
        return {
            {"timestamp", std::chrono::duration_cast<std::chrono::milliseconds>(
                led_state.last_update.time_since_epoch()).count()},
            {"led_state", led_state.lamp_switch}
        };
    }

    // 打开探照灯（低电平开启）
    void turnOnSearchlight() {
        std::unique_lock<std::mutex> lock(mtx);
        gpio.digitalWrite(true);
        ROS_INFO("探照灯已打开 (GPIO111)");
    }

    // 关闭探照灯（高电平关闭）
    void turnOffSearchlight() {
        std::unique_lock<std::mutex> lock(mtx);
        gpio.digitalWrite(false);
        ROS_INFO("探照灯已关闭 (GPIO111)");
    }

    // 处理指令的函数
    void handleLEDCommand(const json& j) {
        ROS_INFO("收到指令: %s", j.dump().c_str());

        try {
            if (!j.contains("command")) {
                ROS_WARN("非法指令格式");
                return;
            }

            const auto& cmd = j["command"];
            std::string led = cmd.value("led", "");

            if (led == "1") {
                if (!led_state.lamp_switch) {
                    led_state.lamp_switch = true;
                    led_state.state_msg = "探照灯已开启";
                    led_state.last_update = std::chrono::system_clock::now();

                    std::thread([this]() {
                        ROS_INFO("[线程] 打开探照灯 (GPIO111)...");
                        turnOnSearchlight();
                        publishstate(); // 更新状态
                    }).detach();
                }
            } else if (led == "0") {
                if (led_state.lamp_switch) {
                    led_state.lamp_switch = false;
                    led_state.state_msg = "探照灯已关闭";
                    led_state.last_update = std::chrono::system_clock::now();

                    std::thread([this]() {
                        ROS_INFO("[线程] 关闭探照灯 (GPIO111)...");
                        turnOffSearchlight();
                        publishstate(); // 更新状态
                    }).detach();
                }
            }
        } catch (const json::exception& e) {
            ROS_ERROR("JSON解析失败: %s", e.what());
        }
    }

public:
    MQTTBridge(const std::string& broker,
               const std::string& username,
               const std::string& password,
               const std::string& pub_topic,
               const std::string& sub_topic)
        : mqtt_broker(broker),
          mqtt_user(username),
          mqtt_password(password),
          mqtt_pub_topic(pub_topic),
          mqtt_sub_topic(sub_topic),
          gpio(111) {  // 使用全局GPIO编号111 (GPIO3_B7)
        client_id = "led_state_" + std::to_string(std::chrono::system_clock::now().time_since_epoch().count());
        initMQTT();
        
        // 确保探照灯在初始化时关闭
        led_state.lamp_switch = false;  // 初始状态为关闭
        turnOffSearchlight();
        
        ROS_INFO("GPIO控制已初始化 (GPIO111)");
    }

    virtual ~MQTTBridge() {
        try {
            if (mqtt_client && mqtt_client->is_connected()) {
                mqtt_client->disconnect()->wait();
                ROS_INFO("Disconnected from MQTT server");
            }
        } catch (const mqtt::exception& e) {
            ROS_ERROR("Disconnection failed: %s", e.what());
        }
        // 确保程序退出时关闭灯
        turnOffSearchlight();
    }

    void initMQTT() {
        mqtt::connect_options opts;
        opts.set_clean_session(true);
        opts.set_automatic_reconnect(true);
        opts.set_keep_alive_interval(60);

        if (!mqtt_user.empty() && !mqtt_password.empty()) {
            opts.set_user_name(mqtt_user);
            opts.set_password(mqtt_password);
        }

        mqtt_client = std::make_unique<mqtt::async_client>(mqtt_broker, client_id);
        mqtt_client->set_callback(*this);

        try {
            mqtt_client->connect(opts)->wait();
            is_connected = true;
            mqtt_client->start_consuming();
            mqtt_client->subscribe(mqtt_sub_topic, 1);
            ROS_INFO("Connected to MQTT server: %s", mqtt_broker.c_str());
        } catch (const mqtt::exception& e) {
            ROS_FATAL("MQTT Connection failed: %s", e.what());
            ros::shutdown();
        }
    }

    void message_arrived(mqtt::const_message_ptr msg) override {
        std::lock_guard<std::mutex> lock(mtx);
        ROS_INFO("Received message on topic [%s]: %s", msg->get_topic().c_str(), msg->get_payload().c_str());
        try {
            j = json::parse(msg->get_payload());
            ROS_INFO("JSON parsed: %s", j.dump().c_str());

            if (!j.is_object() || !j.contains("command") || !j["command"].is_object()) {
                ROS_ERROR("Invalid JSON structure: missing 'command' object");
                return;
            }

            handleLEDCommand(j);
        } catch (const json::exception& e) {
            ROS_ERROR("JSON parsing error: %s", e.what());
        }
    }

    void publish(const std::string& payload, int qos = 0) {
        std::lock_guard<std::mutex> lock(mtx);
        try {
            auto msg = mqtt::make_message(mqtt_pub_topic, payload);
            msg->set_qos(qos);
            mqtt_client->publish(msg);
        } catch (const mqtt::exception& e) {
            ROS_ERROR("Publish failed: %s", e.what());
        }
    }

    void connection_lost(const std::string& cause) override {
        std::lock_guard<std::mutex> lock(mtx);
        ROS_ERROR("Connection lost: %s", cause.c_str());
        is_connected = false;
        cv.notify_all();
        std::thread([this]() {
            reconnect();
        }).detach();
    }

    void publishToTopic(const std::string& topic, const std::string& payload, int qos = 0) {
        std::lock_guard<std::mutex> lock(mtx);
        try {
            auto msg = mqtt::make_message(topic, payload);
            msg->set_qos(qos);
            mqtt_client->publish(msg);
        } catch (const mqtt::exception& e) {
            ROS_ERROR("Publish failed: %s", e.what());
        }
    }

    void subscribe(const std::string& topic, int qos = 1) {
        std::lock_guard<std::mutex> lock(mtx);
        try {
            mqtt_client->subscribe(topic, qos);
            ROS_INFO("Subscribed to topic: %s", topic.c_str());
        } catch (const mqtt::exception& e) {
            ROS_ERROR("Subscribe failed: %s", e.what());
        }
    }

    void wait_for_connection() {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [this] { return is_connected.load(); });
    }

    void publishstate() {
        std::lock_guard<std::mutex> lock(mtx);
        try {
            auto state_json = generatestateJson();
            auto msg = mqtt::make_message(mqtt_pub_topic, state_json.dump());
            msg->set_qos(1);
            mqtt_client->publish(msg)->wait_for(std::chrono::seconds(1));
            ROS_INFO("[MQTT] 状态已更新 (GPIO111): %s", state_json.dump().c_str());
        } catch (const mqtt::exception& e) {
            ROS_ERROR("状态发布失败: %s", e.what());
        }
    }
};

#endif // USR_MQTT_HPP
