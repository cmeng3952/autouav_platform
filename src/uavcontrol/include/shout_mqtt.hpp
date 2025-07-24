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

using json = nlohmann::json;

// 定义音频流地址和音量增益
const std::string STREAM_URL = "rtmp://47.104.183.127/audio/uav1";
const std::string VOLUME_GAIN = "20dB";

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
        bool is_shouting = false;
        std::string last_command;
        std::string state_msg;
        std::chrono::system_clock::time_point last_update;
    } shout_state;

    // 音频相关成员变量
    pid_t audio_pid = -1;
    FILE* audio_stream = nullptr; // 用于向 ffmpeg 发送命令
    std::mutex audio_mutex;
    std::condition_variable audio_cv;

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

    // json generatestateJson() const {
    //     return {
    //         {"timestamp", std::chrono::duration_cast<std::chrono::milliseconds>(
    //             shout_state.last_update.time_since_epoch()).count()},
    //         {"shout_state", {
    //             {"active", shout_state.is_shouting},
    //             {"message", shout_state.state_msg},
    //         }}
    //     };
    // }
    json generatestateJson() const {
        return {
            {"timestamp", std::chrono::duration_cast<std::chrono::milliseconds>(
                shout_state.last_update.time_since_epoch()).count()},
            {"shout_state", shout_state.is_shouting}
        };
    }

    // 音频控制函数， ffmpeg 支持通过标准输入（stdin）接收控制命令的特性，将 q 字符发送给 ffmpeg 进程来停止它。
    // 这里使用 popen 打开一个管道，向 ffmpeg 发送命令，并使用 aplay 进程播放音频。
    void startAudioStream(const std::string& streamUrl, const std::string& volumeGain) {
        std::unique_lock<std::mutex> lock(audio_mutex);
        if (audio_pid != -1) {
            ROS_INFO("音频流已经在运行 (PID: %d)", audio_pid);
            return;
        }

        std::string command = "ffmpeg -loglevel verbose -i \"" + STREAM_URL + "\" "
                              "-af \"volume=" + VOLUME_GAIN + "\" "
                              "-f s16le -acodec pcm_s16le -ar 44100 -ac 2 - | "
                              "/usr/bin/aplay -f S16_LE -r 44100 -c 2";

        // 使用 popen 打开进程，以获取标准输入，popen 打开管道
        audio_stream = popen(command.c_str(), "w");
        if (audio_stream == nullptr) {
            perror("popen failed");
            ROS_ERROR("无法启动音频流");
            return;
        }

        audio_pid = fileno(audio_stream);
        ROS_INFO("音频流启动 (PID: %d)", audio_pid);
    }

    void stopAudioStream() {
        std::unique_lock<std::mutex> lock(audio_mutex);
        if (audio_pid != -1) {
            ROS_INFO("准备停止音频流 (PID: %d)", audio_pid);

            if (audio_stream != nullptr) {
                // 向 ffmpeg 发送 'q' 字符和换行符以停止它
                if (fputc('q', audio_stream) != EOF && fputc('\n', audio_stream) != EOF) {
                    fflush(audio_stream);
                } else {
                    ROS_ERROR("向 ffmpeg 发送停止命令失败");
                }

                // 关闭流
                if (pclose(audio_stream) == -1) {
                    perror("pclose failed");
                    ROS_ERROR("关闭音频流失败");
                }
                audio_stream = nullptr;
            }

            // 尝试停止 aplay 进程
            std::system("pkill -f aplay");

            audio_pid = -1;
            ROS_INFO("音频流成功停止");
        } else {
            ROS_INFO("没有正在运行的音频流，无需停止");
        }
    }

    // 处理指令的函数
    void processCommand(const json& j) {
        ROS_INFO("收到指令: %s", j.dump().c_str());

        try {
            if (!j.contains("command")) {
                ROS_WARN("非法指令格式");
                return;
            }

            const auto& cmd = j["command"];
            std::string shout = cmd.value("shout", "");

            if (shout == "true") {
                if (audio_pid == -1) {
                    // 更新状态并立即发布
                    shout_state.is_shouting = true;
                    shout_state.state_msg = "喊话器已开启";
                    shout_state.last_update = std::chrono::system_clock::now();

                    // 启动音频流
                    std::thread([this]() {
                        ROS_INFO("[线程] 启动音频流...");
                        startAudioStream(STREAM_URL, VOLUME_GAIN);
                        audio_cv.notify_one();
                    }).detach();
                }
            } else if (shout == "false") {
                if (audio_pid != -1) {
                    // 更新状态并立即发布
                    shout_state.is_shouting = false;
                    shout_state.state_msg = "喊话器已关闭";
                    shout_state.last_update = std::chrono::system_clock::now();

                    // 停止音频流
                    std::thread([this]() {
                        ROS_INFO("[线程] 暂停音频流...");
                        stopAudioStream();
                        audio_cv.notify_one();
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
          mqtt_sub_topic(sub_topic) {
        client_id = "shout_state_" + std::to_string(std::chrono::system_clock::now().time_since_epoch().count());
        initMQTT();
    }

    virtual ~MQTTBridge() {
        try {
            if (mqtt_client->is_connected()) {
                mqtt_client->disconnect()->wait();
                ROS_INFO("Disconnected from MQTT server");
            }
        } catch (const mqtt::exception& e) {
            ROS_ERROR("Disconnection failed: %s", e.what());
        }
        // 确保音频进程在析构时停止
        stopAudioStream();
    }

    void initMQTT() {
        mqtt::connect_options opts;
        opts.set_clean_session(true);
        opts.set_automatic_reconnect(true);
        opts.set_keep_alive_interval(60);

        if (!mqtt_user.empty() &&!mqtt_password.empty()) {
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

            // 检查 JSON 结构是否符合预期
            if (!j.is_object() ||!j.contains("command") ||!j["command"].is_object()) {
                ROS_ERROR("Invalid JSON structure: missing 'command' object");
                return;
            }

            processCommand(j);
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
            mqtt_client->publish(msg)->wait_for(std::chrono::seconds(1)); // 等待发布确认
            ROS_INFO("[MQTT] 状态已更新: %s", state_json.dump().c_str());
        } catch (const mqtt::exception& e) {
            ROS_ERROR("状态发布失败: %s", e.what());
        }
    }
};

#endif // USR_MQTT_HPP
