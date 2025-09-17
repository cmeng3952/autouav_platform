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
#include <vector>
#include <Eigen/Dense>
#include <geometry_utils.h>

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
    HYBRID_LAND = 4,         // 混合模式（四角+中心标记）
    PARTIAL_CORNER_GUIDED = 5 // 部分角落标记引导模式（1-3个标记）
};

// 降落控制策略枚举
enum class LandingStrategy {
    CENTER_MARKERS_ONLY = 0,    // 仅使用中心标记(ID19,43)
    CORNER_MARKERS_ONLY = 1,    // 仅使用四角标记(ID1,2,3,4)
    HYBRID_STRATEGY = 2,        // 混合策略（四角+中心）
    AUTO_ADAPTIVE = 3           // 自动适应性策略
};

// 偏航控制模式枚举
enum class YawControlMode {
    MAINTAIN_TAKEOFF_HEADING = 0,   // 保持起飞时朝向（默认）
    FOLLOW_ARUCO_HEADING = 1,       // 跟随ArUco标记朝向
    FOLLOW_PLATFORM_HEADING = 2,    // 跟随平台朝向（四角标记计算）
    FIXED_HEADING = 3               // 固定朝向（如东方向）
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
                     height_source_priority_(5), lidar_enable_(true), 
                     lidar_timeout_(2.0), lidar_noise_threshold_(0.5), lidar_fusion_weight_(0.8),
                     enable_lidar_debug_(true),
                     last_aruco_lost_time_(0), aruco_lost_buffer_active_(false),
                     last_target_yaw_(0.0), yaw_initialized_(false),
                     current_yaw_(0.0), current_yaw_available_(false),
                     yaw_pid_(1.0, 0.1, 0.2), manual_autoland_trigger_(false),
                     takeoff_yaw_(0.0), takeoff_yaw_recorded_(false),
                     // 四角标记相关初始化
                     corner_markers_available_(false), platform_center_x_(0.5), platform_center_y_(0.5),
                     platform_yaw_(0.0), platform_yaw_valid_(false),
                     landing_strategy_(LandingStrategy::AUTO_ADAPTIVE),
                     // 四角标记索引初始化
                     id_1_idx_(-1), id_2_idx_(-1), id_3_idx_(-1), id_4_idx_(-1),
                     // 平台边界初始化
                     platform_boundaries_valid_(false), enable_boundary_limits_(true),
                     boundary_safety_margin_(0.05), enable_boundary_debug_(true),
                     use_polygon_bounds_(true), boundary_constraint_active_(false),
                     boundary_constraint_gain_(2.0), max_boundary_control_output_(0.3) {
        
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
        // 新增：手动触发AUTO.LAND的话题订阅
        manual_autoland_sub = nh_.subscribe<std_msgs::Bool>("/manual_autoland_trigger", 10, &ArucoTracker::manualAutolandCallback, this);
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
        
        // 初始化激光雷达连接诊断
        if (lidar_enable_) {
            ROS_INFO("LiDAR enabled: subscribing to %s (timeout=%.1fs, noise_threshold=%.2fm)", 
                     lidar_topic_.c_str(), lidar_timeout_, lidar_noise_threshold_);
        } else {
            ROS_WARN("LiDAR disabled in configuration");
        }
        
        ROS_INFO("ArucoTracker initialized successfully with Adaptive PID and MAVROS control");
    }

    void pose_cb(const geometry_msgs::PoseStamped::ConstPtr & msg){
        odom_x = msg->pose.position.x;
        odom_y = msg->pose.position.y;
        odom_z = msg->pose.position.z;
        
        // 获取当前飞机朝向（偏航角）
        Eigen::Quaterniond current_quat(msg->pose.orientation.w, 
                                        msg->pose.orientation.x,
                                        msg->pose.orientation.y, 
                                        msg->pose.orientation.z);
        current_yaw_ = geometry_utils::get_yaw_from_quaternion(current_quat);
        current_yaw_available_ = true;
        
        // 记录起飞时的朝向（仅在首次触发二维码降落时记录）
        if (is_trigger_ && !takeoff_yaw_recorded_) {
            takeoff_yaw_ = current_yaw_;
            takeoff_yaw_recorded_ = true;
            ROS_INFO("Takeoff yaw recorded: %.1f° (%.3f rad)", 
                     takeoff_yaw_ * 180.0 / M_PI, takeoff_yaw_);
        }
    }

    void relAltCallback(const std_msgs::Float64::ConstPtr& msg) {
        rel_alt_ = msg->data;
        rel_alt_available_ = true;
        
        // 定期打印高度源对比信息（优化版本）
        static ros::Time last_height_print = ros::Time(0);
        if (enable_lidar_debug_ && (ros::Time::now() - last_height_print).toSec() > height_print_interval_) {
            printHeightComparison();
            last_height_print = ros::Time::now();
        }
    }

    void lidarCallback(const sensor_msgs::Range::ConstPtr& msg) {
        // 检查激光测距数据有效性
        if (msg->range >= msg->min_range && msg->range <= msg->max_range) {
            // 放宽噪声过滤条件，避免过度过滤
            if (!lidar_available_ || fabs(msg->range - lidar_height_) < lidar_noise_threshold_ || lidar_noise_threshold_ <= 0) {
                lidar_height_ = msg->range;
                lidar_available_ = true;
                last_lidar_time_ = ros::Time::now();
                
                // 添加激光雷达数据接收调试信息
                if (enable_lidar_debug_) {
                    static ros::Time last_lidar_debug = ros::Time(0);
                    if ((ros::Time::now() - last_lidar_debug).toSec() > 5.0) {
                        ROS_INFO("Lidar data received: %.2fm [%.2f-%.2f]", msg->range, msg->min_range, msg->max_range);
                        last_lidar_debug = ros::Time::now();
                    }
                }
            } else {
                if (enable_lidar_debug_) {
                    ROS_WARN_THROTTLE(2.0, "Lidar data filtered: current=%.2fm, previous=%.2fm, threshold=%.3fm", 
                                     msg->range, lidar_height_, lidar_noise_threshold_);
                }
            }
        } else {
            if (enable_lidar_debug_) {
                ROS_WARN_THROTTLE(5.0, "Lidar data out of range: %.2fm [%.2f-%.2f]", 
                                 msg->range, msg->min_range, msg->max_range);
            }
        }
    }

    // 获取当前高度（集成激光测距、GPS相对高度、本地高度和ArUco深度）
    double getCurrentHeight() const {
        // 检查激光测距数据是否可用和新鲜
        bool lidar_fresh = lidar_available_ && 
                          (ros::Time::now() - last_lidar_time_).toSec() < lidar_timeout_;
        
        // 获取ArUco深度数据
        double aruco_height = getArucoHeight();
        bool aruco_height_valid = (aruco_height > 0.1 && aruco_height < 50.0);  // 合理范围检查
        
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
                if (lidar_fresh && lidar_height_ > 0.1) {
                    return lidar_height_;
                } else if (rel_alt_available_) {
                    return rel_alt_;
                }
                return odom_z;
                
            case 4: // 新增：ArUco深度优先
                if (aruco_height_valid) {
                    return aruco_height;
                } else if (lidar_fresh && lidar_height_ > 0.1) {
                    return lidar_height_;
                } else if (rel_alt_available_) {
                    return rel_alt_;
                }
                return odom_z;
                
            case 5: // 新增：多源融合（ArUco + 激光测距 + GPS）
                return getMultiSourceFusedHeight();
                
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
        
        std::string source_names[] = {"GPS_ONLY", "LIDAR_ONLY", "LIDAR_GPS_FUSION", "LIDAR_PRIORITY", 
                                     "ARUCO_PRIORITY", "MULTI_SOURCE_FUSION"};
        std::string source_name = (height_source_priority_ >= 0 && height_source_priority_ <= 5) ? 
                                 source_names[height_source_priority_] : "UNKNOWN";
        
        bool aruco_height_valid = (getArucoHeight() > 0.1);
        
        return source_name + " (Lidar:" + (lidar_fresh ? "OK" : "FAIL") + 
               ", GPS:" + (rel_alt_available_ ? "OK" : "FAIL") + 
               ", ArUco:" + (aruco_height_valid ? "OK" : "FAIL") + ")";
    }
    
    // 新增：获取ArUco深度高度信息
    double getArucoHeight() const {
        if (!is_aruco_detected_ || aruco_depth_.empty()) {
            return -1.0; // 无效数据
        }
        
        // 优先使用中心标记的深度信息（ID 19或43）
        if (current_has_43 && first_43_idx >= 0 && first_43_idx < static_cast<int>(aruco_depth_.size())) {
            double depth = aruco_depth_[first_43_idx];
            if (depth > 0.1 && depth < 50.0) {  // 合理范围检查
                return depth;
            }
        }
        
        if (current_has_19 && first_19_idx >= 0 && first_19_idx < static_cast<int>(aruco_depth_.size())) {
            double depth = aruco_depth_[first_19_idx];
            if (depth > 0.1 && depth < 50.0) {  // 合理范围检查
                return depth;
            }
        }
        
        // 如果中心标记不可用，使用四角标记的平均深度
        if (corner_markers_available_) {
            std::vector<double> corner_depths;
            
            if (id_1_idx_ >= 0 && id_1_idx_ < static_cast<int>(aruco_depth_.size())) {
                corner_depths.push_back(aruco_depth_[id_1_idx_]);
            }
            if (id_2_idx_ >= 0 && id_2_idx_ < static_cast<int>(aruco_depth_.size())) {
                corner_depths.push_back(aruco_depth_[id_2_idx_]);
            }
            if (id_3_idx_ >= 0 && id_3_idx_ < static_cast<int>(aruco_depth_.size())) {
                corner_depths.push_back(aruco_depth_[id_3_idx_]);
            }
            if (id_4_idx_ >= 0 && id_4_idx_ < static_cast<int>(aruco_depth_.size())) {
                corner_depths.push_back(aruco_depth_[id_4_idx_]);
            }
            
            if (!corner_depths.empty()) {
                // 计算平均深度，过滤异常值
                double sum = 0.0;
                int valid_count = 0;
                
                for (double depth : corner_depths) {
                    if (depth > 0.1 && depth < 50.0) {
                        sum += depth;
                        valid_count++;
                    }
                }
                
                if (valid_count > 0) {
                    return sum / valid_count;
                }
            }
        }
        
        return -1.0; // 无有效ArUco高度数据
    }
    
