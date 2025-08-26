#include <mqtt/client.h>
#include <mqtt/async_client.h>
#include <string>
#include <iostream>
#include <jsoncpp/json/json.h>
#include <ros/ros.h>
#include <yaml-cpp/yaml.h>
#include <ros/package.h>
#include <std_msgs/String.h>
#include <map>
#include <fstream>
using namespace std;
string state;
class MqttListener : public mqtt::callback {
public:
    MqttListener() : nh_(), running_(false) {
        string mqtt_config_path;
        // ros::NodeHandle nh;
        if (!nh_.getParam("mqtt_config_path", mqtt_config_path)) {
            ROS_ERROR("Failed to get config_path parameter!");
            ros::shutdown();
        }
        map<string,string> config = parseTxtConfig(mqtt_config_path);
        // 读取MQTT配置
        mqtt_broker_ = config["broker"];
        mqtt_client_id_ = config["client_id"];
        mqtt_topic_ = config["topic_mqtt"];
        // mqtt_qos_ = stoi(config["qos"]);
        // ros_topic_ = config["topic_ros"];
            // ros_queue_size_ = stoi(config["queue_size"]);
        // ros_pub_ = nh_.advertise<std_msgs::String>(ros_topic_, 10);
        // 初始化MQTT
        mqtt_client_ = std::make_unique<mqtt::async_client>(mqtt_broker_, mqtt_client_id_);
        mqtt_client_->set_callback(*this);
    }
    void start(){
        // 连接选项
        mqtt::connect_options conn_opts;
        conn_opts.set_keep_alive_interval(20);
        conn_opts.set_clean_session(true);
        try {
            // 连接MQTT Broker
            mqtt_client_->connect(conn_opts)->wait();
            ROS_INFO("Connected to MQTT broker: %s", mqtt_broker_.c_str());
            mqtt_client_->subscribe(mqtt_topic_, 1)->wait();
            ROS_INFO("Subscribed to MQTT topic: %s", mqtt_topic_.c_str());
            running_ = true;
            mqtt_thread_ = thread(&MqttListener::mqttLoop, this);
            
        } catch (const mqtt::exception& exc) {
            ROS_ERROR("MQTT error: %s", exc.what());
            ros::shutdown();
        }
    }
    void stop() {
        running_ = false;
        if (mqtt_thread_.joinable()) {
            mqtt_thread_.join();
        }
        mqtt_client_->disconnect()->wait();
    }
    void message_arrived(mqtt::const_message_ptr msg) override {
        ROS_INFO("Received MQTT message: %s", msg->get_payload().c_str());
        try{
            Json::Value json_msg;
            Json::Reader reader;
            if(reader.parse(msg->get_payload(),json_msg)) {
                if(json_msg.isMember("state")) {
                    state = json_msg["state"].asString();
                    ROS_INFO("Get the state valve: %s",state.c_str());
                }
            } else {
                ROS_ERROR("JSON parse error: %s", reader.getFormattedErrorMessages().c_str());
            }
        } catch(const exception& e){
            ROS_ERROR("Message processiong error: %s",e.what());
        }
    }
    // void run() {
    //     ros::spin();
    // }
    map<std::string, std::string> parseTxtConfig(const std::string& file_path) {
        map<std::string, std::string> config;
        ifstream file(file_path);
        string line;
        if (!file.is_open()) {
            ROS_ERROR("Failed to open config file: %s", file_path.c_str());
            return config;
        }
        while (std::getline(file, line)) {
            if (line.empty() || line[0] == '#') continue;
       
            size_t delimiter_pos = line.find(':');
            if (delimiter_pos == std::string::npos) continue;
            string key = line.substr(0, delimiter_pos);
            string value = line.substr(delimiter_pos + 1);
           
            key.erase(0, key.find_first_not_of(" \t"));
            key.erase(key.find_last_not_of(" \t") + 1);
            value.erase(0, value.find_first_not_of(" \t"));
            value.erase(value.find_last_not_of(" \t") + 1);
            config[key] = value;
        }
        file.close();
        return config;
    }

    void mqttLoop() {
        while (running_) {
            try {
                mqtt_client_->start_consuming();  // Non-blocking message processing
                this_thread::sleep_for(chrono::milliseconds(100));
            } catch (const mqtt::exception& exc) {
                ROS_ERROR("MQTT loop error: %s", exc.what());
            }
        }
    }
    ros::NodeHandle nh_;
    // ros::Publisher ros_pub_;
    unique_ptr<mqtt::async_client> mqtt_client_;
    string mqtt_broker_, mqtt_client_id_, mqtt_topic_;
    // int mqtt_qos_;
    // std::string ros_topic_;
    // int ros_queue_size_;
    atomic<bool> running_;
    thread mqtt_thread_;
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "mqtt_ros_bridge");
    MqttListener listener;
    listener.start();
    int i=1;
    while (i<20)
    {
        cout<<"test code!!"<<endl;
        i++;
    }
    
    
    ros::spin();
    listener.stop();
    
    return 0;
}