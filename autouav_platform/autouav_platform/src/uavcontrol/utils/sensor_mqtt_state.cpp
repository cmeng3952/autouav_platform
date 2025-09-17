#include "sensor_mqtt_state.h"
#include <random>
#include <thread>
#include <chrono>
#include <stdexcept>

using namespace std;

StatePublisherManager::StatePublisherManager(
    ros::NodeHandle& nh,
    const string& broker,
    const string& username,
    const string& password,
    const string& pub_topic,
    const string& state_sync_topic,
    double publish_freq,
    bool auto_start)
    : nh_(nh),
      broker_(broker),
      username_(username),
      password_(password),
      pub_topic_(pub_topic),
      sync_topic_(state_sync_topic),
      publish_freq_(publish_freq) {
    
    // 初始化MQTT连接
    initMqtt();
    
    // 设置初始状态
    current_state_.timestamp = ros::Time::now().toSec();
    current_state_.connected = connected_;
    
    // 自动启动发布
    if (auto_start) {
        startPublishing();
    }
}

StatePublisherManager::~StatePublisherManager() {
    // 停止发布
    stopPublishing();
    
    // 断开MQTT连接
    if (mqtt_client_ && mqtt_client_->is_connected()) {
        try {
            mqtt_client_->disconnect()->wait();
        } catch (const exception& e) {
            ROS_WARN("disconnection MQTT connect falied: %s", e.what());
        }
    }
}

void StatePublisherManager::initMqtt() {
    // 生成唯一客户端ID
    random_device rd;
    string client_id = "uav_state_publisher_" + to_string(rd());
    
    // 创建MQTT客户端
    mqtt_client_ = make_unique<mqtt::async_client>(broker_, client_id);
    mqtt_client_->set_callback(*this);
    
    // 设置连接选项
    mqtt::connect_options opts;
    opts.set_keep_alive_interval(60);
    opts.set_clean_session(true);
    if (!username_.empty() && !password_.empty()) {
        opts.set_user_name(username_);
        opts.set_password(password_);
    }
    
    // 连接到MQTT服务器
    try {
        mqtt_client_->connect(opts)->wait();
        connected_ = true;
        current_state_.connected = true;
        ROS_INFO("status publisher has connected MQTT server: %s", broker_.c_str());
        
        // 订阅状态同步主题
        mqtt_client_->subscribe(sync_topic_, 1)->wait();
        ROS_INFO("Subscribed state_sync_topic", sync_topic_.c_str());
    } catch (const mqtt::exception& e) {
        ROS_ERROR("MQTT connect failed: %s", e.what());
        throw runtime_error("MQTT connect failed");
    }
}

void StatePublisherManager::connection_lost(const string& cause) {
    ROS_WARN("MQTT connect lost: %s", cause.c_str());
    connected_ = false;
    current_state_.connected = false;
    
    // 启动重连线程
    thread([this]() {
        int retries = 0;
        while (!connected_ && ros::ok()) {
            int delay = min(60, (1 << retries));  // 指数退避
            this_thread::sleep_for(chrono::seconds(delay));
            try {
                reconnect();
                connected_ = true;
                current_state_.connected = true;
                ROS_INFO("MQTT reconnect success");
                connection_cv_.notify_all();
            } catch (const exception& e) {
                ROS_WARN("MQTT reconnct failed (attempt %d): %s", retries, e.what());
                retries++;
            }
        }
    }).detach();
}

void StatePublisherManager::reconnect() {
    mqtt::connect_options opts;
    opts.set_keep_alive_interval(60);
    opts.set_clean_session(true);
    if (!username_.empty() && !password_.empty()) {
        opts.set_user_name(username_);
        opts.set_password(password_);
    }
    
    mqtt_client_->connect(opts)->wait();
    
    // 重新订阅状态同步主题
    mqtt_client_->subscribe(sync_topic_, 1)->wait();
}