    // 新增：多源融合高度计算
    double getMultiSourceFusedHeight() const {
        std::vector<std::pair<double, double>> height_sources; // (height, weight)
        
        // 激光测距数据
        bool lidar_fresh = lidar_available_ && 
                          (ros::Time::now() - last_lidar_time_).toSec() < lidar_timeout_;
        if (lidar_fresh && lidar_height_ > 0.1) {
            height_sources.push_back({lidar_height_, aruco_lidar_weight_});
        }
        
        // GPS相对高度数据
        if (rel_alt_available_) {
            height_sources.push_back({rel_alt_, aruco_gps_weight_});
        }
        
        // ArUco深度数据
        double aruco_height = getArucoHeight();
        if (aruco_height > 0.1) {
            height_sources.push_back({aruco_height, aruco_depth_weight_});
        }
        
        // 本地高度数据（最低优先级）
        height_sources.push_back({odom_z, 0.1});
        
        // 加权平均计算
        if (height_sources.empty()) {
            return odom_z;
        }
        
        double weighted_sum = 0.0;
        double weight_sum = 0.0;
        
        for (const auto& source : height_sources) {
            weighted_sum += source.first * source.second;
            weight_sum += source.second;
        }
        
        return weight_sum > 0 ? weighted_sum / weight_sum : odom_z;
    }
    
    // 新增：获取偏航控制模式字符串（用于调试）
    std::string getYawControlModeString() const {
        switch (yaw_control_mode_) {
            case YawControlMode::MAINTAIN_TAKEOFF_HEADING:
                return "MAINTAIN_TAKEOFF";
            case YawControlMode::FOLLOW_ARUCO_HEADING:
                return "FOLLOW_ARUCO";
            case YawControlMode::FOLLOW_PLATFORM_HEADING:
                return "FOLLOW_PLATFORM";
            case YawControlMode::FIXED_HEADING:
                return "FIXED_HEADING";
            default:
                return "UNKNOWN";
        }
    }
    
    // 新增：获取目标朝向数据源信息（用于调试）
    std::string getTargetYawSource() const {
        switch (yaw_control_mode_) {
            case YawControlMode::MAINTAIN_TAKEOFF_HEADING:
                return takeoff_yaw_recorded_ ? "TAKEOFF_RECORDED" : "CURRENT_YAW";
                
            case YawControlMode::FOLLOW_ARUCO_HEADING:
                if (current_has_43 && first_43_idx >= 0) {
                    return "ARUCO_ID43";
                } else if (current_has_19 && first_19_idx >= 0) {
                    return "ARUCO_ID19";
                } else {
                    return takeoff_yaw_recorded_ ? "FALLBACK_TAKEOFF" : "FALLBACK_CURRENT";
                }
                
            case YawControlMode::FOLLOW_PLATFORM_HEADING:
                return platform_yaw_valid_ ? "PLATFORM_YAW" : "FALLBACK_TAKEOFF";
                
            case YawControlMode::FIXED_HEADING:
                return "FIXED_EAST";
                
            default:
                return "UNKNOWN";
        }
    }
    
