#ifndef ARUCO_CONTROLLER_H
#define ARUCO_CONTROLLER_H

#include <ros/ros.h>
#include <uavcontrol_msgs/UAVCommand.h>
#include <vision_msgs/TargetsInFrame.h>
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
    PX4_LAND = 2,
    CORNER_GUIDED_LAND = 3,  // 四角标记引导降落模式
    HYBRID_LAND = 4          // 混合模式（四角+中心标记）
};

// 降落控制策略枚举
enum class LandingStrategy {
    CENTER_MARKERS_ONLY = 0,    // 仅使用中心标记(ID19,43)
    CORNER_MARKERS_ONLY = 1,    // 仅使用四角标记(ID1,2,3,4)
    HYBRID_STRATEGY = 2,        // 混合策略（四角+中心）
    AUTO_ADAPTIVE = 3           // 自动适应性策略
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
                     height_source_priority_(0), lidar_enable_(false), 
                     lidar_timeout_(1.0), lidar_noise_threshold_(0.1), lidar_fusion_weight_(0.8),
                     enable_lidar_debug_(false),
                     last_aruco_lost_time_(0), aruco_lost_buffer_active_(false),
                     last_target_yaw_(0.0), yaw_initialized_(false),
                     // 四角标记相关初始化
                     corner_markers_available_(false), platform_center_x_(0.5), platform_center_y_(0.5),
                     platform_yaw_(0.0), platform_yaw_valid_(false),
                     landing_strategy_(LandingStrategy::AUTO_ADAPTIVE),
                     // 四角标记索引初始化
                     id_1_idx_(-1), id_2_idx_(-1), id_3_idx_(-1), id_4_idx_(-1) {
        
        // 初始化PID控制器参数
        loadParams();
        
        // 直接发布mavros位置控制指令给PX4
        mavros_setpoint_pub = nh_.advertise<mavros_msgs::PositionTarget>("/uav2/mavros/setpoint_raw/local", 10);
        
        // 添加飞行模式设置服务客户端
        set_mode_client = nh_.serviceClient<mavros_msgs::SetMode>("/uav2/mavros/set_mode");
        
        pose_sub = nh_.subscribe<geometry_msgs::PoseStamped>("/uav2/mavros/local_position/pose", 10, &ArucoTracker::pose_cb, this);
        // 添加相对高度订阅，用于更准确的高度数据
        rel_alt_sub = nh_.subscribe<std_msgs::Float64>("/uav2/mavros/global_position/rel_alt", 10, &ArucoTracker::relAltCallback, this);
        // 添加激光测距订阅，用于精确的地面距离测量
        lidar_sub = nh_.subscribe<sensor_msgs::Range>("/uav2/mavros/distance_sensor/hrlv_ez4_pub", 10, &ArucoTracker::lidarCallback, this);
        aruco_dection_sub = nh_.subscribe<vision_msgs::TargetsInFrame>("/uav2/vision/aruco_detection", 10, &ArucoTracker::arucoCenterCallback, this);
        aruco_trigger_sub = nh_.subscribe<std_msgs::Bool>("/aruco_landing", 10, &ArucoTracker::arucotriggerCallback, this);
        // Hangar state (uav_state, uint8) from MQTT bridge
        hangar_state_sub_ = nh_.subscribe<std_msgs::UInt8>("/hangar/uav_state", 10, &ArucoTracker::hangarStateCallback, this);

        // Parameters to control hangar gating
        nh_.param("enable_hangar_trigger", enable_hangar_trigger_, false);
        nh_.param("hangar_ready_value", hangar_ready_value_, 1);
        mavros_state_sub = nh_.subscribe<mavros_msgs::State>("/uav2/mavros/state", 10, &ArucoTracker::mavrosStateCallback, this);
        // 使用可配置的控制频率创建Timer
        control_timer_ = nh_.createTimer(ros::Duration(1.0/control_frequency_), &ArucoTracker::controlLoop, this);
        
        // 启动时显示坐标系转换验证指南（根据调试参数决定）
        if (enable_coordinate_transform_test_) {
            verifyCoordinateTransform();
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
        if (enable_lidar_debug_ && (ros::Time::now() - last_height_print).toSec() > height_print_interval_) {
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

    void arucoCenterCallback(const vision_msgs::TargetsInFrame::ConstPtr& msg) {
        // 清空上一帧的索引记录
        id_19_indices_.clear();
        id_43_indices_.clear();
        first_19_idx = -1;
        first_43_idx = -1;
        
        // 清空四角标记索引记录
        id_1_idx_ = -1;
        id_2_idx_ = -1; 
        id_3_idx_ = -1;
        id_4_idx_ = -1;
        corner_markers_available_ = false;
        
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
                    }
                    // 记录四角标记的位置索引
                    else if(aruco_center_id_[i] == 1) {
                        id_1_idx_ = i;
                    } else if(aruco_center_id_[i] == 2) {
                        id_2_idx_ = i;
                    } else if(aruco_center_id_[i] == 3) {
                        id_3_idx_ = i;
                    } else if(aruco_center_id_[i] == 4) {
                        id_4_idx_ = i;
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
                
                // 检查四角标记是否可用
                corner_markers_available_ = (id_1_idx_ >= 0 && id_2_idx_ >= 0 && 
                                           id_3_idx_ >= 0 && id_4_idx_ >= 0);
                
                // 如果四角标记都可用，计算平台中心和朝向
                if(corner_markers_available_) {
                    calculatePlatformCenterAndOrientation();
                    
                    if(enable_aruco_detection_debug_) {
                        ROS_INFO("Corner markers detected: Platform center (%.3f, %.3f), Yaw: %.1f°", 
                                platform_center_x_, platform_center_y_, 
                                platform_yaw_ * 180.0 / M_PI);
                    }
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
        }
    }

    void arucotriggerCallback(const std_msgs::Bool::ConstPtr & msg){
        is_trigger_manual_ = msg->data;
        updateCombinedTrigger();
        ROS_INFO_ONCE("Aruco landing trigger received: %s", is_trigger_manual_ ? "START" : "STOP");
    }

    void hangarStateCallback(const std_msgs::UInt8::ConstPtr& msg) {
        last_hangar_state_ = static_cast<int>(msg->data);
        updateCombinedTrigger();
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
        if (enable_mode_debug_ && (ros::Time::now() - last_status_print).toSec() > status_print_interval_) {
            double current_height = getCurrentHeight();
            ROS_INFO("Landing Status: Height=%.2fm, ArUco=%s, Mode=%s", 
                     current_height, 
                     is_aruco_detected_ ? "DETECTED" : "LOST",
                     mavros_state_.mode.c_str());
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
                ROS_INFO_THROTTLE(1.0, "ArUco lost but within buffer (%.1fs/%.1fs)", 
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
            // 更新降落模式和策略（只在有实际检测时更新）
            if (is_aruco_detected_) {
                updateLandingModeAndStrategy();
            }
            
            // 根据当前模式执行相应的控制逻辑
            executeModeControl(dt);
        } else {
            // 没有检测到二维码且超出缓冲时间，发送悬停指令
            send_hover_command();
        }
    }

private:
    // 计算平台中心和朝向
    void calculatePlatformCenterAndOrientation() {
        if (!corner_markers_available_) {
            platform_yaw_valid_ = false;
            return;
        }
        
        // 获取四角标记的坐标
        double x1 = aruco_center_x_[id_1_idx_];  // 左前角 (ID1)
        double y1 = aruco_center_y_[id_1_idx_];
        double x2 = aruco_center_x_[id_2_idx_];  // 左后角 (ID2)  
        double y2 = aruco_center_y_[id_2_idx_];
        double x3 = aruco_center_x_[id_3_idx_];  // 右后角 (ID3)
        double y3 = aruco_center_y_[id_3_idx_];
        double x4 = aruco_center_x_[id_4_idx_];  // 右前角 (ID4)
        double y4 = aruco_center_y_[id_4_idx_];
        
        // 计算平台几何中心 (四个角的质心)
        platform_center_x_ = (x1 + x2 + x3 + x4) / 4.0;
        platform_center_y_ = (y1 + y2 + y3 + y4) / 4.0;
        
        // 计算平台朝向 (基于前边的中点到后边中点的向量)
        // 前边中点 (ID1 和 ID4)
        double front_center_x = (x1 + x4) / 2.0;
        double front_center_y = (y1 + y4) / 2.0;
        
        // 后边中点 (ID2 和 ID3)  
        double back_center_x = (x2 + x3) / 2.0;
        double back_center_y = (y2 + y3) / 2.0;
        
        // 计算从后到前的向量 (平台朝向)
        double direction_x = front_center_x - back_center_x;
        double direction_y = front_center_y - back_center_y;
        
        // 计算朝向角度 (相对于图像坐标系)
        // 注意：图像坐标系中，Y轴向下为正，需要调整
        platform_yaw_ = atan2(-direction_y, direction_x);  // 负号是因为图像Y轴向下
        platform_yaw_valid_ = true;
        
        // 应用相机偏移补偿
        applyCameraOffsetCompensation();
    }
    
    // 应用相机偏移补偿
    void applyCameraOffsetCompensation() {
        if (!enable_camera_compensation_) {
            return;
        }
        
        // 获取当前高度用于计算像素偏移量
        double current_height = getCurrentHeight();
        
        // 使用配置的相机视野角度
        double fov_x_rad = camera_fov_horizontal_ * M_PI / 180.0;  // 水平视野角
        double fov_y_rad = camera_fov_vertical_ * M_PI / 180.0;    // 垂直视野角
        
        // 计算在当前高度下，相机偏移对应的像素偏移
        double ground_width = 2.0 * current_height * tan(fov_x_rad / 2.0);
        double ground_height = 2.0 * current_height * tan(fov_y_rad / 2.0);
        
        // 将物理偏移转换为归一化像素偏移
        double pixel_offset_x = camera_offset_forward_ / ground_width;  // 前向偏移
        double pixel_offset_y = camera_offset_right_ / ground_height;   // 横向偏移
        
        // 补偿平台中心坐标 (相机看到的位置需要向后偏移)
        platform_center_x_ -= pixel_offset_x;  // 减去前向偏移，因为目标相对相机向后
        platform_center_y_ -= pixel_offset_y;  // 减去横向偏移
        
        if(enable_aruco_detection_debug_) {
            ROS_INFO_THROTTLE(2.0, "Camera offset compensation: height=%.2fm, pixel_offset=[%.3f,%.3f]", 
                     current_height, pixel_offset_x, pixel_offset_y);
        }
    }

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
        nh_.param("/mission_aruco_land_node/height_rough_land", HEIGHT_ROUGH_LAND, 6.5);
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
        nh_.param("/mission_aruco_land_node/adaptive_pid/error_factors/large", error_factors_.very_high, 1.4);
        nh_.param("/mission_aruco_land_node/adaptive_pid/error_factors/medium", error_factors_.high, 1.2);
        nh_.param("/mission_aruco_land_node/adaptive_pid/error_factors/small", error_factors_.medium, 1.0);
        nh_.param("/mission_aruco_land_node/adaptive_pid/error_factors/tiny", error_factors_.low, 0.8);
        
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
        nh_.param("/mission_aruco_land_node/lidar/enable", lidar_enable_, false);
        nh_.param("/mission_aruco_land_node/lidar/topic_name", lidar_topic_, 
                  std::string("/uav2/mavros/distance_sensor/hrlv_ez4_pub"));
        nh_.param("/mission_aruco_land_node/lidar/timeout", lidar_timeout_, 1.0);
        nh_.param("/mission_aruco_land_node/lidar/noise_threshold", lidar_noise_threshold_, 0.1);
        nh_.param("/mission_aruco_land_node/lidar/fusion_weight", lidar_fusion_weight_, 0.8);
        
        // 调试参数
        nh_.param("/mission_aruco_land_node/debug/enable_coordinate_transform_test", enable_coordinate_transform_test_, true);
        nh_.param("/mission_aruco_land_node/debug/enable_aruco_detection_debug", enable_aruco_detection_debug_, true);
        nh_.param("/mission_aruco_land_node/debug/enable_pid_debug", enable_pid_debug_, true);
        nh_.param("/mission_aruco_land_node/debug/enable_mode_debug", enable_mode_debug_, true);
        nh_.param("/mission_aruco_land_node/debug/enable_lidar_debug", enable_lidar_debug_, false);
        
        // 四角标记降落参数
        nh_.param("/mission_aruco_land_node/corner_marker_landing/enable", corner_landing_enable_, true);
        nh_.param("/mission_aruco_land_node/corner_marker_landing/target_heading", target_platform_heading_, 0.0);
        nh_.param("/mission_aruco_land_node/corner_marker_landing/heading_tolerance", heading_tolerance_, 5.0);
        
        // 降落策略参数
        int strategy_int;
        nh_.param("/mission_aruco_land_node/landing_strategy/default_strategy", strategy_int, 3);
        landing_strategy_ = static_cast<LandingStrategy>(strategy_int);
        
        // 混合模式参数
        nh_.param("/mission_aruco_land_node/landing_strategy/hybrid_mode/center_priority_height", center_priority_height_, 1.0);
        nh_.param("/mission_aruco_land_node/landing_strategy/hybrid_mode/max_center_weight", max_center_weight_, 0.7);
        nh_.param("/mission_aruco_land_node/landing_strategy/hybrid_mode/weight_transition_rate", weight_transition_rate_, 1.5);
        
        // 四角引导降落参数
        nh_.param("/mission_aruco_land_node/corner_guided_land/max_vel_high", corner_guided_params_.max_vel_high, 0.3);
        nh_.param("/mission_aruco_land_node/corner_guided_land/max_vel_low", corner_guided_params_.max_vel_low, 0.2);
        nh_.param("/mission_aruco_land_node/corner_guided_land/z_vel_high", corner_guided_params_.z_vel_high, -0.4);
        nh_.param("/mission_aruco_land_node/corner_guided_land/z_vel_medium", corner_guided_params_.z_vel_medium, -0.3);
        nh_.param("/mission_aruco_land_node/corner_guided_land/z_vel_low", corner_guided_params_.z_vel_low, -0.2);
        nh_.param("/mission_aruco_land_node/corner_guided_land/z_vel_final", corner_guided_params_.z_vel_final, -0.1);
        
        // 混合降落参数
        nh_.param("/mission_aruco_land_node/hybrid_land/max_vel_high", hybrid_land_params_.max_vel_high, 0.25);
        nh_.param("/mission_aruco_land_node/hybrid_land/max_vel_low", hybrid_land_params_.max_vel_low, 0.2);
        nh_.param("/mission_aruco_land_node/hybrid_land/z_vel_high", hybrid_land_params_.z_vel_high, -0.35);
        nh_.param("/mission_aruco_land_node/hybrid_land/z_vel_medium", hybrid_land_params_.z_vel_medium, -0.25);
        nh_.param("/mission_aruco_land_node/hybrid_land/z_vel_low", hybrid_land_params_.z_vel_low, -0.15);
        nh_.param("/mission_aruco_land_node/hybrid_land/z_vel_final", hybrid_land_params_.z_vel_final, -0.1);
        
        // 相机安装偏移参数
        nh_.param("/mission_aruco_land_node/camera_installation/offset_forward", camera_offset_forward_, 0.15);
        nh_.param("/mission_aruco_land_node/camera_installation/offset_right", camera_offset_right_, 0.0);
        nh_.param("/mission_aruco_land_node/camera_installation/offset_down", camera_offset_down_, 0.05);
        nh_.param("/mission_aruco_land_node/camera_installation/horizontal_fov", camera_fov_horizontal_, 70.0);
        nh_.param("/mission_aruco_land_node/camera_installation/vertical_fov", camera_fov_vertical_, 43.0);
        nh_.param("/mission_aruco_land_node/camera_installation/enable_compensation", enable_camera_compensation_, true);
        
        ROS_INFO("ArUco Landing initialized with frequency %.1f Hz, Strategy: %d", 
                 control_frequency_, static_cast<int>(landing_strategy_));
    }
    
    // 坐标系转换验证函数
    void verifyCoordinateTransform() {
        ROS_INFO("Coordinate transform verification enabled");
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
            error_factor = error_factors_.very_high;   // 大误差：强响应
            //error_factor = 1.4;
        } else if (error_magnitude > 0.15) {
            error_factor = error_factors_.high;        // 中误差：适中响应
            //error_factor = 1.2;
        } else if (error_magnitude > 0.05) {
            error_factor = error_factors_.medium;      // 小误差：标准响应
            //error_factor = 1.0;
        } else {
            error_factor = error_factors_.low;         // 极小误差：柔和响应
            //error_factor = 0.8;
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
            case LandingMode::CORNER_GUIDED_LAND:
                mode_factor = 0.85;                       // 四角引导：较保守
                break;
            case LandingMode::HYBRID_LAND:
                mode_factor = 0.95;                       // 混合模式：中等保守
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
            ROS_INFO("PID: Kp=%.3f, Ki=%.4f, Kd=%.3f (H=%.2fm, E=%.3f)", 
                     params.kp_x, params.ki_x, params.kd_x, height, error_magnitude);
            last_param_print = ros::Time::now();
        }
        
        return params;
    }
    
    // 测试坐标系转换的辅助函数
    void testCoordinateTransform(double test_cx, double test_cy) {
        // 坐标系转换测试函数（仅在调试模式下输出）
        if (!enable_coordinate_transform_test_) return;
        
        double error_x = -(test_cx - 0.5);
        double error_y = -(test_cy - 0.5);
        double vel_x = p_gain_x * error_x;
        double vel_y = p_gain_y * error_y;
        double ned_x = vel_y;
        double ned_y = vel_x;
        
        ROS_INFO("Transform test: (%.2f,%.2f) -> NED[%.2f,%.2f]", test_cx, test_cy, ned_x, ned_y);
    }
    
    // 更新降落模式和策略
    void updateLandingModeAndStrategy() {
        double current_height = getCurrentHeight();
        
        // 首先更新降落策略
        updateLandingStrategy();
        
        // 根据高度和可用标记确定降落模式
        if(current_height > HEIGHT_ROUGH_LAND) {
            // 高度 > 0.8m：粗降落模式
            determineRoughLandingTarget();
        } 
        else if(current_height > HEIGHT_FINE_LAND && current_height <= HEIGHT_ROUGH_LAND) {
            // 0.5m < 高度 <= 0.8m：精降落模式
            determineFineLandingTarget();
        }
        else {
            // 高度 <= 0.5m：切换到PX4 AUTO.LAND模式
            current_mode_ = LandingMode::PX4_LAND;
            ROS_INFO("Activating AUTO.LAND at height %.2fm", current_height);
        }
    }
    
    // 更新降落策略
    void updateLandingStrategy() {
        // 根据可用标记自动调整策略
        bool has_center_markers = (current_has_19 || current_has_43);
        
        if (corner_markers_available_ && has_center_markers) {
            landing_strategy_ = LandingStrategy::HYBRID_STRATEGY;
        } else if (corner_markers_available_) {
            landing_strategy_ = LandingStrategy::CORNER_MARKERS_ONLY;
        } else if (has_center_markers) {
            landing_strategy_ = LandingStrategy::CENTER_MARKERS_ONLY;
        } else {
            // 没有可用标记，保持悬停
            current_mode_ = LandingMode::HOVER;
            return;
        }
    }
    
    // 确定粗降落目标
    void determineRoughLandingTarget() {
        switch(landing_strategy_) {
            case LandingStrategy::CORNER_MARKERS_ONLY:
                if(corner_markers_available_) {
                    current_mode_ = LandingMode::CORNER_GUIDED_LAND;
                } else {
                    current_mode_ = LandingMode::HOVER;
                }
                break;
                
            case LandingStrategy::HYBRID_STRATEGY:
                // 混合模式：优先使用四角标记定位，中心标记微调
                if(corner_markers_available_) {
                    current_mode_ = LandingMode::HYBRID_LAND;
                } else if(current_has_19 || current_has_43) {
                    current_mode_ = LandingMode::ROUGH_LAND;
                } else {
                    current_mode_ = LandingMode::HOVER;
                }
                break;
                
            case LandingStrategy::CENTER_MARKERS_ONLY:
            default:
                if(current_has_19) {
                    current_mode_ = LandingMode::ROUGH_LAND;
                } else if(current_has_43) {
                    current_mode_ = LandingMode::ROUGH_LAND;
                } else {
                    current_mode_ = LandingMode::HOVER;
                }
                break;
        }
    }
    
    // 确定精降落目标
    void determineFineLandingTarget() {
        switch(landing_strategy_) {
            case LandingStrategy::CORNER_MARKERS_ONLY:
                if(corner_markers_available_) {
                    current_mode_ = LandingMode::CORNER_GUIDED_LAND;
                } else {
                    current_mode_ = LandingMode::HOVER;
                }
                break;
                
            case LandingStrategy::HYBRID_STRATEGY:
                // 精降落阶段更倚重中心标记
                if(current_has_43) {
                    current_mode_ = LandingMode::HYBRID_LAND;
                } else if(corner_markers_available_) {
                    current_mode_ = LandingMode::CORNER_GUIDED_LAND;
                } else {
                    current_mode_ = LandingMode::HOVER;
                }
                break;
                
            case LandingStrategy::CENTER_MARKERS_ONLY:
            default:
                if(current_has_43) {
                    current_mode_ = LandingMode::FINE_LAND;
                } else {
                    current_mode_ = LandingMode::HOVER;
                }
                break;
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
                
            case LandingMode::CORNER_GUIDED_LAND:
                executeCornerGuidedLandMode(dt);
                break;
                
            case LandingMode::HYBRID_LAND:
                executeHybridLandMode(dt);
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
        
        ROS_INFO_THROTTLE(1.0, "Rough landing using %s: height=%.2fm, vel=[%.2f,%.2f,%.2f]", 
                 target_id.c_str(), current_height, output_x, output_y, output_z);
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
        
        ROS_INFO_THROTTLE(1.0, "Fine landing: height=%.2fm, vel=[%.2f,%.2f,%.2f]", 
                 current_height, output_x, output_y, output_z);
    }
    
    // 执行四角标记引导降落模式
    void executeCornerGuidedLandMode(double dt) {
        if (!corner_markers_available_) {
            ROS_WARN("Corner markers not available for corner-guided landing!");
            send_hover_command();
            return;
        }
        
        double current_height = getCurrentHeight();
        
        // 计算误差 (基于平台中心)
        double error_x = -(platform_center_x_ - 0.5);
        double error_y = -(platform_center_y_ - 0.5);
        double error_magnitude = sqrt(error_x*error_x + error_y*error_y);
        
        // 自适应PID参数计算 
        AdaptivePIDParams adaptive_params = calculateAdaptivePID(current_height, error_magnitude, LandingMode::CORNER_GUIDED_LAND);
        
        // 设置自适应PID参数
        pid_x_.setGains(adaptive_params.kp_x, adaptive_params.ki_x, adaptive_params.kd_x);
        pid_y_.setGains(adaptive_params.kp_y, adaptive_params.ki_y, adaptive_params.kd_y);
        
        double output_x = pid_x_.compute(error_x, dt);
        double output_y = pid_y_.compute(error_y, dt);
        
        // 基于四角标记的Z轴控制 (更保守的下降速度)
        double output_z;
        if (current_height > 2.0) {
            output_z = -0.4;  // 高空慢速下降
        } else if (current_height > 1.0) {
            output_z = -0.3;  // 中空稳定下降
        } else if (current_height > 0.5) {
            output_z = -0.2;  // 低空缓慢下降
        } else {
            output_z = -0.1;  // 极低空安全下降
        }
        
        // 保守的输出限制
        double max_vel = (current_height > 1.0) ? 0.3 : 0.2;
        output_x = std::clamp(output_x, -max_vel, max_vel);
        output_y = std::clamp(output_y, -max_vel, max_vel);
        
        // 使用平台朝向进行偏航控制 (目标朝向为东，即0度)
        float target_yaw = 0.0f;  // 东向为0度
        if (platform_yaw_valid_) {
            // 计算朝向误差，目标是让平台朝向对齐东方
            target_yaw = -platform_yaw_;  // 负号用于抵消当前朝向
        }
        float yaw_rate = calculateYawRate(target_yaw, dt);
        
        send_velocity_setpoint(output_x, output_y, output_z, yaw_rate);
        
        ROS_INFO_THROTTLE(1.0, "Corner-guided landing: height=%.2fm, vel=[%.2f,%.2f,%.2f], target_yaw=%.1f°", 
                 current_height, output_x, output_y, output_z, target_yaw * 180.0 / M_PI);
    }
    
    // 执行混合降落模式 (四角标记定位 + 中心标记微调)
    void executeHybridLandMode(double dt) {
        double current_height = getCurrentHeight();
        double output_x = 0.0, output_y = 0.0;
        float target_yaw = 0.0f;
        
        // 基础定位：使用四角标记计算的平台中心
        if (corner_markers_available_) {
            double error_x = -(platform_center_x_ - 0.5);
            double error_y = -(platform_center_y_ - 0.5);
            
            // 自适应PID参数计算
            double error_magnitude = sqrt(error_x*error_x + error_y*error_y);
            AdaptivePIDParams adaptive_params = calculateAdaptivePID(current_height, error_magnitude, LandingMode::HYBRID_LAND);
            
            pid_x_.setGains(adaptive_params.kp_x, adaptive_params.ki_x, adaptive_params.kd_x);
            pid_y_.setGains(adaptive_params.kp_y, adaptive_params.ki_y, adaptive_params.kd_y);
            
            output_x = pid_x_.compute(error_x, dt);
            output_y = pid_y_.compute(error_y, dt);
            
            // 使用平台朝向进行偏航控制
            if (platform_yaw_valid_) {
                target_yaw = -platform_yaw_;
            }
        }
        
        // 微调：使用中心标记进行精细调整 (低高度时权重更高)
        if ((current_has_19 || current_has_43) && current_height < center_priority_height_) {
            int center_idx = current_has_43 ? first_43_idx : first_19_idx;
            
            if (center_idx >= 0) {
                double center_error_x = -(aruco_center_x_[center_idx] - 0.5);
                double center_error_y = -(aruco_center_y_[center_idx] - 0.5);
                
                // 计算混合权重 (使用配置的权重过渡速率)
                double height_ratio = std::max(0.0, (center_priority_height_ - current_height) / center_priority_height_);
                double center_weight = std::min(max_center_weight_, height_ratio * weight_transition_rate_);
                double corner_weight = 1.0 - center_weight;
                
                // 混合控制输出
                output_x = corner_weight * output_x + center_weight * (p_gain_x * center_error_x);
                output_y = corner_weight * output_y + center_weight * (p_gain_y * center_error_y);
                
                // 混合偏航控制
                float center_yaw = aruco_yaw_[center_idx] / 180.0 * M_PI;
                target_yaw = corner_weight * target_yaw + center_weight * center_yaw;
                
                ROS_INFO_THROTTLE(2.0, "Hybrid mode: center_weight=%.2f, corner_weight=%.2f", 
                         center_weight, corner_weight);
            }
        }
        
        // Z轴控制 (混合模式下更谨慎)
        double output_z;
        if (current_height > 1.5) {
            output_z = -0.35;
        } else if (current_height > 0.8) {
            output_z = -0.25;
        } else if (current_height > 0.5) {
            output_z = -0.15;
        } else {
            output_z = -0.1;
        }
        
        // 输出限制
        double max_vel = (current_height > 1.0) ? 0.25 : 0.2;
        output_x = std::clamp(output_x, -max_vel, max_vel);
        output_y = std::clamp(output_y, -max_vel, max_vel);
        
        float yaw_rate = calculateYawRate(target_yaw, dt);
        send_velocity_setpoint(output_x, output_y, output_z, yaw_rate);
        
        ROS_INFO_THROTTLE(1.0, "Hybrid landing: height=%.2fm, vel=[%.2f,%.2f,%.2f]", 
                 current_height, output_x, output_y, output_z);
    }
    
    // 执行PX4降落模式
    void executePx4LandMode() {
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
        

    }
    
    void send_land_command() {
        mavros_msgs::SetMode land_mode;
        land_mode.request.custom_mode = "AUTO.LAND";
        
        if (!set_mode_client.call(land_mode) || !land_mode.response.mode_sent) {
            ROS_ERROR("Failed to set PX4 LAND mode");
        }
    }
    
    void ensure_offboard_mode() {
        // 只有在需要时才发送模式切换指令，避免频繁调用
        if (mavros_state_.mode != "OFFBOARD") {
            mavros_msgs::SetMode offboard_mode;
            offboard_mode.request.custom_mode = "OFFBOARD";
            
            if (!set_mode_client.call(offboard_mode) || !offboard_mode.response.mode_sent) {
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

    // 新增：四角标记降落参数结构
    struct CornerGuidedParams {
        double max_vel_high, max_vel_low;
        double z_vel_high, z_vel_medium, z_vel_low, z_vel_final;
    } corner_guided_params_;
    
    struct HybridLandParams {
        double max_vel_high, max_vel_low;
        double z_vel_high, z_vel_medium, z_vel_low, z_vel_final;
    } hybrid_land_params_;
    
    // 四角标记降落配置参数
    bool corner_landing_enable_;
    double target_platform_heading_;      // 目标平台朝向 (度)
    double heading_tolerance_;            // 朝向容差 (度)
    
    // 混合模式参数
    double center_priority_height_;       // 中心标记优先高度阈值
    double max_center_weight_;           // 中心标记最大权重
    double weight_transition_rate_;      // 权重过渡速率
    
    // 相机安装偏移参数
    double camera_offset_forward_;       // 相机前向偏移
    double camera_offset_right_;         // 相机右向偏移  
    double camera_offset_down_;          // 相机下向偏移
    double camera_fov_horizontal_;       // 相机水平视野角
    double camera_fov_vertical_;         // 相机垂直视野角
    bool enable_camera_compensation_;    // 启用相机偏移补偿

    // Hangar trigger gate
    bool enable_hangar_trigger_ = false;
    int hangar_ready_value_ = 1; // default: 1 means ready
    int last_hangar_state_ = 0;
    
    // 四角标记相关成员变量
    bool corner_markers_available_;          // 四角标记是否可用
    double platform_center_x_;               // 平台中心X坐标
    double platform_center_y_;               // 平台中心Y坐标  
    double platform_yaw_;                    // 平台朝向
    bool platform_yaw_valid_;                // 平台朝向是否有效
    LandingStrategy landing_strategy_;       // 降落策略
    
    // 四角标记索引
    int id_1_idx_, id_2_idx_, id_3_idx_, id_4_idx_;
};

#endif // ARUCO_CONTROLLER_H