void StatePublisherManager::message_arrived(mqtt::const_message_ptr msg) {
    // 处理状态同步消息
    if (msg->get_topic() == sync_topic_) {
        string payload = msg->get_payload_str();
        ROS_INFO("Recrived status rync nessage: %s", payload.c_str());
        
        try {
            nlohmann::json json_msg = nlohmann::json::parse(payload);
            
            if (json_msg.contains("uavstate")) {
                const auto& uavstate = json_msg["uavstate"];
                UAVState partial_state;
                
                // 解析顶层状态字段
                if (uavstate.contains("led_state")) 
                    partial_state.led_state = uavstate["led_state"].get<bool>();

                if (uavstate.contains("shout_state")) 
                    partial_state.shout_state = uavstate["shout_state"].get<bool>();

                if (uavstate.contains("parachute_state")) 
                    partial_state.parachute_state = uavstate["parachute_state"].get<bool>();
                    
                if (uavstate.contains("police_state")) 
                    partial_state.police_state = uavstate["police_state"].get<bool>();
                
                // 解析左侧抛投器状态
                if (uavstate.contains("left")) {
                    const auto& left = uavstate["left"];
                    if (left.contains("pwm1_state")) 
                        partial_state.pwm1_state = left["pwm1_state"].get<bool>();
                    if (left.contains("pwm2_state")) 
                        partial_state.pwm2_state = left["pwm2_state"].get<bool>();
                }
                
                // 解析右侧抛投器状态
                if (uavstate.contains("right")) {
                    const auto& right = uavstate["right"];
                    if (right.contains("pwm3_state")) 
                        partial_state.pwm3_state = right["pwm3_state"].get<bool>();
                    if (right.contains("pwm4_state")) 
                        partial_state.pwm4_state = right["pwm4_state"].get<bool>();
                }
                
             
                // 更新状态
                updateStatePartial(partial_state);
            }
        } catch (const exception& e) {
            ROS_ERROR("Failed resolve state synchronization messages: %s", e.what());
        }
    }
}

void StatePublisherManager::delivery_complete(mqtt::delivery_token_ptr token) {
    if (token) {
        ROS_DEBUG("State mesage send finished (topic : %s)", token->get_message()->get_topic().c_str());
    }
}

void StatePublisherManager::updateState(const UAVState& state) {
    lock_guard<mutex> lock(state_mutex_);
    current_state_ = state;
    current_state_.timestamp = ros::Time::now().toSec();
    current_state_.connected = connected_;
}

void StatePublisherManager::updateStatePartial(const UAVState& partial_state) {
    lock_guard<mutex> lock(state_mutex_);
    
    // 更新时间戳
    current_state_.timestamp = ros::Time::now().toSec();
    
    // 移除条件判断，直接更新所有字段（无论true/false）
    current_state_.led_state = partial_state.led_state;
    current_state_.shout_state = partial_state.shout_state;
    current_state_.parachute_state = partial_state.parachute_state;
    current_state_.police_state = partial_state.police_state;
    current_state_.pwm1_state = partial_state.pwm1_state;
    current_state_.pwm2_state = partial_state.pwm2_state;
    current_state_.pwm3_state = partial_state.pwm3_state;
    current_state_.pwm4_state = partial_state.pwm4_state;
    
    // 更新连接状态
    current_state_.connected = connected_;
}

UAVState StatePublisherManager::getCurrentState() const {
    lock_guard<mutex> lock(state_mutex_);
    return current_state_;
}

void StatePublisherManager::startPublishing() {
    if (!publish_timer_.hasStarted()) {
        publish_timer_ = nh_.createTimer(
            ros::Duration(1.0/publish_freq_),
            [this](const ros::TimerEvent&) {
                publishState();
            }
        );
        ROS_INFO("start pub state (frequncy: %.1f Hz)", publish_freq_);
    }
}

void StatePublisherManager::stopPublishing() {
    if (publish_timer_.hasStarted()) {
        publish_timer_.stop();
        ROS_INFO("stop pub status");
    }
}

bool StatePublisherManager::isConnected() const {
    return connected_;
}

void StatePublisherManager::waitForConnection() {
    unique_lock<mutex> lock(connection_mutex_);
    // 显式使用load()方法获取原子变量的值
    connection_cv_.wait(lock, [this] { return this->connected_.load(); });
}

void StatePublisherManager::publishState() {
    if (!connected_) return;
    
    try {
        // 获取当前状态并转换为JSON
        UAVState state;
        {
            lock_guard<mutex> lock(state_mutex_);
            state = current_state_;
        }
        
        string payload = state.toJson().dump();
        
        // 发布到MQTT
        mqtt::message_ptr msg = mqtt::make_message(pub_topic_, payload);
        msg->set_qos(1);
        mqtt_client_->publish(msg)->wait();
        
        ROS_DEBUG("publish state: %s", payload.c_str());
    } catch (const exception& e) {
        ROS_ERROR("publish state failed: %s", e.what());
    }
}
