#include <iostream>
#include <stdio.h>
#include <mqtt/async_client.h>
#include <ros/ros.h>
#include <thread>
#include <string>
#include <opencv2/opencv.hpp> 
// #include <jsoncpp/json/json.h>
#include <jsoncpp/json/json.h>
#include <fstream>
#include <mutex>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <queue>
#include <chrono>

using namespace std;

bool is_running = true;
queue<cv::Mat> frame_queue;
mutex queue_mutex;
condition_variable queue_cv;
atomic<bool> streaming_active(true);
atomic<bool> frame_updated(false);

cv::Mat frame;
string rtmp_url = "rtmp://47.104.183.127/live/uav3_cam3";

chrono::time_point<chrono::system_clock> last_frame_time;  // 记录最后一帧的时间

void rtmp_streaming_thread(const string& rtmp_url, int width, int height, double fps) {
    stringstream command;
    command << "ffmpeg -y -fflags nobuffer -flags low_delay -an "
            << "-f rawvideo -vcodec rawvideo -pix_fmt bgr24 "
            << "-s " << width << "x" << height << " "
            << "-r " << fps << " -i - "
            << "-c:v libx264 -pix_fmt yuv420p -crf 22 -preset ultrafast "
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
        if (!rtmp_frame.empty()) {
            fwrite(rtmp_frame.data, sizeof(char), rtmp_frame.total() * rtmp_frame.elemSize(), fp);
            fflush(fp);
        }
    }
    pclose(fp);
}

void imageCallback(const sensor_msgs::ImageConstPtr& msg) {
    try {
        cv_bridge::CvImagePtr cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
        {
            lock_guard<mutex> lock(queue_mutex);
            frame = cv_ptr->image.clone();
            frame_updated = true;
            last_frame_time = chrono::system_clock::now();  // 更新最后一帧时间
        }
    } catch(cv_bridge::Exception &e) {
        ROS_ERROR("CV_bridge exception %s", e.what());
    }
}

bool is_topic_active() {
    // 如果超过 2 秒没有收到新帧，则认为话题无数据
    auto now = chrono::system_clock::now();
    auto elapsed = chrono::duration_cast<chrono::seconds>(now - last_frame_time).count();
    return elapsed < 5;  // 2 秒内收到过数据则返回 true
}

int main(int argc, char *argv[]) {
    ros::init(argc, argv, "rtmp_stream");
    ros::NodeHandle nh;
    ros::Subscriber aruco_image_sub = nh.subscribe("/uav3/rtmp_image_stream", 10, imageCallback);
    
    ROS_INFO("Waiting for the frame...");
    while(ros::ok() && frame.empty()) {
        ros::spinOnce();
        ros::Duration(0.1).sleep();
    }
    if (!ros::ok()) {
        return 0;  // ROS被关闭时退出
    }
    ROS_INFO("The frame received!");

    last_frame_time = chrono::system_clock::now();  // 初始化最后一帧时间

    int width = frame.cols;
    int height = frame.rows;
    double fps = 30.00;
    
    thread rtmp_thread(rtmp_streaming_thread, rtmp_url, width, height, fps);
    ros::Rate loop_rate(30);
    
    while (ros::ok() && is_running) {
        if (frame.empty()) {
            ROS_ERROR("The Frame is Empty!");
            break;
        }

        // 检查话题是否活跃
        if (!is_topic_active()) {
            ROS_WARN("No image data received for 2 seconds. Shutting down...");
            is_running = false;
            break;
        }

        ros::spinOnce();
        
        if (frame_updated.exchange(false)) {
            lock_guard<mutex> lock(queue_mutex);
            while (frame_queue.size() >= 2) {
                frame_queue.pop();
            }
            frame_queue.push(frame.clone());
            queue_cv.notify_one();
        }
        loop_rate.sleep();
    }

    is_running = false;
    queue_cv.notify_all();
    rtmp_thread.join();
    
    ros::shutdown();  // 确保 ROS 节点关闭
    return 0;
}