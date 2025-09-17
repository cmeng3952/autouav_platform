#ifndef MISSION_WAYPOINT_H
#define MISSION_WAYPOINT_H

#include <ros/ros.h>
#include <mavros_msgs/WaypointPush.h>
#include <mavros_msgs/WaypointList.h>
#include <mavros_msgs/Waypoint.h>
#include <mavros_msgs/WaypointReached.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/State.h>
#include <std_msgs/Bool.h>
#include <std_msgs/Float32MultiArray.h>
#include <geometry_msgs/PoseStamped.h>
#include <uavcontrol_msgs/UAVState.h>
#include <mavros_msgs/HomePosition.h>
#include <mavros_msgs/WaypointClear.h>  // 新增：清除航点服务
#include <sensor_msgs/NavSatFix.h>      // 新增：GPS数据
#include <sensor_msgs/Range.h>          // 新增：激光雷达数据
#include <vision_msgs/TargetsInFrame.h> // 新增：ArUco检测数据
#include <vector>
#include <cmath>
#include <limits>
#include<iostream>
#include<thread>
#include<chrono>
// 任务状态枚举
enum class MissionState {
    IDLE = 0,
    UPLOADING = 1,
    ARMED = 2,
    MISSION_ACTIVE = 3,
    MISSION_COMPLETE = 4,
    RTL_MODE = 5,        // 返航模式
    ARUCO_LANDING = 6,   // 新增：二维码降落模式
    ERROR = 7            // 修改：错误状态序号调整
};

class MissionController {
public:
    // 修改构造函数，支持动态UAV ID
    MissionController(int uav_id = 2) : nh_("~"), current_state_(MissionState::IDLE), 
                         mission_triggered_(false), waypoints_uploaded_(false),
                         waypoints_cleared_(false), uav_id_(uav_id),
                         home_lat_(0.0), home_lon_(0.0), home_alt_(0.0), home_received_(false),
                         rtl_triggered_(false), takeoff_lat_(0.0), takeoff_lon_(0.0), takeoff_alt_(0.0),
                         takeoff_recorded_(false), aruco_landing_triggered_(false),
                         current_lat_(0.0), current_lon_(0.0), current_alt_(0.0), gps_available_(false),
                         lidar_height_(0.0), lidar_available_(false), last_lidar_time_(0),
                         aruco_height_(0.0), aruco_depth_available_(false), last_aruco_time_(0),
                         aruco_fusion_weight_(0.7), lidar_fusion_weight_(0.5), gps_fusion_weight_(0.3),
                         last_reached_waypoint_(65535), // 使用65535表示无航点
                         current_yaw_(0.0), target_yaw_(0.0), yaw_tolerance_(0.1), yaw_stability_count_(0),
                         min_yaw_stability_count_(10), enable_heading_check_(true) {
        
        // 初始化发布器和订阅器
        initializeRosComms();
        
        // 启动控制定时器
        control_timer_ = nh_.createTimer(ros::Duration(0.1), &MissionController::controlLoop, this);
        
        // 加载高度融合参数
        loadHeightFusionParams();
        
        ROS_INFO("Mission controller initialized for UAV%d", uav_id_);
    }

    // 任务触发回调
    void missionTriggerCallback(const std_msgs::Bool::ConstPtr& msg) {
        mission_triggered_ = msg->data;
        if (mission_triggered_) {
            ROS_INFO("Mission triggered");
            current_state_ = MissionState::UPLOADING;
        } else {
            ROS_INFO("Mission stopped");
            current_state_ = MissionState::IDLE;
        }
    }
    
    // 设置MQTT航点数据（新增）
    void setMQTTWaypoints(const std::vector<std::vector<float>>& mqtt_waypoints) {
        if (mqtt_waypoints.empty()) {
            ROS_WARN("Empty MQTT waypoints received, using default mission");
            return;
        }
        
        // 清空当前航点
        default_waypoints_.clear();
        
        // 转换MQTT航点为MAVROS格式
        for (size_t i = 0; i < mqtt_waypoints.size(); ++i) {
            const auto& wp_data = mqtt_waypoints[i];
            if (wp_data.size() >= 9) {  // 确保有足够的参数
                mavros_msgs::Waypoint wp;
                wp.frame = static_cast<uint8_t>(wp_data[0]);        // frame
                wp.command = static_cast<uint16_t>(wp_data[1]);     // command
                wp.is_current = (i == 0);                          // 第一个航点为当前
                wp.autocontinue = true;
                wp.x_lat = wp_data[2];                        // latitude (纬度)
                wp.y_long = wp_data[3];                           // longitude (经度)  
                wp.z_alt = wp_data[4];                              // z
                wp.param1 = wp_data[5];                             // param1
                wp.param2 = wp_data[6];                             // param2
                wp.param3 = wp_data[7];                             // param3
                wp.param4 = wp_data[8];                             // param4
                
                default_waypoints_.push_back(wp);
            }
        }
        
        // 重置任务状态，准备上传新航点
        waypoints_uploaded_ = false;
        reached_waypoints_.clear();
        
        ROS_INFO("Converted %zu MQTT waypoints", default_waypoints_.size());
        for (size_t i = 0; i < default_waypoints_.size(); ++i) {
            ROS_INFO("WP%zu: cmd=%d, pos=[纬度:%.6f°, 经度:%.6f°, 高度:%.1fm], params=[%.1f,%.1f,%.1f,%.1f]", 
                     i, default_waypoints_[i].command,
                     default_waypoints_[i].x_lat, default_waypoints_[i].y_long, default_waypoints_[i].z_alt,
                     default_waypoints_[i].param1, default_waypoints_[i].param2, 
                     default_waypoints_[i].param3, default_waypoints_[i].param4);
        }
    }

    // MAVROS状态回调
    void mavrosStateCallback(const mavros_msgs::State::ConstPtr& msg) {
        mavros_state_ = *msg;
    }

    // 位置回调
    void poseCallback(const geometry_msgs::PoseStamped::ConstPtr& msg) {
        current_pose_ = *msg;
    }

    // UAV状态回调
    void uavStateCallback(const uavcontrol_msgs::UAVState::ConstPtr& msg) {
        uav_state_ = *msg;
    }

    // 航点到达回调
    void waypointReachedCallback(const mavros_msgs::WaypointReached::ConstPtr& msg) {
        ROS_INFO("Waypoint %d reached", msg->wp_seq);
        
        reached_waypoints_.push_back(msg->wp_seq);
        
        // 更新最后到达的航点
        last_reached_waypoint_ = msg->wp_seq;
        
        // 立即发布航点到达状态到MQTT
        publishWaypointStatus();
        
        if (msg->wp_seq >= static_cast<int>(default_waypoints_.size() - 1)) {
            ROS_INFO("All waypoints reached");
        }
    }
    
