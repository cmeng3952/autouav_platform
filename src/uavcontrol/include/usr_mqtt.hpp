#ifndef USR_MQTT_HPP
#define USR_MQTT_HPP
#include <usr_mqtt.hpp>
#include <mqtt/async_client.h>
#include <mutex>
#include <atomic>
#include <thread>
#include <chrono>
#include <condition_variable>
#include <nlohmann/json.hpp>
#include <ros/ros.h>
#include <geometry_msgs/PoseStamped.h>
#include <sensor_msgs/NavSatFix.h>
#include <mavros_msgs/ParamSet.h>  // 新增：PX4参数设置服务

using json = nlohmann::json;

struct TrajectoryParams {
    int type = 0;          // 轨迹类型
    float radius = 1.5;    // 半径
    float duration = 60.0; // 持续时间
    bool updated = false;  // 更新标志
};
class MQTTBridge : public mqtt::callback {
private:
    std::unique_ptr<mqtt::async_client> mqtt_client;
    std::string mqtt_sub_topic;
    std::string mqtt_pub_topic;
    std::string mqtt_user;
    std::string mqtt_password;
    std::string mqtt_broker;
    std::string client_id;
    std::mutex mtx; // Mutex for thread safety
    std::atomic<bool> is_connected{false};
    std::condition_variable cv;
    TrajectoryParams traj_params_;    //轨迹处理
    
    // GPS 数据成员
    ros::NodeHandle nh_;
    ros::Subscriber gps_sub_;
    ros::ServiceClient px4_param_set_client_;  // 新增：PX4参数设置客户端
    int uav_id_;  // 新增：UAV ID
    double current_latitude_{0.0};
    double current_longitude_{0.0};
    double current_altitude_{0.0};
    bool gps_available_{false};

    // 定义 DroneCommand 结构体为类的成员
    struct DroneCommand {
            // 起飞相关
            int take_off = 0;
            float mqtt_takeoff_height = 0.0;//mqtt起飞高度
            
            // 降落相关
            int land = 0;
            float mqtt_land_vel = 0.5f;  // mqtt降落速度


            
            
            // 返航相关
            int RTL = 0;
            float mqtt_rtl_height = 5.0f;  // mqtt返航高度
           
            std::vector<float> Velocity = {0.0f, 0.0f, 0.0f, 0.0f};
            std::vector<std::vector<float>> Position; // 改为二维数组
            int Hover = 0;
            int Trajectory_ctrl = 0;
            int Mission = 0;

            int UnlockAndSetMode = 0; // 新增指令标志
    } drone_cmd;

    void reconnect() {
        while (!is_connected) {
            try {
                mqtt_client->connect()->wait();
                is_connected = true;
                ROS_INFO("Reconnected to MQTT server: %s", mqtt_broker.c_str());
            } catch (const mqtt::exception& e) {
                ROS_ERROR("Reconnection failed: %s", e.what());
                std::this_thread::sleep_for(std::chrono::seconds(5)); // Backoff before retrying
            }
        }
    }

    // 新增：设置PX4参数的函数
    bool setPX4Parameter(const std::string& param_name, float value) {
        if (!px4_param_set_client_.exists()) {
            ROS_ERROR("PX4 parameter service not available");
            return false;
        }

        mavros_msgs::ParamSet srv;
        srv.request.param_id = param_name;
        srv.request.value.real = value;

        if (px4_param_set_client_.call(srv)) {
            if (srv.response.success) {
                ROS_INFO("Successfully set PX4 parameter %s = %.2f", param_name.c_str(), value);
                return true;
            } else {
                ROS_ERROR("Failed to set PX4 parameter %s (parameter rejected or invalid)", param_name.c_str());
                return false;
            }
        } else {
            ROS_ERROR("Failed to call PX4 parameter service for %s", param_name.c_str());
            return false;
        }
    }
    

public:
    nlohmann::json j;

    //user use
    int usr_cmd = 0;
    std::vector<float> xyzYaw = {0.0f, 0.0f, 0.0f, 0.0f};
    std::vector<std::vector<float>> waypoints;//储存所有航点
    std::vector<float> wp_new;
    float via_var = 0;

