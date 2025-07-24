#include <ros/ros.h>
#include <uavcontrol_msgs/arucoTrigger.h> 
#include "aruco_land_nocontrol.h"
// bool aruco_tracker;
// bool service_cb(uavcontrol_msgs::arucoTrigger::Request &req,uavcontrol_msgs::arucoTrigger::Response &res){
//     if(req.request){
//         res.response = true;
//         aruco_tracker = true;
//     }
//     else
//     return false;
// }

int main(int argc, char** argv) {
    ros::init(argc, argv, "aruco_code_tracker");
    ros::NodeHandle nh_("~");
    // ros::ServiceServer service = nh_.advertiseService("/aruco_landing",service_cb);// 获取land 触发信号
    // if (aruco_tracker){
        ArucoTracker tracker;
        ros::spin();
    //}
    return 0;
}