    // MQTT航点数据回调（新增）
    void mqttWaypointsCallback(const std_msgs::Float32MultiArray::ConstPtr& msg) {
        if (msg->data.size() % 9 != 0) {
            ROS_ERROR("Invalid MQTT waypoints format! Expected multiple of 9 parameters (frame,cmd,x,y,z,p1,p2,p3,p4)");
            return;
        }
        
        // 解析MQTT航点数据
        // 重要：数据流检查和修正
        // JSON输入：x=经度，y=纬度
        // 但传输过来的数组顺序可能不正确，需要检查和修正
        std::vector<std::vector<float>> mqtt_waypoints;
        for (size_t i = 0; i < msg->data.size(); i += 9) {
            float coord1 = msg->data[i+2];  // 第一个坐标
            float coord2 = msg->data[i+3];  // 第二个坐标
            
            // 坐标合理性检查：纬度范围-90到90，经度范围-180到180
            float latitude, longitude;
            if (coord1 >= -90.0f && coord1 <= 90.0f && coord2 >= -180.0f && coord2 <= 180.0f) {
                // coord1在纬度范围内，coord2在经度范围内
                latitude = coord1;
                longitude = coord2;
                ROS_INFO("Coordinates correct: lat=%.6f°, lon=%.6f°", latitude, longitude);
            } else if (coord2 >= -90.0f && coord2 <= 90.0f && coord1 >= -180.0f && coord1 <= 180.0f) {
                // coord2在纬度范围内，coord1在经度范围内，需要交换
                latitude = coord2;
                longitude = coord1;
                ROS_WARN("Coordinates swapped and corrected: lat=%.6f°, lon=%.6f°", latitude, longitude);
            } else {
                // 都不在合理范围内，使用默认值
                latitude = coord1;  // 假设第一个是纬度
                longitude = coord2; // 假设第二个是经度
                ROS_ERROR("Coordinates out of range! lat=%.6f°, lon=%.6f°", latitude, longitude);
            }
            
            mqtt_waypoints.push_back({
                msg->data[i],     // frame
                msg->data[i+1],   // command
                latitude,         // 确保是纬度
                longitude,        // 确保是经度
                msg->data[i+4],   // z
                msg->data[i+5],   // param1
                msg->data[i+6],   // param2
                msg->data[i+7],   // param3
                msg->data[i+8]    // param4
            });
        }
        
        // 设置MQTT航点
        setMQTTWaypoints(mqtt_waypoints);
        
        ROS_INFO("Received and processed %zu MQTT waypoints", mqtt_waypoints.size());
    }

    // Home position callback
    void homePositionCallback(const mavros_msgs::HomePosition::ConstPtr& msg) {
        home_lat_ = msg->geo.latitude;
        home_lon_ = msg->geo.longitude;
        home_alt_ = msg->geo.altitude;
        home_received_ = true;
        
        // 记录起飞点（首次接收home位置时）
        if (!takeoff_recorded_) {
            takeoff_lat_ = home_lat_;
            takeoff_lon_ = home_lon_;
            takeoff_alt_ = home_alt_;
            takeoff_recorded_ = true;
            ROS_INFO("Takeoff point recorded: lat=%.8f°, lon=%.8f°, alt=%.2fm", 
                     takeoff_lat_, takeoff_lon_, takeoff_alt_);
        }
    }
    
    // GPS位置回调（新增：用于二维码降落集成）
    void gpsCallback(const sensor_msgs::NavSatFix::ConstPtr& msg) {
        current_lat_ = msg->latitude;
        current_lon_ = msg->longitude;
        current_alt_ = msg->altitude;
        gps_available_ = (msg->status.status >= 0); // GPS fix available
        
        // 定期打印GPS位置（避免过于频繁）
        static ros::Time last_gps_print = ros::Time(0);
        if ((ros::Time::now() - last_gps_print).toSec() > 15.0) {
            ROS_INFO("Current GPS: lat=%.8f°, lon=%.8f°, alt=%.2fm, status=%s", 
                     current_lat_, current_lon_, current_alt_, 
                     gps_available_ ? "OK" : "FAIL");
            last_gps_print = ros::Time::now();
        }
    }
    
    // 新增：激光雷达高度回调
    void lidarCallback(const sensor_msgs::Range::ConstPtr& msg) {
        if (msg->range >= msg->min_range && msg->range <= msg->max_range) {
            lidar_height_ = msg->range;
            lidar_available_ = true;
            last_lidar_time_ = ros::Time::now();
        }
    }
    
    // 新增：ArUco检测回调（提取深度信息）
    void arucoDetectionCallback(const vision_msgs::TargetsInFrame::ConstPtr& msg) {
        aruco_depth_available_ = false;
        
        if (!msg->targets.empty()) {
            // 寻找中心标记（ID19或43）的深度信息
            for (const auto& target : msg->targets) {
                if (target.tracked_id == 19 || target.tracked_id == 43) {
                    if (target.pz > 0.1 && target.pz < 50.0) {  // 合理性检查
                        aruco_height_ = target.pz;
                        aruco_depth_available_ = true;
                        last_aruco_time_ = ros::Time::now();
                        break;  // 找到有效深度数据即可
                    }
                }
            }
        }
    }
    
    // 新增：获取融合高度（激光雷达+ArUco深度加权融合）
    double getFusedHeight() const {
        // 检查数据新鲜度（使用配置的超时参数）
        bool lidar_fresh = lidar_available_ && 
                          (ros::Time::now() - last_lidar_time_).toSec() < lidar_timeout_;
        bool aruco_fresh = aruco_depth_available_ && 
                          (ros::Time::now() - last_aruco_time_).toSec() < aruco_timeout_;
        
        // 加权融合算法
        double weighted_sum = 0.0;
        double weight_sum = 0.0;
        
        // ArUco深度数据（权重0.7）
        if (aruco_fresh && aruco_height_ > 0.1 && aruco_height_ < 50.0) {
            weighted_sum += aruco_height_ * aruco_fusion_weight_;
            weight_sum += aruco_fusion_weight_;
        }
        
        // 激光雷达数据（权重0.5）
        if (lidar_fresh && lidar_height_ > 0.1 && lidar_height_ < 50.0) {
            weighted_sum += lidar_height_ * lidar_fusion_weight_;
            weight_sum += lidar_fusion_weight_;
        }
        
        // GPS高度差数据（权重0.3，作为参考）
        double gps_height = current_alt_ - takeoff_alt_;
        if (gps_available_ && gps_height > 0.0 && gps_height < 100.0) {
            weighted_sum += gps_height * gps_fusion_weight_;
            weight_sum += gps_fusion_weight_;
        }
        
        // 计算加权平均
        if (weight_sum > 0.0) {
            double fused_height = weighted_sum / weight_sum;
            
            // 调试输出（根据配置决定是否输出）
            static ros::Time last_fusion_debug = ros::Time(0);
            if (enable_fusion_debug_ && (ros::Time::now() - last_fusion_debug).toSec() > 5.0) {
                ROS_INFO("Height fusion: ArUco=%.2fm(w=%.1f), Lidar=%.2fm(w=%.1f), GPS=%.2fm(w=%.1f) -> Fused=%.2fm", 
                         aruco_fresh ? aruco_height_ : -1.0, aruco_fusion_weight_,
                         lidar_fresh ? lidar_height_ : -1.0, lidar_fusion_weight_,
                         gps_height, gps_fusion_weight_, fused_height);
                last_fusion_debug = ros::Time::now();
            }
            
            return fused_height;
        }
        
        // 如果没有有效数据，使用GPS高度差作为备用
        return gps_height;
    }
    
