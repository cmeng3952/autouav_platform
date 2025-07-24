

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

// PID控制器类
class PIDController {
public:
    PIDController(double p, double i, double d, double max_integral = 0.5)
        : p_gain_(p), i_gain_(i), d_gain_(d), max_integral_(max_integral),
          integral_(0.0), last_error_(0.0) {}

    void reset() {
        integral_ = 0.0;
        last_error_ = 0.0;
    }

    double compute(double error, double dt) {
        std::cout << "error ==" << error << std::endl;
        // 积分项
        integral_ += error * dt;
        // 限制积分项防止windup
        integral_ = std::clamp(integral_, -max_integral_, max_integral_);
        
        // 微分项
        double derivative = (error - last_error_) / dt;
        last_error_ = error;
        
        // PID输出
        return p_gain_ * error + i_gain_ * integral_ + d_gain_ * derivative;
    }

    void setGains(double p, double i, double d) {
        p_gain_ = p;
        i_gain_ = i;
        d_gain_ = d;
    }

private:
    double p_gain_;
    double i_gain_;
    double d_gain_;
    double max_integral_;
    double integral_;
    double last_error_;
};

// 降落模式枚举
enum class LandingMode {
    HOVER = -1,
    ROUGH_LAND = 0,
    FINE_LAND = 1,
    PX4_LAND = 2
};

class ArucoTracker{
public:
    ArucoTracker() : nh_("~"), 
                     pid_x_(0, 0, 0), pid_y_(0, 0, 0), pid_z_(0, 0, 0), 
                     last_update_time_(0), is_aruco_detected_(false), 
                     switch_flag(false), first_19_idx(-1), first_43_idx(-1),
                     system_flag(true), current_mode_(LandingMode::HOVER) {
        
        // 初始化agent_command
        agent_command.Command_ID = 0;
        
        // 初始化PID控制器参数
        loadParams();
        
        // 增加发布队列大小
        uav_command_pub = nh_.advertise<uavcontrol_msgs::UAVCommand>("/uav1/prometheus/command", 10);
        
        pose_sub = nh_.subscribe<geometry_msgs::PoseStamped>("/uav1/mavros/local_position/pose", 10, &ArucoTracker::pose_cb, this);
        aruco_dection_sub = nh_.subscribe<spirecv_msgs::TargetsInFrame>("/uav1/spirecv/aruco_detection", 10, &ArucoTracker::arucoCenterCallback, this);
        aruco_trigger_sub = nh_.subscribe<std_msgs::Bool>("/aruco_landing", 10, &ArucoTracker::arucotriggerCallback, this);
        control_timer_ = nh_.createTimer(ros::Duration(0.05), &ArucoTracker::controlLoop, this);
        
        ROS_INFO("ArucoTracker initialized successfully");
    }

    void pose_cb(const geometry_msgs::PoseStamped::ConstPtr & msg){
        odom_x = msg->pose.position.x;
        odom_y = msg->pose.position.y;
        odom_z = msg->pose.position.z;
    }

    void arucoCenterCallback(const spirecv_msgs::TargetsInFrame::ConstPtr& msg) {
        // 清空上一帧的索引记录
        id_19_indices_.clear();
        id_43_indices_.clear();
        first_19_idx = -1;
        first_43_idx = -1;
        
        if(!msg->targets.empty()){
            size_t target_count = msg->targets.size();
            aruco_center_x_.resize(target_count);
            aruco_center_y_.resize(target_count);
            aruco_center_id_.resize(target_count);
            aruco_yaw_.resize(target_count);
            
            if(target_count > 0){
                for(size_t i = 0; i < target_count; i++){
                    aruco_center_id_[i] = msg->targets[i].tracked_id;
                    aruco_center_x_[i] = msg->targets[i].cx;
                    aruco_center_y_[i] = msg->targets[i].cy;
                    aruco_yaw_[i] = msg->targets[i].yaw_a;
                    
                    // 记录特定ID的位置索引
                    if(aruco_center_id_[i] == 19) {
                        id_19_indices_.push_back(i);
                    } else if(aruco_center_id_[i] == 43) {
                        id_43_indices_.push_back(i);
                        ROS_INFO("aruco centerc x= %f aruco centerc y= %f",aruco_center_x_[i],aruco_center_y_[i]);
                    }
                }
                
                is_aruco_detected_ = true;
                last_update_time_ = ros::Time::now();
                
                // 检查当前帧中是否存在特定ID
                current_has_19 = !id_19_indices_.empty();
                current_has_43 = !id_43_indices_.empty();
                
                if(current_has_19) {
                    first_19_idx = id_19_indices_[0];
                }
                if(current_has_43) {
                    first_43_idx = id_43_indices_[0];
                }
                
                // 更新上一时刻的状态
                last_had_19 = current_has_19;
                last_had_43 = current_has_43;
            }
        }else{
            is_aruco_detected_ = false;
            aruco_center_x_.clear();
            aruco_center_y_.clear();
            aruco_center_id_.clear();
            aruco_yaw_.clear();
            last_had_19 = false;
            last_had_43 = false;
            ROS_INFO("No targets detected");
        }
    }