    // 添加获取轨迹参数的接口
    TrajectoryParams& getTrajParams() { 
        return traj_params_; 
    }
    // 公共访问器
    float getTakeoffHeight() const { return drone_cmd.mqtt_takeoff_height; }
    float getLandVelocity() const { return drone_cmd.mqtt_land_vel; }
    float getRTLHeight() const { return drone_cmd.mqtt_rtl_height; }


    MQTTBridge(const std::string& broker,
               const std::string& username,
               const std::string& password,
               const std::string& pub_topic,
               const std::string& sub_topic,
               int uav_id = 1)  // 新增：UAV ID参数，默认为1
        : mqtt_broker(broker),
          mqtt_user(username),
          mqtt_password(password),
          mqtt_pub_topic(pub_topic),
          mqtt_sub_topic(sub_topic),
          uav_id_(uav_id) {  // 新增：初始化UAV ID
        client_id = "mqtt_client_" + std::to_string(std::chrono::system_clock::now().time_since_epoch().count());
        
        // 初始化 GPS 订阅器
        gps_sub_ = nh_.subscribe<sensor_msgs::NavSatFix>("/uav" + std::to_string(uav_id_) + "/mavros/global_position/global", 1, 
                                                        &MQTTBridge::gpsCallback, this);
        
        // 新增：初始化PX4参数设置客户端
        px4_param_set_client_ = nh_.serviceClient<mavros_msgs::ParamSet>("/uav" + std::to_string(uav_id_) + "/mavros/param/set");
        
        initMQTT();
    }

    ~MQTTBridge() {
        try {
            if (mqtt_client->is_connected()) {
                mqtt_client->disconnect()->wait();
                ROS_INFO("Disconnected from MQTT server: %s", mqtt_broker.c_str());
            }
        } catch (const mqtt::exception& e) {
            ROS_ERROR("Disconnection failed: %s", e.what());
        }
    }
    void clearCommand() {
        std::lock_guard<std::mutex> lock(mtx);
        usr_cmd = 0;
        drone_cmd.UnlockAndSetMode = 0; // 清除新增指令状态
    }

    void initMQTT() {
        mqtt::connect_options opts;
        opts.set_clean_session(true);
        opts.set_automatic_reconnect(true);
        opts.set_keep_alive_interval(60);

        if (!mqtt_user.empty() && !mqtt_password.empty()) {
            opts.set_user_name(mqtt_user);
            opts.set_password(mqtt_password);
        }

        // Configure SSL options for ssl:// connections
        if (mqtt_broker.find("ssl://") == 0) {
            mqtt::ssl_options ssl_opts;
            
            // Option 1: Use Alibaba Cloud EMQX certificate
            ssl_opts.set_trust_store("config/emqxsl-ca.crt"); // Alibaba Cloud EMQX SSL certificate
            ssl_opts.set_verify(true);
            
            // Option 2: Use system CA certificates (fallback)
            // ssl_opts.set_trust_store("/etc/ssl/certs/ca-certificates.crt"); // Default CA bundle on most Linux systems
            // ssl_opts.set_verify(true);
            
            // Option 3: Disable certificate verification (NOT recommended for production)
            // ssl_opts.set_verify(false);
            
            // Note: ALPN is not typically required for MQTT over TLS
            opts.set_ssl(ssl_opts);
            ROS_INFO("SSL/TLS connection configured for MQTT broker");
        }

        mqtt_client = std::make_unique<mqtt::async_client>(mqtt_broker, client_id);
        mqtt_client->set_callback(*this);

        try {
            mqtt_client->connect(opts)->wait();
            is_connected = true;
            mqtt_client->start_consuming();
            mqtt_client->subscribe(mqtt_sub_topic, 1);
            ROS_INFO("Connected to MQTT server: %s", mqtt_broker.c_str());
        } catch (const mqtt::exception& e) {
            ROS_FATAL("MQTT Connection failed: %s", e.what());
            ros::shutdown();
        }
    }