    // 新增：获取当前偏航角（弧度）
    double getCurrentYaw() const {
        // 从四元数转换为偏航角
        double siny_cosp = 2.0 * (current_pose_.pose.orientation.w * current_pose_.pose.orientation.z +
                                   current_pose_.pose.orientation.x * current_pose_.pose.orientation.y);
        double cosy_cosp = 1.0 - 2.0 * (current_pose_.pose.orientation.y * current_pose_.pose.orientation.y +
                                         current_pose_.pose.orientation.z * current_pose_.pose.orientation.z);
        return atan2(siny_cosp, cosy_cosp);
    }
    
    // 新增：计算到起飞点的目标偏航角
    double calculateTargetYaw() const {
        if (!takeoff_recorded_ || !gps_available_) {
            return 0.0; // 默认朝北
        }
        
        // 计算从当前位置到起飞点的方向角
        double dlat = takeoff_lat_ - current_lat_;
        double dlon = takeoff_lon_ - current_lon_;
        
        // 转换为弧度并考虑地球曲率
        double lat_rad = current_lat_ * M_PI / 180.0;
        double dlon_rad = dlon * M_PI / 180.0;
        double dlat_rad = dlat * M_PI / 180.0;
        
        // 使用atan2计算方位角（从北方向顺时针测量）
        double target_bearing = atan2(sin(dlon_rad) * cos(takeoff_lat_ * M_PI / 180.0),
                                      cos(lat_rad) * sin(takeoff_lat_ * M_PI / 180.0) -
                                      sin(lat_rad) * cos(takeoff_lat_ * M_PI / 180.0) * cos(dlon_rad));
        
        return target_bearing;
    }
    
    // 新增：检查机头朝向是否已经回正
    bool isHeadingStabilized() {
        if (!enable_heading_check_) {
            return true; // 如果禁用了朝向检查，直接返回true
        }
        
        // 获取当前偏航角
        current_yaw_ = getCurrentYaw();
        target_yaw_ = calculateTargetYaw();
        
        // 计算偏航角差值（考虑角度环绕）
        double yaw_diff = target_yaw_ - current_yaw_;
        
        // 将角度差值规范化到 [-π, π] 范围
        while (yaw_diff > M_PI) yaw_diff -= 2.0 * M_PI;
        while (yaw_diff < -M_PI) yaw_diff += 2.0 * M_PI;
        
        // 检查偏航角是否在容忍范围内
        bool yaw_aligned = fabs(yaw_diff) < yaw_tolerance_;
        
        // 稳定性检查：需要连续几次都满足条件
        if (yaw_aligned) {
            yaw_stability_count_++;
        } else {
            yaw_stability_count_ = 0; // 重置计数器
        }
        
        bool is_stable = yaw_stability_count_ >= min_yaw_stability_count_;
        
        // 定期调试输出
        static ros::Time last_yaw_debug = ros::Time(0);
        if ((ros::Time::now() - last_yaw_debug).toSec() > 3.0) {
            ROS_INFO("Heading check: current=%.1f°, target=%.1f°, diff=%.1f°, stable_count=%d/%d, aligned=%s, stable=%s",
                     current_yaw_ * 180.0 / M_PI, target_yaw_ * 180.0 / M_PI, yaw_diff * 180.0 / M_PI,
                     yaw_stability_count_, min_yaw_stability_count_,
                     yaw_aligned ? "YES" : "NO", is_stable ? "YES" : "NO");
            last_yaw_debug = ros::Time::now();
        }
        
        return is_stable;
    }

    // Convert local NED offsets (north/east in metres) to global lat/lon (deg)
    void offsetToGlobal(double north, double east, double& lat, double& lon) const {
        const double EARTH_RADIUS = 6378137.0; // metres
        lat = home_lat_ + (north / EARTH_RADIUS) * 180.0 / M_PI;
        lon = home_lon_ + (east  / (EARTH_RADIUS * cos(home_lat_ * M_PI / 180.0))) * 180.0 / M_PI;
    }
    
    // 计算两个GPS坐标之间的距离（米）- Haversine公式
    double calculateDistance(double lat1, double lon1, double lat2, double lon2) const {
        const double EARTH_RADIUS = 6378137.0; // 地球半径（米）
        
        // 转换为弧度
        double lat1_rad = lat1 * M_PI / 180.0;
        double lon1_rad = lon1 * M_PI / 180.0;
        double lat2_rad = lat2 * M_PI / 180.0;
        double lon2_rad = lon2 * M_PI / 180.0;
        
        // Haversine公式
        double dlat = lat2_rad - lat1_rad;
        double dlon = lon2_rad - lon1_rad;
        
        double a = sin(dlat/2) * sin(dlat/2) + 
                   cos(lat1_rad) * cos(lat2_rad) * sin(dlon/2) * sin(dlon/2);
        double c = 2 * atan2(sqrt(a), sqrt(1-a));
        
        return EARTH_RADIUS * c;
    }
    
    // 检查是否接近起飞点
    bool isNearTakeoffPoint() const {
        if (!takeoff_recorded_ || !gps_available_) {
            return false;
        }
        
        // 第一步：先进行水平距离判断（使用实时GPS坐标和起飞点经纬度计算）
        double horizontal_distance = calculateDistance(current_lat_, current_lon_, 
                                                      takeoff_lat_, takeoff_lon_);
        
        // 水平距离判断：必须在4米范围内
        bool near_horizontally = horizontal_distance < 1.5;
        
        static ros::Time last_debug_print = ros::Time(0);
        bool should_print = (ros::Time::now() - last_debug_print).toSec() > 5.0;
        
        // 如果水平距离不满足，直接返回false，不进行高度判断
        if (!near_horizontally) {
                         if (should_print) {
                 //ROS_INFO("Horizontal check: %.1fm > 4.0m (not met)", horizontal_distance);
                 last_debug_print = ros::Time::now();
             }
            return false;
        }
        
        // 第二步：水平距离满足后，再进行高度判断（使用融合高度数据）
        double fused_height = getFusedHeight();
        double gps_height = current_alt_ - takeoff_alt_;
        
        // 使用融合高度进行判断，GPS高度作为参考
        bool proper_height = (fused_height >= 5.0 && fused_height <= 8.0);
        
        if (should_print) {
            // 获取各高度源状态
            std::string lidar_status = lidar_available_ ? "OK" : "FAIL";
            std::string aruco_status = aruco_depth_available_ ? "OK" : "FAIL";
            
            ROS_INFO("Distance check: horiz=%.1fm (OK<1.5m), fused_height=%.1fm, gps_height=%.1fm, range=%s", 
                     horizontal_distance, fused_height, gps_height,
                     proper_height ? "OK(5-8m)" : "FAIL(need 5-8m)");
            ROS_INFO("Height sources: Lidar=%s(%.1fm), ArUco=%s(%.1fm), GPS=%.1fm", 
                     lidar_status.c_str(), lidar_available_ ? lidar_height_ : -1.0,
                     aruco_status.c_str(), aruco_depth_available_ ? aruco_height_ : -1.0,
                     gps_height);
            last_debug_print = ros::Time::now();
        }
        
        return proper_height; // 水平距离已满足，返回高度判断结果
    }
    
