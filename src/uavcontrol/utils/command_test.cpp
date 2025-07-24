#ifndef ARUCO_CONTROLLER_H
#define ARUCO_CONTROLLER_H

#include <ros/ros.h>
#include <uavcontrol_msgs/UAVCommand.h>
#include <spirecv_msgs/TargetsInFrame.h>
#include <std_msgs/Bool.h>
#include <algorithm>
#include <geometry_msgs/Twist.h>
#include <geometry_msgs/PoseStamped.h>
#include <cmath>

class ArucoTracker{
public:
    ArucoTracker() : nh_("~") {
        
        // 初始化agent_command
        agent_command.Command_ID = 0;
        
        // 增加发布队列大小
        uav_command_pub = nh_.advertise<uavcontrol_msgs::UAVCommand>("/uav1/prometheus/command", 10);
        control_timer_ = nh_.createTimer(ros::Duration(0.05), &ArucoTracker::controlLoop, this);
        
        ROS_INFO("ArucoTracker initialized successfully");
    }
    
    void controlLoop(const ros::TimerEvent& event) {
        uavcommand_pub(4,p_gain_x,i_gain_x,d_gain_x,p_z);
    }

private:
    // 加载参数
    void loadParams() {
        nh_.param("/mission_aruco_land_node/p_gain_x", p_gain_x, 0.5);
        nh_.param("/mission_aruco_land_node/i_gain_x", i_gain_x, 0.01);
        nh_.param("/mission_aruco_land_node/d_gain_x", d_gain_x, 0.1);
        nh_.param("/mission_aruco_land_node/p_gain_y", p_gain_y, 0.5);
        nh_.param("/mission_aruco_land_node/i_gain_y", i_gain_y, 0.01);
        nh_.param("/mission_aruco_land_node/d_gain_y", d_gain_y, 0.1);
        nh_.param("/mission_aruco_land_node/p_gain_z", p_z, 0.3);
    }
    

    // 发布UAV命令（简化版）
    void uavcommand_pub(int mode) {
        uav_command.header.stamp = ros::Time::now();
        uav_command.Agent_CMD = mode;
        uav_command.Command_ID = agent_command.Command_ID + 1;
        
        ROS_INFO("Publishing command: mode=%d, cmd_id=%d", mode, uav_command.Command_ID);
        
        uav_command_pub.publish(uav_command);
        agent_command.Command_ID = uav_command.Command_ID;
    }

    // 发布UAV命令（带参数版）
    void uavcommand_pub(int mode, double x, double y, double z, float yaw_ref) {
        uav_command.header.stamp = ros::Time::now();
        uav_command.Agent_CMD = mode;
        uav_command.Control_Level = 0;
        uav_command.Move_mode = 4;
        
        uav_command.position_ref[0] = 0;
        uav_command.position_ref[1] = 0;
        uav_command.position_ref[2] = 0;

        // 确保velocity_ref顺序正确
        uav_command.velocity_ref[0] = x;  // x轴速度
        uav_command.velocity_ref[1] = y;  // y轴速度
        uav_command.velocity_ref[2] = z;  // z轴速度
        
        // 输出调试信息
        ROS_INFO("Publishing command: mode=%d, x=%.2f, y=%.2f, z=%.2f, yaw=%.2f, cmd_id=%d", 
                 mode, x, y, z, yaw_ref, agent_command.Command_ID + 1);
        
        //uav_command.yaw_ref = yaw_ref;
        uav_command.Command_ID = agent_command.Command_ID + 1;
        uav_command_pub.publish(uav_command);
        agent_command.Command_ID = uav_command.Command_ID;
    }

    // 常量定义
    static constexpr double DATA_TIMEOUT = 0.5;        // 数据超时时间(秒)
    static constexpr double HEIGHT_ROUGH_LAND = 1.0;   // 粗降落高度阈值(米)
    static constexpr double HEIGHT_FINE_LAND = 0.3;    // 精降落高度阈值(米)

    // ROS相关成员
    ros::NodeHandle nh_;
    ros::Subscriber pose_sub, aruco_dection_sub, aruco_trigger_sub;
    ros::Publisher uav_command_pub;
    ros::Timer control_timer_;
    
    // PID参数
    double p_gain_x, i_gain_x, d_gain_x, p_gain_y, i_gain_y, d_gain_y, p_z;
    // 命令消息
    uavcontrol_msgs::UAVCommand uav_command, agent_command;
};

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
#endif // ARUCO_CONTROLLER_H