    // 新增：获取目标偏航角（根据配置模式确定目标朝向）
    float getTargetYaw() const {
        switch (yaw_control_mode_) {
            case YawControlMode::MAINTAIN_TAKEOFF_HEADING:
                // 方式1：保持起飞时的朝向
                if (takeoff_yaw_recorded_) {
                    return takeoff_yaw_;
                }
                break;
                
            case YawControlMode::FOLLOW_ARUCO_HEADING:
                // 方式2：跟随ArUco标记朝向（优先使用中心标记）
                if (enable_aruco_yaw_tracking_) {
                    // 优先使用ID43（精降落标记）
                    if (current_has_43 && first_43_idx >= 0 && first_43_idx < static_cast<int>(aruco_yaw_.size())) {
                        double aruco_yaw_rad = aruco_yaw_[first_43_idx] * M_PI / 180.0;
                        return geometry_utils::normalize_angle(aruco_yaw_rad);
                    }
                    // 备用使用ID19（粗降落标记）
                    else if (current_has_19 && first_19_idx >= 0 && first_19_idx < static_cast<int>(aruco_yaw_.size())) {
                        double aruco_yaw_rad = aruco_yaw_[first_19_idx] * M_PI / 180.0;
                        return geometry_utils::normalize_angle(aruco_yaw_rad);
                    }
                }
                break;
                
            case YawControlMode::FOLLOW_PLATFORM_HEADING:
                // 方式3：使用平台朝向（四角标记计算的朝向）
                if (enable_aruco_yaw_tracking_ && platform_yaw_valid_) {
                    return geometry_utils::normalize_angle(platform_yaw_);
                }
                break;
                
            case YawControlMode::FIXED_HEADING:
                // 方式4：固定朝向（东方向或配置的方向）
                return target_east_yaw_;
        }
        
        // 默认备用：保持起飞朝向，如果未记录则使用当前朝向
        if (takeoff_yaw_recorded_) {
            return takeoff_yaw_;
        } else if (current_yaw_available_) {
            return current_yaw_;
        } else {
            return 0.0;  // 最后备用：朝向北方
        }
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
        detected_corner_markers_.clear();
        
        if(!msg->targets.empty()){
            size_t target_count = msg->targets.size();
            
            aruco_center_x_.resize(target_count);
            aruco_center_y_.resize(target_count);
            aruco_center_id_.resize(target_count);
            aruco_yaw_.resize(target_count);
            aruco_depth_.resize(target_count);  // 新增：存储深度信息
            
            if(target_count > 0){
                for(size_t i = 0; i < target_count; i++){
                    aruco_center_id_[i] = msg->targets[i].tracked_id;
                    aruco_center_x_[i] = msg->targets[i].cx;
                    aruco_center_y_[i] = msg->targets[i].cy;
                    aruco_yaw_[i] = msg->targets[i].yaw_a;
                    aruco_depth_[i] = msg->targets[i].pz;  // 新增：存储深度信息
                    
                    // 记录特定ID的位置索引
                    if(aruco_center_id_[i] == 19) {
                        id_19_indices_.push_back(i);
                    } else if(aruco_center_id_[i] == 43) {
                        id_43_indices_.push_back(i);
                    }
                    // 记录四角标记的位置索引
                    else if(aruco_center_id_[i] == 1) {
                        id_1_idx_ = i;
                        detected_corner_markers_.push_back({1, i});
                    } else if(aruco_center_id_[i] == 2) {
                        id_2_idx_ = i;
                        detected_corner_markers_.push_back({2, i});
                    } else if(aruco_center_id_[i] == 3) {
                        id_3_idx_ = i;
                        detected_corner_markers_.push_back({3, i});
                    } else if(aruco_center_id_[i] == 4) {
                        id_4_idx_ = i;
                        detected_corner_markers_.push_back({4, i});
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
                
                // ArUco深度信息调试输出（优化版本）
                if (enable_aruco_depth_debug_) {
                    static ros::Time last_depth_print = ros::Time(0);
                    if ((ros::Time::now() - last_depth_print).toSec() > 3.0) {
                        printArucoDepthInfo();
                        last_depth_print = ros::Time::now();
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
            aruco_depth_.clear();  // 新增：清空深度信息
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
    
    // 新增：手动触发AUTO.LAND回调
    void manualAutolandCallback(const std_msgs::Bool::ConstPtr& msg) {
        manual_autoland_trigger_ = msg->data;
        if (manual_autoland_trigger_) {
            ROS_INFO("Manual AUTO.LAND trigger received");
        }
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
    // 新增：优化的高度信息打印函数
    void printHeightComparison() const {
        double aruco_height = getArucoHeight();
        double current_height = getCurrentHeight();
        
        // 检查各数据源状态
        bool lidar_fresh = lidar_available_ && 
                          (ros::Time::now() - last_lidar_time_).toSec() < lidar_timeout_;
        bool aruco_valid = (aruco_height > 0.1);
        
        // 构建简洁的状态字符串
        std::string status_str = "[";
        status_str += rel_alt_available_ ? "GPS✓" : "GPS✗";
        status_str += lidar_fresh ? " LiDAR✓" : " LiDAR✗";
        status_str += aruco_valid ? " ArUco✓" : " ArUco✗";
        status_str += "]";
        
        // 打印核心高度信息
        ROS_INFO("Heights: GPS=%.2fm, LiDAR=%.2fm, ArUco=%.2fm → Final=%.2fm %s", 
                 rel_alt_available_ ? rel_alt_ : -1.0,
                 lidar_fresh ? lidar_height_ : -1.0,
                 aruco_valid ? aruco_height : -1.0,
                 current_height,
                 status_str.c_str());
        
        // 如果启用详细调试，额外显示数据源信息
        if (enable_mode_debug_) {
            ROS_INFO("Height Source: %s (Priority: %d)", 
                     getHeightSourceInfo().c_str(), height_source_priority_);
        }
    }
    
    // 新增：优化的ArUco深度信息打印函数
    void printArucoDepthInfo() const {
        double aruco_height = getArucoHeight();
        if (aruco_height <= 0) {
            return;  // 没有有效的ArUco深度数据
        }
        
        std::string markers_info = "ArUco Depths: ";
        
        // 检查中心标记
        if (current_has_43 && first_43_idx >= 0) {
            markers_info += "ID43=" + std::to_string((int)(aruco_depth_[first_43_idx]*100)/100.0) + "m ";
        }
        if (current_has_19 && first_19_idx >= 0) {
            markers_info += "ID19=" + std::to_string((int)(aruco_depth_[first_19_idx]*100)/100.0) + "m ";
        }
        
        // 检查角落标记（如果可用）
        int corner_count = 0;
        double corner_avg_depth = 0.0;
        if (corner_markers_available_) {
            if (id_1_idx_ >= 0) { corner_avg_depth += aruco_depth_[id_1_idx_]; corner_count++; }
            if (id_2_idx_ >= 0) { corner_avg_depth += aruco_depth_[id_2_idx_]; corner_count++; }
            if (id_3_idx_ >= 0) { corner_avg_depth += aruco_depth_[id_3_idx_]; corner_count++; }
            if (id_4_idx_ >= 0) { corner_avg_depth += aruco_depth_[id_4_idx_]; corner_count++; }
            
            if (corner_count > 0) {
                corner_avg_depth /= corner_count;
                markers_info += "Corners(avg)=" + std::to_string((int)(corner_avg_depth*100)/100.0) + "m ";
            }
        }
        
        markers_info += "→ Used=" + std::to_string((int)(aruco_height*100)/100.0) + "m";
        
        ROS_INFO("%s", markers_info.c_str());
    }
    
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
        
        // 计算平台边界限制
        calculatePlatformBoundaries();
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
    
    // 计算平台边界限制（基于相对位置）
    void calculatePlatformBoundaries() {
        if (!corner_markers_available_) {
            platform_boundaries_valid_ = false;
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
        
        // 计算平台相对尺寸（基于当前检测到的四角标记）
        calculateRelativeBoundaryConstraints(x1, y1, x2, y2, x3, y3, x4, y4);
        
        platform_boundaries_valid_ = true;
        
        if(enable_boundary_debug_) {
            ROS_INFO_THROTTLE(3.0, "Platform relative boundaries calculated from current marker positions");
        }
    }
    
    // 基于当前检测到的四角标记计算相对边界约束
    void calculateRelativeBoundaryConstraints(double x1, double y1, double x2, double y2, 
                                            double x3, double y3, double x4, double y4) {
        // 计算平台的几何中心
        double center_x = (x1 + x2 + x3 + x4) / 4.0;
        double center_y = (y1 + y2 + y3 + y4) / 4.0;
        
        // 计算平台的相对尺寸（在当前视野中）
        double platform_width = std::max({x1, x2, x3, x4}) - std::min({x1, x2, x3, x4});
        double platform_height = std::max({y1, y2, y3, y4}) - std::min({y1, y2, y3, y4});
        
        // 存储平台几何信息用于边界计算
        platform_geometry_.center_x = center_x;
        platform_geometry_.center_y = center_y;
        platform_geometry_.width = platform_width;
        platform_geometry_.height = platform_height;
        
        // 计算相对于平台中心的四角点位置
        platform_geometry_.corner1_rel_x = x1 - center_x;
        platform_geometry_.corner1_rel_y = y1 - center_y;
        platform_geometry_.corner2_rel_x = x2 - center_x;
        platform_geometry_.corner2_rel_y = y2 - center_y;
        platform_geometry_.corner3_rel_x = x3 - center_x;
        platform_geometry_.corner3_rel_y = y3 - center_y;
        platform_geometry_.corner4_rel_x = x4 - center_x;
        platform_geometry_.corner4_rel_y = y4 - center_y;
        
        if(enable_boundary_debug_) {
            ROS_INFO_THROTTLE(3.0, "Platform geometry: center(%.3f,%.3f), size(%.3f x %.3f)", 
                     center_x, center_y, platform_width, platform_height);
        }
    }
    
    // 检查飞机相对位置是否在平台边界内
    bool isUAVPositionWithinPlatformBounds() const {
        if (!platform_boundaries_valid_ || !enable_boundary_limits_ || !corner_markers_available_) {
            return true;  // 如果边界无效或未启用，则不限制
        }
        
        // 计算飞机相对于平台中心的位置偏移
        double uav_offset_x, uav_offset_y;
        calculateUAVRelativePosition(uav_offset_x, uav_offset_y);
        
        if (use_polygon_bounds_) {
            // 使用多边形边界检查
            return isUAVOffsetInPlatformPolygon(uav_offset_x, uav_offset_y);
        } else {
            // 使用矩形边界检查
            double max_offset_x = platform_geometry_.width * (0.5 - boundary_safety_margin_);
            double max_offset_y = platform_geometry_.height * (0.5 - boundary_safety_margin_);
            
            return (std::abs(uav_offset_x) <= max_offset_x && 
                    std::abs(uav_offset_y) <= max_offset_y);
        }
    }
    
    // 计算飞机相对于平台中心的位置偏移
    void calculateUAVRelativePosition(double& offset_x, double& offset_y) const {
        // 图像中心 (0.5, 0.5) 表示飞机当前位置
        // 平台中心在图像中的位置
        double platform_center_x = platform_geometry_.center_x;
        double platform_center_y = platform_geometry_.center_y;
        
        // 计算飞机相对于平台中心的偏移（归一化坐标）
        offset_x = 0.5 - platform_center_x;  // 正值表示飞机在平台右侧
        offset_y = 0.5 - platform_center_y;  // 正值表示飞机在平台下方
    }
    
    // 检查飞机偏移是否在平台多边形边界内
    bool isUAVOffsetInPlatformPolygon(double offset_x, double offset_y) const {
        // 应用安全边距的平台顶点（相对于平台中心）
        std::vector<std::pair<double, double>> safe_vertices;
        
        double margin_factor = 1.0 - boundary_safety_margin_;
        
        safe_vertices.push_back({platform_geometry_.corner1_rel_x * margin_factor, 
                                platform_geometry_.corner1_rel_y * margin_factor});
        safe_vertices.push_back({platform_geometry_.corner4_rel_x * margin_factor, 
                                platform_geometry_.corner4_rel_y * margin_factor});
        safe_vertices.push_back({platform_geometry_.corner3_rel_x * margin_factor, 
                                platform_geometry_.corner3_rel_y * margin_factor});
        safe_vertices.push_back({platform_geometry_.corner2_rel_x * margin_factor, 
                                platform_geometry_.corner2_rel_y * margin_factor});
        
        // 使用射线法检测点是否在多边形内
        return pointInPolygon(offset_x, offset_y, safe_vertices);
    }
    
    // 通用射线法检测点在多边形内
    bool pointInPolygon(double x, double y, const std::vector<std::pair<double, double>>& vertices) const {
        bool inside = false;
        int n = vertices.size();
        
        for (int i = 0, j = n - 1; i < n; j = i++) {
            double xi = vertices[i].first;
            double yi = vertices[i].second;
            double xj = vertices[j].first;
            double yj = vertices[j].second;
            
            if (((yi > y) != (yj > y)) && 
                (x < (xj - xi) * (y - yi) / (yj - yi) + xi)) {
                inside = !inside;
            }
        }
        
        return inside;
    }
    
    // 点在多边形内检测算法（射线法）- 兼容旧接口
    bool isPointInPolygon(double x, double y) const {
        if (!corner_markers_available_) {
            return true;
        }
        
        // 获取四角标记坐标（应用安全边距）
        std::vector<std::pair<double, double>> polygon_vertices;
        
        double x1 = aruco_center_x_[id_1_idx_];  // 左前角 (ID1)
        double y1 = aruco_center_y_[id_1_idx_];
        double x2 = aruco_center_x_[id_2_idx_];  // 左后角 (ID2)  
        double y2 = aruco_center_y_[id_2_idx_];
        double x3 = aruco_center_x_[id_3_idx_];  // 右后角 (ID3)
        double y3 = aruco_center_y_[id_3_idx_];
        double x4 = aruco_center_x_[id_4_idx_];  // 右前角 (ID4)
        double y4 = aruco_center_y_[id_4_idx_];
        
        // 计算内缩多边形（应用安全边距）
        double center_x = (x1 + x2 + x3 + x4) / 4.0;
        double center_y = (y1 + y2 + y3 + y4) / 4.0;
        
        // 将各顶点向中心移动安全边距
        x1 = x1 + (center_x - x1) * boundary_safety_margin_;
        y1 = y1 + (center_y - y1) * boundary_safety_margin_;
        x2 = x2 + (center_x - x2) * boundary_safety_margin_;
        y2 = y2 + (center_y - y2) * boundary_safety_margin_;
        x3 = x3 + (center_x - x3) * boundary_safety_margin_;
        y3 = y3 + (center_y - y3) * boundary_safety_margin_;
        x4 = x4 + (center_x - x4) * boundary_safety_margin_;
        y4 = y4 + (center_y - y4) * boundary_safety_margin_;
        
        // 按顺序添加顶点（顺时针或逆时针）
        polygon_vertices.push_back({x1, y1});  // 左前角
        polygon_vertices.push_back({x4, y4});  // 右前角
        polygon_vertices.push_back({x3, y3});  // 右后角
        polygon_vertices.push_back({x2, y2});  // 左后角
        
        // 使用射线法检测点是否在多边形内
        bool inside = false;
        int n = polygon_vertices.size();
        
        for (int i = 0, j = n - 1; i < n; j = i++) {
            double xi = polygon_vertices[i].first;
            double yi = polygon_vertices[i].second;
            double xj = polygon_vertices[j].first;
            double yj = polygon_vertices[j].second;
            
            if (((yi > y) != (yj > y)) && 
                (x < (xj - xi) * (y - yi) / (yj - yi) + xi)) {
                inside = !inside;
            }
        }
        
        return inside;
    }
    
    // 将位置限制在边界内
    std::pair<double, double> constrainPositionToBounds(double x, double y) const {
        if (!platform_boundaries_valid_ || !enable_boundary_limits_) {
            return {x, y};  // 如果边界无效或未启用，则不限制
        }
        
        if (use_polygon_bounds_ && corner_markers_available_) {
            // 如果点在多边形内，直接返回
            if (isPointInPolygon(x, y)) {
                return {x, y};
            }
            
            // 如果点在多边形外，找到最近的边界点
            return findNearestBoundaryPoint(x, y);
        } else {
            // 使用简单的矩形约束
            double constrained_x = std::clamp(x, platform_bounds_.min_x, platform_bounds_.max_x);
            double constrained_y = std::clamp(y, platform_bounds_.min_y, platform_bounds_.max_y);
            return {constrained_x, constrained_y};
        }
    }
    
    // 找到多边形边界上距离给定点最近的点
    std::pair<double, double> findNearestBoundaryPoint(double x, double y) const {
        if (!corner_markers_available_) {
            return {x, y};
        }
        
        // 获取多边形顶点（应用安全边距）
        std::vector<std::pair<double, double>> vertices = getPolygonVertices();
        
        double min_distance = std::numeric_limits<double>::max();
        std::pair<double, double> nearest_point = {x, y};
        
        // 检查每条边，找到最近的点
        for (size_t i = 0; i < vertices.size(); ++i) {
            size_t next = (i + 1) % vertices.size();
            
            auto closest_on_edge = closestPointOnLineSegment(
                x, y,
                vertices[i].first, vertices[i].second,
                vertices[next].first, vertices[next].second
            );
            
            double distance = std::sqrt(
                std::pow(closest_on_edge.first - x, 2) + 
                std::pow(closest_on_edge.second - y, 2)
            );
            
            if (distance < min_distance) {
                min_distance = distance;
                nearest_point = closest_on_edge;
            }
        }
        
        return nearest_point;
    }
    
    // 获取多边形顶点（应用安全边距）
    std::vector<std::pair<double, double>> getPolygonVertices() const {
        std::vector<std::pair<double, double>> vertices;
        
        double x1 = aruco_center_x_[id_1_idx_];  // 左前角 (ID1)
        double y1 = aruco_center_y_[id_1_idx_];
        double x2 = aruco_center_x_[id_2_idx_];  // 左后角 (ID2)  
        double y2 = aruco_center_y_[id_2_idx_];
        double x3 = aruco_center_x_[id_3_idx_];  // 右后角 (ID3)
        double y3 = aruco_center_y_[id_3_idx_];
        double x4 = aruco_center_x_[id_4_idx_];  // 右前角 (ID4)
        double y4 = aruco_center_y_[id_4_idx_];
        
        // 计算多边形中心
        double center_x = (x1 + x2 + x3 + x4) / 4.0;
        double center_y = (y1 + y2 + y3 + y4) / 4.0;
        
        // 将各顶点向中心移动安全边距
        x1 = x1 + (center_x - x1) * boundary_safety_margin_;
        y1 = y1 + (center_y - y1) * boundary_safety_margin_;
        x2 = x2 + (center_x - x2) * boundary_safety_margin_;
        y2 = y2 + (center_y - y2) * boundary_safety_margin_;
        x3 = x3 + (center_x - x3) * boundary_safety_margin_;
        y3 = y3 + (center_y - y3) * boundary_safety_margin_;
        x4 = x4 + (center_x - x4) * boundary_safety_margin_;
        y4 = y4 + (center_y - y4) * boundary_safety_margin_;
        
        // 按顺序添加顶点
        vertices.push_back({x1, y1});  // 左前角
        vertices.push_back({x4, y4});  // 右前角
        vertices.push_back({x3, y3});  // 右后角
        vertices.push_back({x2, y2});  // 左后角
        
        return vertices;
    }
    
    // 计算点到线段的最近点
    std::pair<double, double> closestPointOnLineSegment(
        double px, double py,      // 目标点
        double x1, double y1,      // 线段起点
        double x2, double y2       // 线段终点
    ) const {
        double dx = x2 - x1;
        double dy = y2 - y1;
        
        if (dx == 0 && dy == 0) {
            // 线段退化为点
            return {x1, y1};
        }
        
        // 计算投影参数t
        double t = ((px - x1) * dx + (py - y1) * dy) / (dx * dx + dy * dy);
        
        // 将t限制在[0,1]范围内
        t = std::clamp(t, 0.0, 1.0);
        
        // 计算投影点
        double closest_x = x1 + t * dx;
        double closest_y = y1 + t * dy;
        
        return {closest_x, closest_y};
    }
    
    // 检查飞机位置并应用边界约束
    void applyUAVBoundaryConstraints() {
        if (!enable_boundary_limits_ || !platform_boundaries_valid_ || !corner_markers_available_) {
            boundary_constraint_active_ = false;
            return;
        }
        
        // 检查飞机是否在平台边界内
        bool within_bounds = isUAVPositionWithinPlatformBounds();
        
        if (!within_bounds) {
            // 飞机超出边界，激活约束
            boundary_constraint_active_ = true;
            
            // 计算约束方向（朝向平台中心）
            double uav_offset_x, uav_offset_y;
            calculateUAVRelativePosition(uav_offset_x, uav_offset_y);
            
            // 计算约束强度（距离边界越远，约束越强）
            double constraint_strength = calculateConstraintStrength(uav_offset_x, uav_offset_y);
            
            // 存储约束信息供控制器使用
            boundary_constraint_.direction_x = -uav_offset_x;  // 朝向平台中心
            boundary_constraint_.direction_y = -uav_offset_y;
            boundary_constraint_.strength = constraint_strength;
            
            if(enable_boundary_debug_) {
                ROS_WARN_THROTTLE(1.0, "UAV out of bounds! Offset: (%.3f, %.3f), Constraint: (%.3f, %.3f), Strength: %.3f", 
                         uav_offset_x, uav_offset_y, 
                         boundary_constraint_.direction_x, boundary_constraint_.direction_y,
                         constraint_strength);
            }
        } else {
            boundary_constraint_active_ = false;
        }
    }
    
    // 计算约束强度
    double calculateConstraintStrength(double offset_x, double offset_y) const {
        // 计算飞机距离平台中心的距离
        double distance = std::sqrt(offset_x * offset_x + offset_y * offset_y);
        
        // 计算平台的特征尺寸
        double platform_size = std::sqrt(platform_geometry_.width * platform_geometry_.width + 
                                       platform_geometry_.height * platform_geometry_.height) / 2.0;
        
        // 归一化距离
        double normalized_distance = distance / platform_size;
        
        // 约束强度：距离越远，约束越强
        return std::clamp(normalized_distance * boundary_constraint_gain_, 0.0, 1.0);
    }
    
    // 获取边界约束控制输出
    std::pair<double, double> getBoundaryConstraintOutput() const {
        if (!boundary_constraint_active_) {
            return {0.0, 0.0};
        }
        
        double constraint_x = boundary_constraint_.direction_x * boundary_constraint_.strength * max_boundary_control_output_;
        double constraint_y = boundary_constraint_.direction_y * boundary_constraint_.strength * max_boundary_control_output_;
        
        return {constraint_x, constraint_y};
    }
    
    // 部分角落标记引导系统
    bool hasPartialCornerMarkers() const {
        return !detected_corner_markers_.empty() && !corner_markers_available_;
    }
    
    // 基于部分角落标记计算引导指令
    std::pair<double, double> calculatePartialCornerGuidance() const {
        if (!hasPartialCornerMarkers()) {
            return {0.0, 0.0};
        }
        
        double guidance_x = 0.0, guidance_y = 0.0;
        int marker_count = detected_corner_markers_.size();
        
        if (marker_count == 1) {
            // 单个标记引导
            calculateSingleMarkerGuidance(guidance_x, guidance_y);
        } else if (marker_count == 2) {
            // 两个标记引导
            calculateDualMarkerGuidance(guidance_x, guidance_y);
        } else if (marker_count == 3) {
            // 三个标记引导
            calculateTripleMarkerGuidance(guidance_x, guidance_y);
        }
        
        return {guidance_x, guidance_y};
    }
    
    // 单个标记引导逻辑
    void calculateSingleMarkerGuidance(double& guidance_x, double& guidance_y) const {
        const auto& marker = detected_corner_markers_[0];
        int marker_id = marker.first;
        int marker_idx = marker.second;
        
        double marker_x = aruco_center_x_[marker_idx];
        double marker_y = aruco_center_y_[marker_idx];
        
        // 根据标记ID确定理想的相对位置
        auto ideal_position = getIdealUAVPositionForMarker(marker_id);
        
        // 计算当前相对位置
        double current_rel_x = 0.5 - marker_x;  // 飞机相对于标记的位置
        double current_rel_y = 0.5 - marker_y;
        
        // 计算引导方向（朝向理想位置）
        guidance_x = (ideal_position.rel_x - current_rel_x) * partial_guidance_gain_;
        guidance_y = (ideal_position.rel_y - current_rel_y) * partial_guidance_gain_;
        
        if(enable_boundary_debug_) {
            ROS_INFO_THROTTLE(2.0, "Single marker guidance: ID%d at (%.3f,%.3f), target rel(%.3f,%.3f), guidance(%.3f,%.3f)", 
                     marker_id, marker_x, marker_y, 
                     ideal_position.rel_x, ideal_position.rel_y, guidance_x, guidance_y);
        }
    }
    
    // 两个标记引导逻辑
    void calculateDualMarkerGuidance(double& guidance_x, double& guidance_y) const {
        std::vector<int> marker_ids;
        std::vector<std::pair<double, double>> marker_positions;
        
        for (const auto& marker : detected_corner_markers_) {
            marker_ids.push_back(marker.first);
            int idx = marker.second;
            marker_positions.push_back({aruco_center_x_[idx], aruco_center_y_[idx]});
        }
        
        // 基于两个标记推断平台朝向和理想位置
        auto platform_info = estimatePlatformFromTwoMarkers(marker_ids, marker_positions);
        
        if (platform_info.valid) {
            // 计算朝向平台中心的引导
            double current_rel_x = 0.5 - platform_info.estimated_center_x;
            double current_rel_y = 0.5 - platform_info.estimated_center_y;
            
            guidance_x = -current_rel_x * partial_guidance_gain_;
            guidance_y = -current_rel_y * partial_guidance_gain_;
            
            if(enable_boundary_debug_) {
                ROS_INFO_THROTTLE(2.0, "Dual marker guidance: estimated center(%.3f,%.3f), guidance(%.3f,%.3f)", 
                         platform_info.estimated_center_x, platform_info.estimated_center_y, guidance_x, guidance_y);
            }
        }
    }
    
    // 三个标记引导逻辑
    void calculateTripleMarkerGuidance(double& guidance_x, double& guidance_y) const {
        std::vector<int> marker_ids;
        std::vector<std::pair<double, double>> marker_positions;
        
        for (const auto& marker : detected_corner_markers_) {
            marker_ids.push_back(marker.first);
            int idx = marker.second;
            marker_positions.push_back({aruco_center_x_[idx], aruco_center_y_[idx]});
        }
        
        // 基于三个标记推断平台位置和朝向
        auto platform_info = estimatePlatformFromThreeMarkers(marker_ids, marker_positions);
        
        if (platform_info.valid) {
            // 高精度引导到平台中心
            double current_rel_x = 0.5 - platform_info.estimated_center_x;
            double current_rel_y = 0.5 - platform_info.estimated_center_y;
            
            guidance_x = -current_rel_x * partial_guidance_gain_;
            guidance_y = -current_rel_y * partial_guidance_gain_;
            
            if(enable_boundary_debug_) {
                ROS_INFO_THROTTLE(2.0, "Triple marker guidance: estimated center(%.3f,%.3f), yaw=%.1f°, guidance(%.3f,%.3f)", 
                         platform_info.estimated_center_x, platform_info.estimated_center_y,
                         platform_info.estimated_yaw * 180.0 / M_PI, guidance_x, guidance_y);
            }
        }
    }
    
    // 标记的理想飞机位置
    struct IdealPosition {
        double rel_x, rel_y;  // 飞机相对于标记的理想位置
        std::string description;
    };
    
    IdealPosition getIdealUAVPositionForMarker(int marker_id) const {
        // 基于标记ID和预期的平台布局，确定飞机应该相对于该标记的理想位置
        switch(marker_id) {
            case 1:  // 左前角 - 飞机应该在平台中心方向（右下方）
                return {0.25, 0.35, "左前角引导"};
            case 2:  // 左后角 - 飞机应该在平台中心方向（右上方）  
                return {0.25, -0.35, "左后角引导"};
            case 3:  // 右后角 - 飞机应该在平台中心方向（左上方）
                return {-0.25, -0.35, "右后角引导"};
            case 4:  // 右前角 - 飞机应该在平台中心方向（左下方）
                return {-0.25, 0.35, "右前角引导"};
            default:
                return {0.0, 0.0, "未知标记"};
        }
    }
    
    // 平台估计信息
    struct PlatformEstimate {
        bool valid;
        double estimated_center_x, estimated_center_y;
        double estimated_yaw;
        double confidence;
    };
    
    // 基于两个标记估计平台信息
    PlatformEstimate estimatePlatformFromTwoMarkers(const std::vector<int>& ids, 
                                                   const std::vector<std::pair<double, double>>& positions) const {
        PlatformEstimate estimate;
        estimate.valid = false;
        
        if (ids.size() != 2 || positions.size() != 2) {
            return estimate;
        }
        
        int id1 = ids[0], id2 = ids[1];
        auto pos1 = positions[0], pos2 = positions[1];
        
        // 根据两个标记的组合推断平台中心
        if ((id1 == 1 && id2 == 3) || (id1 == 3 && id2 == 1)) {
            // 对角线：左前角 + 右后角
            estimate.estimated_center_x = (pos1.first + pos2.first) / 2.0;
            estimate.estimated_center_y = (pos1.second + pos2.second) / 2.0;
            estimate.confidence = 0.9;  // 高置信度
        } else if ((id1 == 2 && id2 == 4) || (id1 == 4 && id2 == 2)) {
            // 对角线：左后角 + 右前角
            estimate.estimated_center_x = (pos1.first + pos2.first) / 2.0;
            estimate.estimated_center_y = (pos1.second + pos2.second) / 2.0;
            estimate.confidence = 0.9;
        } else {
            // 相邻边的标记，使用几何推算
            estimate.estimated_center_x = (pos1.first + pos2.first) / 2.0;
            estimate.estimated_center_y = (pos1.second + pos2.second) / 2.0;
            estimate.confidence = 0.7;  // 中等置信度
        }
        
        estimate.valid = true;
        return estimate;
    }
    
    // 基于三个标记估计平台信息
    PlatformEstimate estimatePlatformFromThreeMarkers(const std::vector<int>& ids, 
                                                      const std::vector<std::pair<double, double>>& positions) const {
        PlatformEstimate estimate;
        estimate.valid = false;
        
        if (ids.size() != 3 || positions.size() != 3) {
            return estimate;
        }
        
        // 用三个已知点计算第四个点和平台中心
        // 根据缺失的角点推算平台几何
        int missing_id = 0;
        for (int i = 1; i <= 4; i++) {
            bool found = false;
            for (int id : ids) {
                if (id == i) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                missing_id = i;
                break;
            }
        }
        
        // 基于三个已知点的质心作为平台中心的近似
        double sum_x = 0, sum_y = 0;
        for (const auto& pos : positions) {
            sum_x += pos.first;
            sum_y += pos.second;
        }
        
        // 调整质心以补偿缺失的第四个点
        double adjustment_factor = 4.0 / 3.0;  // 从3点质心推算4点质心
        estimate.estimated_center_x = sum_x / 3.0;
        estimate.estimated_center_y = sum_y / 3.0;
        
        // 尝试计算朝向（如果有足够的几何信息）
        if (positions.size() >= 2) {
            // 使用前两个点估算朝向
            double dx = positions[1].first - positions[0].first;
            double dy = positions[1].second - positions[0].second;
            estimate.estimated_yaw = atan2(-dy, dx);
        }
        
        estimate.confidence = 0.8;  // 较高置信度
        estimate.valid = true;
        
        return estimate;
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
        
        // 高度阈值参数（调整为更实际的高度范围）
        nh_.param("/mission_aruco_land_node/height_rough_land", HEIGHT_ROUGH_LAND, 15.0);  // 粗降落：15米以上
        nh_.param("/mission_aruco_land_node/height_fine_land", HEIGHT_FINE_LAND, 3.0);    // 精降落：3米以上
        
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
        nh_.param("/mission_aruco_land_node/yaw_control/max_yaw_rate", max_yaw_rate_, 0.5);
        nh_.param("/mission_aruco_land_node/yaw_control/yaw_p_gain", yaw_p_gain_, 1.0);
        nh_.param("/mission_aruco_land_node/yaw_control/yaw_i_gain", yaw_i_gain_, 0.1);
        nh_.param("/mission_aruco_land_node/yaw_control/yaw_d_gain", yaw_d_gain_, 0.2);
        nh_.param("/mission_aruco_land_node/yaw_control/target_east_yaw", target_east_yaw_, 0.0);
        nh_.param("/mission_aruco_land_node/yaw_control/enable_yaw_control", enable_yaw_control_, true);
        
        // 偏航控制模式参数
        int yaw_mode_int;
        nh_.param("/mission_aruco_land_node/yaw_control/yaw_control_mode", yaw_mode_int, 0);
        yaw_control_mode_ = static_cast<YawControlMode>(yaw_mode_int);
        nh_.param("/mission_aruco_land_node/yaw_control/enable_aruco_yaw_tracking", enable_aruco_yaw_tracking_, false);
        nh_.param("/mission_aruco_land_node/yaw_control/yaw_tracking_source", yaw_tracking_source_, std::string("takeoff"));
        nh_.param("/mission_aruco_land_node/yaw_control/max_rate_change", max_yaw_rate_change_, 0.2);
        nh_.param("/mission_aruco_land_node/yaw_control/abnormal_rate_threshold", abnormal_rate_threshold_, 2.0);
        nh_.param("/mission_aruco_land_node/yaw_control/yaw_tolerance", yaw_tolerance_, 0.087);
        nh_.param("/mission_aruco_land_node/yaw_control/enable_yaw_debug", enable_yaw_debug_, true);
        nh_.param("/mission_aruco_land_node/yaw_control/debug_print_interval", yaw_debug_print_interval_, 3.0);
        
        // AUTO.LAND触发参数
        nh_.param("/mission_aruco_land_node/autoland_trigger/enable_height_trigger", enable_height_trigger_, true);
        nh_.param("/mission_aruco_land_node/autoland_trigger/enable_time_trigger", enable_time_trigger_, true);
        nh_.param("/mission_aruco_land_node/autoland_trigger/enable_accuracy_trigger", enable_accuracy_trigger_, true);
        nh_.param("/mission_aruco_land_node/autoland_trigger/auto_land_time_threshold", auto_land_time_threshold_, 15.0);
        nh_.param("/mission_aruco_land_node/autoland_trigger/position_accuracy_threshold", position_accuracy_threshold_, 0.10);
        
        // 安全参数
        nh_.param("/mission_aruco_land_node/safety/offboard_check_interval", offboard_check_interval_, 1.0);
        nh_.param("/mission_aruco_land_node/safety/status_print_interval", status_print_interval_, 2.0);
        nh_.param("/mission_aruco_land_node/safety/param_print_interval", param_print_interval_, 3.0);
        nh_.param("/mission_aruco_land_node/safety/height_print_interval", height_print_interval_, 5.0);
        
        // 激光测距参数
        nh_.param("/mission_aruco_land_node/height_source_priority", height_source_priority_, 1);
        nh_.param("/mission_aruco_land_node/lidar/enable", lidar_enable_, true);
        nh_.param("/mission_aruco_land_node/lidar/topic_name", lidar_topic_, 
                  std::string("/uav2/mavros/distance_sensor/hrlv_ez4_pub"));
        nh_.param("/mission_aruco_land_node/lidar/timeout", lidar_timeout_, 2.0);
        nh_.param("/mission_aruco_land_node/lidar/noise_threshold", lidar_noise_threshold_, 0.5);  // 放宽噪声阈值
        nh_.param("/mission_aruco_land_node/lidar/fusion_weight", lidar_fusion_weight_, 0.8);
        
        // ArUco深度数据参数
        nh_.param("/mission_aruco_land_node/aruco_depth/enable", aruco_depth_enable_, true);
        nh_.param("/mission_aruco_land_node/aruco_depth/min_valid_depth", aruco_min_depth_, 0.1);
        nh_.param("/mission_aruco_land_node/aruco_depth/max_valid_depth", aruco_max_depth_, 50.0);
        nh_.param("/mission_aruco_land_node/aruco_depth/depth_weight", aruco_depth_weight_, 0.8);
        nh_.param("/mission_aruco_land_node/aruco_depth/lidar_weight", aruco_lidar_weight_, 0.6);
        nh_.param("/mission_aruco_land_node/aruco_depth/gps_weight", aruco_gps_weight_, 0.4);
        nh_.param("/mission_aruco_land_node/aruco_depth/enable_depth_debug", enable_aruco_depth_debug_, true);
        
        // 调试参数
        nh_.param("/mission_aruco_land_node/debug/enable_coordinate_transform_test", enable_coordinate_transform_test_, true);
        nh_.param("/mission_aruco_land_node/debug/enable_aruco_detection_debug", enable_aruco_detection_debug_, true);
        nh_.param("/mission_aruco_land_node/debug/enable_pid_debug", enable_pid_debug_, true);
        nh_.param("/mission_aruco_land_node/debug/enable_mode_debug", enable_mode_debug_, true);
        nh_.param("/mission_aruco_land_node/debug/enable_lidar_debug", enable_lidar_debug_, true);
        
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
        
        // 边界限制参数
        nh_.param("/mission_aruco_land_node/boundary_limits/enable", enable_boundary_limits_, true);
        nh_.param("/mission_aruco_land_node/boundary_limits/safety_margin", boundary_safety_margin_, 0.05);
        nh_.param("/mission_aruco_land_node/boundary_limits/enable_debug", enable_boundary_debug_, true);
        nh_.param("/mission_aruco_land_node/boundary_limits/use_polygon_bounds", use_polygon_bounds_, true);
        nh_.param("/mission_aruco_land_node/boundary_limits/constraint_gain", boundary_constraint_gain_, 2.0);
        nh_.param("/mission_aruco_land_node/boundary_limits/max_control_output", max_boundary_control_output_, 0.3);
        
        // 部分角落标记引导参数
        nh_.param("/mission_aruco_land_node/partial_corner_guidance/enable", partial_guidance_enable_, true);
        nh_.param("/mission_aruco_land_node/partial_corner_guidance/guidance_gain", partial_guidance_gain_, 1.5);
        nh_.param("/mission_aruco_land_node/partial_corner_guidance/conservatism_factor", partial_guidance_conservatism_, 0.8);
        nh_.param("/mission_aruco_land_node/partial_corner_guidance/max_vel_high", partial_guidance_max_vel_high_, 0.25);
        nh_.param("/mission_aruco_land_node/partial_corner_guidance/max_vel_low", partial_guidance_max_vel_low_, 0.15);
        nh_.param("/mission_aruco_land_node/partial_corner_guidance/z_vel_high", partial_guidance_z_vel_high_, -0.3);
        nh_.param("/mission_aruco_land_node/partial_corner_guidance/z_vel_medium", partial_guidance_z_vel_medium_, -0.2);
        nh_.param("/mission_aruco_land_node/partial_corner_guidance/z_vel_low", partial_guidance_z_vel_low_, -0.1);
        
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
        if (height > 10.0) {
            height_factor = height_factors_.very_high;      // 高空：更激进
        } else if (height > 5.0) {
            height_factor = height_factors_.high;           // 中高空：稍激进
        } else if (height > 3.0) {
            height_factor = height_factors_.medium;         // 中空：保守
        } else {
            height_factor = height_factors_.low;            // 低空：非常保守
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
            case LandingMode::PARTIAL_CORNER_GUIDED:
                mode_factor = 0.75;                       // 部分角落引导：非常保守
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
        
        // 检查是否应该触发AUTO.LAND模式（多种触发条件）
        if (shouldTriggerAutoLand(current_height)) {
            current_mode_ = LandingMode::PX4_LAND;
            ROS_INFO("Triggering AUTO.LAND: height=%.2fm", current_height);
            return;
        }
        
        // 根据高度和可用标记确定降落模式
        if(current_height > HEIGHT_ROUGH_LAND) {
            // 高度 > 15.0m：粗降落模式
            determineRoughLandingTarget();
        } 
        else if(current_height > HEIGHT_FINE_LAND && current_height <= HEIGHT_ROUGH_LAND) {
            // 3.0m < 高度 <= 15.0m：精降落模式
            determineFineLandingTarget();
        }
        else {
            // 默认：继续精降落模式或悬停
            determineFineLandingTarget();
        }
    }
    
    // 新增：判断是否应该触发AUTO.LAND的多种条件
    bool shouldTriggerAutoLand(double current_height) {
        static ros::Time fine_landing_start_time = ros::Time(0);
        static bool fine_landing_started = false;
        
        // 方式1：传统高度触发（如果启用）
        if (enable_height_trigger_ && current_height <= HEIGHT_FINE_LAND) {
            return true;
        }
        
        // 方式2：时间触发 - 精降落模式持续一定时间后自动切换
        if (enable_time_trigger_ && current_mode_ == LandingMode::FINE_LAND) {
            if (!fine_landing_started) {
                fine_landing_start_time = ros::Time::now();
                fine_landing_started = true;
            }
            
            double fine_landing_duration = (ros::Time::now() - fine_landing_start_time).toSec();
            if (fine_landing_duration > auto_land_time_threshold_) {
                ROS_INFO("Time-based AUTO.LAND trigger: %.1fs in fine landing", fine_landing_duration);
                fine_landing_started = false;
                return true;
            }
        }
        
        // 方式3：位置精度触发 - 当位置误差足够小且稳定时
        if (enable_accuracy_trigger_ && checkPositionAccuracy()) {
            ROS_INFO("Accuracy-based AUTO.LAND trigger: position stable and accurate");
            return true;
        }
        
        // 方式4：手动触发 - 通过话题或服务
        if (manual_autoland_trigger_) {
            ROS_INFO("Manual AUTO.LAND trigger received");
            manual_autoland_trigger_ = false; // 重置标志
            return true;
        }
        
        return false;
    }
    
    // 新增：检查位置精度是否满足AUTO.LAND条件
    bool checkPositionAccuracy() {
        if (!is_aruco_detected_ || (!current_has_19 && !current_has_43)) {
            return false;
        }
        
        int target_idx = current_has_43 ? first_43_idx : first_19_idx;
        if (target_idx < 0) return false;
        
        double error_x = -(aruco_center_x_[target_idx] - 0.5);
        double error_y = -(aruco_center_y_[target_idx] - 0.5);
        double position_error = sqrt(error_x * error_x + error_y * error_y);
        
        // 检查位置误差是否在阈值内
        static std::vector<double> error_history;
        static const size_t history_size = 10; // 保存最近10次的误差
        
        error_history.push_back(position_error);
        if (error_history.size() > history_size) {
            error_history.erase(error_history.begin());
        }
        
        // 需要至少5次稳定的数据
        if (error_history.size() < 5) return false;
        
        // 检查最近的误差是否都在阈值内
        bool all_accurate = true;
        for (double err : error_history) {
            if (err > position_accuracy_threshold_) {
                all_accurate = false;
                break;
            }
        }
        
        return all_accurate;
    }
    
    // 更新降落策略
    void updateLandingStrategy() {
        // 根据可用标记自动调整策略
        bool has_center_markers = (current_has_19 || current_has_43);
        bool has_partial_corners = hasPartialCornerMarkers();
        
        if (corner_markers_available_ && has_center_markers) {
            landing_strategy_ = LandingStrategy::HYBRID_STRATEGY;
        } else if (corner_markers_available_) {
            landing_strategy_ = LandingStrategy::CORNER_MARKERS_ONLY;
        } else if (has_partial_corners) {
            // 部分角落标记引导模式
            current_mode_ = LandingMode::PARTIAL_CORNER_GUIDED;
            return;
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
                
            case LandingMode::PARTIAL_CORNER_GUIDED:
                executePartialCornerGuidedMode(dt);
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
        
        // 粗降落模式Z轴控制逻辑（针对15.0m以上高度）
        double output_z;
        if (current_height > 20.0) {
            // 超高空快速下降
            output_z = rough_land_params_.z_vel_high;  
        } else if (current_height > 10.0) {
            // 高空适中下降
            output_z = rough_land_params_.z_vel_medium;
        } else if (current_height > 5.0) {
            // 中等高度缓慢下降（二维码开始清晰可见）
            output_z = rough_land_params_.z_vel_approach;
        } else {
            // 接近精降落阈值时极慢下降
            output_z = rough_land_params_.z_vel_transition;
        }
        
        // 自适应输出限制（根据高度调整最大速度）
        double max_vel = (current_height > 10.0) ? rough_land_params_.max_vel_high : 
                        (current_height > 5.0) ? rough_land_params_.max_vel_medium : 
                        rough_land_params_.max_vel_low;
        output_x = std::clamp(output_x, -max_vel, max_vel);
        output_y = std::clamp(output_y, -max_vel, max_vel);
        
        // 计算偏航角速率并发布所有控制量（保持起飞时朝向）
        float target_yaw = getTargetYaw();  // 使用起飞时记录的朝向
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
        
        // 精降落模式Z轴控制逻辑（针对3.0m以下高度）
        double output_z;
        if (current_height > 2.5) {
            output_z = fine_land_params_.z_vel_upper;  // 精降落上段，适中下降
        } else if (current_height > 2.0) {
            output_z = fine_land_params_.z_vel_middle;   // 精降落中段，稍慢下降
        } else if (current_height > 1.0) {
            output_z = fine_land_params_.z_vel_lower;  // 低空慢速下降
        } else {
            output_z = fine_land_params_.z_vel_final;   // 极低空极慢下降
        }
        
        // 精降落模式的自适应输出限制（更保守）
        double max_vel = (current_height > 2.0) ? fine_land_params_.max_vel_upper : 
                        (current_height > 1.5) ? fine_land_params_.max_vel_middle : 
                        fine_land_params_.max_vel_lower;
        output_x = std::clamp(output_x, -max_vel, max_vel);
        output_y = std::clamp(output_y, -max_vel, max_vel);
        
        // 计算偏航角速率并发布MAVROS速度控制命令（保持起飞时朝向）
        float target_yaw = getTargetYaw();  // 使用起飞时记录的朝向
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
        
        // 应用飞机边界约束检查
        applyUAVBoundaryConstraints();
        
        // 计算基础控制误差 (平台中心相对于图像中心)
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
        
        // 添加边界约束控制输出
        auto boundary_control = getBoundaryConstraintOutput();
        output_x += boundary_control.first;
        output_y += boundary_control.second;
        
        // 基于四角标记的Z轴控制 (更保守的下降速度)
        double output_z;
        if (current_height > 8.0) {
            output_z = -0.6;  // 高空较快下降
        } else if (current_height > 5.0) {
            output_z = -0.4;  // 中高空稳定下降
        } else if (current_height > 3.0) {
            output_z = -0.3;  // 中空缓慢下降
        } else if (current_height > 1.5) {
            output_z = -0.2;  // 低空慢速下降
        } else {
            output_z = -0.1;  // 极低空安全下降
        }
        
        // 保守的输出限制
        double max_vel = (current_height > 5.0) ? 0.4 : (current_height > 3.0) ? 0.3 : 0.2;
        output_x = std::clamp(output_x, -max_vel, max_vel);
        output_y = std::clamp(output_y, -max_vel, max_vel);
        
        // 使用平台朝向进行偏航控制（保持起飞时朝向或使用二维码朝向）
        float target_yaw = getTargetYaw();
        
        // 如果启用二维码朝向跟踪，使用平台朝向调整
        if (enable_aruco_yaw_tracking_ && platform_yaw_valid_) {
            // 使用二维码平台的朝向信息进行调整
            target_yaw = platform_yaw_ + takeoff_yaw_;  // 平台朝向 + 起飞朝向偏移
            target_yaw = geometry_utils::normalize_angle(target_yaw);
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
            // 应用飞机边界约束检查
            applyUAVBoundaryConstraints();
            
            double error_x = -(platform_center_x_ - 0.5);
            double error_y = -(platform_center_y_ - 0.5);
            
            // 自适应PID参数计算
            double error_magnitude = sqrt(error_x*error_x + error_y*error_y);
            AdaptivePIDParams adaptive_params = calculateAdaptivePID(current_height, error_magnitude, LandingMode::HYBRID_LAND);
            
            pid_x_.setGains(adaptive_params.kp_x, adaptive_params.ki_x, adaptive_params.kd_x);
            pid_y_.setGains(adaptive_params.kp_y, adaptive_params.ki_y, adaptive_params.kd_y);
            
            output_x = pid_x_.compute(error_x, dt);
            output_y = pid_y_.compute(error_y, dt);
            
            // 添加边界约束控制输出
            auto boundary_control = getBoundaryConstraintOutput();
            output_x += boundary_control.first;
            output_y += boundary_control.second;
            
            // 使用平台朝向进行偏航控制
            if (enable_aruco_yaw_tracking_ && platform_yaw_valid_) {
                // 使用二维码平台朝向 + 起飞朝向偏移
                target_yaw = platform_yaw_ + takeoff_yaw_;
                target_yaw = geometry_utils::normalize_angle(target_yaw);
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
        if (current_height > 8.0) {
            output_z = -0.5;   // 高空适中下降
        } else if (current_height > 5.0) {
            output_z = -0.35;  // 中高空缓慢下降
        } else if (current_height > 3.0) {
            output_z = -0.25;  // 中空慢速下降
        } else if (current_height > 1.5) {
            output_z = -0.15;  // 低空极慢下降
        } else {
            output_z = -0.1;   // 极低空安全下降
        }
        
        // 输出限制
        double max_vel = (current_height > 5.0) ? 0.4 : (current_height > 3.0) ? 0.25 : 0.2;
        output_x = std::clamp(output_x, -max_vel, max_vel);
        output_y = std::clamp(output_y, -max_vel, max_vel);
        
        float yaw_rate = calculateYawRate(target_yaw, dt);
        send_velocity_setpoint(output_x, output_y, output_z, yaw_rate);
        
        ROS_INFO_THROTTLE(1.0, "Hybrid landing: height=%.2fm, vel=[%.2f,%.2f,%.2f]", 
                 current_height, output_x, output_y, output_z);
    }
    
    // 执行部分角落标记引导降落模式
    void executePartialCornerGuidedMode(double dt) {
        if (!hasPartialCornerMarkers()) {
            ROS_WARN("No partial corner markers available for partial corner-guided landing!");
            send_hover_command();
            return;
        }
        
        double current_height = getCurrentHeight();
        int marker_count = detected_corner_markers_.size();
        
        // 应用飞机边界约束检查（如果启用）
        applyUAVBoundaryConstraints();
        
        // 获取部分角落标记引导指令
        auto guidance = calculatePartialCornerGuidance();
        double guidance_x = guidance.first;
        double guidance_y = guidance.second;
        
        // 计算基础误差（保守的引导策略）
        double error_magnitude = sqrt(guidance_x*guidance_x + guidance_y*guidance_y);
        
        // 自适应PID参数计算（使用部分引导模式因子）
        AdaptivePIDParams adaptive_params = calculateAdaptivePID(current_height, error_magnitude, LandingMode::PARTIAL_CORNER_GUIDED);
        
        // 设置PID参数（更保守）
        pid_x_.setGains(adaptive_params.kp_x * partial_guidance_conservatism_, 
                       adaptive_params.ki_x * partial_guidance_conservatism_, 
                       adaptive_params.kd_x * partial_guidance_conservatism_);
        pid_y_.setGains(adaptive_params.kp_y * partial_guidance_conservatism_, 
                       adaptive_params.ki_y * partial_guidance_conservatism_, 
                       adaptive_params.kd_y * partial_guidance_conservatism_);
        
        // 使用引导指令作为控制输入
        double output_x = guidance_x;
        double output_y = guidance_y;
        
        // 添加边界约束控制输出
        auto boundary_control = getBoundaryConstraintOutput();
        output_x += boundary_control.first;
        output_y += boundary_control.second;
        
        // 部分引导模式的Z轴控制（非常保守，主要目的是寻找更多标记）
        double output_z;
        if (current_height > 8.0) {
            // 高空：慢速下降，保持足够高度以寻找更多标记
            output_z = partial_guidance_z_vel_high_;
        } else if (current_height > 5.0) {
            // 中高空：极慢下降，重点调整位置
            output_z = partial_guidance_z_vel_medium_;
        } else if (current_height > 3.0) {
            // 中空：微下降，等待获得更多标记
            output_z = partial_guidance_z_vel_low_;
        } else {
            // 低空：悬停，等待完整标记检测
            output_z = -0.05;  // 极慢下降
        }
        
        // 保守的输出限制（部分引导模式应该非常谨慎）
        double max_vel = (current_height > 5.0) ? partial_guidance_max_vel_high_ : partial_guidance_max_vel_low_;
        output_x = std::clamp(output_x, -max_vel, max_vel);
        output_y = std::clamp(output_y, -max_vel, max_vel);
        
        // 偏航控制：尝试基于现有标记估算朝向
        float target_yaw = 0.0f;  // 默认朝向东方
        if (marker_count >= 2) {
            // 如果有两个或更多标记，尝试估算平台朝向
            std::vector<int> marker_ids;
            std::vector<std::pair<double, double>> marker_positions;
            
            for (const auto& marker : detected_corner_markers_) {
                marker_ids.push_back(marker.first);
                int idx = marker.second;
                marker_positions.push_back({aruco_center_x_[idx], aruco_center_y_[idx]});
            }
            
            auto platform_info = (marker_count == 2) ? 
                estimatePlatformFromTwoMarkers(marker_ids, marker_positions) : 
                estimatePlatformFromThreeMarkers(marker_ids, marker_positions);
            
            if (platform_info.valid) {
                target_yaw = -platform_info.estimated_yaw;  // 抵消平台朝向
            }
        }
        
        float yaw_rate = calculateYawRate(target_yaw, dt);
        send_velocity_setpoint(output_x, output_y, output_z, yaw_rate);
        
        ROS_INFO_THROTTLE(1.0, "Partial corner guidance: %d markers, height=%.2fm, vel=[%.2f,%.2f,%.2f], guidance=[%.3f,%.3f]", 
                 marker_count, current_height, output_x, output_y, output_z, guidance_x, guidance_y);
        
        // 定期报告检测到的角落标记
        if(enable_boundary_debug_) {
            std::string marker_info = "Detected corners: ";
            for (const auto& marker : detected_corner_markers_) {
                marker_info += "ID" + std::to_string(marker.first) + " ";
            }
            ROS_INFO_THROTTLE(3.0, "%s", marker_info.c_str());
        }
    }
    
    // 执行PX4降落模式（改进版本：多重试和状态监控）
    void executePx4LandMode() {
        static bool land_command_sent = false;
        static ros::Time land_command_time = ros::Time(0);
        static int land_retry_count = 0;
        const int max_retry_count = 5;
        const double retry_interval = 2.0; // 2秒重试间隔
        
        ros::Time current_time = ros::Time::now();
        
        // 首次或重试发送降落指令
        if (!land_command_sent || 
            ((current_time - land_command_time).toSec() > retry_interval && land_retry_count < max_retry_count)) {
            
            ROS_INFO("Attempting to switch to AUTO.LAND mode (attempt %d/%d)", land_retry_count + 1, max_retry_count);
            
            // 先停止发送OFFBOARD指令
        system_flag = false;
            
            // 等待一小段时间让系统稳定
            ros::Duration(0.5).sleep();
            
            if (send_land_command()) {
                land_command_sent = true;
                land_command_time = current_time;
                ROS_INFO("AUTO.LAND command sent successfully");
            } else {
                land_retry_count++;
                land_command_time = current_time;
                ROS_WARN("Failed to send AUTO.LAND command (attempt %d/%d)", land_retry_count, max_retry_count);
                
                // 如果多次失败，保持当前控制模式
                if (land_retry_count >= max_retry_count) {
                    ROS_ERROR("AUTO.LAND command failed after %d attempts, keeping current control", max_retry_count);
                    // 不设置system_flag = false，继续当前控制模式
                    return;
                }
            }
        }
        
        // 检查是否成功切换到LAND模式
        if (land_command_sent) {
            if (mavros_state_.mode == "AUTO.LAND" || mavros_state_.mode == "LAND") {
                ROS_INFO("Successfully switched to %s mode", mavros_state_.mode.c_str());
                system_flag = false; // 停止OFFBOARD控制
                return;
            } else {
                // 仍然不在LAND模式，继续监控
                ROS_INFO_THROTTLE(2.0, "Waiting for mode switch to LAND, current mode: %s", mavros_state_.mode.c_str());
            }
        }
    }
    
    // 计算偏航角速率的辅助函数（改进版本：基于PID控制和当前朝向）
    float calculateYawRate(float target_yaw, double dt) {
        if (!enable_yaw_control_) {
            return 0.0f;
        }
        
        // 如果没有当前朝向信息，使用原来的方法
        if (!current_yaw_available_) {
            ROS_WARN_THROTTLE(5.0, "Current yaw not available, using simplified yaw control");
            return calculateSimpleYawRate(target_yaw, dt);
        }
        
        // 计算朝向误差（目标朝向 - 当前朝向）
        double yaw_error = target_yaw - current_yaw_;
        
        // 处理角度环绕问题（-π到π）
        yaw_error = geometry_utils::normalize_angle(yaw_error);
        
        // 设置PID参数
        yaw_pid_.setGains(yaw_p_gain_, yaw_i_gain_, yaw_d_gain_);
        
        // 使用PID控制器计算偏航角速率
        double yaw_rate = yaw_pid_.compute(yaw_error, dt);
        
        // 安全检查：检测异常的偏航角速率
        if (std::abs(yaw_rate) > max_yaw_rate_ * abnormal_rate_threshold_) {
            ROS_WARN("Abnormal yaw rate detected: %.3f rad/s, resetting PID", yaw_rate);
            yaw_pid_.reset();
            yaw_rate = 0.0;
        }
        
        // 限制偏航角速率在合理范围内
        yaw_rate = std::clamp(yaw_rate, -(double)max_yaw_rate_, (double)max_yaw_rate_);
        
        // 平滑处理：避免突变
        static double last_yaw_rate = 0.0;
        double rate_change = yaw_rate - last_yaw_rate;
        if (std::abs(rate_change) > max_yaw_rate_change_ * dt) {
            yaw_rate = last_yaw_rate + std::copysign(max_yaw_rate_change_ * dt, rate_change);
        }
        last_yaw_rate = yaw_rate;
        
        // 调试输出
        static ros::Time last_yaw_debug_print = ros::Time(0);
        if (enable_yaw_debug_ && (ros::Time::now() - last_yaw_debug_print).toSec() > yaw_debug_print_interval_) {
            std::string mode_name = getYawControlModeString();
            std::string target_source = getTargetYawSource();
            
            ROS_INFO("Yaw control [%s]: current=%.1f°, target=%.1f°, error=%.1f°, rate=%.2f rad/s, source=%s", 
                     mode_name.c_str(),
                     current_yaw_ * 180.0 / M_PI, target_yaw * 180.0 / M_PI, 
                     yaw_error * 180.0 / M_PI, yaw_rate, target_source.c_str());
            last_yaw_debug_print = ros::Time::now();
        }
        
        return (float)yaw_rate;
    }
    
    // 简化的偏航角速率计算（备用方法）
    float calculateSimpleYawRate(float target_yaw, double dt) {
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
        yaw_error = geometry_utils::normalize_angle(yaw_error);
        
        // 计算时间差
        double time_diff = std::max((current_time - last_yaw_time_).toSec(), dt);
        
        // 计算偏航角速率，并限制在合理范围内
        float yaw_rate = yaw_error / time_diff;
        yaw_rate = std::clamp(yaw_rate, -(float)max_yaw_rate_, (float)max_yaw_rate_);
        
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
    
    bool send_land_command() {
        mavros_msgs::SetMode land_mode;
        land_mode.request.custom_mode = "AUTO.LAND";
        
        if (set_mode_client.call(land_mode)) {
            if (land_mode.response.mode_sent) {
                ROS_INFO("PX4 AUTO.LAND mode command sent successfully");
                return true;
            } else {
                ROS_WARN("PX4 AUTO.LAND mode command rejected by flight controller");
                return false;
            }
        } else {
            ROS_ERROR("Failed to call set_mode service for AUTO.LAND mode");
            return false;
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
    ros::Subscriber manual_autoland_sub;  // 新增：手动AUTO.LAND触发订阅器
    ros::Publisher mavros_setpoint_pub;  // 替换原来的uav_command_pub
    ros::ServiceClient set_mode_client;  // 添加模式设置客户端
    ros::Timer control_timer_;
    mavros_msgs::State mavros_state_;  // 添加MAVROS状态

    // PID控制器实例
    PIDController pid_x_;
    PIDController pid_y_;
    PIDController pid_z_;
    
    // 二维码数据
    std::vector<double> aruco_center_x_, aruco_center_y_, aruco_yaw_, aruco_depth_;
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
    
    // ArUco深度数据参数
    bool aruco_depth_enable_;          // 启用ArUco深度数据
    double aruco_min_depth_;           // ArUco深度最小有效值
    double aruco_max_depth_;           // ArUco深度最大有效值
    double aruco_depth_weight_;        // ArUco深度数据权重
    double aruco_lidar_weight_;        // 激光测距权重（多源融合时）
    double aruco_gps_weight_;          // GPS权重（多源融合时）
    bool enable_aruco_depth_debug_;    // ArUco深度调试开关
    
    // 偏航角速率计算相关变量
    double last_target_yaw_;
    ros::Time last_yaw_time_;
    bool yaw_initialized_;
    
    // 当前飞机朝向相关变量
    double current_yaw_;                 // 当前飞机偏航角（弧度）
    bool current_yaw_available_;         // 当前朝向是否可用
    
    // 偏航控制PID控制器
    PIDController yaw_pid_;
    
    // 偏航控制参数
    double yaw_p_gain_, yaw_i_gain_, yaw_d_gain_;
    double target_east_yaw_;             // 目标东向偏航角（弧度）
    bool enable_yaw_control_;            // 启用偏航控制
    double max_yaw_rate_change_;         // 最大偏航角速率变化率（rad/s^2）
    double abnormal_rate_threshold_;     // 异常角速率检测阈值倍数
    double yaw_tolerance_;               // 偏航角容差（弧度）
    bool enable_yaw_debug_;              // 启用偏航控制调试输出
    double yaw_debug_print_interval_;    // 偏航调试信息打印间隔（秒）
    
    // AUTO.LAND触发相关参数
    bool enable_height_trigger_;         // 启用高度触发AUTO.LAND
    bool enable_time_trigger_;           // 启用时间触发AUTO.LAND
    bool enable_accuracy_trigger_;       // 启用精度触发AUTO.LAND
    double auto_land_time_threshold_;    // 精降落持续时间阈值（秒）
    double position_accuracy_threshold_; // 位置精度阈值
    bool manual_autoland_trigger_;       // 手动AUTO.LAND触发标志
    
    // 起飞朝向记录
    double takeoff_yaw_;                 // 起飞时记录的朝向（弧度）
    bool takeoff_yaw_recorded_;          // 是否已记录起飞朝向
    
    // 偏航控制模式
    YawControlMode yaw_control_mode_;    // 偏航控制模式
    bool enable_aruco_yaw_tracking_;     // 启用ArUco朝向跟踪
    std::string yaw_tracking_source_;    // 朝向跟踪源（配置用）

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
    
    // 平台几何信息
    struct PlatformGeometry {
        double center_x, center_y;       // 平台中心在图像中的位置
        double width, height;            // 平台在图像中的尺寸
        // 四角点相对于平台中心的位置
        double corner1_rel_x, corner1_rel_y;  // ID1
        double corner2_rel_x, corner2_rel_y;  // ID2
        double corner3_rel_x, corner3_rel_y;  // ID3
        double corner4_rel_x, corner4_rel_y;  // ID4
    } platform_geometry_;
    
    // 边界约束信息
    struct BoundaryConstraint {
        double direction_x, direction_y; // 约束方向（归一化）
        double strength;                 // 约束强度 (0.0-1.0)
    } boundary_constraint_;
    
    // 平台边界限制参数
    struct PlatformBounds {
        double min_x, max_x, min_y, max_y;
    } platform_bounds_;
    bool platform_boundaries_valid_;    // 边界是否有效
    bool enable_boundary_limits_;       // 启用边界限制
    double boundary_safety_margin_;     // 边界安全边距
    bool enable_boundary_debug_;        // 启用边界调试
    bool use_polygon_bounds_;           // 使用多边形边界（更精确）
    bool boundary_constraint_active_;   // 边界约束是否激活
    double boundary_constraint_gain_;   // 边界约束增益
    double max_boundary_control_output_; // 最大边界控制输出
    
    // 部分角落标记引导参数
    std::vector<std::pair<int, int>> detected_corner_markers_;  // 检测到的角落标记 (ID, index)
    bool partial_guidance_enable_;      // 启用部分角落标记引导
    double partial_guidance_gain_;      // 部分引导增益
    double partial_guidance_conservatism_; // 保守性因子
    double partial_guidance_max_vel_high_;  // 高空最大速度
    double partial_guidance_max_vel_low_;   // 低空最大速度
    double partial_guidance_z_vel_high_;    // 高空下降速度
    double partial_guidance_z_vel_medium_;  // 中空下降速度
    double partial_guidance_z_vel_low_;     // 低空下降速度

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