    // 触发二维码降落
    void triggerArucoLanding() {
        if (aruco_landing_triggered_) {
            return; // 避免重复触发
        }
        
        ROS_INFO("========== ArUco Landing Triggered ==========");
        ROS_INFO("Current pos: lat=%.8f°, lon=%.8f°, alt=%.2fm", 
                 current_lat_, current_lon_, current_alt_);
        ROS_INFO("Takeoff pos: lat=%.8f°, lon=%.8f°, alt=%.2fm", 
                 takeoff_lat_, takeoff_lon_, takeoff_alt_);
        ROS_INFO("Horizontal dist: %.2fm", calculateDistance(current_lat_, current_lon_, 
                                                   takeoff_lat_, takeoff_lon_));
        ROS_INFO("Height diff: %.2fm", current_alt_ - takeoff_alt_);
        
        // 发布二维码降落触发信号
        std_msgs::Bool aruco_trigger;
        aruco_trigger.data = true;
        aruco_trigger_pub_.publish(aruco_trigger);
        
        aruco_landing_triggered_ = true;
        ROS_INFO("ArUco landing signal sent");
        ROS_INFO("===========================================");
    }

    // 发布航点状态信息
    void publishWaypointStatus() {
        uavcontrol_msgs::UAVState waypoint_state;
        
        // 设置header
        waypoint_state.header.stamp = ros::Time::now();
        waypoint_state.header.frame_id = "base_link";
        
        // 设置UAV ID
        waypoint_state.uav_id = uav_id_;
        
        // 设置航点任务相关信息
        waypoint_state.mission_active = (current_state_ == MissionState::MISSION_ACTIVE || 
                                       current_state_ == MissionState::RTL_MODE ||
                                       current_state_ == MissionState::ARUCO_LANDING);
        waypoint_state.total_waypoints = default_waypoints_.size();
        waypoint_state.last_reached_waypoint = last_reached_waypoint_;
        
        // 根据当前状态设置mission_state字符串
        switch (current_state_) {
            case MissionState::IDLE:
                waypoint_state.mission_state = "IDLE";
                waypoint_state.current_waypoint = 65535; // 无航点
                break;
            case MissionState::UPLOADING:
                waypoint_state.mission_state = "UPLOADING";
                waypoint_state.current_waypoint = 65535; // 尚未开始
                break;
            case MissionState::ARMED:
                waypoint_state.mission_state = "ARMED";
                waypoint_state.current_waypoint = 0; // 准备执行第一个航点
                break;
            case MissionState::MISSION_ACTIVE:
                waypoint_state.mission_state = "MISSION_ACTIVE";
                waypoint_state.current_waypoint = (last_reached_waypoint_ == 65535) ? 0 : last_reached_waypoint_ + 1;
                break;
            case MissionState::MISSION_COMPLETE:
                waypoint_state.mission_state = "MISSION_COMPLETE";
                waypoint_state.current_waypoint = 65535; // 任务完成
                break;
            case MissionState::RTL_MODE:
                waypoint_state.mission_state = "RTL_MODE";
                waypoint_state.current_waypoint = 65535; // RTL阶段
                break;
            case MissionState::ARUCO_LANDING:
                waypoint_state.mission_state = "ARUCO_LANDING";
                waypoint_state.current_waypoint = 65535; // 二维码降落阶段
                break;
            case MissionState::ERROR:
                waypoint_state.mission_state = "ERROR";
                waypoint_state.current_waypoint = 65535; // 错误状态
                break;
        }
        
        // 设置基本状态信息（如果有的话）
        waypoint_state.connected = mavros_state_.connected;
        waypoint_state.armed = mavros_state_.armed;
        waypoint_state.mode = mavros_state_.mode;
        
        // 设置GPS信息
        waypoint_state.latitude = current_lat_;
        waypoint_state.longitude = current_lon_;
        waypoint_state.altitude = current_alt_;
        
        // 发布航点状态
        waypoint_status_pub_.publish(waypoint_state);
        
        ROS_INFO("Published waypoint status: mission=%s, total=%d, last_reached=%d, current=%d", 
                 waypoint_state.mission_state.c_str(),
                 waypoint_state.total_waypoints,
                 waypoint_state.last_reached_waypoint,
                 waypoint_state.current_waypoint);
    }

private:
    // 新增：加载高度融合参数
    void loadHeightFusionParams() {
        // 从ROS参数服务器加载融合权重
        nh_.param("/mission_waypoint_node/height_fusion/aruco_weight", aruco_fusion_weight_, 0.7);
        nh_.param("/mission_waypoint_node/height_fusion/lidar_weight", lidar_fusion_weight_, 0.5);
        nh_.param("/mission_waypoint_node/height_fusion/gps_weight", gps_fusion_weight_, 0.3);
        
        // 数据有效性参数
        nh_.param("/mission_waypoint_node/height_fusion/lidar_timeout", lidar_timeout_, 2.0);
        nh_.param("/mission_waypoint_node/height_fusion/aruco_timeout", aruco_timeout_, 1.0);
        nh_.param("/mission_waypoint_node/height_fusion/enable_fusion_debug", enable_fusion_debug_, true);
        
        // 新增：偏航角检查参数
        nh_.param("/mission_waypoint_node/heading_check/yaw_tolerance_deg", yaw_tolerance_, 6.0); // 默认6度容忍度
        yaw_tolerance_ = yaw_tolerance_ * M_PI / 180.0; // 转换为弧度
        nh_.param("/mission_waypoint_node/heading_check/min_stability_count", min_yaw_stability_count_, 10);
        nh_.param("/mission_waypoint_node/heading_check/enable_heading_check", enable_heading_check_, true);
        
        ROS_INFO("Height fusion weights: ArUco=%.2f, Lidar=%.2f, GPS=%.2f", 
                 aruco_fusion_weight_, lidar_fusion_weight_, gps_fusion_weight_);
        ROS_INFO("Heading check params: tolerance=%.1f°, stability_count=%d, enabled=%s",
                 yaw_tolerance_ * 180.0 / M_PI, min_yaw_stability_count_, enable_heading_check_ ? "YES" : "NO");
    }

