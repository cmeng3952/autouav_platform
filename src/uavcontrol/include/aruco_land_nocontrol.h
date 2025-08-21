#ifndef ARUCO_CONTROLLER_H
#define ARUCO_CONTROLLER_H

#include <ros/ros.h>
#include <uavcontrol_msgs/UAVCommand.h>
#include <spirecv_msgs/TargetsInFrame.h>
#include <std_msgs/Bool.h>
#include <std_msgs/UInt8.h>
#include <std_msgs/Float64.h>
#include <algorithm>
#include <geometry_msgs/Twist.h>
#include <geometry_msgs/PoseStamped.h>
#include <mavros_msgs/PositionTarget.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/State.h>
#include <sensor_msgs/Range.h>
#include <cmath>
#include <string>

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
                     system_flag(true), current_mode_(LandingMode::HOVER),
                     rel_alt_(0.0), rel_alt_available_(false),
                     lidar_height_(0.0), lidar_available_(false), last_lidar_time_(0),
                     height_source_priority_(3), lidar_enable_(true), 
                     lidar_timeout_(1.0), lidar_noise_threshold_(0.1), lidar_fusion_weight_(0.8),
                     enable_lidar_debug_(true),
                     last_aruco_lost_time_(0), aruco_lost_buffer_active_(false),
                     last_target_yaw_(0.0), yaw_initialized_(false) {
        
        // 初始化PID控制器参数
        loadParams();
        
        // 直接发布mavros位置控制指令给PX4
        mavros_setpoint_pub = nh_.advertise<mavros_msgs::PositionTarget>("/uav1/mavros/setpoint_raw/local", 10);
        
        // 添加飞行模式设置服务客户端
        set_mode_client = nh_.serviceClient<mavros_msgs::SetMode>("/uav1/mavros/set_mode");
        
        pose_sub = nh_.subscribe<geometry_msgs::PoseStamped>("/uav1/mavros/local_position/pose", 10, &ArucoTracker::pose_cb, this);
        // 添加相对高度订阅，用于更准确的高度数据
        rel_alt_sub = nh_.subscribe<std_msgs::Float64>("/uav1/mavros/global_position/rel_alt", 10, &ArucoTracker::relAltCallback, this);
        // 添加激光测距订阅，用于精确的地面距离测量
        lidar_sub = nh_.subscribe<sensor_msgs::Range>("/uav1/mavros/distance_sensor/hrlv_ez4_pub", 10, &ArucoTracker::lidarCallback, this);
        aruco_dection_sub = nh_.subscribe<spirecv_msgs::TargetsInFrame>("/uav1/uavcontrol/aruco_detection", 10, &ArucoTracker::arucoCenterCallback, this);
        aruco_trigger_sub = nh_.subscribe<std_msgs::Bool>("/aruco_landing", 10, &ArucoTracker::arucotriggerCallback, this);
        // Hangar state (uav_state, uint8) from MQTT bridge
        hangar_state_sub_ = nh_.subscribe<std_msgs::UInt8>("/hangar/uav_state", 10, &ArucoTracker::hangarStateCallback, this);

        // Parameters to control hangar gating
        nh_.param("enable_hangar_trigger", enable_hangar_trigger_, true);
        nh_.param("hangar_ready_value", hangar_ready_value_, 1);
        mavros_state_sub = nh_.subscribe<mavros_msgs::State>("/uav1/mavros/state", 10, &ArucoTracker::mavrosStateCallback, this);
        // 使用可配置的控制频率创建Timer
        control_timer_ = nh_.createTimer(ros::Duration(1.0/control_frequency_), &ArucoTracker::controlLoop, this);
        
        // 启动时显示坐标系转换验证指南（根据调试参数决定）
        if (enable_coordinate_transform_test_) {
            verifyCoordinateTransform();
            
            // 测试一些典型的坐标转换场景
            ROS_INFO("=== 坐标系转换测试示例 ===");
            testCoordinateTransform(0.7, 0.5);  // ArUco在右侧
            testCoordinateTransform(0.3, 0.5);  // ArUco在左侧
            testCoordinateTransform(0.5, 0.7);  // ArUco在下方
            testCoordinateTransform(0.5, 0.3);  // ArUco在上方
        }
        
        ROS_INFO("ArucoTracker initialized successfully with Adaptive PID and MAVROS control");
    }

    void pose_cb(const geometry_msgs::PoseStamped::ConstPtr & msg){
        odom_x = msg->pose.position.x;
        odom_y = msg->pose.position.y;
        odom_z = msg->pose.position.z;
    }

    void relAltCallback(const std_msgs::Float64::ConstPtr& msg) {
        rel_alt_ = msg->data;
        rel_alt_available_ = true;
        
        // 定期打印相对高度vs本地高度的对比（避免过于频繁）
        static ros::Time last_height_print = ros::Time(0);
        if ((ros::Time::now() - last_height_print).toSec() > height_print_interval_) {
            ROS_INFO("Height comparison: rel_alt=%.2fm, local_z=%.2fm, lidar=%.2fm, fused=%.2fm", 
                     rel_alt_, odom_z, lidar_height_, getCurrentHeight());
            last_height_print = ros::Time::now();
        }
    }

    void lidarCallback(const sensor_msgs::Range::ConstPtr& msg) {
        // 检查激光测距数据有效性
        if (msg->range >= msg->min_range && msg->range <= msg->max_range) {
            // 简单的噪声过滤
            if (!lidar_available_ || fabs(msg->range - lidar_height_) < lidar_noise_threshold_) {
                lidar_height_ = msg->range;
                lidar_available_ = true;
                last_lidar_time_ = ros::Time::now();
                
                if (enable_lidar_debug_) {
                    static ros::Time last_lidar_print = ros::Time(0);
                    if ((ros::Time::now() - last_lidar_print).toSec() > 2.0) {
                        ROS_INFO("Lidar height: %.2fm (range: [%.2f, %.2f]m)", 
                                 lidar_height_, msg->min_range, msg->max_range);
                        last_lidar_print = ros::Time::now();
                    }
                }
            } else {
                if (enable_lidar_debug_) {
                    ROS_WARN("Lidar noise filtered: current=%.2fm, new=%.2fm, diff=%.3fm", 
                             lidar_height_, msg->range, fabs(msg->range - lidar_height_));
                }
            }
        } else {
            if (enable_lidar_debug_) {
                ROS_WARN("Lidar out of range: %.2fm (valid: [%.2f, %.2f]m)", 
                         msg->range, msg->min_range, msg->max_range);
            }
        }
    }

    // 获取当前高度（集成激光测距、GPS相对高度和本地高度）
    double getCurrentHeight() const {
        // 检查激光测距数据是否可用和新鲜
        bool lidar_fresh = lidar_available_ && 
                          (ros::Time::now() - last_lidar_time_).toSec() < lidar_timeout_;
        
        // 根据配置的高度数据源优先级选择高度数据
        switch (height_source_priority_) {
            case 0: // 仅GPS相对高度
                if (rel_alt_available_) {
                    return rel_alt_;
                }
                return odom_z; // 备用本地高度
                
            case 1: // 仅激光测距
                if (lidar_fresh && lidar_height_ > 0.1) {  // 最小有效距离检查
                    return lidar_height_;
                }
                return rel_alt_available_ ? rel_alt_ : odom_z; // 备用高度
                
            case 2: // 激光测距+GPS融合
                if (lidar_fresh && rel_alt_available_) {
                    // 加权融合：激光测距权重更高
                    return lidar_fusion_weight_ * lidar_height_ + 
                           (1.0 - lidar_fusion_weight_) * rel_alt_;
                } else if (lidar_fresh) {
                    return lidar_height_;
                } else if (rel_alt_available_) {
                    return rel_alt_;
                }
                return odom_z;
                
            case 3: // 激光测距优先，GPS备用
            default:
                if (lidar_fresh && lidar_height_ > 0.1) {
                    return lidar_height_;
                } else if (rel_alt_available_) {
                    return rel_alt_;
                }
                return odom_z;
        }
    }
    
    // 获取高度数据源信息
    std::string getHeightSourceInfo() const {
        bool lidar_fresh = lidar_available_ && 
                          (ros::Time::now() - last_lidar_time_).toSec() < lidar_timeout_;
        
        std::string source_names[] = {"GPS_ONLY", "LIDAR_ONLY", "LIDAR_GPS_FUSION", "LIDAR_PRIORITY"};
        std::string source_name = (height_source_priority_ >= 0 && height_source_priority_ <= 3) ? 
                                 source_names[height_source_priority_] : "UNKNOWN";
        
        return source_name + " (Lidar:" + (lidar_fresh ? "OK" : "FAIL") + 
               ", GPS:" + (rel_alt_available_ ? "OK" : "FAIL") + ")";
    }

    void arucoCenterCallback(const spirecv_msgs::TargetsInFrame::ConstPtr& msg) {
        // 添加调试信息 - 确认回调函数被调用
        ROS_INFO("=== ArUco Callback Triggered ===");
        ROS_INFO("Message received with %zu targets", msg->targets.size());
        
        // 清空上一帧的索引记录
        id_19_indices_.clear();
        id_43_indices_.clear();
        first_19_idx = -1;
        first_43_idx = -1;
        
        if(!msg->targets.empty()){
            size_t target_count = msg->targets.size();
            ROS_INFO("Processing %zu targets", target_count);
            
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
                    
                    // 添加详细的ID调试信息
                    ROS_INFO("Target %zu: ID=%d, cx=%.3f, cy=%.3f, yaw=%.1f", 
                             i, aruco_center_id_[i], aruco_center_x_[i], aruco_center_y_[i], aruco_yaw_[i]);
                    
                    // 记录特定ID的位置索引
                    if(aruco_center_id_[i] == 19) {
                        id_19_indices_.push_back(i);
                        ROS_INFO("*** Found ID 19 at index %zu ***", i);
                    } else if(aruco_center_id_[i] == 43) {
                        id_43_indices_.push_back(i);
                        ROS_INFO("*** Found ID 43 at index %zu: cx=%.3f, cy=%.3f ***", 
                                 i, aruco_center_x_[i], aruco_center_y_[i]);
                    }
                }
                
                is_aruco_detected_ = true;
                last_update_time_ = ros::Time::now();
                
                // 检查当前帧中是否存在特定ID
                current_has_19 = !id_19_indices_.empty();
                current_has_43 = !id_43_indices_.empty();
                
                ROS_INFO("Detection summary: has_19=%d, has_43=%d, total_targets=%zu", 
                         current_has_19, current_has_43, target_count);
                
                if(current_has_19) {
                    first_19_idx = id_19_indices_[0];
                    ROS_INFO("Using ID 19 at index %d", first_19_idx);
                }
                if(current_has_43) {
                    first_43_idx = id_43_indices_[0];
                    ROS_INFO("Using ID 43 at index %d", first_43_idx);
                }
                
                // 更新上一时刻的状态
                last_had_19 = current_has_19;
                last_had_43 = current_has_43;
            }
        }else{
            ROS_INFO("No targets detected in this frame");
            is_aruco_detected_ = false;
            aruco_center_x_.clear();
            aruco_center_y_.clear();
            aruco_center_id_.clear();
            aruco_yaw_.clear();
            last_had_19 = false;
            last_had_43 = false;
        }
        
        ROS_INFO("=== ArUco Callback End: detected=%s ===", is_aruco_detected_ ? "YES" : "NO");
    }

    void arucotriggerCallback(const std_msgs::Bool::ConstPtr & msg){
        is_trigger_manual_ = msg->data;
        updateCombinedTrigger();
        ROS_INFO("Aruco landing trigger(manual): %s, gate=%s, hangar=%s -> combined=%s",
                 is_trigger_manual_ ? "ON" : "OFF",
                 enable_hangar_trigger_ ? "ON" : "OFF",
                 (last_hangar_state_ == hangar_ready_value_) ? "READY" : "NOT_READY",
                 is_trigger_ ? "ON" : "OFF");
    }

    void hangarStateCallback(const std_msgs::UInt8::ConstPtr& msg) {
        last_hangar_state_ = static_cast<int>(msg->data);
        updateCombinedTrigger();
        ROS_INFO_THROTTLE(1.0, "Hangar state=%d, expected=%d, gate=%s, combined_trigger=%s",
                          last_hangar_state_, hangar_ready_value_,
                          enable_hangar_trigger_ ? "ON" : "OFF",
                          is_trigger_ ? "ON" : "OFF");
    }

    void updateCombinedTrigger() {
        if (!enable_hangar_trigger_) {
            is_trigger_ = is_trigger_manual_;
            return;
        }
        const bool hangar_ready = (last_hangar_state_ == hangar_ready_value_);
        is_trigger_ = is_trigger_manual_ && hangar_ready;
    }
    
    void mavrosStateCallback(const mavros_msgs::State::ConstPtr& msg) {
        mavros_state_ = *msg;
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
        double current_height = getCurrentHeight();
        double output_z = -(p_z*current_height > 0.3 ? 0.3 : p_z*current_height);
        
        // 限制输出范围
        output_x = std::clamp(output_x, -0.3, 0.3);
        output_y = std::clamp(output_y, -0.3, 0.3);
        
        // 计算偏航角速率并发布MAVROS速度控制命令
        float target_yaw = is_aruco_detected_ ? aruco_yaw_[id]/180*M_PI : 0.0;
        float yaw_rate = calculateYawRate(target_yaw, dt);
        send_velocity_setpoint(output_x, output_y, output_z, yaw_rate);
    }
    
    void controlLoop(const ros::TimerEvent& event) {
        // 系统关闭模式
        if(!system_flag){
            send_hover_command();
            return;
        }
        
        // 未触发降落模式 - 持续发送悬停指令确保OFFBOARD模式稳定
        if(!is_trigger_){ 
            send_hover_command();
            return; 
        }
        
        // 关键修复：确保OFFBOARD模式设置和维持
        // 定期检查模式状态，避免频繁调用服务
        static ros::Time last_offboard_check = ros::Time(0);
        if ((ros::Time::now() - last_offboard_check).toSec() > offboard_check_interval_) {
            ensure_offboard_mode();
            last_offboard_check = ros::Time::now();
        }
        
        // 增强的状态监控和调试信息
        static ros::Time last_status_print = ros::Time(0);
        bool should_print_status = (ros::Time::now() - last_status_print).toSec() > status_print_interval_;
        
        if (should_print_status) {
            double current_height = getCurrentHeight();
            ROS_INFO("==== ArUco Landing Status ====");
            ROS_INFO("MAVROS: mode=%s, armed=%s, connected=%s", 
                     mavros_state_.mode.c_str(), 
                     mavros_state_.armed ? "YES" : "NO",
                     mavros_state_.connected ? "YES" : "NO");
            ROS_INFO("Height: %.2fm [%s], Position: [%.2f, %.2f, %.2f]", 
                     current_height, getHeightSourceInfo().c_str(), odom_x, odom_y, odom_z);
            ROS_INFO("Height sources: GPS=%.2fm, Lidar=%.2fm, Local=%.2fm", 
                     rel_alt_, lidar_height_, odom_z);
            ROS_INFO("ArUco: detected=%s, has_19=%d, has_43=%d, trigger=%d, buffer_active=%s", 
                     is_aruco_detected_ ? "YES" : "NO", current_has_19, current_has_43, is_trigger_,
                     aruco_lost_buffer_active_ ? "YES" : "NO");
            ROS_INFO("Thresholds: ROUGH_LAND=%.1fm, FINE_LAND=%.1fm", 
                     HEIGHT_ROUGH_LAND, HEIGHT_FINE_LAND);
            last_status_print = ros::Time::now();
        }
        
        // 改进的二维码检测丢失处理机制
        bool should_continue_landing = false;
        
        // 检查二维码数据是否过期
        if (is_aruco_detected_ && (ros::Time::now() - last_update_time_).toSec() > DATA_TIMEOUT) {
            is_aruco_detected_ = false;
            last_aruco_lost_time_ = ros::Time::now();
            aruco_lost_buffer_active_ = true;
            ROS_WARN("ArUco data timeout! Entering buffer mode for %.1fs", ARUCO_LOST_BUFFER_TIME);
        }
        
        // 如果检测到二维码，清除缓冲状态
        if (is_aruco_detected_) {
            aruco_lost_buffer_active_ = false;
            should_continue_landing = true;
        }
        // 如果在缓冲时间内，继续执行降落控制
        else if (aruco_lost_buffer_active_) {
            double lost_duration = (ros::Time::now() - last_aruco_lost_time_).toSec();
            if (lost_duration < ARUCO_LOST_BUFFER_TIME) {
                should_continue_landing = true;
                ROS_INFO("ArUco lost but within buffer time (%.1fs/%.1fs), continuing landing control", 
                         lost_duration, ARUCO_LOST_BUFFER_TIME);
            } else {
                aruco_lost_buffer_active_ = false;
                ROS_WARN("ArUco lost buffer timeout! Switching to hover mode");
                pid_x_.reset();
                pid_y_.reset();
            }
        }
        
        // 计算时间步长
        double dt = (event.current_real - event.last_real).toSec();
        if (dt <= 0) dt = 0.05; // 默认50ms
        
        // 执行降落控制或悬停
        if (should_continue_landing) {
            // 更新降落模式（只在有实际检测时更新）
            if (is_aruco_detected_) {
                updateLandingMode();
            }
            
            ROS_INFO("================= current_mode_ ================= %d", static_cast<int>(current_mode_));
            
            // 根据当前模式执行相应的控制逻辑
            executeModeControl(dt);
        } else {
            // 没有检测到二维码且超出缓冲时间，发送悬停指令
            ROS_INFO("Waiting for ArUco detection, sending hover command");
            send_hover_command();
        }
    }

