#include <ros/ros.h>
#include <image_transport/image_transport.h>
#include <opencv2/opencv.hpp>
#include <cv_bridge/cv_bridge.h>
#include <string>

using namespace std;
int main(int argc ,char **argv){

    ros::init(argc,argv,"video_dual_pub");
    ros::NodeHandle nh;
    ros::Rate loop_rate(30);
    string aruco_topic = "/uav1/image_aruco";
    string ai_topic = "/uav1/image_ai";
    image_transport::ImageTransport it1(nh);
    image_transport::ImageTransport it2(nh);
    image_transport::Publisher pub1 = it1.advertise(aruco_topic,1);
    image_transport::Publisher pub2 = it2.advertise(ai_topic,1);

    string rtsp_url = "rtsp://192.168.144.108:554/stream=0";
    cv::VideoCapture cap(rtsp_url);
    if(!cap.isOpened()){
        ROS_ERROR("Can not open the Camera!");
        return -1;
    }
    cap.set(cv::CAP_PROP_FRAME_WIDTH,1280);
    cap.set(cv::CAP_PROP_FRAME_HEIGHT,720);
    

    cv::Mat frame;
    sensor_msgs::ImagePtr msg;

    while(ros::ok()){
        if(!cap.read(frame)){
            ROS_WARN("can not capture this frame!!");
        }
        try{
            msg = cv_bridge::CvImage(std_msgs::Header(),"bgr8",frame).toImageMsg();
            msg->header.stamp = ros::Time::now();
        }
        catch(cv_bridge::Exception& e){
            ROS_ERROR("cv_bridge exception!");
            continue;
        }
        pub1.publish(msg);
        pub2.publish(msg);
        ROS_INFO("Topic %s has published!" , aruco_topic.c_str());
        ROS_INFO("Topic %s has published!" , ai_topic.c_str());
        ros::spinOnce();
        loop_rate.sleep();
    }

    cap.release();
    return 0;
}