    // 初始化ROS通信
    void initializeRosComms() {
        // 构建动态的topic和service名称
        std::string uav_prefix = "/uav" + std::to_string(uav_id_);
        
        // 订阅器
        mission_trigger_sub_ = nh_.subscribe<std_msgs::Bool>("/mission_waypoint_trigger", 10, 
                                                            &MissionController::missionTriggerCallback, this);
        mavros_state_sub_ = nh_.subscribe<mavros_msgs::State>(uav_prefix + "/mavros/state", 10, 
                                                             &MissionController::mavrosStateCallback, this);
        pose_sub_ = nh_.subscribe<geometry_msgs::PoseStamped>(uav_prefix + "/mavros/local_position/pose", 10, 
                                                             &MissionController::poseCallback, this);
        uav_state_sub_ = nh_.subscribe<uavcontrol_msgs::UAVState>(uav_prefix + "/prometheus/state", 10, 
                                                                 &MissionController::uavStateCallback, this);
        waypoint_reached_sub_ = nh_.subscribe<mavros_msgs::WaypointReached>(uav_prefix + "/mavros/mission/reached", 10,
                                                                           &MissionController::waypointReachedCallback, this);
        
        // 订阅MQTT航点数据（新增）
        mqtt_waypoints_sub_ = nh_.subscribe<std_msgs::Float32MultiArray>("/mission_waypoint_mqtt_data", 10,
                                                                        &MissionController::mqttWaypointsCallback, this);
        
        // 订阅GPS位置信息（新增：用于二维码降落集成）
        gps_sub_ = nh_.subscribe<sensor_msgs::NavSatFix>(uav_prefix + "/mavros/global_position/global", 10,
                                                        &MissionController::gpsCallback, this);
        
        // 新增：订阅激光雷达高度数据
        lidar_sub_ = nh_.subscribe<sensor_msgs::Range>(uav_prefix + "/mavros/distance_sensor/hrlv_ez4_pub", 10,
                                                      &MissionController::lidarCallback, this);
        
        // 新增：订阅ArUco检测数据（用于获取深度信息）
        aruco_detection_sub_ = nh_.subscribe<vision_msgs::TargetsInFrame>(uav_prefix + "/vision/aruco_detection", 10,
                                                                         &MissionController::arucoDetectionCallback, this);
        
        // 发布二维码降落触发信号（新增）
        aruco_trigger_pub_ = nh_.advertise<std_msgs::Bool>("/aruco_landing", 10);
        
        // 发布航点状态信息（新增）
        waypoint_status_pub_ = nh_.advertise<uavcontrol_msgs::UAVState>(uav_prefix + "/prometheus/state_waypoint", 10);
        
        // 服务客户端
        waypoint_push_client_ = nh_.serviceClient<mavros_msgs::WaypointPush>(uav_prefix + "/mavros/mission/push");
        set_mode_client_ = nh_.serviceClient<mavros_msgs::SetMode>(uav_prefix + "/mavros/set_mode");
        arming_client_ = nh_.serviceClient<mavros_msgs::CommandBool>(uav_prefix + "/mavros/cmd/arming");
        // 航点清除服务客户端
        waypoint_clear_client_ = nh_.serviceClient<mavros_msgs::WaypointClear>(uav_prefix + "/mavros/mission/clear");
        
        // Home position subscriber (used for converting local offsets to global lat/lon)
        home_pos_sub_ = nh_.subscribe<mavros_msgs::HomePosition>(uav_prefix + "/mavros/home_position/home", 10,
                                                                 &MissionController::homePositionCallback, this);
        
        ROS_INFO("ROS communications initialized for UAV%d", uav_id_);
    }

    // 创建默认任务 - 使用机体坐标系的简单航点任务
    void createDefaultMission() {
        default_waypoints_.clear();
        
        // 确保已收到home位置
        if (!home_received_) {
            ROS_WARN("Home position not received yet, cannot create global waypoints");
            return;
        }

        // === 航点1：向前（北）飞行5米 ===
        mavros_msgs::Waypoint wp1;
        wp1.frame = mavros_msgs::Waypoint::FRAME_GLOBAL_REL_ALT;
        wp1.command = 16; // NAV_WAYPOINT
        wp1.is_current = false;
        wp1.autocontinue = true;
        wp1.param1 = 5.0; // 悬停时间5秒
        wp1.param2 = 1.0; // 接受半径1米
        wp1.param3 = 0.0; 
        wp1.param4 = std::numeric_limits<float>::quiet_NaN(); // yaw不变
        offsetToGlobal(5.0, 0.0, wp1.x_lat, wp1.y_long);
        wp1.z_alt = 2.0; // 相对高度 (home +2m)
        default_waypoints_.push_back(wp1);

        ROS_INFO("Created default mission with %zu waypoints", default_waypoints_.size());
    }

    // 上传航点到MAVROS
    bool uploadWaypoints() {
        if (default_waypoints_.empty()) {
            ROS_ERROR("Empty waypoint list");
            return false;
        }

        ROS_INFO("Uploading %zu waypoints", default_waypoints_.size());
        
        mavros_msgs::WaypointPush srv;
        srv.request.start_index = 0;
        srv.request.waypoints = default_waypoints_;

        if (waypoint_push_client_.call(srv)) {
            if (srv.response.success) {
                ROS_INFO("Uploaded %d waypoints", srv.response.wp_transfered);
                
                if (srv.response.wp_transfered != static_cast<int>(default_waypoints_.size())) {
                    ROS_WARN("Waypoint count mismatch: expected %zu, uploaded %d", 
                             default_waypoints_.size(), srv.response.wp_transfered);
                }
                
                waypoints_uploaded_ = true;
                return true;
            } else {
                ROS_ERROR("Flight controller rejected waypoint upload");
                return false;
            }
        } else {
            ROS_ERROR("Failed to call waypoint push service");
            return false;
        }
    }

    // 清除飞控中的航点任务
    bool clearWaypoints() {
        mavros_msgs::WaypointClear srv;
        if (waypoint_clear_client_.call(srv)) {
            if (srv.response.success) {
                ROS_INFO("Waypoints cleared");
                return true;
            } else {
                ROS_WARN("Failed to clear waypoints");
                return false;
            }
        } else {
            ROS_ERROR("Failed to call clear service");
            return false;
        }
    }

    // 设置飞行模式
    bool setMode(const std::string& mode) {
        if (!mavros_state_.connected) {
            ROS_ERROR("MAVROS not connected");
            return false;
        }

        ROS_INFO("Setting mode: %s", mode.c_str());
        
        mavros_msgs::SetMode srv;
        srv.request.custom_mode = mode;

        if (set_mode_client_.call(srv)) {
            if (srv.response.mode_sent) {
                ROS_INFO("Mode set: %s", mode.c_str());
                return true;
            } else {
                ROS_ERROR("Mode rejected: %s (current: %s)", mode.c_str(), mavros_state_.mode.c_str());
                return false;
            }
        } else {
            ROS_ERROR("Failed to call set mode service");
            return false;
        }
    }

    // 解锁无人机
    bool armVehicle() {
        if (!mavros_state_.connected) {
            ROS_ERROR("MAVROS not connected");
            return false;
        }

        if (mavros_state_.armed) {
            ROS_INFO("Already armed");
            return true;
        }

        if (mavros_state_.mode != "AUTO.MISSION") {
            ROS_WARN("Arming in mode: %s (expected: AUTO.MISSION)", mavros_state_.mode.c_str());
        }

        ROS_INFO("Arming vehicle");
        
        mavros_msgs::CommandBool srv;
        srv.request.value = true;

        if (arming_client_.call(srv)) {
            if (srv.response.success) {
                ROS_INFO("Vehicle armed");
                return true;
            } else {
                ROS_ERROR("Arm request rejected (check GPS, safety, battery)");
                return false;
            }
        } else {
            ROS_ERROR("Failed to call arming service");
            return false;
        }
    }

