#define TRA_WINDOW 2000
#include <ros/ros.h>
#include <Eigen/Eigen>
#include <atomic>
#include <mutex>
#include <string>
#include <vector>
#include <sstream>
#include <locale.h>
#include "controller_test.h"
#include <uavcontrol_msgs/UAVCommand.h>
#include <uavcontrol_msgs/UAVState.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/RCIn.h>
#include <uavcontrol_msgs/UAVSetup.h>
#include <uavcontrol_msgs/UAVControlState.h>
#include <uavcontrol_msgs/TextInfo.h>
#include <nav_msgs/Path.h>
#include <std_msgs/Bool.h>
#include <mavros_msgs/SetMode.h>
#include "usr_mqtt.hpp"
#include <geometry_msgs/PoseStamped.h>
#include <rc_input.h>
#include <std_msgs/Float32MultiArray.h>
#include <uavcontrol_msgs/GeoFence.h>

// 全局变量定义
std::vector<float> input;
std::mutex input_mtx;
std::mutex wp_mtx;
extern std::mutex global_wp_mtx;
extern std::vector<std::vector<float>> global_mission_waypoints;
uavcontrol_msgs::UAVControlState uav_control_state;
uavcontrol_msgs::UAVCommand agent_command;
uavcontrol_msgs::TextInfo text_info;
std::vector<geometry_msgs::PoseStamped> posehistory_vector_;
std_msgs::Bool stop_control_state;
Eigen::Vector3d start_pos;
ros::Time traj_start_time;
bool traj_active = false;
extern float threshold;
bool is_ground_station_control;
uavcontrol_msgs::UAVState uav_state;
std::atomic<bool> inputThreadRunning(true);
static std::vector<std::vector<float>> last_waypoints;
RC_Input rc_input;
ros::Publisher uav_setup_pub;  // 新增发布器
bool is_command_control = false; // 添加缺失的变量定义
// ros::Publisher geo_fence_pub;  // 地理围栏发布者


// MQTT 桥接类定义
class MyMQTTBridge : public MQTTBridge {
public:
    MyMQTTBridge(const std::string& broker,
                 const std::string& username,
                 const std::string& password,
                 const std::string& pub_topic,
                 const std::string& sub_topic)
        : MQTTBridge(broker, username, password, pub_topic, sub_topic) {}
};


bool executeWaypointMission(MyMQTTBridge& mqtt_bridge, 
    const uavcontrol_msgs::UAVState& uav_state,
    float threshold,
    ros::Publisher& uav_command_pub,
    uavcontrol_msgs::UAVCommand& agent_command,
    ros::Rate& loop_rate);

// 回调函数实现
void uav_state_cb(const uavcontrol_msgs::UAVState::ConstPtr& msg) {
    uav_state = *msg;
}

void uav_control_state_cb(const uavcontrol_msgs::UAVControlState::ConstPtr& msg) {
    uav_control_state = *msg;
}

void stop_control_state_cb(const std_msgs::Bool::ConstPtr& msg) {
    stop_control_state = *msg;
}

// 输入处理线程函数实现
void inputThreadFunction() {
    while (inputThreadRunning) {
        std::vector<float> temp_input;
        float num;
        while (std::cin >> num) {
            temp_input.push_back(num);
            if (std::cin.peek() == '\n') break;
        }
        std::cin.clear();
        std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
        {
            std::lock_guard<std::mutex> lock(input_mtx);
            input = std::move(temp_input);
        }
    }
}


void waypointsCallback(const std_msgs::Float32MultiArray::ConstPtr& msg, MyMQTTBridge& mqtt_bridge) {
    if (msg->data.size() % 4 != 0) {
        ROS_ERROR("Invalid waypoints format! Expected [x1,y1,z1,yaw1, x2,y2,z2,yaw2,...]");
        return;
    }
    
    std::lock_guard<std::mutex> lock(wp_mtx);
    mqtt_bridge.waypoints.clear();
    
    for (size_t i=0; i<msg->data.size(); i+=4) {
        mqtt_bridge.waypoints.push_back({
            msg->data[i],    // X
            msg->data[i+1],  // Y
            msg->data[i+2],  // Z
            msg->data[i+3]   // Yaw (度)
        });
    }
    ROS_INFO("Received %zu waypoints via ROS topic", mqtt_bridge.waypoints.size());
}


