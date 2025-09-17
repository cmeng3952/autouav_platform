#pragma once

#include <mqtt/async_client.h>
#include <nlohmann/json.hpp>
#include <ros/ros.h>
#include <mutex>
#include <string>
#include <memory>

#include "gimbal/z2mini_controller_v2.hpp"

namespace gimbal {

class GimbalMQTTBridge : public mqtt::callback {
public:
  GimbalMQTTBridge(const std::string& broker,
                   const std::string& username,
                   const std::string& password,
                   const std::string& sub_topic,
                   const std::string& pub_topic)
      : broker_(broker), username_(username), password_(password), sub_topic_(sub_topic), pub_topic_(pub_topic) {
    initMQTT();
  }

  ~GimbalMQTTBridge() override {
    try {
      if (client_ && client_->is_connected()) client_->disconnect()->wait();
    } catch (...) {}
  }

  void setController(std::shared_ptr<Z2MiniControllerV2> controller) { controller_ = std::move(controller); }

  void publishState() {
    if (!client_ || !client_->is_connected()) return;
    nlohmann::json j;
    float p, y, r;
    std::tie(p, y, r) = controller_ ? controller_->currentAngles() : std::tuple<float,float,float>{0,0,0};
    j["angles"] = { {"pitch", p}, {"yaw", y}, {"roll", r} };
    auto msg = mqtt::make_message(pub_topic_, j.dump());
    msg->set_qos(0);
    try { client_->publish(msg); } catch (...) {}
  }

  void connection_lost(const std::string& cause) override {
    ROS_ERROR("MQTT lost: %s", cause.c_str());
  }

  void message_arrived(mqtt::const_message_ptr msg) override {
    std::lock_guard<std::mutex> lock(mtx_);
    ROS_INFO("MQTT message arrived: topic=%s payload=%s", msg->get_topic().c_str(), msg->get_payload().c_str());
    try {
      auto j = nlohmann::json::parse(msg->get_payload());
      handleCommand(j);
    } catch (const std::exception& e) {
      ROS_ERROR("MQTT JSON parse error: %s", e.what());
    }
  }

private:
  void initMQTT() {
    client_ = std::make_unique<mqtt::async_client>(broker_, "gimbal_bridge_" + std::to_string(::time(nullptr)));
    client_->set_callback(*this);
    mqtt::connect_options opts;
    opts.set_clean_session(true);
    opts.set_automatic_reconnect(true);
    if (!username_.empty()) {
      opts.set_user_name(username_);
      opts.set_password(password_);
    }
    client_->connect(opts)->wait();
    ROS_INFO("Connected to MQTT %s", broker_.c_str());
    client_->start_consuming();
    client_->subscribe(sub_topic_, 1);
    ROS_INFO("Subscribed topic: %s", sub_topic_.c_str());
  }

  void handleCommand(const nlohmann::json& j) {
    if (!controller_) return;

    // Supported commands:
    // {"cmd":"center"}
    // {"cmd":"point_down"}
    // {"cmd":"set_pip_mode", "mode": x}  // x in [0,4], 0=cycle, 1-4=specific modes
    // {"cmd":"cycle_pip"}
    // {"cmd":"set_angle", "pitch": x, "yaw": y, "roll": r, "smooth": bool, "duration": s, "steps": n}
    // {"cmd":"rotate_rel", "dp": x, "dy": y, "dr": r}

    const std::string cmd = j.value("cmd", "");
    ROS_INFO("Parsed cmd: %s", cmd.c_str());
    bool ok = false;
    if (cmd == "center") {
      ok = controller_->center();
    } else if (cmd == "point_down") {
      ok = controller_->pointDown();
    } else if (cmd == "set_pip_mode") {
      const uint8_t mode = static_cast<uint8_t>(j.value("mode", 0));
      ok = controller_->setPipMode(mode);
    } else if (cmd == "cycle_pip") {
      ok = controller_->cyclePipMode();
    } else if (cmd == "set_angle") {
      const float p = j.value("pitch", 0.0f);
      const float y = j.value("yaw", 0.0f);
      const float r = j.value("roll", 0.0f);
      const bool smooth = j.value("smooth", false);
      if (smooth) {
        const float duration = j.value("duration", 1.0f);
        const int steps = j.value("steps", 10);
        ok = controller_->smoothRotateTo(p, y, r, duration, steps);
      } else {
        ok = controller_->setAngle(p, y, r);
      }
    } else if (cmd == "rotate_rel") {
      ok = controller_->rotateRelative(j.value("dp", 0.0f), j.value("dy", 0.0f), j.value("dr", 0.0f));
    }

    nlohmann::json resp;
    resp["ok"] = ok;
    publishJSON(resp);
  }

  void publishJSON(const nlohmann::json& j) {
    if (!client_ || !client_->is_connected()) return;
    auto msg = mqtt::make_message(pub_topic_, j.dump());
    msg->set_qos(0);
    try { client_->publish(msg); } catch (...) {}
  }

  std::mutex mtx_;
  std::unique_ptr<mqtt::async_client> client_;
  std::string broker_;
  std::string username_;
  std::string password_;
  std::string sub_topic_;
  std::string pub_topic_;
  std::shared_ptr<Z2MiniControllerV2> controller_;
};

}  // namespace gimbal 