    // 主控制循环
    void controlLoop(const ros::TimerEvent& event) {
        // 定期发布航点状态（每5秒发布一次，即使任务未触发）
        static ros::Time last_status_publish = ros::Time(0);
        if ((ros::Time::now() - last_status_publish).toSec() > 5.0) {
            publishWaypointStatus();
            last_status_publish = ros::Time::now();
        }
        
        if (!mission_triggered_) {
            return;
        }

        switch (current_state_) {
            case MissionState::UPLOADING:
                handleUploadingState();
                break;
                
            case MissionState::ARMED:
                handleArmedState();
                break;
                
            case MissionState::MISSION_ACTIVE:
                handleMissionActiveState();
                break;
                
            case MissionState::MISSION_COMPLETE:
                handleMissionCompleteState();
                break;
                
            case MissionState::RTL_MODE:
                //system("systemctl --user stop rtmp_stream.service");
                //system("roslaunch cloudfly_cv detect_AruUco.launch &");
                 //std::this_thread::sleep_for(std::chrono::seconds(2));
                //system("roslaunch cloudfly_cv push_rtmp_stream.launch");
                handleRTLModeState();
                break;
                
            case MissionState::ARUCO_LANDING:
                handleArucoLandingState();
                break;
                
            case MissionState::ERROR:
                handleErrorState();
                break;
                
            default:
                break;
        }
    }

    // 处理上传状态
    void handleUploadingState() {
        static int upload_attempts = 0;
        static ros::Time last_attempt_time = ros::Time(0);
        const int max_attempts = 5;
        const double retry_interval = 2.0; // 2秒重试间隔

        if (!mavros_state_.connected) {
            static ros::Time last_connection_warning = ros::Time(0);
            if ((ros::Time::now() - last_connection_warning).toSec() > 5.0) {
                ROS_WARN("MAVROS not connected, waiting...");
                last_connection_warning = ros::Time::now();
            }
            return;
        }

        if (!home_received_) {
            if (upload_attempts == 0) {
                ROS_INFO_THROTTLE(5.0, "Waiting for home position...");
            }
            return;
        }

        if (default_waypoints_.empty()) {
            createDefaultMission();
            if (default_waypoints_.empty()) {
                ROS_WARN("No waypoints created");
                return;
            }
        }

        // 避免频繁重试
        if ((ros::Time::now() - last_attempt_time).toSec() < retry_interval) {
            return;
        }

        if (!waypoints_uploaded_) {
            if (!waypoints_cleared_ && !default_waypoints_.empty()) {
                ROS_INFO("Clearing old waypoints");
                if (clearWaypoints()) {
                    waypoints_cleared_ = true;
                    ROS_INFO("Waypoints cleared");
                } else {
                    ROS_WARN("Failed to clear waypoints, continuing");
                }
            }

            ROS_INFO("Upload attempt %d/%d", upload_attempts + 1, max_attempts);
            
            if (uploadWaypoints()) {
                upload_attempts = 0;
                ROS_INFO("Upload complete, proceeding to arm");
                current_state_ = MissionState::ARMED;
            } else {
                upload_attempts++;
                last_attempt_time = ros::Time::now();
                
                if (upload_attempts >= max_attempts) {
                    ROS_ERROR("Upload failed after %d attempts", max_attempts);
                    current_state_ = MissionState::ERROR;
                }
            }
        }
    }

    // 处理解锁状态
    void handleArmedState() {
        static ros::Time last_arm_attempt = ros::Time(0);
        static ros::Time last_mode_attempt = ros::Time(0);
        const double attempt_interval = 1.0; // 1秒重试间隔

        if (!mavros_state_.connected) {
            static ros::Time last_connection_warning = ros::Time(0);
            if ((ros::Time::now() - last_connection_warning).toSec() > 5.0) {
                ROS_WARN("MAVROS not connected");
                last_connection_warning = ros::Time::now();
            }
            return;
        }

        // Set mode first, then arm
        if (mavros_state_.mode != "AUTO.MISSION") {
            if ((ros::Time::now() - last_mode_attempt).toSec() > attempt_interval) {
                if (setMode("AUTO.MISSION")) {
                    ROS_INFO("Mode set to AUTO.MISSION");
                } else {
                    ROS_WARN("Failed to set mode, retrying");
                }
                last_mode_attempt = ros::Time::now();
            }
            return;
        }

        if (!mavros_state_.armed) {
            if ((ros::Time::now() - last_arm_attempt).toSec() > attempt_interval) {
                if (armVehicle()) {
                    ROS_INFO("Armed, mission starting");
                    current_state_ = MissionState::MISSION_ACTIVE;
                } else {
                    ROS_WARN("Failed to arm, retrying");
                }
                last_arm_attempt = ros::Time::now();
            }
        } else {
            ROS_INFO("Ready, mission starting");
            current_state_ = MissionState::MISSION_ACTIVE;
        }
    }

    // 处理任务执行状态
    void handleMissionActiveState() {
        static ros::Time mission_start_time = ros::Time::now();
        static bool mission_timer_initialized = false;
        const double mission_timeout = 300.0; // 5分钟超时
        
        if (!mission_timer_initialized) {
            mission_start_time = ros::Time::now();
            mission_timer_initialized = true;
            ROS_INFO("Mission timer started");
        }

        // 检查任务超时
        double elapsed_time = (ros::Time::now() - mission_start_time).toSec();
        if (elapsed_time > mission_timeout) {
            ROS_ERROR("Mission timeout after %.1f seconds", elapsed_time);
            current_state_ = MissionState::ERROR;
            return;
        }

        if (mavros_state_.mode != "AUTO.MISSION") {
            ROS_INFO("Mode changed to %s", mavros_state_.mode.c_str());
            
            if (mavros_state_.mode == "AUTO.LOITER" || mavros_state_.mode == "AUTO.LAND" || 
                mavros_state_.mode == "LAND" || mavros_state_.mode == "LOITER" ||
                mavros_state_.mode == "HOLD" || mavros_state_.mode == "AUTO.HOLD" ||
                !mavros_state_.armed) {
                ROS_INFO("Mission completed");
                current_state_ = MissionState::MISSION_COMPLETE;
                mission_timer_initialized = false;
            } else {
                ROS_WARN("Mission interrupted by mode change");
                current_state_ = MissionState::MISSION_COMPLETE;
                mission_timer_initialized = false;
            }
        }

        static ros::Time last_status_print = ros::Time(0);
        if ((ros::Time::now() - last_status_print).toSec() > 10.0) {
            ROS_INFO("Mission active - %s, armed: %s, time: %.1fs", 
                     mavros_state_.mode.c_str(), 
                     mavros_state_.armed ? "yes" : "no",
                     elapsed_time);
            last_status_print = ros::Time::now();
        }
    }

