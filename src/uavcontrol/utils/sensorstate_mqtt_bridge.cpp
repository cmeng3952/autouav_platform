#include "ros/ros.h"
#include <uavcontrol_msgs/LedStates.h>
#include <uavcontrol_msgs/ShoutStates.h>
#include <mqtt/async_client.h>
#include <nlohmann/json.hpp>
#include <mutex>
#include <atomic>
#include <condition_variable>
#include <thread>

using json = nlohmann::json;

class StateAggregator {
private:
    ros::NodeHandle nh_;
    ros::Subscriber led_sub_;
    ros::Subscriber shout_sub_;
    std::unique_ptr<mqtt::async_client> mqtt_client_;
    std::string mqtt_broker_;
    std::string mqtt_user_;
    std::string mqtt_password_;
    std::string pub_topic_;  // 改为 pub_topic_

    // 状态缓存
    struct AggregatedState {
        bool led_active = false;
        bool shout_active = false;
        std::string led_msg;
        std::string shout_msg;
    } current_state_;
    
    std::mutex state_mutex_;
    std::atomic<bool> is_connected_{false};

    void reconnect() {
        while (ros::ok() && !is_connected_) {
            try {
                mqtt::connect_options connOpts;
                connOpts.set_clean_session(true);
                connOpts.set_automatic_reconnect(true);
                connOpts.set_keep_alive_interval(60);
                
                if (!mqtt_user_.empty() && !mqtt_password_.empty()) {
                    connOpts.set_user_name(mqtt_user_);
                    connOpts.set_password(mqtt_password_);
                }
                
                mqtt_client_->connect(connOpts)->wait();
                is_connected_ = true;
                ROS_INFO("Reconnected to MQTT server: %s", mqtt_broker_.c_str());
            } catch (const mqtt::exception& e) {
                ROS_ERROR_THROTTLE(5, "Reconnection failed: %s", e.what());
                std::this_thread::sleep_for(std::chrono::seconds(5));
            }
        }
    }

public:
    StateAggregator(const std::string& broker, 
                    const std::string& user,
                    const std::string& password,
                    const std::string& pub_topic)  // 参数名改为 pub_topic
        : mqtt_broker_(broker), 
          mqtt_user_(user), 
          mqtt_password_(password), 
          pub_topic_(pub_topic) {  // 初始化 pub_topic_
        
        // 初始化MQTT客户端
        std::string client_id = "state_aggregator_" + std::to_string(ros::Time::now().toSec());
        mqtt_client_ = std::make_unique<mqtt::async_client>(mqtt_broker_, client_id);
        
        // 连接MQTT
        try {
            mqtt::connect_options connOpts;
            connOpts.set_clean_session(true);
            connOpts.set_automatic_reconnect(true);
            connOpts.set_keep_alive_interval(60);
            
            if (!mqtt_user_.empty() && !mqtt_password_.empty()) {
                connOpts.set_user_name(mqtt_user_);
                connOpts.set_password(mqtt_password_);
            }
            
            mqtt_client_->connect(connOpts)->wait();
            is_connected_ = true;
            ROS_INFO("Connected to MQTT server: %s", mqtt_broker_.c_str());
        } catch (const mqtt::exception& e) {
            ROS_ERROR("MQTT connection failed: %s", e.what());
            // 启动重连线程
            std::thread([this] { reconnect(); }).detach();
        }
        
        // 订阅ROS主题
        led_sub_ = nh_.subscribe("led_state", 10, &StateAggregator::ledCallback, this);
        shout_sub_ = nh_.subscribe("shout_state", 10, &StateAggregator::shoutCallback, this);
    }

    ~StateAggregator() {
        if (mqtt_client_ && mqtt_client_->is_connected()) {
            try {
                mqtt_client_->disconnect()->wait();
                ROS_INFO("Disconnected from MQTT server");
            } catch (const mqtt::exception& e) {
                ROS_ERROR("Disconnection failed: %s", e.what());
            }
        }
    }

    void ledCallback(const uavcontrol_msgs::LedStates::ConstPtr& msg) {
        std::lock_guard<std::mutex> lock(state_mutex_);
        current_state_.led_active = msg->is_active;
        current_state_.led_msg = msg->state;
    }

    void shoutCallback(const uavcontrol_msgs::ShoutStates::ConstPtr& msg) {
        std::lock_guard<std::mutex> lock(state_mutex_);
        current_state_.shout_active = msg->is_active;
        current_state_.shout_msg = msg->state;
    }

    void publishAggregatedState() {
        if (!is_connected_) return;
        
        AggregatedState state;
        {
            std::lock_guard<std::mutex> lock(state_mutex_);
            state = current_state_;
        }
        
        json mqtt_msg;
        mqtt_msg["led_state"] = state.led_active ? 1 : 0;
        mqtt_msg["shout_state"] = state.shout_active;
        
        try {
            // 使用 pub_topic_ 作为发布主题
            auto msg = mqtt::make_message(pub_topic_, mqtt_msg.dump());
            msg->set_qos(1);
            mqtt_client_->publish(msg);
            ROS_INFO_THROTTLE(0.5, "Published aggregated state: LED=%d, SHOUT=%d", 
                              state.led_active, state.shout_active);
        } catch (const mqtt::exception& e) {
            ROS_ERROR("Publish failed: %s", e.what());
            is_connected_ = false;
            std::thread([this] { reconnect(); }).detach();
        }
    }
};

int main(int argc, char** argv) {
    setlocale(LC_ALL, "");
    ros::init(argc, argv, "state_aggregator");
    ros::NodeHandle nh;
    
    std::string broker = "tcp://47.104.183.127:1983";
    std::string username = "pxtest";
    std::string password = "test2025@px";
    std::string pub_topic = "uavsensor/state/uav1";  // 改为 pub_topic
    
    // 使用 pub_topic 作为参数
    StateAggregator aggregator(broker, username, password, pub_topic);
    
    ros::Rate rate(1); // 1Hz
    while (ros::ok()) {
        aggregator.publishAggregatedState();
        ros::spinOnce();
        rate.sleep();
    }
    
    return 0;
}
