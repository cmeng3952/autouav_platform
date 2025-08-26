#include <opencv2/opencv.hpp>
#include <opencv2/aruco.hpp>
#include <string>
#include <fstream>
#include <map>
#include <ros/ros.h>
#include <cmath>
#include <yaml-cpp/yaml.h>
#include <ros/package.h>
#include <std_msgs/String.h>
#include <sensor_msgs/Image.h>
#include "common.h"
#include "cloudfly_cv/position.h"
#include <vision_msgs/TargetsInFrame.h>
#include "marker_tracker.h"
#include "kalman_filter_3d.h"
#include <mqtt/client.h>
#include <mqtt/async_client.h>
#include <jsoncpp/json/json.h>
#include <thread>
#include <mutex>
#include <queue>
#include <condition_variable>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/image_encodings.h>
// #include<spirecv_msgs/TargetsInFrame.h>
#include<vision_msgs/ROI.h>
#include<vision_msgs/Target.h>
using namespace std;

float fx,fy,cx,cy;

string intrinsic_path;
string marker_sizes_path;
map<int, double> markerSizes;
bool is_running = true;
string state;
bool detect_result = false;
cv::Mat frame;
// Camera Connect
mutex camera_mutex;
cv::VideoCapture cap;
string camera_type;
string rtsp_url;
atomic<bool> camera_connected(false);
const int RECONNECT_INTERVAL = 3; // 重连间隔(秒)
const int MAX_RECONNECT_ATTEMPTS = 8; // 最大重连尝试次数
thread reconnect_thread;
// Aruco detect thread
mutex detection_mutex;
queue<cv::Mat> detection_queue;
condition_variable detection_cv;
atomic<bool> detection_active(true);
cv::Mat Detect_frame;

class MqttListener : public mqtt::callback {
public:
    MqttListener() : nh_(), running_(false) {
        string mqtt_config_path;
        if (!nh_.getParam("mqtt_config_path", mqtt_config_path)) {
            ROS_ERROR("Failed to get config_path parameter!");
            ros::shutdown();
        }
        map<string,string> config = parseTxtConfig(mqtt_config_path);
        mqtt_broker_ = config["broker"]; 
        mqtt_client_id_ = config["client_id"];
        mqtt_topic_ = config["topic_mqtt"];
        mqtt_username_ = config["mqtt_username"];
        mqtt_password_ = config["mqtt_password"];
        mqtt_client_ = std::make_unique<mqtt::async_client>(mqtt_broker_, mqtt_client_id_);
        mqtt_client_->set_callback(*this);
    }