    void message_arrived(mqtt::const_message_ptr msg) override {
        std::lock_guard<std::mutex> lock(mtx);
        ROS_INFO("Received message on topic [%s]: %s", msg->get_topic().c_str(), msg->get_payload().c_str());
        try {
            j = nlohmann::json::parse(msg->get_payload());
            dataProcess();
        } catch (const nlohmann::json::exception& e) {
            ROS_ERROR("JSON Parsing error: %s", e.what());
        }
    }

    void connection_lost(const std::string& cause) override {
        std::lock_guard<std::mutex> lock(mtx);
        ROS_ERROR("Connection lost: %s", cause.c_str());
        is_connected = false;
        cv.notify_all();
    }

    void publish(const std::string& payload, int qos = 0) {
        std::lock_guard<std::mutex> lock(mtx);
        try {
            auto msg = mqtt::make_message(mqtt_pub_topic, payload);
            msg->set_qos(qos);
            mqtt_client->publish(msg);
        } catch (const mqtt::exception& e) {
            ROS_ERROR("Publish failed: %s", e.what());
        }
    }

    void publishToTopic(const std::string& topic, const std::string& payload, int qos = 0) {
        std::lock_guard<std::mutex> lock(mtx);
        try {
            auto msg = mqtt::make_message(topic, payload);
            msg->set_qos(qos);
            mqtt_client->publish(msg);
        } catch (const mqtt::exception& e) {
            ROS_ERROR("Publish failed: %s", e.what());
        }
    }

    void subscribe(const std::string& topic, int qos = 1) {
        std::lock_guard<std::mutex> lock(mtx);
        try {
            mqtt_client->subscribe(topic, qos);
            ROS_INFO("Subscribed to topic: %s", topic.c_str());
        } catch (const mqtt::exception& e) {
            ROS_ERROR("Subscribe failed: %s", e.what());
        }
    }