    void arucotriggerCallback(const std_msgs::Bool::ConstPtr & msg){
        is_trigger_ = msg->data;
        ROS_INFO("Aruco landing trigger: %s", is_trigger_ ? "ON" : "OFF");
    }
    
    void pid_control_output(int id, double dt, double p_g_x, double i_g_x, double d_g_x, 
                           double p_g_y, double i_g_y, double d_g_y, double p_z){
        if (id < 0 || id >= static_cast<int>(aruco_center_x_.size())) {
            ROS_ERROR("Invalid marker index for PID control!");
            return;
        }
        
        // 计算误差
        double error_x = -(aruco_center_x_[id] - 0.5); 
        double error_y = -(aruco_center_y_[id] - 0.5);
        
        // 参数设置
        pid_x_.setGains(p_g_x, i_g_x, d_g_x);
        pid_y_.setGains(p_g_y, i_g_y, d_g_y);
        pid_z_.setGains(p_z, 0.0, 0.0);
        
        // 使用PID控制器计算输出
        double output_x = pid_x_.compute(error_x, dt);
        double output_y = pid_y_.compute(error_y, dt);
        double output_z = -(p_z*odom_z > 0.3 ? 0.3 : p_z*odom_z);
        
        // 限制输出范围
        output_x = std::clamp(output_x, -0.3, 0.3);
        output_y = std::clamp(output_y, -0.3, 0.3);
        
        // 发布控制命令
        uavcommand_pub(4, output_y, output_x, output_z, 0);
    }
    