    void start(){
       
        mqtt::connect_options conn_opts;
        conn_opts.set_user_name(mqtt_username_);
        conn_opts.set_password(mqtt_password_);
        conn_opts.set_keep_alive_interval(20);
        conn_opts.set_clean_session(true);
        try {
            mqtt_client_->connect(conn_opts)->wait();
            ROS_INFO("Connected to MQTT broker: %s", mqtt_broker_.c_str());
            mqtt_client_->subscribe(mqtt_topic_, 1)->wait();
            ROS_INFO("Subscribed to MQTT topic: %s", mqtt_topic_.c_str());
            publishStopCommand();
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

    void publishStopCommand() {
        Json::Value msg;
        msg["command"] = "stop_script";
        // msg["choose"] = "4";
        msg["force_stop"] = false;
        Json::StreamWriterBuilder writer;
        std::string payload = Json::writeString(writer, msg);
        try {
            mqtt_client_->publish(mqtt_topic_, payload, 1, false)->wait();
            ROS_INFO("Published stop_script command");
        } catch (const mqtt::exception& exc) {
            ROS_ERROR("Failed to publish stop_script: %s", exc.what());
        }
    }

    void message_arrived(mqtt::const_message_ptr msg) override {
        ROS_INFO("Received MQTT message: %s", msg->get_payload().c_str());
        try {
            Json::Value json_msg;
            // json_msg["detect_result"] = true;
            Json::Reader reader;
            if(reader.parse(msg->get_payload(), json_msg)) {
                if(json_msg.isMember("command")) {
                    std::string command = json_msg["command"].asString();
                    std::string choose = json_msg["choose"].asString();
                    if(command == "start_script" && (choose=="1" || choose=="2" || choose=="3" || choose=="0")) {
                        ROS_INFO("Received start_script command, shutting down...");
                        ros::shutdown();
                    }
                }
                if(json_msg.isMember("detect_result")){
                    detect_result = json_msg["detect_result"].asBool();
                }
            } else {
                ROS_ERROR("JSON parse error: %s", reader.getFormattedErrorMessages().c_str());
            }
        } catch(const exception& e) {
            ROS_ERROR("Message processing error: %s", e.what());
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
                mqtt_client_->start_consuming();
                this_thread::sleep_for(chrono::milliseconds(100));
            } catch (const mqtt::exception& exc) {
                ROS_ERROR("MQTT loop error: %s", exc.what());
            }
        }
    }

    ros::NodeHandle nh_;
    unique_ptr<mqtt::async_client> mqtt_client_;
    string mqtt_broker_, mqtt_client_id_, mqtt_topic_, mqtt_username_, mqtt_password_;
    atomic<bool> running_;
    thread mqtt_thread_;
};


void OnSignal(int){
    is_running  = false;
}
bool loadMarkerSizes(const string& filePath) {
    ifstream file(filePath);
    if (!file.is_open()) {
        ROS_ERROR("无法打开尺寸文件: %s", filePath.c_str());
        return false;
    }

    string line;
    while (getline(file, line)) {
        if (line.empty() || line[0] == '#') continue;
        size_t pos = line.find(',');
        if (pos == string::npos) {
            ROS_WARN("无效行格式: %s", line.c_str());
            continue;
        }
        
        try {
            int id = stoi(line.substr(0, pos));
            double size = stod(line.substr(pos + 1));
            markerSizes[id] = size;
            ROS_INFO("Load marker scalar: ID=%d, size=%.3f m", id, size);
        } catch (const exception& e) {
            ROS_ERROR("解析行错误: %s, 原因: %s", line.c_str(), e.what());
        }
    }
    
    file.close();
    return !markerSizes.empty();
}

void get_parameters() {
    ros::NodeHandle nh;
    
    if (!nh.getParam("intrinsic_path", intrinsic_path)) {
        ROS_ERROR("读取内参文件失败,请检查文件路径!");
        exit(1);
    }
    
    if (!nh.getParam("marker_sizes_path", marker_sizes_path)) {
        ROS_WARN("未指定标记尺寸文件路径,使用默认尺寸0.11 0.05 0.55");
        markerSizes[0] = 0.11;
        markerSizes[1] = 0.11;
        markerSizes[2] = 0.11;
        markerSizes[3] = 0.11;
        markerSizes[4] = 0.55;
        markerSizes[5] = 0.05;
    } else {
        if (!loadMarkerSizes(marker_sizes_path)) {
            ROS_WARN("标记尺寸加载失败,使用默认尺寸列表里面的参数");
        }
    }
    camera_type = nh.param<string>("camera_type", "0");
    if (camera_type != "0") {
        rtsp_url = nh.param<string>("camera_type", "rtsp://192.168.144.108");
    }
}

bool init_camera() {
    lock_guard<mutex> lock(camera_mutex);
    
    if (cap.isOpened()) {
        cap.release();
    }
    
    if (camera_type == "0") {
        ROS_INFO("Try to open usb camera...");
        cap.open(stoi(camera_type), cv::CAP_V4L2);
    } else {
        ROS_INFO("Try to open internet camera: %s", rtsp_url.c_str());
        cap.open(rtsp_url);
    }
    
    if (!cap.isOpened()) {
        ROS_INFO("Try to Reconnect the camera!");
        camera_connected = false;
        return false;
    }
    
    // // 设置相机参数
    // cap.set(cv::CAP_PROP_FRAME_WIDTH, 1280);
    // cap.set(cv::CAP_PROP_FRAME_HEIGHT, 720);
    // cap.set(cv::CAP_PROP_FPS, 30);
    
    int width = cap.get(cv::CAP_PROP_FRAME_WIDTH);
    int height = cap.get(cv::CAP_PROP_FRAME_HEIGHT);
    double fps = cap.get(cv::CAP_PROP_FPS);
    
    ROS_INFO("摄像头已连接 - 分辨率: %dx%d, FPS: %.2f", width, height, fps);
    camera_connected = true;
    return true;
}

void camera_reconnect_thread() {
    int reconnect_attempts = 0;
    
    while (is_running) {
        if (!camera_connected || !cap.isOpened()) {
            ROS_WARN("尝试重新连接摄像头 (尝试 %d/%d)...",
                    reconnect_attempts + 1, MAX_RECONNECT_ATTEMPTS);
            
            if (init_camera()) {
                reconnect_attempts = 0;
                ROS_INFO("摄像头重新连接成功!");
                continue;
            }
            
            reconnect_attempts++;
            if (reconnect_attempts >= MAX_RECONNECT_ATTEMPTS) {
                ROS_ERROR("达到最大重连尝试次数(%d), 停止尝试", MAX_RECONNECT_ATTEMPTS);
                is_running = false;
                break;
            }
            
            this_thread::sleep_for(chrono::seconds(RECONNECT_INTERVAL));
        } else {
            this_thread::sleep_for(chrono::seconds(1));
        }
    }
}

// 将旋转向量转换为欧拉角 (yaw, pitch, roll)
cv::Vec3d rotationVectorToEulerAngles(const cv::Vec3d& rvec) {
    // 旋转向量到旋转矩阵的转换
    cv::Mat rotationMatrix;
    cv::Rodrigues(rvec, rotationMatrix);
    
    if (rotationMatrix.rows != 3 || rotationMatrix.cols != 3) {
        return cv::Vec3d(0, 0, 0);
    }
    
    // 提取旋转矩阵元素
    double r11 = rotationMatrix.at<double>(0, 0);
    double r12 = rotationMatrix.at<double>(0, 1);
    double r13 = rotationMatrix.at<double>(0, 2);
    double r21 = rotationMatrix.at<double>(1, 0);
    double r22 = rotationMatrix.at<double>(1, 1);
    double r23 = rotationMatrix.at<double>(1, 2);
    double r31 = rotationMatrix.at<double>(2, 0);
    double r32 = rotationMatrix.at<double>(2, 1);
    double r33 = rotationMatrix.at<double>(2, 2);
    
    // 计算俯仰角 (pitch) - 绕Y轴旋转
    double pitch = std::asin(-r31);
    
    // 避免万向锁情况
    if (std::fabs(r31) < 0.9999) {
        // 计算偏航角 (yaw) - 绕Z轴旋转
        double yaw = std::atan2(r21, r11);
        
        // 计算滚转角 (roll) - 绕X轴旋转
        double roll = std::atan2(r32, r33);
        
        // 返回弧度值
        return cv::Vec3d(yaw, pitch, roll);
    } 
    else {
        // 在万向锁情况下，只能计算yaw + roll的和
        double yaw = 0.0;
        double roll = std::atan2(-r12, r22);
        return cv::Vec3d(yaw, pitch, roll);
    }
}

// 弧度转换为角度
cv::Vec3d radiansToDegrees(const cv::Vec3d& radians) {
    const double rad2deg = 180.0 / CV_PI;
    return cv::Vec3d(
        radians[0] * rad2deg,
        radians[1] * rad2deg,
        radians[2] * rad2deg
    );
}
// listen the image topic 
void imageCallback(const sensor_msgs::ImageConstPtr& msg){
    try{
        cv_bridge::CvImagePtr cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
        frame = cv_ptr->image.clone();
    }catch(cv_bridge::Exception &e) {
        ROS_ERROR("CV_bridge exception %s",e.what());
    }
}
// Aruco detect thread
// opencv 4.7.0
void detection_thread(cv::Mat camera_intrinsic,cv::Mat distortion_vector, cv::aruco::Dictionary dictionary,
                    cv::aruco::DetectorParameters parameters,ros::Publisher result_detect_pub,cv::Vec3d eulerRad, cv::Vec3d eulerDeg){
// opencv 4.2.0
// void detection_thread(cv::Mat camera_intrinsic,cv::Mat distortion_vector, cv::Ptr<cv::aruco::Dictionary> dictionary,
//                     cv::Ptr<cv::aruco::DetectorParameters> parameters,ros::Publisher result_detect_pub,cv::Vec3d eulerRad, cv::Vec3d eulerDeg){
    MarkerTracker tracker(3);
    ros::Rate loop_rate(30);
    float normalized_x;
    float normalized_y;
    while(is_running){
        // cv::Mat Detect_frame;
       {
        unique_lock<mutex> lock(detection_mutex);
        detection_cv.wait(lock, []{return !detection_queue.empty() || !is_running;});
        if(!detection_queue.empty()){
            Detect_frame = detection_queue.front().clone();
            detection_queue.pop();
        }
       }
        double current_time = ros::Time::now().toSec();
        cv::Mat RTMP_frame; 
        

        // cap >> RTMP_frame;
        // ros::spinOnce();
        if (frame.empty()) {
            ROS_WARN("空帧，跳过");
            continue;
        }
        // ROS_WARN("GET THE MQTT MESSAGE %s",state.c_str());
        
        Detect_frame = frame.clone();
        
        // 检测ArUco标记
        vector<int> markerIds;
        vector<vector<cv::Point2f>> markerCorners, rejectedCandidates;
        // for (auto& corners : markerCorners) {
        //     for (auto& point : corners) {
        //         point.y = Detect_frame.rows - point.y;
        //     }
        // }
        // change
        //opencv 4.7.0
        cv::aruco::ArucoDetector detector(dictionary, parameters);
        detector.detectMarkers(Detect_frame, markerCorners, markerIds, rejectedCandidates);
        //opencv 4.2.0
        // cv::aruco::detectMarkers(Detect_frame, dictionary, markerCorners, markerIds, parameters, rejectedCandidates);

        ROS_INFO_COND(!markerIds.empty(), "检测到 %zu 个标记", markerIds.size());
        
        vector<cv::Vec3d> rvecs(markerIds.size());
        vector<cv::Vec3d> tvecs(markerIds.size());
        
        if (!markerIds.empty())
        {
            // 处理每个标记的姿态估计
            for (size_t i = 0; i < markerIds.size(); i++)
            {
                int markerId = markerIds[i];
                double markerSize = 0.05;
                if (markerSizes.find(markerId) != markerSizes.end()) {
                    markerSize = markerSizes[markerId];
                } else {
                    ROS_WARN("未找到标记 %d 的尺寸，使用默认值 0.05米", markerId);
                }
                
                // 使用solvePnP进行姿态估计
                vector<cv::Point3f> objPoints;
                float halfSize = markerSize / 2.0f;
                objPoints.push_back(cv::Point3f(-halfSize, halfSize, 0));
                objPoints.push_back(cv::Point3f(halfSize, halfSize, 0));
                objPoints.push_back(cv::Point3f(halfSize, -halfSize, 0));
                objPoints.push_back(cv::Point3f(-halfSize, -halfSize, 0));
                
                cv::Vec3d rvec, tvec;
                bool pnpSuccess = cv::solvePnP(
                    objPoints, 
                    markerCorners[i], 
                    camera_intrinsic, 
                    distortion_vector, 
                    rvec, 
                    tvec,
                     false, 
                    cv::SOLVEPNP_IPPE_SQUARE
                );
                
                if (pnpSuccess) {
                    rvecs[i] = rvec;
                    tvecs[i] = tvec;
                    // eulerRad = rotationVectorToEulerAngles(rvec);
                    // eulerDeg = radiansToDegrees(eulerRad);
                    // cout<<"eulerDeg:"<<eulerDeg<<endl;
                } else {
                    ROS_WARN("标记 %d 的姿态估计失败", markerId);
                }
            }
            
            // 更新位置和角点跟踪器
            tracker.update(markerIds, tvecs, rvecs, current_time);
            for (size_t i = 0; i < markerIds.size(); i++) {
                tracker.updateCorners(markerIds[i], markerCorners[i]);
            }
        

        // 获取稳定位置
        auto stable_markers = tracker.get_stable_positions(5);
        // 获取稳定姿态
        auto stable_rotations = tracker.get_stable_rotations(5);

        // 处理稳定标记
        for (const auto& marker : stable_markers) {
            int markerId = marker.first;
            // if(markerId !=19 || markerId !=43){
            //     continue;
            // }
            cv::Vec3d position = marker.second;
            cv::Vec3d rotation = stable_rotations[markerId];
            auto it = std::find(markerIds.begin(), markerIds.end(), markerId);


            // zai zhe li jia yi ge if pan duan 
            // if(it != markerIds.end()){
            // 获取平滑后的角点
            vector<cv::Point2f> smoothedCorners = tracker.get_smoothed_corners(markerId);
            double markerSize = markerSizes.find(markerId) != markerSizes.end() ? 
                                markerSizes[markerId] : 0.05;
            if (!smoothedCorners.empty()) {
                // 绘制平滑后的标记框
                size_t idx = std::distance(markerIds.begin(), it);
                vector<vector<cv::Point2f>> smoothCornersVec = {smoothedCorners};
                vector<int> smoothIds = {markerId};
                cv::aruco::drawDetectedMarkers(Detect_frame, smoothCornersVec, smoothIds);
                // 绘制坐标系
                // cv::drawFrameAxes(
                //     frame, 
                //     camera_intrinsic, 
                //     distortion_vector, 
                //     rvecs[idx], 
                //     tvecs[idx],  
                //     markerSize * 1,
                //     2
                // );
                eulerRad = rotationVectorToEulerAngles(rotation);
                eulerDeg = radiansToDegrees(eulerRad);
                // 计算图像坐标 8.25 add test**********************************//
                cv::Point2f center(0, 0);
                for (const auto& corner : smoothedCorners) {
                    center.x += corner.x;
                    center.y += corner.y;
                }
                center.x /= smoothedCorners.size();
                center.y /= smoothedCorners.size();
                
                // 归一化图像坐标
                normalized_x = center.x / Detect_frame.cols;
                normalized_y = center.y / Detect_frame.rows;
                // ROS_INFO("normalize position, x: %.2f, y:%.2f",normalized_x,normalized_y);
                // *********************************************************//


                // 显示ID 位置 旋转关系
                cv::Point textPos = center;
                int show_offset = 60;
                int position_type = markerId;
                switch(position_type) {
                    case 1:  textPos += cv::Point(-6*show_offset,0);break;
                    case 2:  textPos += cv::Point(-6*show_offset,0);break;
                    case 3:  textPos += cv::Point(show_offset-10,0);break;
                    case 4:  textPos += cv::Point(show_offset-10,0);break;
                    case 19: textPos += cv::Point(-show_offset-20, 30); break;  
                    case 43: textPos += cv::Point(-show_offset-20, -show_offset); break;   
                }
                
                string text = "ID:" + to_string(markerId) + 
                             " T:(" + to_string(position[0]) + "," + 
                             to_string(position[1]) + "," + 
                             to_string(position[2]) + ")";
                string R_text = "R:(" + to_string(eulerDeg[0]) + "," +  
                                to_string(eulerDeg[1]) + "," + 
                                to_string(eulerDeg[2]) + ")";

                int baseline = 0;
                cv::Size textSize = cv::getTextSize(text, cv::FONT_HERSHEY_SIMPLEX, 0.6, 2, &baseline);
                cv::putText(Detect_frame, text, textPos, cv::FONT_HERSHEY_SIMPLEX, 
                            0.6, cv::Scalar(0, 255, 0), 2);

                cv::Point textPos2 = textPos + cv::Point(0, textSize.height + 20);
                cv::putText(Detect_frame, R_text, textPos2, cv::FONT_HERSHEY_SIMPLEX, 
                            0.6, cv::Scalar(0, 255, 0), 2);
                 cv::circle(Detect_frame, center, 2, cv::Scalar(0, 0, 255), 3); // 红色圆圈
            }
            // }
            
            // 创建并发布位置消息
            vision_msgs::TargetsInFrame msg;
            vision_msgs::TargetsInFrame vision_msg;
            vision_msgs::Target ros_target;
            msg.header.stamp = ros::Time::now();
            msg.header.frame_id = "TargetsInfo";
            msg.marker_id = markerId;
            // msg.x = (static_cast<float>(position[0]) + markerSize/2) / Detect_frame.cols;
            // msg.y = (static_cast<float>(position[1]) + markerSize/2 + 0.15) / Detect_frame.rows;
            // if(msg.marker_id==19 || msg.marker_id==43 ){
                //根据各角点位置计算的2d坐标
                ROS_INFO("Test normalize position, x: %.2f, y:%.2f",normalized_x,normalized_y);
 
                msg.x = static_cast<float>(position[0]);
                msg.y = static_cast<float>(position[1]);
                msg.z = static_cast<float>(position[2]);
                //根据相机内参自行计算的2d坐标
                float u = (fx * msg.x/msg.z) + cx;
                float v = (fy * msg.y/msg.z) + cy;
                // int pixel_u = static_cast<int>(u + 0.5f);  
                // int pixel_v = static_cast<int>(v + 0.5f);
                // cv::Point2f image_point(pixel_u, pixel_v);
                // cv::circle(Detect_frame, image_point, 2, cv::Scalar(0, 0, 255), 3); // 红色圆圈
                ROS_INFO("Get the pixel value,u:%.5f,v:%.5f",u,v);
                //归一化后的坐标
                ROS_INFO("Get the pixel value,u:%.5f,v:%.5f",u / Detect_frame.cols,v / Detect_frame.rows); 
                ros_target.tracked_id = markerId;
                // ros_target.cx = static_cast<float>(position[0]);
                // ros_target.cy = static_cast<float>(position[1]);
                //测试坐标1
                ros_target.cx = u / Detect_frame.cols;
                ros_target.cy = v / Detect_frame.rows;
                //测试坐标2
                // ros_target.cx = normalized_x;
                // ros_target.cy = normalized_y;
                ros_target.yaw_a = static_cast<float>(eulerDeg[0]);
                vision_msg.targets.push_back(ros_target);
            // }
            // msg.x = static_cast<float>(position[0]);
            // msg.y = static_cast<float>(position[1]);
            // msg.z = static_cast<float>(position[2]);
            // //根据相机内参自行计算的2d坐标
            // float u = (fx * msg.x/msg.z) + cx;
            // float v = (fy * msg.y/msg.z) + cy;
            // ROS_INFO("Get the pixel value,u:%.5f,v:%.5f",u,v);

            msg.yaw = static_cast<float>(eulerDeg[0]);
            msg.pitch = static_cast<float>(eulerDeg[1]);
            msg.roll = static_cast<float>(eulerDeg[2]);
            
            if(!vision_msg.targets.empty()){
                result_detect_pub.publish(vision_msg);
                for (const auto& target : vision_msg.targets) {
                    ROS_INFO("Publish detect result - ID: %d, Position: (%.3f, %.3f), Yaw: %.3f", 
                    target.tracked_id, 
                    target.cx, 
                    target.cy, 
                    target.yaw_a);
                }
            }
            // ROS_INFO("发布稳定标记 %d: (%.3f, %.3f, %.3f)米,R:(%.3f, %.3f, %.3f)", 
            //          markerId, msg.x, msg.y, msg.z, msg.yaw, msg.pitch, msg.roll);
        }
        }
        else{
            ROS_INFO("Current Frame is occluded");
        }
        
        // 显示原始图像
        cv::imshow("ArUco Detection", Detect_frame);

        // 按下 'q' 键退出循环
        if (cv::waitKey(1) == 'q')
        {
            break;
        }
        
        // 处理ROS回调
        ros::spinOnce();
        
        loop_rate.sleep();
    }
}

int main(int argc, char *argv[])
{
    ros::init(argc, argv, "detect_ArUco");
    ros::NodeHandle nh;
    ros::Rate loop_rate(30);
    // ros::Publisher result_detect_pub_1 = nh.advertise<vision_msgs::TargetsInFrame>("/uav1/vision/aruco_detection_1", 10);
    ros::Publisher result_detect_pub = nh.advertise<vision_msgs::TargetsInFrame>("/uav2/vision/aruco_detection", 10);
    //MQTT start 
    MqttListener listener;
    listener.start();
    cout<< "detect_result:" << detect_result << endl;
    get_parameters();

    if (!init_camera()) {
        ROS_INFO("START RECONNECT!");
        reconnect_thread = thread(camera_reconnect_thread);
    }
    

    vector<float> intrinsic;
    getIntrinsic(intrinsic_path, intrinsic);
    vector<float> distortion;
    getDistortion(intrinsic_path, distortion);
    
    //欧拉角(Z-->Y-->X方向,yaw-->pitch-->roll)
    cv::Vec3d eulerRad;
    cv::Vec3d eulerDeg;

    cv::Mat camera_intrinsic = cv::Mat::eye(3, 3, CV_64F);
    camera_intrinsic.at<double>(0, 0) = intrinsic[0];
    camera_intrinsic.at<double>(0, 2) = intrinsic[2];
    camera_intrinsic.at<double>(1, 1) = intrinsic[4];
    camera_intrinsic.at<double>(1, 2) = intrinsic[5];
    fx = intrinsic[0];
    fy = intrinsic[4];
    cx = intrinsic[2];
    cy = intrinsic[5];
    cout<< camera_intrinsic << endl;
    cv::Mat distortion_vector = cv::Mat::zeros(5, 1, CV_64F);
    distortion_vector.at<double>(0) = distortion[0];
    distortion_vector.at<double>(1) = distortion[1];
    distortion_vector.at<double>(2) = distortion[2];
    distortion_vector.at<double>(3) = distortion[3];
    distortion_vector.at<double>(4) = distortion[4];
   
    // ArUco 设置
    // marker_id 0-250
    //opencv 4.7.0
    cv::aruco::Dictionary dictionary = cv::aruco::getPredefinedDictionary(cv::aruco::DICT_6X6_250);
    cv::aruco::DetectorParameters parameters = cv::aruco::DetectorParameters();
    parameters.cornerRefinementMethod = cv::aruco::CORNER_REFINE_SUBPIX;
    //opencv 4.2.0
    // cv::Ptr<cv::aruco::Dictionary> dictionary = cv::aruco::getPredefinedDictionary(cv::aruco::DICT_6X6_250);
    // cv::Ptr<cv::aruco::DetectorParameters> parameters = cv::aruco::DetectorParameters::create();
    // parameters->cornerRefinementMethod = cv::aruco::CORNER_REFINE_SUBPIX;
 

    // 初始化标记追踪器
    // MarkerTracker tracker(3); //3帧连续
    // rtsp
    // cv::VideoCapture cap;
    // string camera_type = nh.param<string>("camera_type","0");

    // if(camera_type == "0"){
    //     cout<< "camera_type: "<< "USB Camera"<<endl;
    //     cap.open(stoi(camera_type),cv::CAP_V4L2);
    // }else{
    //     string rtsp_url = nh.param<string>("camera_type","rtsp://192.168.144.108");
    //     cout<< "camera_type: "<< "Internet Camera ,"<<"Address: "<< rtsp_url <<endl;
    //     cap.open(rtsp_url);
    // }

    // if (!cap.isOpened())
    // {
    //     ROS_ERROR("Can not open camera!!");
    //     return -1;
    // }
    
    //image topic publish
    string rtmp_topic = "/uav2/rtmp_image_stream";
    image_transport::ImageTransport it1(nh);
    image_transport::Publisher pub1 = it1.advertise(rtmp_topic,10);
    // 获取相机参数
    int width = cap.get(cv::CAP_PROP_FRAME_WIDTH);
    int height = cap.get(cv::CAP_PROP_FRAME_HEIGHT);
    string rtmp_url = "rtmp://47.104.183.127/live/test_stream";

    // 创建显示窗口
    cv::namedWindow("ArUco Detection", cv::WINDOW_NORMAL);
    cv::resizeWindow("ArUco Detection", 1280, 720); // 1920 1080
    // FILE *fp = nullptr;
    // fp = popen(command.str().c_str(),"w");
    thread detect_thread(detection_thread,camera_intrinsic,distortion_vector,dictionary,parameters,result_detect_pub,eulerRad,eulerDeg);
    
    // thread stream_thread(rtmp_streaming_thread, rtmp_url, width, height, actualFPS);
    // this_thread::sleep_for(chrono::seconds(5));
    sensor_msgs::ImagePtr msg_rtmp;
    while (ros::ok() && is_running)
    {
        // cap >> frame;
        // cv::flip(frame, frame, -1);
         if (camera_connected && cap.isOpened()) {
                {
                lock_guard<mutex> lock(camera_mutex);
                if (!cap.read(frame)) {
                    ROS_WARN("Empty Frame!");
                    camera_connected = false;
                    continue;
                    }
                }
                {
                    lock_guard<mutex> lock(detection_mutex);
                    if (detection_queue.size() < 3) {  // 限制队列长度
                        detection_queue.push(frame.clone());
                        detection_cv.notify_one();
                    }
                }
                try{
                    if(detect_result)
                        msg_rtmp = cv_bridge::CvImage(std_msgs::Header(),"bgr8",Detect_frame).toImageMsg();
                    else
                        msg_rtmp = cv_bridge::CvImage(std_msgs::Header(),"bgr8",frame).toImageMsg();
                    msg_rtmp->header.stamp = ros::Time::now();
                }
                catch(cv_bridge::Exception& e){
                    ROS_ERROR("cv_bridge exception!");
                    continue;
                }
                pub1.publish(msg_rtmp);
         }
        // ROS_INFO("Topic %s has published!" , rtmp_topic.c_str());
        ros::spinOnce();
        loop_rate.sleep(); 
    }
    // 释放资源
    is_running = false;
    detection_cv.notify_all();
    reconnect_thread.join();
    detect_thread.join();
    listener.stop();
    {
        lock_guard<mutex> lock(camera_mutex);
        if (cap.isOpened()) {
            cap.release();
        }
    }
    cv::destroyAllWindows();

    return 0;
}