    void wait_for_connection() {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [this] { return is_connected.load(); });
    }
    
    // GPS 回调函数
    void gpsCallback(const sensor_msgs::NavSatFix::ConstPtr& msg) {
        std::lock_guard<std::mutex> lock(mtx);
        current_latitude_ = msg->latitude;
        current_longitude_ = msg->longitude;
        current_altitude_ = msg->altitude;
        gps_available_ = true;
        
        // 打印接收到的GPS坐标（每10秒打印一次，避免过于频繁）
        static ros::Time last_print_time = ros::Time::now();
        if ((ros::Time::now() - last_print_time).toSec() > 10.0) {
            ROS_INFO("GPS位置更新: 纬度=%.8f, 经度=%.8f, 高度=%.2f", 
                     current_latitude_, current_longitude_, current_altitude_);
            last_print_time = ros::Time::now();
        }
    }
 
  
    void dataProcess() {
        try {
            if (j.contains("command")) {
                const auto& cmd = j["command"];
                const json* cmd_ptr = cmd.is_array() ? &cmd[0] : &cmd;

                if (cmd_ptr) {
                    const auto& cmd_data = *cmd_ptr;


                    // 新增：解析解锁并设置模式的指令
                    if (cmd_data.contains("UnlockAndSetMode")) {
                        drone_cmd.UnlockAndSetMode = 1;
                        usr_cmd = 1; // 设置指令码为9
                        ROS_INFO("Received UnlockAndSetMode command via MQTT");
                    }

                    // 起飞指令解析
                    if (cmd_data.contains("Takeoff")) {
                        const auto& takeoff_cmd = cmd_data["Takeoff"];
                        drone_cmd.take_off = 1;  // 标志位设为1
                        drone_cmd.mqtt_takeoff_height = takeoff_cmd.value("takeoff_height", 3.0f); // 默认3米
                        usr_cmd = 1;
                    }

                    // 降落指令解析
                    if (cmd_data.contains("Land")) {
                        const auto& land_cmd = cmd_data["Land"];
                        drone_cmd.land = 1;
                        drone_cmd.mqtt_land_vel = land_cmd.value("land_vel", 0.5f); // 默认0.5m/s
                        usr_cmd = 2;
                    }

                    // 返航指令解析
                    if (cmd_data.contains("RTL")) {
                        const auto& rtl_cmd = cmd_data["RTL"];
                        drone_cmd.RTL = 1;
                        drone_cmd.mqtt_rtl_height = rtl_cmd.value("rtl height", 20.0f); // 默认20米
                        usr_cmd = 3;
                    }

                    // 悬停指令解析
                    if (cmd_data.contains("Hover")) {
                        drone_cmd.Hover = cmd_data["Hover"];
                        usr_cmd = 6;
                    }

                    // 巡航指令解析
                    if (cmd_data.contains("Mission")) {
                        drone_cmd.Mission = cmd_data["Mission"];
                        usr_cmd = 8;
                        
                        ROS_INFO("收到Mission任务指令");
                        ROS_INFO("GPS状态: %s", gps_available_ ? "可用" : "不可用");
                        if (gps_available_) {
                            ROS_INFO("当前GPS坐标: 纬度=%.8f°, 经度=%.8f°", current_latitude_, current_longitude_);
                        }
                        
                        // 新增：解析ParamData参数配置（在航点设置之前执行）
                        if (cmd_data.contains("ParamData")) {
                            const auto& param_data = cmd_data["ParamData"];
                            ROS_INFO("开始处理ParamData参数配置");
                            
                            // 处理返航高度设置
                            if (param_data.contains("rtl_height")) {
                                float rtl_height = param_data["rtl_height"].get<float>();
                                
                                // 参数有效性检查
                                if (rtl_height < 1.0f || rtl_height > 100.0f) {
                                    ROS_WARN("返航高度参数超出有效范围(1-100m): %.1fm, 使用默认值5.0m", rtl_height);
                                    rtl_height = 5.0f;
                                }
                                
                                ROS_INFO("设置PX4返航高度: %.1fm", rtl_height);
                                
                                // 设置PX4返航高度参数
                                bool rtl_set_success = setPX4Parameter("RTL_RETURN_ALT", rtl_height);
                                
                                if (rtl_set_success) {
                                    // 同时更新本地存储的返航高度
                                    drone_cmd.mqtt_rtl_height = rtl_height;
                                    ROS_INFO("PX4返航高度设置成功: %.1fm", rtl_height);
                                } else {
                                    ROS_ERROR("PX4返航高度设置失败，将使用默认值");
                                }
                            }
                            
                            // 可以在这里添加其他PX4参数的设置
                            // 例如：失控保护高度、速度限制等
                            /*
                            if (param_data.contains("failsafe_alt")) {
                                float failsafe_alt = param_data["failsafe_alt"].get<float>();
                                setPX4Parameter("NAV_DLL_ACT", failsafe_alt);
                            }
                            */
                            
                            ROS_INFO("ParamData参数配置完成");
                        }
                        
                        waypoints.clear(); // 清空旧航点
                        
                        // 检查是否有 BeginPoint 定义
                        bool has_begin_point = cmd_data.contains("BeginPoint");
                        float takeoff_height = 5.0f; // 默认起飞高度
                        
                        ROS_INFO("任务类型: %s", has_begin_point ? "自动起飞模式" : "手动航点模式");
                        
                        if (has_begin_point) {
                            const auto& begin_point = cmd_data["BeginPoint"];
                            takeoff_height = begin_point.value("takeoff_height", 3.0f);
                            
                            // 如果有 BeginPoint，自动添加起飞航点（command 22 = TAKEOFF）
                            if (gps_available_) {
                                ROS_INFO("==================== 起飞航点信息 ====================");
                                ROS_INFO("当前GPS坐标 - 纬度: %.8f°, 经度: %.8f°, 高度: %.2fm", 
                                        current_latitude_, current_longitude_, current_altitude_);
                                ROS_INFO("起飞高度设置: %.1fm (相对高度)", takeoff_height);
                                
                                waypoints.push_back({
                                    3.0f,                           // FRAME_GLOBAL_REL_ALT = 3
                                    22.0f,                          // NAV_TAKEOFF = 22
                                    static_cast<float>(current_latitude_),    // 当前纬度
                                    static_cast<float>(current_longitude_),   // 当前经度
                                    takeoff_height,                 // 起飞高度
                                    NAN,                          // param1
                                    NAN,                          // param2
                                    NAN,                          // param3
                                    NAN                           // param4
                                });
                                
                                ROS_INFO("起飞航点已创建:");
                                ROS_INFO("  Frame: 3 (GLOBAL_REL_ALT)");
                                ROS_INFO("  Command: 22 (NAV_TAKEOFF)");
                                ROS_INFO("  坐标: [%.8f°, %.8f°, %.1fm]", 
                                        current_latitude_, current_longitude_, takeoff_height);
                                ROS_INFO("===================================================");
                            } else {
                                ROS_WARN("GPS数据不可用！无法创建起飞航点，请检查GPS连接状态");
                                ROS_WARN("当前GPS状态: gps_available_=%s", gps_available_ ? "true" : "false");
                            }
                        }
                        
                        // 解析MAVROS格式的航点数据
                        if (cmd_data.contains("Waypoints")) {
                            ROS_INFO("开始解析航点数据 (JSON格式: x=经度, y=纬度)");
                            if (cmd_data["Waypoints"].is_array()) {
                                for (const auto& wp : cmd_data["Waypoints"]) {
                                    if (wp.is_object()) {
                                        // MAVROS格式：frame, command, lat, lon, alt, param1, param2, param3, param4
                                        // 注意：JSON中x表示经度，y表示纬度，但MAVROS需要纬度在前，经度在后
                                        float longitude = wp.value("x", 0.0f);     // JSON中的x是经度
                                        float latitude = wp.value("y", 0.0f);      // JSON中的y是纬度
                                        
                                        waypoints.push_back({
                                            wp.value("frame", 3.0f),        // FRAME_GLOBAL_REL_ALT = 3
                                            wp.value("command", 16.0f),     // NAV_WAYPOINT = 16
                                            latitude,                        // 纬度 (MAVROS x_lat)
                                            longitude,                       // 经度 (MAVROS y_long)
                                            wp.value("z", 0.0f),            // 高度
                                            wp.value("param1", NAN),       // Hold time
                                            wp.value("param2", NAN),       // Accept radius
                                            wp.value("param3", NAN),       // Pass radius
                                            wp.value("param4", NAN)        // Yaw angle
                                        });
                                    }
                                }
                                                        ROS_INFO("任务航点解析完成:");
                        ROS_INFO("  总航点数量: %zu", waypoints.size());
                        for (size_t i = 0; i < waypoints.size(); ++i) {
                            ROS_INFO("  航点%zu: cmd=%d, 坐标=[纬度:%.6f°, 经度:%.6f°, 高度:%.1fm]", 
                                     i+1, static_cast<int>(waypoints[i][1]), 
                                     waypoints[i][2], waypoints[i][3], waypoints[i][4]);
                        }
                            }
                        }
                        
                        // 最终任务总结
                        ROS_INFO("========== 任务总结 ==========");
                        ROS_INFO("任务模式: %s", has_begin_point ? "自动起飞" : "手动航点");
                        ROS_INFO("航点总数: %zu", waypoints.size());
                        ROS_INFO("GPS状态: %s", gps_available_ ? "正常" : "异常");
                        ROS_INFO("=============================");
                    }

                    // 速度指令解析
                    if (cmd_data.contains("Velocity")) {

                        //对象格式解析
                        if (cmd_data["Velocity"].is_object()) {
                            try {
                                float vx = cmd_data["Velocity"]["vx"].get<float>();
                                float vy = cmd_data["Velocity"]["vy"].get<float>();
                                float vz = cmd_data["Velocity"]["vz"].get<float>();               
                                float yaw = cmd_data["Velocity"]["yaw"].get<float>();   
                                drone_cmd.Velocity = {vx, vy, vz, yaw};
                                usr_cmd = 4;
                                for (int i = 0; i < 4; i++) {
                                    xyzYaw[i] = drone_cmd.Velocity[i];
                                }
                            } catch (const json::exception& e) {
                                std::cerr << "Error parsing Velocity object: " << e.what() << std::endl;
                                std::cerr << "Using default [0,0,0,0]." << std::endl;
                            }
                        //数组格式解析
                        } else if (cmd_data["Velocity"].is_array() && cmd_data["Velocity"].size() == 4) {
                            drone_cmd.Velocity = cmd_data["Velocity"].get<std::vector<float>>();
                            usr_cmd = 4;
                            for (int i = 0; i < 4; i++) {
                                xyzYaw[i] = drone_cmd.Velocity[i];
                            } 
                        } else {
                            std::cerr << "Warning: 'Velocity' must be a 4-element array or a valid object. Using default [0,0,0,0]." << std::endl;
                        }
                    }

                    // 位置指令解析
                    if (cmd_data.contains("Position")) {
                        //std::lock_guard<std::mutex> lock(wp_mtx); // 加锁
                        waypoints.clear(); // 清空旧航点
    
                        if (cmd_data["Position"].is_array()) {
                            for (const auto& point : cmd_data["Position"]) {
                                if (point.is_array() && point.size() == 4) {
                                    waypoints.push_back({
                                        point[0].get<float>(), // x
                                        point[1].get<float>(), // y
                                        point[2].get<float>(), // z
                                        point[3].get<float>()  // yaw
                                    });
                                } else {
                                    ROS_WARN("Invalid waypoint format, skipping");
                                }
                            }
                            usr_cmd = 5; // 设置航点模式
                            ROS_INFO("Received %zu waypoints via MQTT", waypoints.size());
                        }
                    }
                    if (cmd_data.contains("Trajectory")) 
                    {
                        // 轨迹模式需要同时包含必要参数
                        if (cmd_data.contains("Type") && cmd_data.contains("Radius") && cmd_data.contains("Duration")) 
                        {
                            try {
                                // 安全获取参数值
                                int traj_type = cmd_data["Type"].get<int>();
                                float radius = cmd_data["Radius"].get<float>();
                                float duration = cmd_data["Duration"].get<float>();
                    
                                // 参数有效性验证
                                if (traj_type < 0 || traj_type > 1) {
                                    ROS_WARN("非法轨迹类型%d,自动设置为圆形轨迹(0)", traj_type);
                                    traj_type = 0;
                                }
                                radius = std::max(0.5f, radius);  // 最小半径0.5米
                                duration = std::max(1.0f, duration); // 最小持续时间1秒
                    
                                // 更新轨迹参数
                                this->traj_params_.type = traj_type;
                                this->traj_params_.radius = radius;
                                this->traj_params_.duration = duration;
                                this->traj_params_.updated = true;

                                        
                                        
                                // 设置轨迹控制指令
                                drone_cmd.Trajectory_ctrl = cmd_data["Trajectory"].get<int>();
                                via_var = drone_cmd.Trajectory_ctrl;
                                usr_cmd = 7; //设置轨迹模式
                    
                                ROS_INFO("轨迹指令接收成功 类型:%s 半径:%.1fm 时长:%.1fs",
                                       (traj_type == 0) ? "圆形" : "8字", radius, duration);
                                
                            } catch (const json::exception& e) {
                                ROS_ERROR("轨迹参数解析错误: %s", e.what());
                                usr_cmd = 0; // 清除错误指令
                            }
                        } 
                        else 
                        {
                            ROS_WARN("不完整的轨迹参数,需要同时包含Type/Radius/Duration");
                            usr_cmd = 0; // 拒绝不完整指令
                        }
                    }




                }
            }
        } catch (const json::exception& e) {
            ROS_ERROR("JSON parsing error: %s", e.what());
        } catch (const std::exception& e) {
            ROS_ERROR("Unexpected error: %s", e.what());
        }
    }


};
#endif // USR_MQTT_HPP