    void controlLoop(const ros::TimerEvent& event) {
        // 系统关闭模式
        if(!system_flag){
            uavcommand_pub(7);
            return;
        }
        
        // 未触发降落模式
        if(!is_trigger_){ 
            uavcommand_pub(7);
            return; 
        }
        
        ROS_INFO("odom_z ======%lf current_has_43 = %d", odom_z, current_has_43);
        
        // 没有检测到二维码
        if (!is_aruco_detected_) {
            uavcommand_pub(7);
            return;
        }
        
        // 检查二维码数据是否过期
        if ((ros::Time::now() - last_update_time_).toSec() > DATA_TIMEOUT) {
            is_aruco_detected_ = false;
            ROS_WARN("aruco data timeout!");
            uavcommand_pub(7);
            pid_x_.reset();
            pid_y_.reset();
            return;
        }
        
        // 计算时间步长
        double dt = (event.current_real - event.last_real).toSec();
        if (dt <= 0) dt = 0.05; // 默认50ms
        
        // 更新降落模式
        updateLandingMode();
        
        ROS_INFO("================= current_mode_ ================= %d", static_cast<int>(current_mode_));
        
        // 根据当前模式执行相应的控制逻辑
        executeModeControl(dt);
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
    
    // 更新降落模式
    void updateLandingMode() {
        // 模式切换逻辑
        if(((current_has_19 && current_has_43) || current_has_19) && odom_z > HEIGHT_ROUGH_LAND) {
            current_mode_ = LandingMode::ROUGH_LAND;
            ROS_INFO("Mode changed to ROUGH_LAND: ID 19 detected, height > %f", HEIGHT_ROUGH_LAND);
        } 
        else if(current_has_43 && odom_z < HEIGHT_ROUGH_LAND && odom_z > HEIGHT_FINE_LAND) {
            current_mode_ = LandingMode::FINE_LAND;
            ROS_INFO("Mode changed to FINE_LAND: ID 43 detected, %f < height < %f", 
                     HEIGHT_FINE_LAND, HEIGHT_ROUGH_LAND);
        }
        else if(odom_z < HEIGHT_FINE_LAND){
            current_mode_ = LandingMode::PX4_LAND;
            ROS_INFO("Mode changed to PX4_LAND: height < %f", HEIGHT_FINE_LAND);
        }
        else{
            current_mode_ = LandingMode::HOVER;
            ROS_INFO("Hovering: waiting for proper conditions");
            uavcommand_pub(7);
        }
    }
    
    // 执行模式控制
    void executeModeControl(double dt) {
        switch(current_mode_){
            case LandingMode::ROUGH_LAND:
                executeRoughLandMode(dt);
                break;
                
            case LandingMode::FINE_LAND:
                executeFineLandMode(dt);
                break;
                
            case LandingMode::PX4_LAND:
                executePx4LandMode();
                break;
                
            default:
                uavcommand_pub(7);
                break;
        }
    }
    
    // 执行粗降落模式
    void executeRoughLandMode(double dt) {
        if (first_19_idx < 0) {
            ROS_WARN("No ID 19 marker found for rough landing!");
            uavcommand_pub(7);
            return;
        }
        
        // 合并两次发布为一次
        double output_x = pid_x_.compute(-(aruco_center_x_[first_19_idx] - 0.5), dt);
        double output_y = pid_y_.compute(-(aruco_center_y_[first_19_idx] - 0.5), dt);
        double output_z = -(1*odom_z > 0.3 ? 0.3 : 1*odom_z);
        
        // 限制输出范围
        output_x = std::clamp(output_x, -0.3, 0.3);
        output_y = std::clamp(output_y, -0.3, 0.3);
        
        // 一次性发布所有控制量
        uavcommand_pub(4, output_y, output_x, output_z, aruco_yaw_[first_19_idx]/180*M_PI);
        
        ROS_INFO("Rough landing: x=%.2f, y=%.2f, z=%.2f, yaw=%.2f", 
                 output_x, output_y, output_z, aruco_yaw_[first_19_idx]/180*M_PI);
    }
    
    // 执行精降落模式
    void executeFineLandMode(double dt) {
        if (first_43_idx < 0) {
            ROS_WARN("No ID 43 marker found for fine landing!");
            uavcommand_pub(7);
            return;
        }
        
        // 使用参数化PID控制
        pid_control_output(first_43_idx, dt, p_gain_x, i_gain_x, d_gain_x, 
                          p_gain_y, i_gain_y, d_gain_y, p_z);
    }
    
    // 执行PX4降落模式
    void executePx4LandMode() {
        ROS_INFO("PX4 land mode activated");
        // 直接降落，不依赖二维码数据
        uavcommand_pub(2);
        system_flag = false;
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
        uav_command.velocity_ref[2] = -z;  // z轴速度
        
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

    // PID控制器实例
    PIDController pid_x_;
    PIDController pid_y_;
    PIDController pid_z_;
    
    // 二维码数据
    std::vector<double> aruco_center_x_, aruco_center_y_, aruco_yaw_;
    std::vector<int> aruco_center_id_, id_19_indices_, id_43_indices_;
    ros::Time last_update_time_;
    
    // 状态变量
    bool is_aruco_detected_, is_trigger_, last_had_19, last_had_43, 
         switch_flag, current_has_19, current_has_43, system_flag;
    LandingMode current_mode_;
    int first_19_idx, first_43_idx;
    
    // PID参数
    double p_gain_x, i_gain_x, d_gain_x, p_gain_y, i_gain_y, d_gain_y, p_z;
    
    // 位置信息
    float odom_x, odom_y, odom_z;
    
    // 命令消息
    uavcontrol_msgs::UAVCommand uav_command, agent_command;
};

#endif // ARUCO_CONTROLLER_H

