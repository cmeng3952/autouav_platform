#include <ros/ros.h>
#include <mavros_msgs/Mavlink.h>
#include <mavlink/v2.0/common/mavlink.h>
#include <std_srvs/Empty.h>
#include <iostream>
#include <string>
#include <vector>
#include <unistd.h>

#include "../../communication/include/message_convert.hpp"

class EKF2ResetNode
{
private:
    ros::NodeHandle nh_;
    ros::Publisher serial_control_pub_;
    ros::ServiceServer reset_service_;
    int uav_id_;
    
public:
    EKF2ResetNode(ros::NodeHandle& nh) : nh_(nh)
    {
        // 获取无人机ID参数
        nh_.param<int>("uav_id", uav_id_, 2);
        
        // 初始化发布器，用于发送mavlink消息
        serial_control_pub_ = nh_.advertise<mavros_msgs::Mavlink>("/uav" + std::to_string(uav_id_) + "/mavlink/to", 10);
        
        // 创建服务，用于外部调用EKF2重置
        reset_service_ = nh_.advertiseService("/uav" + std::to_string(uav_id_) + "/ekf2_reset", 
                                            &EKF2ResetNode::resetEKF2Service, this);
        
        ROS_INFO("[EKF2 Reset Node] UAV%d EKF2 Reset Node initialized", uav_id_);
        ROS_INFO("[EKF2 Reset Node] Service available at: /uav%d/ekf2_reset", uav_id_);
    }
    
    /**
     * @brief 发送串口控制命令到PX4
     * @param cmd 要发送的命令字符串
     */
    void sendSerialControl(const std::string& cmd)
    {
        if (cmd.empty())
            return;
            
        // 准备要发送的命令
        std::string command = cmd;
        if (cmd.back() != '\n')
        {
            command += '\n';
        }
        
        std::vector<uint8_t> data(70, 0);
        std::copy(command.begin(), command.end(), data.begin());
        
        // 创建序列控制消息
        mavlink_serial_control_t msg;
        msg.device = SERIAL_CONTROL_DEV_SHELL;
        msg.flags = (SERIAL_CONTROL_FLAG_RESPOND |
                     SERIAL_CONTROL_FLAG_EXCLUSIVE |
                     SERIAL_CONTROL_FLAG_MULTI);
        msg.timeout = 1000;
        msg.baudrate = 0;
        msg.count = command.length();
        std::copy(data.begin(), data.end(), msg.data);
        
        // 将mavlink_serial_control_t消息编码为mavlink_message_t消息
        mavlink_message_t mavlink_msg;
        mavlink_msg_serial_control_encode(1, 240, &mavlink_msg, &msg); // 1是系统ID，240是组件ID
        
        // 将mavlink_message_t转换为mavros_msgs::Mavlink
        mavros_msgs::Mavlink ros_msg;
        message_convert::convert(mavlink_msg, ros_msg);
        
        // 发布消息
        serial_control_pub_.publish(ros_msg);
        
        ROS_INFO("[EKF2 Reset Node] Sent command: %s", cmd.c_str());
    }
    
    /**
     * @brief 重置EKF2的服务回调函数
     */
    bool resetEKF2Service(std_srvs::Empty::Request& req, std_srvs::Empty::Response& res)
    {
        ROS_INFO("[EKF2 Reset Node] Starting EKF2 reset procedure...");
        
        try {
            // 发送ekf2 stop命令
            ROS_INFO("[EKF2 Reset Node] Sending 'ekf2 stop' command");
            sendSerialControl("ekf2 stop");
            
            // 等待3秒
            ROS_INFO("[EKF2 Reset Node] Waiting 3 seconds...");
            sleep(3);
            
            // 发送ekf2 start命令
            ROS_INFO("[EKF2 Reset Node] Sending 'ekf2 start' command");
            sendSerialControl("ekf2 start");
            
            ROS_INFO("[EKF2 Reset Node] EKF2 reset completed successfully!");
            return true;
        }
        catch (const std::exception& e) {
            ROS_ERROR("[EKF2 Reset Node] EKF2 reset failed: %s", e.what());
            return false;
        }
    }
    