private:
    // 加载参数
    void loadParams() {
        // 基础PID参数
        nh_.param("/mission_aruco_land_node/p_gain_x", p_gain_x, 0.5);
        nh_.param("/mission_aruco_land_node/i_gain_x", i_gain_x, 0.01);
        nh_.param("/mission_aruco_land_node/d_gain_x", d_gain_x, 0.1);
        nh_.param("/mission_aruco_land_node/p_gain_y", p_gain_y, 0.5);
        nh_.param("/mission_aruco_land_node/i_gain_y", i_gain_y, 0.01);
        nh_.param("/mission_aruco_land_node/d_gain_y", d_gain_y, 0.1);
        nh_.param("/mission_aruco_land_node/p_gain_z", p_z, 0.3);
        
        // 控制系统参数
        nh_.param("/mission_aruco_land_node/control_frequency", control_frequency_, 20.0);
        nh_.param("/mission_aruco_land_node/data_timeout", DATA_TIMEOUT, 0.5);
        nh_.param("/mission_aruco_land_node/aruco_lost_buffer_time", ARUCO_LOST_BUFFER_TIME, 2.0);
        
        // 高度阈值参数
        nh_.param("/mission_aruco_land_node/height_rough_land", HEIGHT_ROUGH_LAND, 1.0);
        nh_.param("/mission_aruco_land_node/height_fine_land", HEIGHT_FINE_LAND, 0.5);
        
        // 粗降落模式参数
        nh_.param("/mission_aruco_land_node/rough_land/max_vel_high", rough_land_params_.max_vel_high, 0.4);
        nh_.param("/mission_aruco_land_node/rough_land/max_vel_medium", rough_land_params_.max_vel_medium, 0.3);
        nh_.param("/mission_aruco_land_node/rough_land/max_vel_low", rough_land_params_.max_vel_low, 0.2);
        nh_.param("/mission_aruco_land_node/rough_land/z_vel_high", rough_land_params_.z_vel_high, -0.6);
        nh_.param("/mission_aruco_land_node/rough_land/z_vel_medium", rough_land_params_.z_vel_medium, -0.4);
        nh_.param("/mission_aruco_land_node/rough_land/z_vel_approach", rough_land_params_.z_vel_approach, -0.2);
        nh_.param("/mission_aruco_land_node/rough_land/z_vel_transition", rough_land_params_.z_vel_transition, -0.1);
        
        // 精降落模式参数
        nh_.param("/mission_aruco_land_node/fine_land/max_vel_upper", fine_land_params_.max_vel_upper, 0.25);
        nh_.param("/mission_aruco_land_node/fine_land/max_vel_middle", fine_land_params_.max_vel_middle, 0.2);
        nh_.param("/mission_aruco_land_node/fine_land/max_vel_lower", fine_land_params_.max_vel_lower, 0.15);
        nh_.param("/mission_aruco_land_node/fine_land/z_vel_upper", fine_land_params_.z_vel_upper, -0.25);
        nh_.param("/mission_aruco_land_node/fine_land/z_vel_middle", fine_land_params_.z_vel_middle, -0.2);
        nh_.param("/mission_aruco_land_node/fine_land/z_vel_lower", fine_land_params_.z_vel_lower, -0.15);
        nh_.param("/mission_aruco_land_node/fine_land/z_vel_final", fine_land_params_.z_vel_final, -0.1);
        
        // 自适应PID参数 - 高度因子
        nh_.param("/mission_aruco_land_node/adaptive_pid/height_factors/very_high", height_factors_.very_high, 1.3);
        nh_.param("/mission_aruco_land_node/adaptive_pid/height_factors/high", height_factors_.high, 1.1);
        nh_.param("/mission_aruco_land_node/adaptive_pid/height_factors/medium", height_factors_.medium, 0.9);
        nh_.param("/mission_aruco_land_node/adaptive_pid/height_factors/low", height_factors_.low, 0.7);
        
        // 自适应PID参数 - 误差因子
        //nh_.param("/mission_aruco_land_node/adaptive_pid/error_factors/large", error_factors_.large, 1.4);
        //nh_.param("/mission_aruco_land_node/adaptive_pid/error_factors/medium", error_factors_.medium, 1.2);
        //nh_.param("/mission_aruco_land_node/adaptive_pid/error_factors/small", error_factors_.small, 1.0);
        //nh_.param("/mission_aruco_land_node/adaptive_pid/error_factors/tiny", error_factors_.tiny, 0.8);
        
        // 自适应PID参数 - 模式因子
        nh_.param("/mission_aruco_land_node/adaptive_pid/mode_factors/rough_land", mode_factors_.rough_land, 1.2);
        nh_.param("/mission_aruco_land_node/adaptive_pid/mode_factors/fine_land", mode_factors_.fine_land, 0.9);
        nh_.param("/mission_aruco_land_node/adaptive_pid/mode_factors/default", mode_factors_.default_mode, 1.0);
        
        // 自适应PID参数 - 限制范围
        nh_.param("/mission_aruco_land_node/adaptive_pid/limits/kp_min", adaptive_limits_.kp_min, 0.3);
        nh_.param("/mission_aruco_land_node/adaptive_pid/limits/kp_max", adaptive_limits_.kp_max, 2.5);
        nh_.param("/mission_aruco_land_node/adaptive_pid/limits/ki_min", adaptive_limits_.ki_min, 0.5);
        nh_.param("/mission_aruco_land_node/adaptive_pid/limits/ki_max", adaptive_limits_.ki_max, 1.5);
        nh_.param("/mission_aruco_land_node/adaptive_pid/limits/kd_min", adaptive_limits_.kd_min, 0.7);
        nh_.param("/mission_aruco_land_node/adaptive_pid/limits/kd_max", adaptive_limits_.kd_max, 1.8);
        
        // 偏航控制参数
        nh_.param("/mission_aruco_land_node/yaw_control/max_yaw_rate", max_yaw_rate_, 1.0);
        
        // 安全参数
        nh_.param("/mission_aruco_land_node/safety/offboard_check_interval", offboard_check_interval_, 1.0);
        nh_.param("/mission_aruco_land_node/safety/status_print_interval", status_print_interval_, 2.0);
        nh_.param("/mission_aruco_land_node/safety/param_print_interval", param_print_interval_, 3.0);
        nh_.param("/mission_aruco_land_node/safety/height_print_interval", height_print_interval_, 5.0);
        
        // 激光测距参数
        nh_.param("/mission_aruco_land_node/height_source_priority", height_source_priority_, 3);
        nh_.param("/mission_aruco_land_node/lidar/enable", lidar_enable_, true);
        nh_.param("/mission_aruco_land_node/lidar/topic_name", lidar_topic_, 
                  std::string("/uav1/mavros/distance_sensor/hrlv_ez4_pub"));
        nh_.param("/mission_aruco_land_node/lidar/timeout", lidar_timeout_, 1.0);
        nh_.param("/mission_aruco_land_node/lidar/noise_threshold", lidar_noise_threshold_, 0.1);
        nh_.param("/mission_aruco_land_node/lidar/fusion_weight", lidar_fusion_weight_, 0.8);
        
        // 调试参数
        nh_.param("/mission_aruco_land_node/debug/enable_coordinate_transform_test", enable_coordinate_transform_test_, true);
        nh_.param("/mission_aruco_land_node/debug/enable_aruco_detection_debug", enable_aruco_detection_debug_, true);
        nh_.param("/mission_aruco_land_node/debug/enable_pid_debug", enable_pid_debug_, true);
        nh_.param("/mission_aruco_land_node/debug/enable_mode_debug", enable_mode_debug_, true);
        nh_.param("/mission_aruco_land_node/debug/enable_lidar_debug", enable_lidar_debug_, true);
        
        ROS_INFO("ArUco Landing Parameters Loaded:");
        ROS_INFO("  Control frequency: %.1f Hz", control_frequency_);
        ROS_INFO("  Data timeout: %.1f s", DATA_TIMEOUT);
        ROS_INFO("  Buffer time: %.1f s", ARUCO_LOST_BUFFER_TIME);
        ROS_INFO("  Height thresholds: rough=%.1f m, fine=%.1f m", HEIGHT_ROUGH_LAND, HEIGHT_FINE_LAND);
        ROS_INFO("  Height source priority: %d", height_source_priority_);
        ROS_INFO("  Lidar enabled: %s, topic: %s", lidar_enable_ ? "YES" : "NO", lidar_topic_.c_str());
        ROS_INFO("  Max yaw rate: %.1f rad/s", max_yaw_rate_);
    }
    
    // 坐标系转换验证函数
    void verifyCoordinateTransform() {
        ROS_INFO("=== 坐标系转换验证指南 ===");
        ROS_INFO("测试方法：");
        ROS_INFO("1. 手动控制ArUco标记在图像中的位置变化");
        ROS_INFO("2. 观察无人机的响应方向");
        ROS_INFO("预期行为：");
        ROS_INFO("- ArUco在图像右侧(cx>0.5) -> 无人机向东移动(+Y_NED)");
        ROS_INFO("- ArUco在图像左侧(cx<0.5) -> 无人机向西移动(-Y_NED)");  
        ROS_INFO("- ArUco在图像下方(cy>0.5) -> 无人机向北移动(+X_NED)");
        ROS_INFO("- ArUco在图像上方(cy<0.5) -> 无人机向南移动(-X_NED)");
        ROS_INFO("当前转换公式：");
        ROS_INFO("- NED_X = camera_vel_y (图像Y误差 -> 北向速度)");
        ROS_INFO("- NED_Y = camera_vel_x (图像X误差 -> 东向速度)");
        ROS_INFO("- NED_Z = -camera_vel_z (向下为正)");
    }
    
    // 自适应PID参数调整函数
    struct AdaptivePIDParams {
        double kp_x, ki_x, kd_x;
        double kp_y, ki_y, kd_y;
    };
    
    AdaptivePIDParams calculateAdaptivePID(double height, double error_magnitude, LandingMode mode) {
        AdaptivePIDParams params;
        
        // 基础参数
        double base_kp_x = p_gain_x;
        double base_ki_x = i_gain_x;
        double base_kd_x = d_gain_x;
        double base_kp_y = p_gain_y;
        double base_ki_y = i_gain_y;
        double base_kd_y = d_gain_y;
        
        // 1. 高度自适应系数 (高度越低，参数越保守)
        double height_factor;
        if (height > 2.0) {
            height_factor = height_factors_.very_high;      // 高空：更激进
        } else if (height > 1.0) {
            height_factor = height_factors_.high;           // 中空：稍激进
        } else if (height > 0.5) {
            height_factor = height_factors_.medium;         // 低空：保守
        } else {
            height_factor = height_factors_.low;            // 极低空：非常保守
        }
        
        // 2. 误差自适应系数 (误差越大，比例增益适当增加)
        double error_factor;
        if (error_magnitude > 0.3) {
            //error_factor = error_factors_.large;       // 大误差：强响应
            error_factor = 1.4;
        } else if (error_magnitude > 0.15) {
            //error_factor = error_factors_.medium;      // 中误差：适中响应
            error_factor = 1.2;
        } else if (error_magnitude > 0.05) {
            //error_factor = error_factors_.small;       // 小误差：标准响应
            error_factor = 1.0;
        } else {
            //error_factor = error_factors_.tiny;        // 极小误差：柔和响应
            error_factor = 0.8;
        }
        
        // 3. 模式自适应系数
        double mode_factor;
        switch(mode) {
            case LandingMode::ROUGH_LAND:
                mode_factor = mode_factors_.rough_land;    // 粗降落：较激进
                break;
            case LandingMode::FINE_LAND:
                mode_factor = mode_factors_.fine_land;     // 精降落：保守
                break;
            default:
                mode_factor = mode_factors_.default_mode;  // 其他模式：标准
                break;
        }
        
        // 综合调整系数 (限制调整范围，避免过度调整)
        double kp_factor = std::clamp(height_factor * error_factor * mode_factor, adaptive_limits_.kp_min, adaptive_limits_.kp_max);
        double ki_factor = std::clamp(height_factor * 0.8, adaptive_limits_.ki_min, adaptive_limits_.ki_max);  // 积分项调整更保守
        double kd_factor = std::clamp(height_factor * 1.1, adaptive_limits_.kd_min, adaptive_limits_.kd_max);  // 微分项适中调整
        
        // 计算最终参数
        params.kp_x = base_kp_x * kp_factor;
        params.ki_x = base_ki_x * ki_factor;
        params.kd_x = base_kd_x * kd_factor;
        params.kp_y = base_kp_y * kp_factor;
        params.ki_y = base_ki_y * ki_factor;
        params.kd_y = base_kd_y * kd_factor;
        
        // 调试输出
        static ros::Time last_param_print = ros::Time(0);
        if (enable_pid_debug_ && (ros::Time::now() - last_param_print).toSec() > param_print_interval_) {
            ROS_INFO("Adaptive PID: height=%.2f, error_mag=%.3f, mode=%d", height, error_magnitude, static_cast<int>(mode));
            ROS_INFO("Factors: height=%.2f, error=%.2f, mode=%.2f -> kp=%.2f, ki=%.2f, kd=%.2f", 
                     height_factor, error_factor, mode_factor, kp_factor, ki_factor, kd_factor);
            ROS_INFO("Final PID_X: Kp=%.3f, Ki=%.4f, Kd=%.3f", params.kp_x, params.ki_x, params.kd_x);
            last_param_print = ros::Time::now();
        }
        
        return params;
    }
    
    // 测试坐标系转换的辅助函数
    void testCoordinateTransform(double test_cx, double test_cy) {
        ROS_INFO("=== 坐标系转换测试 ===");
        ROS_INFO("输入：ArUco图像坐标 (%.3f, %.3f)", test_cx, test_cy);
        
        // 计算误差
        double error_x = -(test_cx - 0.5);
        double error_y = -(test_cy - 0.5);
        ROS_INFO("图像误差：error_x=%.3f, error_y=%.3f", error_x, error_y);
        
        // 模拟PID输出 (简化为比例控制)
        double vel_x = p_gain_x * error_x;
        double vel_y = p_gain_y * error_y;
        ROS_INFO("相机坐标系速度：vel_x=%.3f, vel_y=%.3f", vel_x, vel_y);
        
        // 坐标系转换
        double ned_x = vel_y;
        double ned_y = vel_x;
        ROS_INFO("NED坐标系速度：ned_x=%.3f, ned_y=%.3f", ned_x, ned_y);
        
        // 运动方向分析
        std::string direction_x = (ned_x > 0) ? "北" : (ned_x < 0) ? "南" : "无";
        std::string direction_y = (ned_y > 0) ? "东" : (ned_y < 0) ? "西" : "无";
        ROS_INFO("预期无人机运动方向：%s%s", direction_x.c_str(), direction_y.c_str());
        
        // 验证逻辑
        if (test_cx > 0.5 && ned_y > 0) {
            ROS_INFO("✓ 正确：ArUco在右侧，无人机向东移动");
        } else if (test_cx < 0.5 && ned_y < 0) {
            ROS_INFO("✓ 正确：ArUco在左侧，无人机向西移动");
        } else if (test_cy > 0.5 && ned_x > 0) {
            ROS_INFO("✓ 正确：ArUco在下方，无人机向北移动");
        } else if (test_cy < 0.5 && ned_x < 0) {
            ROS_INFO("✓ 正确：ArUco在上方，无人机向南移动");
        } else {
            ROS_WARN("⚠ 需要验证：运动方向可能不正确");
        }
    }
    
    // 更新降落模式
    void updateLandingMode() {
        double current_height = getCurrentHeight();
        
        // 按用户要求的模式切换逻辑：
        // 0.8m以上 -> ID19粗降落模式
        // 0.5m-0.8m -> ID43精降落模式  
        // 0.5m以下 -> AUTO.LAND模式
        
        if(current_height > HEIGHT_ROUGH_LAND) {
            // 高度 > 0.8m：优先使用ID19进行粗降落
            if(current_has_19) {
                current_mode_ = LandingMode::ROUGH_LAND;
                ROS_INFO("Mode: ROUGH_LAND (ID19) - height %.2fm > %.1fm", current_height, HEIGHT_ROUGH_LAND);
            }
            // 如果没有ID19但有ID43，也可以进行粗降落
            else if(current_has_43) {
                current_mode_ = LandingMode::ROUGH_LAND;
                ROS_INFO("Mode: ROUGH_LAND (ID43 fallback) - height %.2fm > %.1fm, no ID19 available", 
                         current_height, HEIGHT_ROUGH_LAND);
            }
            else {
                current_mode_ = LandingMode::HOVER;
                ROS_INFO("Mode: HOVER - height %.2fm > %.1fm, but no ArUco markers detected", 
                         current_height, HEIGHT_ROUGH_LAND);
                send_hover_command();
            }
        } 
        else if(current_height > HEIGHT_FINE_LAND && current_height <= HEIGHT_ROUGH_LAND) {
            // 0.5m < 高度 <= 0.8m：使用ID43进行精降落
            if(current_has_43) {
                current_mode_ = LandingMode::FINE_LAND;
                ROS_INFO("Mode: FINE_LAND (ID43) - %.1fm < height %.2fm <= %.1fm", 
                         HEIGHT_FINE_LAND, current_height, HEIGHT_ROUGH_LAND);
            }
            else {
                current_mode_ = LandingMode::HOVER;
                ROS_INFO("Mode: HOVER - %.1fm < height %.2fm <= %.1fm, but no ID43 detected", 
                         HEIGHT_FINE_LAND, current_height, HEIGHT_ROUGH_LAND);
                send_hover_command();
            }
        }
        else {
            // 高度 <= 0.5m：切换到PX4 AUTO.LAND模式
            current_mode_ = LandingMode::PX4_LAND;
            ROS_INFO("Mode: PX4_LAND - height %.2fm <= %.1fm, activating AUTO.LAND", 
                     current_height, HEIGHT_FINE_LAND);
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
                send_hover_command();
                break;
        }
    }
    
    // 执行粗降落模式
    void executeRoughLandMode(double dt) {
        // 优先使用ID19，如果没有则使用ID43
        int target_idx = -1;
        std::string target_id;
        
        if (first_19_idx >= 0) {
            target_idx = first_19_idx;
            target_id = "ID 19";
        } else if (first_43_idx >= 0) {
            target_idx = first_43_idx;
            target_id = "ID 43";
        } else {
            ROS_WARN("No suitable marker found for rough landing!");
            send_hover_command();
            return;
        }
        
        double current_height = getCurrentHeight();
        
        // 计算误差
        double error_x = -(aruco_center_x_[target_idx] - 0.5);
        double error_y = -(aruco_center_y_[target_idx] - 0.5);
        double error_magnitude = sqrt(error_x*error_x + error_y*error_y);
        
        // 自适应PID参数计算
        AdaptivePIDParams adaptive_params = calculateAdaptivePID(current_height, error_magnitude, LandingMode::ROUGH_LAND);
        
        // 设置自适应PID参数
        pid_x_.setGains(adaptive_params.kp_x, adaptive_params.ki_x, adaptive_params.kd_x);
        pid_y_.setGains(adaptive_params.kp_y, adaptive_params.ki_y, adaptive_params.kd_y);
        
        double output_x = pid_x_.compute(error_x, dt);
        double output_y = pid_y_.compute(error_y, dt);
        
        // 粗降落模式Z轴控制逻辑（针对0.8m以上高度）
        double output_z;
        if (current_height > 2.0) {
            // 高空快速下降
            output_z = rough_land_params_.z_vel_high;  
        } else if (current_height > 1.2) {
            // 中等高度适中下降
            output_z = rough_land_params_.z_vel_medium;
        } else if (current_height > 0.8) {
            // 接近精降落阈值时减速
            output_z = rough_land_params_.z_vel_approach;
        } else {
            // 已经进入精降落范围，极慢下降
            output_z = rough_land_params_.z_vel_transition;
        }
        
        // 自适应输出限制（根据高度调整最大速度）
        double max_vel = (current_height > 1.5) ? rough_land_params_.max_vel_high : 
                        (current_height > 0.8) ? rough_land_params_.max_vel_medium : 
                        rough_land_params_.max_vel_low;
        output_x = std::clamp(output_x, -max_vel, max_vel);
        output_y = std::clamp(output_y, -max_vel, max_vel);
        
        // 计算偏航角速率并发布所有控制量
        float target_yaw = is_aruco_detected_ ? aruco_yaw_[target_idx]/180*M_PI : 0.0;
        float yaw_rate = calculateYawRate(target_yaw, dt);
        send_velocity_setpoint(output_x, output_y, output_z, yaw_rate);
        
        ROS_INFO("Rough landing using %s: height=%.2fm, error_mag=%.3f, max_vel=%.1f, x=%.2f, y=%.2f, z=%.2f, yaw_rate=%.2f", 
                 target_id.c_str(), current_height, error_magnitude, max_vel, output_x, output_y, output_z, yaw_rate);
    }
    
    // 执行精降落模式
    void executeFineLandMode(double dt) {
        if (first_43_idx < 0) {
            ROS_WARN("No ID 43 marker found for fine landing!");
            send_hover_command();
            return;
        }
        
        double current_height = getCurrentHeight();
        
        // 计算误差
        double error_x = -(aruco_center_x_[first_43_idx] - 0.5); 
        double error_y = -(aruco_center_y_[first_43_idx] - 0.5);
        double error_magnitude = sqrt(error_x*error_x + error_y*error_y);
        
        // 自适应PID参数计算
        AdaptivePIDParams adaptive_params = calculateAdaptivePID(current_height, error_magnitude, LandingMode::FINE_LAND);
        
        // 设置自适应PID参数
        pid_x_.setGains(adaptive_params.kp_x, adaptive_params.ki_x, adaptive_params.kd_x);
        pid_y_.setGains(adaptive_params.kp_y, adaptive_params.ki_y, adaptive_params.kd_y);
        
        double output_x = pid_x_.compute(error_x, dt);
        double output_y = pid_y_.compute(error_y, dt);
        
        // 精降落模式Z轴控制逻辑（针对0.5-0.8m范围）
        double output_z;
        if (current_height > 0.7) {
            output_z = fine_land_params_.z_vel_upper;  // 精降落上段，适中下降
        } else if (current_height > 0.6) {
            output_z = fine_land_params_.z_vel_middle;   // 精降落中段，稍慢下降
        } else if (current_height > 0.5) {
            output_z = fine_land_params_.z_vel_lower;  // 接近AUTO.LAND阈值，慢速下降
        } else {
            output_z = fine_land_params_.z_vel_final;   // 保险起见，极慢下降
        }
        
        // 精降落模式的自适应输出限制（更保守）
        double max_vel = (current_height > 0.7) ? fine_land_params_.max_vel_upper : 
                        (current_height > 0.6) ? fine_land_params_.max_vel_middle : 
                        fine_land_params_.max_vel_lower;
        output_x = std::clamp(output_x, -max_vel, max_vel);
        output_y = std::clamp(output_y, -max_vel, max_vel);
        
        // 计算偏航角速率并发布MAVROS速度控制命令
        float target_yaw = is_aruco_detected_ ? aruco_yaw_[first_43_idx]/180*M_PI : 0.0;
        float yaw_rate = calculateYawRate(target_yaw, dt);
        send_velocity_setpoint(output_x, output_y, output_z, yaw_rate);
        
        ROS_INFO("Fine landing mode: height=%.2fm, error_mag=%.3f, max_vel=%.2f, PID[%.3f,%.4f,%.3f], x=%.2f, y=%.2f, z=%.2f, yaw_rate=%.2f", 
                 current_height, error_magnitude, max_vel, adaptive_params.kp_x, adaptive_params.ki_x, adaptive_params.kd_x,
                 output_x, output_y, output_z, yaw_rate);
    }
    
    // 执行PX4降落模式
    void executePx4LandMode() {
        ROS_INFO("PX4 land mode activated");
        send_land_command();
        system_flag = false;
    }
    
    // 计算偏航角速率的辅助函数
    float calculateYawRate(float target_yaw, double dt) {
        ros::Time current_time = ros::Time::now();
        
        if (!yaw_initialized_) {
            // 第一次调用，初始化
            last_target_yaw_ = target_yaw;
            last_yaw_time_ = current_time;
            yaw_initialized_ = true;
            return 0.0f; // 第一次不产生偏航角速率
        }
        
        // 计算偏航角差值，处理角度环绕问题
        float yaw_error = target_yaw - last_target_yaw_;
        
        // 处理角度环绕（-π到π）
        while (yaw_error > M_PI) yaw_error -= 2 * M_PI;
        while (yaw_error < -M_PI) yaw_error += 2 * M_PI;
        
        // 计算时间差
        double time_diff = std::max((current_time - last_yaw_time_).toSec(), dt);
        
        // 计算偏航角速率，并限制在合理范围内
        float yaw_rate = yaw_error / time_diff;
        yaw_rate = std::clamp(yaw_rate, -(float)max_yaw_rate_, (float)max_yaw_rate_); // 使用可配置的偏航角速率限制
        
        // 更新历史值
        last_target_yaw_ = target_yaw;
        last_yaw_time_ = current_time;
        
        return yaw_rate;
    }

    // 修改后的发布函数，直接发送mavros消息（使用偏航角速率控制）
    void send_velocity_setpoint(double vel_x, double vel_y, double vel_z, float yaw_rate) {
        mavros_msgs::PositionTarget pos_setpoint;
        
        // 添加时间戳 - 关键修复！
        pos_setpoint.header.stamp = ros::Time::now();
        pos_setpoint.header.frame_id = "base_link";
        
        pos_setpoint.coordinate_frame = mavros_msgs::PositionTarget::FRAME_LOCAL_NED;
        
        // 设置type_mask为速度+偏航角速率控制模式
        pos_setpoint.type_mask = mavros_msgs::PositionTarget::IGNORE_PX |
                                mavros_msgs::PositionTarget::IGNORE_PY |
                                mavros_msgs::PositionTarget::IGNORE_PZ |
                                mavros_msgs::PositionTarget::IGNORE_AFX |
                                mavros_msgs::PositionTarget::IGNORE_AFY |
                                mavros_msgs::PositionTarget::IGNORE_AFZ |
                                mavros_msgs::PositionTarget::IGNORE_YAW;
        
        // 坐标系转换：相机坐标 -> NED坐标系
        // 相机坐标：右x正，下y正 -> NED坐标：北x正，东y正，下z正
        pos_setpoint.velocity.x = vel_y;   // 相机Y轴对应NED的X轴（向前）
        pos_setpoint.velocity.y = vel_x;   // 相机X轴对应NED的Y轴（向右）
        pos_setpoint.velocity.z = vel_z;   // 直接发送：负值向下降落，正值向上
        pos_setpoint.yaw_rate = yaw_rate;
        
        mavros_setpoint_pub.publish(pos_setpoint);
        
        ROS_INFO("MAVROS velocity: camera[%.2f,%.2f,%.2f] -> NED[%.2f,%.2f,%.2f], yaw_rate=%.2f", 
                 vel_x, vel_y, vel_z, pos_setpoint.velocity.x, pos_setpoint.velocity.y, pos_setpoint.velocity.z, yaw_rate);
    }
    
    void send_land_command() {
        mavros_msgs::SetMode land_mode;
        land_mode.request.custom_mode = "AUTO.LAND";
        
        if (set_mode_client.call(land_mode) && land_mode.response.mode_sent) {
            ROS_INFO("PX4 LAND mode activated via MAVROS");
        } else {
            ROS_ERROR("Failed to set PX4 LAND mode");
        }
    }
    
    void ensure_offboard_mode() {
        // 只有在需要时才发送模式切换指令，避免频繁调用
        if (mavros_state_.mode != "OFFBOARD") {
            mavros_msgs::SetMode offboard_mode;
            offboard_mode.request.custom_mode = "OFFBOARD";
            
            if (set_mode_client.call(offboard_mode) && offboard_mode.response.mode_sent) {
                ROS_INFO("PX4 OFFBOARD mode activated for aruco landing control (was: %s)", 
                         mavros_state_.mode.c_str());
            } else {
                ROS_ERROR("Failed to set PX4 OFFBOARD mode from %s", mavros_state_.mode.c_str());
            }
        }
    }
    
    void send_hover_command() {
        mavros_msgs::PositionTarget pos_setpoint;
        
        // 添加时间戳 - 关键修复！
        pos_setpoint.header.stamp = ros::Time::now();
        pos_setpoint.header.frame_id = "base_link";
        
        pos_setpoint.coordinate_frame = mavros_msgs::PositionTarget::FRAME_LOCAL_NED;

        // 设置type_mask为悬停模式（速度为0，偏航角速率为0）
        pos_setpoint.type_mask = mavros_msgs::PositionTarget::IGNORE_PX |
                                mavros_msgs::PositionTarget::IGNORE_PY |
                                mavros_msgs::PositionTarget::IGNORE_PZ |
                                mavros_msgs::PositionTarget::IGNORE_AFX |
                                mavros_msgs::PositionTarget::IGNORE_AFY |
                                mavros_msgs::PositionTarget::IGNORE_AFZ |
                                mavros_msgs::PositionTarget::IGNORE_YAW;
        
        pos_setpoint.velocity.x = 0.0;
        pos_setpoint.velocity.y = 0.0;
        pos_setpoint.velocity.z = 0.0;
        pos_setpoint.yaw_rate = 0.0;  // 偏航角速率为0，保持当前朝向
        
        mavros_setpoint_pub.publish(pos_setpoint);
    }

    // 可配置参数 (从YAML文件加载)
    double DATA_TIMEOUT;           // 数据超时时间(秒)
    double ARUCO_LOST_BUFFER_TIME; // ArUco丢失缓冲时间(秒)
    double HEIGHT_ROUGH_LAND;      // 粗降落高度阈值(米)
    double HEIGHT_FINE_LAND;       // 精降落高度阈值(米)
    
    // 控制频率参数
    double control_frequency_;
    
    // 速度限制参数
    struct RoughLandParams {
        double max_vel_high, max_vel_medium, max_vel_low;
        double z_vel_high, z_vel_medium, z_vel_approach, z_vel_transition;
    } rough_land_params_;
    
    struct FineLandParams {
        double max_vel_upper, max_vel_middle, max_vel_lower;
        double z_vel_upper, z_vel_middle, z_vel_lower, z_vel_final;
    } fine_land_params_;
    
    // 自适应PID参数
    struct AdaptiveFactors {
        double very_high, high, medium, low;
    } height_factors_, error_factors_;
    
    struct ModeFactors {
        double rough_land, fine_land, default_mode;
    } mode_factors_;
    
    struct AdaptiveLimits {
        double kp_min, kp_max, ki_min, ki_max, kd_min, kd_max;
    } adaptive_limits_;
    
    // 偏航控制参数
    double max_yaw_rate_;
    
    // 安全和调试参数
    double offboard_check_interval_, status_print_interval_, param_print_interval_, height_print_interval_;
    bool enable_coordinate_transform_test_, enable_aruco_detection_debug_, enable_pid_debug_, enable_mode_debug_;

    // ROS相关成员
    ros::NodeHandle nh_;
    ros::Subscriber pose_sub, aruco_dection_sub, aruco_trigger_sub, mavros_state_sub, rel_alt_sub, lidar_sub, hangar_state_sub_;
    ros::Publisher mavros_setpoint_pub;  // 替换原来的uav_command_pub
    ros::ServiceClient set_mode_client;  // 添加模式设置客户端
    ros::Timer control_timer_;
    mavros_msgs::State mavros_state_;  // 添加MAVROS状态

    // PID控制器实例
    PIDController pid_x_;
    PIDController pid_y_;
    PIDController pid_z_;
    
    // 二维码数据
    std::vector<double> aruco_center_x_, aruco_center_y_, aruco_yaw_;
    std::vector<int> aruco_center_id_, id_19_indices_, id_43_indices_;
    ros::Time last_update_time_;
    
    // 状态变量
    bool is_aruco_detected_ = false,
         is_trigger_ = false,
         is_trigger_manual_ = false,
         last_had_19 = false,
         last_had_43 = false,
         switch_flag = false,
         current_has_19 = false,
         current_has_43 = false,
         system_flag = true;
    LandingMode current_mode_;
    int first_19_idx, first_43_idx;
    
    // 新增：ArUco丢失缓冲机制相关变量
    ros::Time last_aruco_lost_time_;
    bool aruco_lost_buffer_active_;
    
    // PID参数
    double p_gain_x, i_gain_x, d_gain_x, p_gain_y, i_gain_y, d_gain_y, p_z;
    
    // 位置信息
    float odom_x, odom_y, odom_z;
    
    // 相对高度数据（更准确的高度信息）
    double rel_alt_;
    bool rel_alt_available_;
    
    // 激光测距数据
    double lidar_height_;
    bool lidar_available_;
    ros::Time last_lidar_time_;
    
    // 激光测距配置参数
    int height_source_priority_;       // 高度数据源优先级
    bool lidar_enable_;                // 是否启用激光测距
    std::string lidar_topic_;          // 激光测距话题名称
    double lidar_timeout_;             // 激光测距数据超时时间
    double lidar_noise_threshold_;     // 噪声过滤阈值
    double lidar_fusion_weight_;       // 融合权重
    bool enable_lidar_debug_;          // 激光测距调试开关
    
    // 偏航角速率计算相关变量
    double last_target_yaw_;
    ros::Time last_yaw_time_;
    bool yaw_initialized_;

    // Hangar trigger gate
    bool enable_hangar_trigger_ = true;
    int hangar_ready_value_ = 1; // default: 1 means ready
    int last_hangar_state_ = 0;
};

#endif // ARUCO_CONTROLLER_H