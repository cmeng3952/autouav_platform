#include <ros/ros.h>
#include "mission_waypoint.h"

int main(int argc, char** argv) {
    // 初始化ROS节点
    ros::init(argc, argv, "mission_waypoint_node");
    
    // 获取UAV ID参数
    ros::NodeHandle nh("~");
    int uav_id = 1; // 默认UAV ID为1
    
    // 尝试从ROS参数服务器获取UAV ID
    if (nh.hasParam("uav_id")) {
        nh.getParam("uav_id", uav_id);
        ROS_INFO("UAV ID set from ROS parameter: %d", uav_id);
    } else if (argc > 1) {
        // 如果没有ROS参数，尝试从命令行参数获取
        try {
            uav_id = std::stoi(argv[1]);
            ROS_INFO("UAV ID set from command line: %d", uav_id);
        } catch (const std::exception& e) {
            ROS_WARN("Invalid UAV ID parameter, using default: 1");
            uav_id = 1;
        }
    } else {
        ROS_INFO("Using default UAV ID: %d", uav_id);
    }
    
    ROS_INFO("Starting MAVROS Mission Waypoint Controller Node for UAV%d...", uav_id);
    
    try {
        // 创建任务控制器实例，传入UAV ID
        MissionController mission_controller(uav_id);
        
        ROS_INFO("Mission Waypoint Controller initialized successfully for UAV%d", uav_id);
        ROS_INFO("Waiting for mission trigger on /mission_waypoint_trigger topic...");
        
        // 运行ROS循环
        ros::spin();
        
    } catch (const std::exception& e) {
        ROS_ERROR("Mission Waypoint Controller failed to start: %s", e.what());
        return -1;
    }
    
    ROS_INFO("Mission Waypoint Controller node shutting down");
    return 0;
} 