    /**
     * @brief 直接执行EKF2重置（无服务调用）
     */
    void resetEKF2()
    {
        ROS_INFO("[EKF2 Reset Node] Executing EKF2 reset...");
        
        // 发送ekf2 stop命令
        ROS_INFO("[EKF2 Reset Node] Sending 'ekf2 stop' command");
        sendSerialControl("ekf2 stop");
        
        // 等待3秒
        ROS_INFO("[EKF2 Reset Node] Waiting 3 seconds...");
        sleep(3);
        
        // 发送ekf2 start命令
        ROS_INFO("[EKF2 Reset Node] Sending 'ekf2 start' command");
        sendSerialControl("ekf2 start");
        
        ROS_INFO("[EKF2 Reset Node] EKF2 reset completed!");
    }
    
    /**
     * @brief 发送单个EKF2命令
     * @param cmd 命令类型，"stop"或"start"
     */
    void sendEKF2Command(const std::string& cmd)
    {
        std::string full_cmd = "ekf2 " + cmd;
        ROS_INFO("[EKF2 Reset Node] Sending command: %s", full_cmd.c_str());
        sendSerialControl(full_cmd);
    }
};

void printUsage()
{
    std::cout << "\n=== EKF2 Reset Node Usage ===" << std::endl;
    std::cout << "This node provides EKF2 reset functionality for PX4 autopilot via mavlink serial control." << std::endl;
    std::cout << "\nAvailable methods:" << std::endl;
    std::cout << "1. ROS Service: rosservice call /uav<ID>/ekf2_reset" << std::endl;
    std::cout << "2. Command line parameters:" << std::endl;
    std::cout << "   - reset: Execute full EKF2 reset (stop + wait + start)" << std::endl;
    std::cout << "   - stop:  Send 'ekf2 stop' command only" << std::endl;  
    std::cout << "   - start: Send 'ekf2 start' command only" << std::endl;
    std::cout << "\nExamples:" << std::endl;
    std::cout << "rosrun uavcontrol ekf2_reset_node _uav_id:=2 reset" << std::endl;
    std::cout << "rosrun uavcontrol ekf2_reset_node _uav_id:=2 stop" << std::endl;
    std::cout << "rosservice call /uav2/ekf2_reset" << std::endl;
    std::cout << "==============================\n" << std::endl;
}

int main(int argc, char** argv)
{
    ros::init(argc, argv, "ekf2_reset_node");
    ros::NodeHandle nh("~");
    
    printUsage();
    
    // 创建EKF2重置节点
    EKF2ResetNode ekf2_node(nh);
    
    // 等待mavlink发布器准备就绪
    ROS_INFO("[EKF2 Reset Node] Waiting for mavlink publisher to be ready...");
    ros::Duration(2.0).sleep();
    
    // 检查是否有命令行参数
    bool command_executed = false;
    if (argc > 1)
    {
        std::string command = argv[1];
        ROS_INFO("[EKF2 Reset Node] Received command: %s", command.c_str());
        
        if (command == "reset")
        {
            ekf2_node.resetEKF2();
            command_executed = true;
        }
        else if (command == "stop")
        {
            ekf2_node.sendEKF2Command("stop");
            command_executed = true;
        }
        else if (command == "start")
        {
            ekf2_node.sendEKF2Command("start");
            command_executed = true;
        }
        else
        {
            ROS_ERROR("[EKF2 Reset Node] Unknown command: %s", command.c_str());
            ROS_ERROR("[EKF2 Reset Node] Available commands: reset, stop, start");
            return -1;
        }
        
        // 如果执行了命令，等待一下然后退出
        if (command_executed)
        {
            ros::Duration(1.0).sleep();
            ROS_INFO("[EKF2 Reset Node] Command executed, shutting down...");
            return 0;
        }
    }
    
    // 如果没有命令行参数，保持节点运行以提供服务
    ROS_INFO("[EKF2 Reset Node] Node running, waiting for service calls...");
    ros::spin();
    
    return 0;
}