    // 处理任务完成状态
    void handleMissionCompleteState() {
        ROS_INFO("Mission completed - reached %zu waypoints", reached_waypoints_.size());
        
        // 检查最后一个航点的指令类型，决定是否触发RTL（在清除航点之前）
        bool should_trigger_rtl = true;
        
        if (!default_waypoints_.empty()) {
            uint16_t last_command = default_waypoints_.back().command;
            
            switch(last_command) {
                case 21:  // NAV_LAND - 降落指令
                    ROS_INFO("Last waypoint was LAND command, mission complete without RTL");
                    should_trigger_rtl = false;
                    break;
                    
                case 17:  // NAV_RETURN_TO_LAUNCH - 悬停指令 
                    ROS_INFO("Last waypoint was HOVER/RTL command, mission complete without additional RTL");
                    should_trigger_rtl = false;
                    break;
                          
                case 16:  // NAV_WAYPOINT - 普通航点
                default:
                    ROS_INFO("Last waypoint was normal waypoint, triggering auto RTL");
                    should_trigger_rtl = true;
                    break;
            }
            
            ROS_INFO("Last waypoint command: %d, RTL trigger: %s", 
                     last_command, should_trigger_rtl ? "YES" : "NO");
        }
        
        // 现在清除航点（在检查完指令类型之后）
        clearWaypoints();
        
        if (should_trigger_rtl && !rtl_triggered_) {
            ROS_INFO("Initiating RTL mode");
            
            if (!set_mode_client_.exists()) {
                ROS_ERROR("Set mode service not available");
                current_state_ = MissionState::ERROR;
                return;
            }
            
            if (setMode("AUTO.RTL")) {
                ROS_INFO("RTL mode set");
                current_state_ = MissionState::RTL_MODE;
                rtl_triggered_ = true;
            } else {
                ROS_WARN("Trying alternative RTL");
                if (setMode("RTL")) {
                    ROS_INFO("RTL mode set (alternative)");
                    current_state_ = MissionState::RTL_MODE;
                    rtl_triggered_ = true;
                } else {
                    ROS_ERROR("RTL failed, switching to LOITER");
                    setMode("AUTO.LOITER");
                    current_state_ = MissionState::ERROR;
                }
            }
        } else {
            // 不需要RTL，直接重置任务状态
            ROS_INFO("Mission completed without RTL, resetting to IDLE");
            
            mission_triggered_ = false;
            waypoints_uploaded_ = false;
            waypoints_cleared_ = false;
            reached_waypoints_.clear();
            rtl_triggered_ = false;
            takeoff_recorded_ = false;
            aruco_landing_triggered_ = false;
            last_reached_waypoint_ = 65535; // 重置航点状态
            current_state_ = MissionState::IDLE;
            
            ROS_INFO("Ready for next mission");
        }
    }

    // 处理RTL模式状态
    void handleRTLModeState() {
        static ros::Time rtl_start_time = ros::Time::now();
        static bool rtl_timer_initialized = false;
        const double rtl_timeout = 600.0;
        
        if (!rtl_timer_initialized) {
            rtl_start_time = ros::Time::now();
            rtl_timer_initialized = true;
            ROS_INFO("RTL started");
        }

        double elapsed_time = (ros::Time::now() - rtl_start_time).toSec();
        if (elapsed_time > rtl_timeout) {
            ROS_ERROR("RTL timeout after %.1f seconds", elapsed_time);
            current_state_ = MissionState::ERROR;
            rtl_timer_initialized = false;
            return;
        }

        // 核心功能：检查是否接近起飞点并触发二维码降落
        // 在AUTO.RTL或AUTO.LOITER模式下都要持续监控距离
        if (!aruco_landing_triggered_ && isNearTakeoffPoint()) {
            ROS_INFO("Near takeoff point detected, checking heading stability...");
            
            // 新增：检查机头朝向是否已经回正稳定
            if (isHeadingStabilized()) {
                ROS_INFO("Heading stabilized, preparing ArUco landing...");
                
                // 切换到OFFBOARD模式以便二维码控制
                if (setMode("OFFBOARD")) {
                    ROS_INFO("Switched to OFFBOARD mode, waiting for stability");
                    
                    // 等待模式稳定后触发二维码降落
                    ros::Duration(1.0).sleep();
                    
                    triggerArucoLanding();
                    current_state_ = MissionState::ARUCO_LANDING;
                    rtl_timer_initialized = false;
                    return;
                } else {
                    ROS_WARN("Failed to switch to OFFBOARD, continuing RTL");
                }
            } else {
                // 机头还没有稳定，继续等待
                static ros::Time last_heading_wait_msg = ros::Time(0);
                if ((ros::Time::now() - last_heading_wait_msg).toSec() > 5.0) {
                    ROS_INFO("Waiting for heading to stabilize before ArUco landing...");
                    last_heading_wait_msg = ros::Time::now();
                }
            }
        }

        // 修改：在AUTO.LOITER模式下继续监控，不要立即结束任务
        if (mavros_state_.mode == "AUTO.RTL" || mavros_state_.mode == "AUTO.LOITER" || 
            mavros_state_.mode == "LOITER") {
            // 在RTL或LOITER模式下继续监控，直到触发二维码降落或手动停止
            static ros::Time last_status_print = ros::Time(0);
            if ((ros::Time::now() - last_status_print).toSec() > 10.0) {
                if (mavros_state_.mode == "AUTO.LOITER" || mavros_state_.mode == "LOITER") {
                    ROS_INFO("RTL LOITER monitoring - %s, armed: %s, time: %.1fs (monitoring distance)", 
                             mavros_state_.mode.c_str(), 
                             mavros_state_.armed ? "yes" : "no",
                             elapsed_time);
                } else {
                    ROS_INFO("RTL active - %s, armed: %s, time: %.1fs", 
                             mavros_state_.mode.c_str(), 
                             mavros_state_.armed ? "yes" : "no",
                             elapsed_time);
                }
                last_status_print = ros::Time::now();
            }
        } else {
            // 只有在非RTL/LOITER模式下才结束任务
            ROS_INFO("RTL mode changed to %s", mavros_state_.mode.c_str());
            
            if (mavros_state_.mode == "AUTO.LAND" || mavros_state_.mode == "LAND" || 
                !mavros_state_.armed) {
                ROS_INFO("RTL completed without aruco landing (final landing detected)");
                
                mission_triggered_ = false;
                waypoints_uploaded_ = false;
                waypoints_cleared_ = false;
                reached_waypoints_.clear();
                rtl_triggered_ = false;
                takeoff_recorded_ = false;
                aruco_landing_triggered_ = false;
                last_reached_waypoint_ = 65535; // 重置航点状态
                current_state_ = MissionState::IDLE;
                rtl_timer_initialized = false;
                
                ROS_INFO("Ready for next mission");
            } else {
                ROS_WARN("RTL interrupted by unexpected mode change to %s", mavros_state_.mode.c_str());
                
                mission_triggered_ = false;
                waypoints_uploaded_ = false;
                waypoints_cleared_ = false;
                reached_waypoints_.clear();
                rtl_triggered_ = false;
                takeoff_recorded_ = false;
                aruco_landing_triggered_ = false;
                last_reached_waypoint_ = 65535; // 重置航点状态
                current_state_ = MissionState::IDLE;
                rtl_timer_initialized = false;
                
                ROS_INFO("Controller reset due to mode change");
            }
        }
    }

