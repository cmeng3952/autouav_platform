#include <ros/ros.h>
#include <std_msgs/UInt8.h>
#include <mqtt/async_client.h>
#include <nlohmann/json.hpp>
#include <memory>
#include <mutex>
#include <atomic>
#include <string>

using json = nlohmann::json;

class HangarMQTTBridge : public mqtt::callback {
public:
  HangarMQTTBridge(const std::string& broker,
                   const std::string& username,
                   const std::string& password,
                   const std::string& mqtt_sub_topic,
                   const std::string& ros_pub_topic)
      : broker_(broker), username_(username), password_(password),
        sub_topic_(mqtt_sub_topic), ros_pub_topic_(ros_pub_topic) {
    initROS();
    initMQTT();
  }

  void connection_lost(const std::string& cause) override {
    ROS_WARN("MQTT connection lost: %s", cause.c_str());
    is_connected_ = false;
  }

  void message_arrived(mqtt::const_message_ptr msg) override {
    std::lock_guard<std::mutex> lock(mtx_);
    const std::string payload = msg->get_payload();
    ROS_INFO("Hangar MQTT message: topic=%s payload=%s", msg->get_topic().c_str(), payload.c_str());

    uint8_t state_value = 0;
    bool parsed = false;

    // Try parse as plain integer text
    try {
      int v = std::stoi(payload);
      if (v >= 0 && v <= 255) {
        state_value = static_cast<uint8_t>(v);
        parsed = true;
      }
    } catch (...) {
      // ignore and try JSON
    }

    if (!parsed) {
      try {
        json j = json::parse(payload);
        // Accept several common keys
        if (j.contains("uav_state")) {
          state_value = static_cast<uint8_t>(j.at("uav_state").get<int>());
          parsed = true;
        } else if (j.contains("state")) {
          state_value = static_cast<uint8_t>(j.at("state").get<int>());
          parsed = true;
        } else if (j.contains("value")) {
          state_value = static_cast<uint8_t>(j.at("value").get<int>());
          parsed = true;
        }
      } catch (const std::exception& e) {
        ROS_WARN("JSON parse error: %s", e.what());
      }
    }

    if (!parsed) {
      ROS_ERROR("Failed to parse hangar state from payload");
      return;
    }

    std_msgs::UInt8 msg_out;
    msg_out.data = state_value;
    hangar_state_pub_.publish(msg_out);
  }

private:
  void initROS() {
    hangar_state_pub_ = nh_.advertise<std_msgs::UInt8>(ros_pub_topic_, 10, true);
  }

  void initMQTT() {
    std::string client_id =
        std::string("hangar_bridge_") + std::to_string(::time(nullptr));
    client_ = std::make_unique<mqtt::async_client>(broker_, client_id);
    client_->set_callback(*this);

    mqtt::connect_options opts;
    opts.set_clean_session(true);
    opts.set_automatic_reconnect(true);
    opts.set_keep_alive_interval(60);
    if (!username_.empty() && !password_.empty()) {
      opts.set_user_name(username_);
      opts.set_password(password_);
    }

    try {
      client_->connect(opts)->wait();
      is_connected_ = true;
      client_->start_consuming();
      client_->subscribe(sub_topic_, 1)->wait();
      ROS_INFO("Connected to MQTT %s and subscribed %s", broker_.c_str(), sub_topic_.c_str());
    } catch (const mqtt::exception& e) {
      ROS_FATAL("MQTT connect/subscribe failed: %s", e.what());
      throw; // Let main handle shutdown
    }
  }

  ros::NodeHandle nh_;
  ros::Publisher hangar_state_pub_;

  std::mutex mtx_;
  std::unique_ptr<mqtt::async_client> client_;
  std::atomic<bool> is_connected_{false};

  std::string broker_;
  std::string username_;
  std::string password_;
  std::string sub_topic_;
  std::string ros_pub_topic_;
};

int main(int argc, char** argv) {
  setlocale(LC_ALL, "");
  ros::init(argc, argv, "hangar_mqtt_bridge");
  ros::NodeHandle nh;

  std::string broker = "tcp://47.104.183.127:1983";
  std::string user = "pxtest";
  std::string pass = "test2025@px";
  std::string mqtt_sub_topic = "uavhangar_mqtt/state/hangar1";
  std::string ros_pub_topic = "hangar/uav_state"; // std_msgs/UInt8

  nh.param("mqtt_broker", broker, broker);
  nh.param("mqtt_user", user, user);
  nh.param("mqtt_password", pass, pass);
  nh.param("mqtt_sub_topic", mqtt_sub_topic, mqtt_sub_topic);
  nh.param("ros_pub_topic", ros_pub_topic, ros_pub_topic);

  try {
    HangarMQTTBridge bridge(broker, user, pass, mqtt_sub_topic, ros_pub_topic);
    ros::spin();
  } catch (...) {
    // Already logged
  }

  return 0;
}



