#include<iostream>
#include<stdio.h>
#include<mqtt/async_client.h>
#include<ros/ros.h>
#include<thread>
#include<string>
#include<opencv2/opencv.hpp> 
#include<jsoncpp/json/json.h>
#include<fstream>
#include <mutex>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <queue>
using namespace std;

string state;
bool is_running = true;
queue<cv::Mat> frame_queue;
mutex queue_mutex;
condition_variable queue_cv;
atomic<bool> streaming_active(false);
atomic<bool> frame_updated(false);

cv::Mat frame;
string rtmp_url = "rtmp://47.104.183.127/live/uav3_cam3";
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
        mqtt_username_ = config["mqtt_username"];
        mqtt_password_ = config["mqtt_password"] ;
        // 初始化MQTT
        mqtt_client_ = std::make_unique<mqtt::async_client>(mqtt_broker_, mqtt_client_id_);
        mqtt_client_->set_callback(*this);
    }
    void start(){
        // 连接选项
        mqtt::connect_options conn_opts;
        conn_opts.set_user_name(mqtt_username_);
        conn_opts.set_password(mqtt_password_);
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
    string mqtt_broker_, mqtt_client_id_, mqtt_topic_,mqtt_username_,mqtt_password_;
    // int mqtt_qos_;
    // std::string ros_topic_;
    // int ros_queue_size_;
    atomic<bool> running_;
    thread mqtt_thread_;
};

void rtmp_streaming_thread(const string& rtmp_url, int width, int height, double fps) {
    stringstream command;
    command << "ffmpeg -y -fflags nobuffer -flags low_delay -an "
            << "-f rawvideo -vcodec rawvideo -pix_fmt bgr24 "
            << "-s " << width << "x" << height << " "
            << "-r " << fps << " -i - "
            << "-c:v libx264 -pix_fmt yuv420p -crf 22 -preset ultrafast "
            // << "-tune film -profile:v high -level 4.2 "
            << "-g 60 -bufsize 3000k -maxrate 2000k -tune zerolatency -movflags faststart "
            << "-f flv " << rtmp_url;

    FILE* fp = popen(command.str().c_str(), "w");
    if (!fp) {
        ROS_ERROR("Failed to open FFmpeg pipe");
        return;
    } 
    while (is_running || !frame_queue.empty()) {
        cv::Mat rtmp_frame;
        {
            unique_lock<mutex> lock(queue_mutex);
            queue_cv.wait(lock, [&] { 
                return !frame_queue.empty() || !is_running; 
            });

            if (!frame_queue.empty()) {
                rtmp_frame = frame_queue.front();
                frame_queue.pop();
            }
        }
        // mqtt message listen
        if (!rtmp_frame.empty() && streaming_active) {
            fwrite(rtmp_frame.data, sizeof(char), rtmp_frame.total() * rtmp_frame.elemSize(), fp);
            fflush(fp);
        }
    }
    pclose(fp);
}

void imageCallback(const sensor_msgs::ImageConstPtr& msg){
    try{
        cv_bridge::CvImagePtr cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
        // frame = cv_ptr->image.clone();
         {
            lock_guard<mutex> lock(queue_mutex);
            frame = cv_ptr->image.clone();
            frame_updated = true;
        }
    }catch(cv_bridge::Exception &e) {
        ROS_ERROR("CV_bridge exception %s",e.what());
    }
}

int main(int argc, char *argv[]){
    ros::init(argc,argv,"rtmp_stream");
    ros::NodeHandle nh;
    ros::Subscriber aruco_image_sub = nh.subscribe("/uav3/rtmp_image_stream", 10, imageCallback);
    
    while(ros::ok() && frame.empty()) {
        ros::spinOnce();
        ros::Duration(0.1).sleep();
    }

    MqttListener listener;
    listener.start();
    int width = frame.cols;
    int height = frame.rows;

    // cout << "width:" << width << "height" << height << endl;
    double fps = 30.00;
    thread rtmp_thread(rtmp_streaming_thread,rtmp_url,width,height,fps);
    ros::Rate loop_rate(30);
    while (ros::ok() &&  is_running)
    {
        
        if((frame.empty())){
            ROS_ERROR("The Frame is Empty!");
            break;
        }
        ros::spinOnce();
        if(frame_updated.exchange(false)){
            streaming_active = (state == "landing");
        }
        if(streaming_active)
        {
            // RTMP_frame = frame;
            lock_guard<mutex> lock(queue_mutex);
            while(frame_queue.size() >= 2){
                frame_queue.pop();
            }
                frame_queue.push(frame.clone());
                queue_cv.notify_one();
            
        }
        loop_rate.sleep();
        //  this_thread::sleep_for(chrono::milliseconds(1000 / fps));        
    }

    is_running = false;
    queue_cv.notify_all();
    rtmp_thread.join();
    // cap.release();
    listener.stop();
    
    return 0;
}