// 新增函数实现
bool executeWaypointMission(MyMQTTBridge& mqtt_bridge, 
    const uavcontrol_msgs::UAVState& uav_state,
    float threshold,
    ros::Publisher& uav_command_pub,
    uavcontrol_msgs::UAVCommand& agent_command,
    ros::Rate& loop_rate) 
{
    std::vector<std::vector<float>> current_waypoints;
    {
        std::lock_guard<std::mutex> lock(wp_mtx);
        current_waypoints = mqtt_bridge.waypoints;
        mqtt_bridge.waypoints.clear(); // 清空已获取的航点
    }

    if (current_waypoints.empty()) {
        ROS_WARN("Waypoints list is empty! Mission aborted.");
        return false;
    }

    size_t current_wp_idx = 0;
    bool mission_complete = false;
    ROS_INFO("Starting waypoint mission with %zu points", current_waypoints.size());

    while (ros::ok() && !mission_complete) 
    {
        // 计算当前航点距离
        float dx = uav_state.position[0] - current_waypoints[current_wp_idx][0];
        float dy = uav_state.position[1] - current_waypoints[current_wp_idx][1];
        float dz = uav_state.position[2] - current_waypoints[current_wp_idx][2];
        float distance = sqrt(dx*dx + dy*dy + dz*dz);

        // 到达航点阈值判断
        if (distance < threshold) 
        {
            // 更新到下一个航点
            if (++current_wp_idx >= current_waypoints.size()) 
            {
                mission_complete = true;
                ROS_INFO("All waypoints completed!");
                break;
            }
            ROS_INFO("Waypoint %zu reached, proceeding to %zu/%zu", 
                    current_wp_idx-1, current_wp_idx, current_waypoints.size());
        }

        // 发布当前航点指令
        uavcontrol_msgs::UAVCommand pos_cmd;
        pos_cmd.header.stamp = ros::Time::now();
        pos_cmd.Agent_CMD = uavcontrol_msgs::UAVCommand::Move;
        pos_cmd.Move_mode = uavcontrol_msgs::UAVCommand::XYZ_POS;
        pos_cmd.position_ref = {
            current_waypoints[current_wp_idx][0],
            current_waypoints[current_wp_idx][1],
            current_waypoints[current_wp_idx][2]
        };

        ROS_INFO("position_x %f,position_y%f,position_z%f", 
            current_waypoints[current_wp_idx][0],
            current_waypoints[current_wp_idx][1],
            current_waypoints[current_wp_idx][2]);

        pos_cmd.yaw_ref = current_waypoints[current_wp_idx][3] * M_PI / 180.0;
        pos_cmd.Command_ID = agent_command.Command_ID + 1;
        uav_command_pub.publish(pos_cmd);
        agent_command.Command_ID = pos_cmd.Command_ID;

        // 处理回调并保持循环速率
        ros::spinOnce();
        loop_rate.sleep();
    }

    // 任务完成后清理
    mqtt_bridge.clearCommand();
    return true;
}