    // 处理二维码降落状态
    void handleArucoLandingState() {
        static ros::Time aruco_start_time = ros::Time::now();
        static bool aruco_timer_initialized = false;
        const double aruco_timeout = 180.0; // 3分钟超时
        
        if (!aruco_timer_initialized) {
            aruco_start_time = ros::Time::now();
            aruco_timer_initialized = true;
            ROS_INFO("ArUco landing started, waiting for completion...");
        }

        // 检查二维码降落超时
        double elapsed_time = (ros::Time::now() - aruco_start_time).toSec();
        if (elapsed_time > aruco_timeout) {
            ROS_ERROR("ArUco landing timeout (%.1fs), switching to emergency landing", elapsed_time);
            setMode("AUTO.LAND");
            current_state_ = MissionState::ERROR;
            aruco_timer_initialized = false;
            return;
        }

        // 检查是否已经降落（无人机上锁表示降落完成）
        if (!mavros_state_.armed) {
            ROS_INFO("ArUco landing complete, vehicle disarmed");
            
            // 重置所有状态
            mission_triggered_ = false;
            waypoints_uploaded_ = false;
            waypoints_cleared_ = false;
            reached_waypoints_.clear();
            rtl_triggered_ = false;
            aruco_landing_triggered_ = false;
            takeoff_recorded_ = false;
            last_reached_waypoint_ = 65535; // 重置航点状态
            current_state_ = MissionState::IDLE;
            aruco_timer_initialized = false;
            
            ROS_INFO("Mission fully complete, controller reset, ready for next mission");
            return;
        }
        
        // 检查飞行模式变化
        if (mavros_state_.mode == "AUTO.LAND" || mavros_state_.mode == "LAND") {
            ROS_INFO("PX4 landing mode detected, ArUco landing may be complete or switched to PX4 landing");
            
            static ros::Time last_status_print = ros::Time(0);
            if ((ros::Time::now() - last_status_print).toSec() > 5.0) {
                ROS_INFO("ArUco landing in progress - mode: %s, armed: %s, time: %.1fs", 
                         mavros_state_.mode.c_str(), 
                         mavros_state_.armed ? "YES" : "NO",
                         elapsed_time);
                last_status_print = ros::Time::now();
            }
        } else if (mavros_state_.mode != "OFFBOARD") {
            ROS_WARN("Unexpected mode change during ArUco landing: %s", mavros_state_.mode.c_str());
        }

        // 定期状态报告
        static ros::Time last_status_print = ros::Time(0);
        if ((ros::Time::now() - last_status_print).toSec() > 10.0) {
            ROS_INFO("ArUco landing in progress - mode: %s, armed: %s, time: %.1fs", 
                     mavros_state_.mode.c_str(), 
                     mavros_state_.armed ? "YES" : "NO",
                     elapsed_time);
            last_status_print = ros::Time::now();
        }
    }

    // 处理错误状态
    void handleErrorState() {
        ROS_ERROR("Mission error, switching to LOITER");
        setMode("AUTO.LOITER");
        
        clearWaypoints();
        
        mission_triggered_ = false;
        waypoints_uploaded_ = false;
        waypoints_cleared_ = false;
        reached_waypoints_.clear();
        rtl_triggered_ = false;
        takeoff_recorded_ = false;
        aruco_landing_triggered_ = false;
        last_reached_waypoint_ = 65535; // 重置航点状态
        current_state_ = MissionState::IDLE;
        
        ROS_WARN("Controller reset due to error");
    }

    // ROS相关成员
    ros::NodeHandle nh_;
    ros::Subscriber mission_trigger_sub_;
    ros::Subscriber mavros_state_sub_;
    ros::Subscriber pose_sub_;
    ros::Subscriber uav_state_sub_;
    ros::Subscriber waypoint_reached_sub_;
    ros::Subscriber mqtt_waypoints_sub_;  // 新增：MQTT航点数据订阅器
    ros::Subscriber gps_sub_;             // 新增：GPS数据订阅器
    ros::Subscriber lidar_sub_;           // 新增：激光雷达数据订阅器
    ros::Subscriber aruco_detection_sub_; // 新增：ArUco检测数据订阅器
    ros::Publisher aruco_trigger_pub_;    // 新增：二维码降落触发发布器
    ros::Publisher waypoint_status_pub_;  // 新增：航点状态发布器（发布到prometheus/state）
    ros::ServiceClient waypoint_push_client_;
    ros::ServiceClient waypoint_clear_client_;  // 新增：航点清除客户端
    ros::ServiceClient set_mode_client_;
    ros::ServiceClient arming_client_;
    ros::Timer control_timer_;

    // 状态变量
    MissionState current_state_;
    bool mission_triggered_;
    bool waypoints_uploaded_;
    bool waypoints_cleared_;  // 新增：是否已尝试清除航点
    mavros_msgs::State mavros_state_;
    geometry_msgs::PoseStamped current_pose_;
    uavcontrol_msgs::UAVState uav_state_;

    // 航点数据
    std::vector<mavros_msgs::Waypoint> default_waypoints_;
    std::vector<int> reached_waypoints_;
    
    // Home position related members
    ros::Subscriber home_pos_sub_;
    double home_lat_, home_lon_, home_alt_;
    bool home_received_;

    // 新增成员变量
    int uav_id_;
    bool rtl_triggered_;
    
    // 二维码降落集成相关成员变量
    double takeoff_lat_, takeoff_lon_, takeoff_alt_;  // 起飞点GPS坐标
    bool takeoff_recorded_;                          // 是否已记录起飞点
    bool aruco_landing_triggered_;                   // 是否已触发二维码降落
    double current_lat_, current_lon_, current_alt_; // 当前GPS坐标
    bool gps_available_;                             // GPS是否可用
    
    // 新增：激光雷达高度数据
    double lidar_height_;                            // 激光雷达高度
    bool lidar_available_;                           // 激光雷达数据是否可用
    ros::Time last_lidar_time_;                      // 最后接收激光雷达数据的时间
    
    // 新增：ArUco深度数据
    double aruco_height_;                            // ArUco检测深度
    bool aruco_depth_available_;                     // ArUco深度数据是否可用
    ros::Time last_aruco_time_;                      // 最后接收ArUco数据的时间
    
    // 新增：高度融合权重参数
    double aruco_fusion_weight_;                     // ArUco深度数据融合权重
    double lidar_fusion_weight_;                     // 激光雷达数据融合权重
    double gps_fusion_weight_;                       // GPS数据融合权重
    
    // 新增：数据超时参数
    double lidar_timeout_;                           // 激光雷达数据超时时间
    double aruco_timeout_;                           // ArUco数据超时时间
    bool enable_fusion_debug_;                       // 启用融合调试输出
    
    // 航点状态相关成员变量
    uint16_t last_reached_waypoint_;                 // 最后到达的航点序号（-1表示尚未到达任何航点）
    
    // 新增：机头朝向检查相关成员变量
    double current_yaw_;                             // 当前偏航角（弧度）
    double target_yaw_;                              // 目标偏航角（弧度）
    double yaw_tolerance_;                           // 偏航角容忍度（弧度）
    int yaw_stability_count_;                        // 偏航角稳定计数器
    int min_yaw_stability_count_;                    // 最小稳定计数要求
    bool enable_heading_check_;                      // 是否启用机头朝向检查
};

#endif // MISSION_WAYPOINT_H 