//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>主 函 数<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
int main(int argc, char **argv)
{
    ros::init(argc, argv, "uav_command_pub");
    ros::NodeHandle nh("~");  
    setlocale(LC_ALL, "en_US.UTF-8");  
    int uav_id;
    bool sim_mode;
    Controller_Test controller_test;
    controller_test.printf_param();
    float threshold;
    //多线程实现非阻塞输入
    std::thread inputThreadObj(inputThreadFunction);
    inputThreadObj.detach();
    static bool new_mission = true;
    
    // 2. MQTT连接参数 (修正后的格式)
    std::string broker = "tcp://47.104.183.127:1983";  // mqtt服务器ip和端口号
    std::string username = "pxtest";                   //用户名
    std::string password = "test2025@px";              //密码
    std::string sub_topic = "uavcontrol/command/uav1";  // 订阅主题(改为不同主题)
    std::string pub_topic = "uavcontrol/command/uav1";  // 订阅主题(改为不同主题)
    MyMQTTBridge mqtt_bridge(broker, username, password, pub_topic, sub_topic);

    //ros外部参数 （uav_control里面定义发送PX4）
    float Takeoff_height;
    float land_speed;
    float rtl_height;
    nh.param("uav_id", uav_id, 1);
    nh.param("sim_mode", sim_mode, true);
    nh.getParam("/communication_bridge/trajectory_ground_control",is_ground_station_control);
    nh.param<float>("control/Takeoff_height", Takeoff_height, 1.5);      // 【参数】起飞高度
    nh.param<float>("control/Land_speed", land_speed, 0.6);              // 【参数】降落速度
    nh.param<float>("control/Rtl_height", rtl_height, 5.0);              // 【参数】返航高度
    nh.param<float>("control/waypoint_threshold", threshold, 0.5);  // 默认值0.5米

    std::string uav_name = "/uav" + std::to_string(uav_id);

    //【订阅】状态信息
    ros::Subscriber uav_state_sub = nh.subscribe<uavcontrol_msgs::UAVState>(uav_name + "/prometheus/state", 1, uav_state_cb);

    //【订阅】无人机控制信息
    ros::Subscriber uav_contorl_state_sub = nh.subscribe<uavcontrol_msgs::UAVControlState>(uav_name + "/prometheus/control_state", 1, uav_control_state_cb);
   
    //【订阅】无人机解锁指令
    ros::ServiceClient arming_client = nh.serviceClient<mavros_msgs::CommandBool>(uav_name + "/mavros/cmd/arming");

    //【订阅】无人机飞行模式
    ros::ServiceClient set_mode_client = nh.serviceClient<mavros_msgs::SetMode>(uav_name + "/mavros/set_mode");

    //【发布】UAVCommand
    ros::Publisher ref_trajectory_pub = nh.advertise<nav_msgs::Path>(uav_name + "/prometheus/reference_trajectory", 10);

    //【发布】UAVCommand
    ros::Publisher uav_command_pub = nh.advertise<uavcontrol_msgs::UAVCommand>(uav_name + "/prometheus/command", 1);

    //【订阅】无人机停止控制状态
    ros::Subscriber stop_control_state_sub = nh.subscribe<std_msgs::Bool>(uav_name + "/prometheus/stop_control_state", 1, stop_control_state_cb);

    //【发布】UAVCommand
    ros::Publisher text_info_pub = nh.advertise<uavcontrol_msgs::TextInfo>(uav_name + "/prometheus/text_info", 1);

    // 订阅遥控器输入，使用RC_Input类的处理函数
    ros::Subscriber rc_in_sub = nh.subscribe<mavros_msgs::RCIn>(uav_name + "/mavros/rc/in", 1, boost::bind(&RC_Input::handle_rc_data, &rc_input, _1));

    uav_setup_pub = nh.advertise<uavcontrol_msgs::UAVSetup>(uav_name + "/prometheus/setup", 1);

    auto waypoints_sub = nh.subscribe<std_msgs::Float32MultiArray>( uav_name + "/prometheus/waypoints", 1, boost::bind(&waypointsCallback, _1, std::ref(mqtt_bridge)));
    //发布二维码降落
    ros::Publisher aruco_landing_pub = nh.advertise<std_msgs::Bool>("/aruco_landing", 10);

    // 【发布】地理围栏指令
    ros::Publisher geo_fence_pub = nh.advertise<uavcontrol_msgs::GeoFence>(uav_name + "/prometheus/geo_fence", 10);

    //初始化数据
    int CMD = 0;
    stop_control_state.data = false;
    agent_command.header.stamp = ros::Time::now();
    agent_command.Agent_CMD = uavcontrol_msgs::UAVCommand::Move;
    agent_command.Move_mode = uavcontrol_msgs::UAVCommand::XYZ_POS;
    agent_command.position_ref[0] = 0.0;
    agent_command.position_ref[1] = 0.0;
    agent_command.position_ref[2] = 0.0;
    agent_command.velocity_ref[0] = 0.0;
    agent_command.velocity_ref[1] = 0.0;
    agent_command.velocity_ref[2] = 0.0;
    agent_command.acceleration_ref[0] = 0.0;
    agent_command.acceleration_ref[1] = 0.0;
    agent_command.acceleration_ref[2] = 0.0;
    agent_command.att_ref[0] = 0.0;
    agent_command.att_ref[1] = 0.0;
    agent_command.att_ref[2] = 0.0;
    agent_command.att_ref[3] = 0.0;
    agent_command.Yaw_Rate_Mode = false;
    agent_command.yaw_ref = 0.0;
    agent_command.yaw_rate_ref = 0.0;
    agent_command.Command_ID = 0;
    float time_trajectory = 0.0;
    ros::Rate r(10);
    rc_input.init();

    //----------------------------------------------------------主循环----------------------------------------------------
    while (ros::ok())
    {
        if (mqtt_bridge.isGeoFenceUpdated()) {
            const auto& fence_params = mqtt_bridge.getGeoFenceParams();
            if (fence_params.size() == 6) {
                uavcontrol_msgs::GeoFence fence_msg;
                fence_msg.x_min = fence_params[0];
                fence_msg.x_max = fence_params[1];
                fence_msg.y_min = fence_params[2];
                fence_msg.y_max = fence_params[3];
                fence_msg.z_min = fence_params[4];
                fence_msg.z_max = fence_params[5];
                
                geo_fence_pub.publish(fence_msg);
                ROS_INFO("Published geo-fence: x[%.1f, %.1f] y[%.1f, %.1f] z[%.1f, %.1f]",
                        fence_msg.x_min, fence_msg.x_max,
                        fence_msg.y_min, fence_msg.y_max,
                        fence_msg.z_min, fence_msg.z_max);
            }
            mqtt_bridge.resetGeoFenceFlag();
        }
        // 处理RC输入状态变化 (替换为修改后的代码)
        if (rc_input.enter_command_control)
        {
            // 进入COMMAND_CONTROL模式
            uavcontrol_msgs::UAVSetup setup_msg;
            setup_msg.header.stamp = ros::Time::now();
            setup_msg.cmd = 3;
            setup_msg.control_state = "COMMAND_CONTROL";
            uav_setup_pub.publish(setup_msg);
            
            ROS_INFO("遥控器切换到自动模式，已进入COMMAND_CONTROL");
            rc_input.enter_command_control = false; // 重置标志
            is_command_control = true;
        }
        else if (rc_input.enter_rc_pos_control)
        {
            // 仅在特定条件下退出COMMAND_CONTROL
            // 只有当用户主动请求退出时，或者执行完任务后
            
            // 获取当前执行的命令
            int current_cmd = 0;
            {
                std::lock_guard<std::mutex> input_lock(input_mtx);
                if(!input.empty()) {
                    current_cmd = input[0];
                } else {
                    std::lock_guard<std::mutex> mqtt_lock(wp_mtx);
                    current_cmd = mqtt_bridge.usr_cmd;
                }
            }
            
            // 仅在特定条件下退出COMMAND_CONTROL
            if (current_cmd == 0 || current_cmd == 6) {  // 无命令或悬停命令
                // 退出COMMAND_CONTROL模式，进入RC位置控制模式
                uavcontrol_msgs::UAVSetup setup_msg;
                setup_msg.header.stamp = ros::Time::now();
                setup_msg.cmd = 3;
                setup_msg.control_state = ""; // 清空控制状态
                uav_setup_pub.publish(setup_msg);
                
                ROS_INFO("遥控器切换到手动模式，已退出COMMAND_CONTROL");
                rc_input.enter_rc_pos_control = false; // 重置标志
                is_command_control = false;
                
                // 进入悬停状态
                agent_command.header.stamp = ros::Time::now();
                agent_command.Agent_CMD = uavcontrol_msgs::UAVCommand::Current_Pos_Hover;
                uav_command_pub.publish(agent_command);
            } else {
                // 执行其他命令时忽略遥控器切换
                ROS_WARN("当前正在执行命令 %d，忽略遥控器模式切换", current_cmd);
                rc_input.enter_rc_pos_control = false; // 重置标志但保持COMMAND_CONTROL
            }
        }
        
        // 只在COMMAND_CONTROL模式下处理控制命令
        if (is_command_control) {
            // mqtt指令获取
            int CMD = 0;
            {
                // 优先检查终端输入
                std::lock_guard<std::mutex> input_lock(input_mtx);
                if(!input.empty()) {
                    CMD = input[0];
                } else {
                    // 仅当无终端输入时使用MQTT指令
                    std::lock_guard<std::mutex> mqtt_lock(wp_mtx);
                    CMD = mqtt_bridge.usr_cmd;
                    mqtt_bridge.usr_cmd = 0; // 清除MQTT指令状态
                }
            }

            std::cout << " CONTROL_CMD: " << CMD << std::endl; // 打印获取指令控制模式
            if (uav_control_state.control_state != uavcontrol_msgs::UAVControlState::COMMAND_CONTROL)
            {
                ROS_WARN("Please switch to COMMAND_CONTROL mode first");
            }
            
            //--------------------------------------------对应所有控制模式---------------------------------------------------
            if (!is_ground_station_control)
            {
                // std::cout << "\033[32m" << ">>>>>>>>>>>>>>>>>>>>>>>>>>>>UAV Terminal Control<<<<<<<<<<<<<<<<<<<<<<<<< " << "\033[0m" << std::endl;
                // std::cout << "\033[32m" << "Please choose the CMD:\n"
                //      << "1 Takeoff         //一键起飞\n"
                //      << "2 Land            //一键降落\n"
                //      << "3 RTL             //一键返航\n"
                //      << "4 XYZ_VEL_BODY    //速度控制\n"
                //      << "5 XYZ_POS_ENU     //位置控制\n"
                //      << "6 Hover           //悬停\n"
                //      << "7 Trajectory      //轨迹控制\n"
                //      << "8 Mission         //自主巡航\n"
                //      << "9 aruco_land      //二维码降落\n"
                //      << "\033[0m" << std::endl;
                //     std::cout.flush(); 

                if(input.size()){
                    CMD = input[0];
                    std::cout << "CMD: " << CMD << std::endl;
                    if (input[0] == 1)
                    {
                        mqtt_bridge.via_var = input[1];
                    }
                    else if (input[0] == 2)
                    {
                        mqtt_bridge.via_var = input[1];
                    }
                    else if (input[0] == 7)
                    {
                        mqtt_bridge.via_var = input[1];
                    }
                    else if (input[0] == 4)
                    {
                        mqtt_bridge.xyzYaw[0] = input[1];
                        mqtt_bridge.xyzYaw[1] = input[2];
                        mqtt_bridge.xyzYaw[2] = input[3];
                        mqtt_bridge.xyzYaw[3] = input[4];
                    }
                    else if (input[0] == 5) {
                        // 检查输入格式是否正确（4N+1参数）
                        if((input.size()-1) % 4 != 0) {
                            ROS_ERROR("Invalid waypoint input! Requires 4N+1 parameters (CMD x1 y1 z1 yaw1 x2 y2 z2 yaw2...)");
                            break;
                        }
                        
                        // 解析航点
                        std::vector<std::vector<float>> new_waypoints;
                        for(size_t i=1; i<input.size(); i+=4) {
                            new_waypoints.push_back({
                                input[i],   // x
                                input[i+1], // y
                                input[i+2], // z
                                input[i+3]  // yaw
                            });
                        }
                        
                        // 线程安全更新
                        {
                            std::lock_guard<std::mutex> lock(wp_mtx);
                            mqtt_bridge.waypoints.insert(mqtt_bridge.waypoints.end(), new_waypoints.begin(), new_waypoints.end());
                        }
                        
                        ROS_INFO("Received %zu waypoints from terminal:", new_waypoints.size());
                        for(size_t i=0; i<new_waypoints.size(); ++i) {
                            ROS_INFO("WP%zu: [%.1f, %.1f, %.1f] yaw:%.1f", 
                                    i,
                                    new_waypoints[i][0],
                                    new_waypoints[i][1],
                                    new_waypoints[i][2],
                                    new_waypoints[i][3]);
                        }
                    }

                    input.clear();
                }
            }
            else
            {
                CMD = 9;
            }

            // 悬停模式任何时候都可以切进去
            if (CMD == 6) {
                agent_command.header.stamp = ros::Time::now();
                agent_command.Agent_CMD = uavcontrol_msgs::UAVCommand::Current_Pos_Hover;
                uav_command_pub.publish(agent_command);
                traj_active = false;
                ROS_WARN_THROTTLE(1, "强制进入悬停模式!");

                // 清理其他状态
                mqtt_bridge.clearCommand();
                mqtt_bridge.usr_cmd = 0;
                mqtt_bridge.via_var = 0;
                std::fill(mqtt_bridge.xyzYaw.begin(), mqtt_bridge.xyzYaw.end(), 0);
                {
                    std::lock_guard<std::mutex> lock(wp_mtx);
                    mqtt_bridge.waypoints.clear();
                }

                // 清零 agent_command 中的相关数据
                std::fill(agent_command.position_ref.begin(), agent_command.position_ref.end(), 0.0);
                std::fill(agent_command.velocity_ref.begin(), agent_command.velocity_ref.end(), 0.0);
                std::fill(agent_command.acceleration_ref.begin(), agent_command.acceleration_ref.end(), 0.0);
                agent_command.yaw_ref = 0.0;
                agent_command.yaw_rate_ref = 0.0;

                continue; // 跳过后续处理
            }

            // 轨迹模式可以随时退出
            if (traj_active && CMD != 7) {
                traj_active = false;
                text_info.Message = uav_name + " 轨迹模式已退出";
                text_info_pub.publish(text_info);
                agent_command.header.stamp = ros::Time::now();
                agent_command.Agent_CMD = uavcontrol_msgs::UAVCommand::Current_Pos_Hover;
                uav_command_pub.publish(agent_command);
                mqtt_bridge.clearCommand();
                // 清零 xyzyaw 数据
                std::fill(mqtt_bridge.xyzYaw.begin(), mqtt_bridge.xyzYaw.end(), 0);

                // 清零 agent_command 中的相关数据
                std::fill(agent_command.position_ref.begin(), agent_command.position_ref.end(), 0.0);
                std::fill(agent_command.velocity_ref.begin(), agent_command.velocity_ref.end(), 0.0);
                std::fill(agent_command.acceleration_ref.begin(), agent_command.acceleration_ref.end(), 0.0);
                agent_command.yaw_ref = 0.0;
                agent_command.yaw_rate_ref = 0.0;
            }

            switch (CMD)
            {
            //----------------------------------执行一键起飞模式---------------------------------
            case 1:
            {
                // 阶段1：解锁无人机
                mavros_msgs::CommandBool arm_cmd;
                arm_cmd.request.value = true;
                if (!arming_client.call(arm_cmd) || !arm_cmd.response.success) {
                    ROS_ERROR("[%s] 解锁失败! 请检查安全开关", uav_name.c_str());
                    break;
                }
                ROS_INFO("[%s] 解锁成功 >> 等待电机启动...", uav_name.c_str());
                ros::Duration(2.0).sleep(); // 等待电机初始化

                // 阶段3：发送起飞指令
                Takeoff_height = mqtt_bridge.getTakeoffHeight();
                ROS_INFO("从MQTT服务器获取的返航高度: %.2f米", Takeoff_height);
                agent_command.header.stamp = ros::Time::now();
                agent_command.Agent_CMD = uavcontrol_msgs::UAVCommand::Takeoff;
                agent_command.position_ref[2] = Takeoff_height;
                uav_command_pub.publish(agent_command);
                ROS_INFO("已发布目标高度: CMD=%d, Takeoff_height返航高度=%.2f米, Command_ID=%d",
                        agent_command.Agent_CMD, 
                        agent_command.position_ref[2],
                        agent_command.Command_ID++);
                ROS_INFO("[%s] 起飞指令已发送 >> 目标高度: %.1f米", uav_name.c_str(), Takeoff_height);

                //阶段4：进入COMMAND_CONTROL模式                
                // rc_input.forceEnterCommandControl();//由于编译报错RC_Input 没有 forceEnterCommandControl 和 force_command_control所以这里注释了，需要可以自行添加，下面有关同理
                 uavcontrol_msgs::UAVSetup setup_msg;
                 setup_msg.header.stamp = ros::Time::now();
                 setup_msg.cmd = 3;
                 setup_msg.control_state = "COMMAND_CONTROL";
                 uav_setup_pub.publish(setup_msg);
                
                // 更新状态变量
                is_command_control = true;
                
                // 验证控制状态
                ros::Duration(1.5).sleep(); // 等待状态更新
                ros::spinOnce();
                if (uav_control_state.control_state != uavcontrol_msgs::UAVControlState::COMMAND_CONTROL) {
                    ROS_WARN("[%s] 控制模式未切换，需要手动通过遥控器切换", uav_name.c_str());
                } else {
                    ROS_INFO("[%s] 已进入COMMAND_CONTROL模式", uav_name.c_str());
                }
                break;
            }

            //-------------------------------执行一键降落模式----------------------------
            case 2:
                land_speed = mqtt_bridge.getLandVelocity(); // 更新降落速度
                ROS_INFO("从MQTT服务器获取的返航高度: %.2f米", land_speed);
                agent_command.header.stamp = ros::Time::now();
                agent_command.Agent_CMD = uavcontrol_msgs::UAVCommand::Land;
                agent_command.land_speed = land_speed;
                uav_command_pub.publish(agent_command);
                ROS_INFO("已发布降落指令: CMD=%d, Land高度=%.2f米, Command_ID=%d",
                        agent_command.Agent_CMD, 
                        agent_command.land_speed,
                        agent_command.Command_ID++);
                mqtt_bridge.clearCommand(); // 关键：清除指令状态
                break;
            
            //-------------------------------执行返航模式-------------------------------  
            case 3:
            {
                // 发布返航指令UAVCommand
                rtl_height = mqtt_bridge.getRTLHeight(); // 更新返航高度
                ROS_INFO("从MQTT服务器获取的返航高度: %.2f米", rtl_height);
                agent_command.header.stamp = ros::Time::now();
                agent_command.Agent_CMD = uavcontrol_msgs::UAVCommand::RTL;
                agent_command.rtl_height = rtl_height;
                uav_command_pub.publish(agent_command);
                ROS_INFO("已发布返航指令: CMD=%d, RTL高度=%.2f米, Command_ID=%d",
                        agent_command.Agent_CMD, 
                        agent_command.rtl_height,
                        agent_command.Command_ID++);
                mqtt_bridge.clearCommand(); // 关键：清除指令状态
                break;
            }

            //---------------------------执行速度指令接口发送-----------------------------
            case 4:
            {
                uavcontrol_msgs::UAVCommand vel_cmd;
                vel_cmd.header.stamp = ros::Time::now();
                vel_cmd.Agent_CMD = uavcontrol_msgs::UAVCommand::Move;
                vel_cmd.Move_mode = uavcontrol_msgs::UAVCommand::XYZ_VEL_BODY;
                
                // 原子加载数据保证值安全
                vel_cmd.velocity_ref[0] = mqtt_bridge.xyzYaw[0];
                vel_cmd.velocity_ref[1] = mqtt_bridge.xyzYaw[1]; 
                vel_cmd.velocity_ref[2] = mqtt_bridge.xyzYaw[2];
                
                // 角度转换应在加载后立即完成
                vel_cmd.yaw_rate_ref = mqtt_bridge.xyzYaw[3] * M_PI / 180.0;
                vel_cmd.Yaw_Rate_Mode = true;
                vel_cmd.Command_ID = agent_command.Command_ID + 1;  // 确保ID递增
                uav_command_pub.publish(vel_cmd);                  
                agent_command.Command_ID = vel_cmd.Command_ID;  // 确保下次递增正确
                
                std::cout << "pos_des [X Y Z] : " << vel_cmd.velocity_ref[0] << " [ m/s ] " << vel_cmd.velocity_ref[1] << " [ m/s ] " << vel_cmd.velocity_ref[2] << " [ m/s ] " << std::endl;
                std::cout << "yaw_des : " << vel_cmd.yaw_rate_ref << " [ deg/s ] " << std::endl;
                mqtt_bridge.clearCommand(); // 关键：清除指令状态
                break;
            }

            //------------------------------执行位置指令接口发送-----------------------------------
            case 5:
            {
                executeWaypointMission(mqtt_bridge, uav_state, threshold, uav_command_pub, agent_command, r);
                break;
            }
            
            //---------------------------------执行悬停控制模式--------------------------------
            case 6:
                agent_command.header.stamp = ros::Time::now();
                agent_command.Agent_CMD = uavcontrol_msgs::UAVCommand::Current_Pos_Hover;
                uav_command_pub.publish(agent_command);
                ROS_WARN_THROTTLE(1, "强制进入悬停模式!");
                mqtt_bridge.clearCommand(); // 关键：清除指令状态
                traj_active = false;
                mqtt_bridge.clearCommand(); // 关键：清除指令状态
                std::fill(mqtt_bridge.xyzYaw.begin(), mqtt_bridge.xyzYaw.end(), 0);

                // 清零 agent_command 中的相关数据
                std::fill(agent_command.position_ref.begin(), agent_command.position_ref.end(), 0.0);
                std::fill(agent_command.velocity_ref.begin(), agent_command.velocity_ref.end(), 0.0);
                std::fill(agent_command.acceleration_ref.begin(), agent_command.acceleration_ref.end(), 0.0);
                agent_command.yaw_ref = 0.0;
                agent_command.yaw_rate_ref = 0.0;
                break;

            //---------------------------------- 轨迹控制模式---------------------------------
            case 7:
            {
                // 参数更新处理
                if (mqtt_bridge.getTrajParams().updated == true) 
                {
                    // 获取轨迹参数
                    auto& params = mqtt_bridge.getTrajParams();
                    float radius = params.radius;
                    float duration = params.duration;
                    int traj_type = params.type;

                    // 初始化轨迹参数（使用当前无人机位置作为轨迹中心）
                    start_pos << uav_state.position[0], 
                                uav_state.position[1], 
                                uav_state.position[2];
                    traj_start_time = ros::Time::now();
                    
                    // 根据类型选择控制算法
                    if(traj_type == 0) { // 圆形轨迹
                        // 计算线速度 = 周长/时间 = (2πr)/duration
                        float linear_vel = (2 * M_PI * radius) / duration;
                        // 设置圆形轨迹参数（半径、线速度、方向[1.0=逆时针]）
                        controller_test.setCircleParams(radius, linear_vel, 1.0f);
                    } else { // 8字轨迹
                        // 计算8字轨迹参数（半径，角速度=2π/(duration/2)）
                        float eight_radius = mqtt_bridge.getTrajParams().radius;
                        float eight_duration = mqtt_bridge.getTrajParams().duration;
                        float eight_omega = (2 * M_PI) / (eight_duration / 2.0f); 
                        controller_test.setEightParams(radius, eight_omega);
                    }

                    // 状态通知
                    text_info.Message = uav_name + " 启动" + 
                                    ((traj_type == 0) ? "圆形" : "8字") + "轨迹 半径:" + 
                                    std::to_string(radius) + "m 时长:" +
                                    std::to_string(duration) + "s";
                    text_info_pub.publish(text_info);

                    // 激活轨迹并清除更新标志
                    traj_active = true;
                    mqtt_bridge.getTrajParams().updated = false; 
                }

                // 轨迹运行控制
                if (traj_active) 
                {
                    // 计算已运行时间
                    float time_from_start = (ros::Time::now() - traj_start_time).toSec();
                    
                    // 生成轨迹指令
                    agent_command = (mqtt_bridge.getTrajParams().type == 0) ? 
                                controller_test.Circle_trajectory_generation(time_from_start) :
                                controller_test.Eight_trajectory_generation(time_from_start);

                    // 保持初始高度
                    agent_command.position_ref[2] = start_pos.z();

                    // 设置指令参数
                    agent_command.header.stamp = ros::Time::now();
                    agent_command.Agent_CMD = uavcontrol_msgs::UAVCommand::Move;
                    agent_command.Move_mode = uavcontrol_msgs::UAVCommand::TRAJECTORY;
                    agent_command.Command_ID++;

                    // 发布控制指令
                    uav_command_pub.publish(agent_command);

                    // 轨迹可视化处理
                    if (posehistory_vector_.size() >= TRA_WINDOW) {
                        posehistory_vector_.erase(posehistory_vector_.begin());
                    }
                    geometry_msgs::PoseStamped ref_pose;
                    ref_pose.pose.position.x = agent_command.position_ref[0];
                    ref_pose.pose.position.y = agent_command.position_ref[1];
                    ref_pose.pose.position.z = agent_command.position_ref[2];
                    posehistory_vector_.push_back(ref_pose);

                    // 完成检测
                    if (time_from_start >= mqtt_bridge.getTrajParams().duration) 
                    {
                        traj_active = false;
                        text_info.Message = uav_name + " 轨迹完成，总时长 " + 
                                        std::to_string(mqtt_bridge.getTrajParams().duration) + "s";
                        text_info_pub.publish(text_info);
                        
                        // 自动进入悬停
                        agent_command.header.stamp = ros::Time::now();
                        agent_command.Agent_CMD = uavcontrol_msgs::UAVCommand::Current_Pos_Hover;
                        uav_command_pub.publish(agent_command);
                    }
                }
                
                mqtt_bridge.clearCommand(); // 清除MQTT指令状态
                break;
            }

            //-----------------------------------执行自主任务巡航模式----------------------------
            case 8:       
            {                
                // 发布任务开始指令
                agent_command.header.stamp = ros::Time::now();
                agent_command.Agent_CMD = uavcontrol_msgs::UAVCommand::Mission;
                uav_command_pub.publish(agent_command);               
                mqtt_bridge.clearCommand(); // 关键：清除指令状态
                break;
            }

            //-----------------------------------执行二维码降落模式----------------------------
            case 9:       
            {                
                // 阶段1: 强制锁定COMMAND模式
                // rc_input.force_command_control = true; // 设置强制标志
                rc_input.enter_command_control = true;//上面注释修改成enter_command_control
                uavcontrol_msgs::UAVSetup setup_msg;
                setup_msg.header.stamp = ros::Time::now();
                setup_msg.cmd = 3;
                setup_msg.control_state = "COMMAND_CONTROL";
                uav_setup_pub.publish(setup_msg);
                ROS_INFO("[降落模式] 锁定COMMAND_CONTROL模式");

                // 阶段2: 持续发送模式心跳 (关键!)
                ros::Rate mode_rate(10); // 10Hz心跳频率
                ros::Time start_time = ros::Time::now();
                
                while (ros::ok() && (ros::Time::now() - start_time) < ros::Duration(60.0)) 
                {
                    // 持续发送模式指令
                    setup_msg.header.stamp = ros::Time::now();
                    uav_setup_pub.publish(setup_msg);

                    // 发送降落指令
                    agent_command.header.stamp = ros::Time::now();
                    agent_command.Agent_CMD = uavcontrol_msgs::UAVCommand::aruco_land;
                    uav_command_pub.publish(agent_command);

                    // 检测降落完成或异常退出
                    if (uav_state.landed || 
                        uav_control_state.control_state != uavcontrol_msgs::UAVControlState::COMMAND_CONTROL) {
                        break;
                    }

                    mode_rate.sleep();
                    ros::spinOnce();
                }

                // 阶段3: 清理状态
                // rc_input.force_command_control = false; 
                rc_input.enter_command_control = false;//上面注释修改成enter_command_control
                agent_command.header.stamp = ros::Time::now();
                agent_command.Agent_CMD = uavcontrol_msgs::UAVCommand::Current_Pos_Hover;
                uav_command_pub.publish(agent_command);
                ROS_WARN("[降落模式] 退出流程，进入悬停");
                
                break;
            }

            default:
                ROS_WARN_THROTTLE(1, "Invalid command received: %d", CMD);
                break;
            }


        }
        
        ros::spinOnce();
        r.sleep();
    }   
    
    inputThreadRunning = false;
    return 0;
}