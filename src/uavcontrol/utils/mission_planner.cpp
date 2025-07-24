#include <ros/ros.h>
#include <std_msgs/Float32MultiArray.h>
#include <std_msgs/Bool.h>
#include <mutex>
#include <vector>
#include "usr_mqtt.hpp"

// Forward declaration so we can declare a pointer before the full definition
class MyMQTTBridge;

// Global variables
std::mutex wp_mtx;
std::vector<std::vector<float>> global_mission_waypoints;
MyMQTTBridge* mqtt_bridge_ptr = nullptr;
 
// MyMQTTBridge wrapper adds no new functionality but provides a convenient alias
class MyMQTTBridge : public MQTTBridge {
public:
    MyMQTTBridge(const std::string& broker,
                 const std::string& username,
                 const std::string& password,
                 const std::string& pub_topic,
                 const std::string& sub_topic)
        : MQTTBridge(broker, username, password, pub_topic, sub_topic) {}
};

// Callback for MQTT command processing
void mqttCommandCallback() {
    if (!mqtt_bridge_ptr) return;
    
    std::lock_guard<std::mutex> lock(wp_mtx);
    if (mqtt_bridge_ptr->usr_cmd == 8) {
        // If MQTT command is 8, copy waypoints from mqtt_bridge to global_mission_waypoints
        global_mission_waypoints = mqtt_bridge_ptr->waypoints;
        mqtt_bridge_ptr->waypoints.clear();
        mqtt_bridge_ptr->clearCommand();
        ROS_INFO("MQTT command 8 received, copied %zu waypoints", global_mission_waypoints.size());
    }
}

int main(int argc, char **argv) {
    ros::init(argc, argv, "mission_planner");
    ros::NodeHandle nh("~");
    
    // MQTT connection parameters
    std::string broker = "tcp://47.104.183.127:1983";
    std::string username = "pxtest";
    std::string password = "test2025@px";
    std::string sub_topic = "uavcontrol/command/uav1";
    std::string pub_topic = "uavcontrol/command/uav1";
    
    // Initialize MQTT bridge
    MyMQTTBridge mqtt_bridge(broker, username, password, pub_topic, sub_topic);
    mqtt_bridge_ptr = &mqtt_bridge;
    
    // Publishers for MAVROS mission system
    ros::Publisher mqtt_waypoints_pub = nh.advertise<std_msgs::Float32MultiArray>("/mission_waypoint_mqtt_data", 1, true);
    ros::Publisher mission_waypoint_trigger_pub = nh.advertise<std_msgs::Bool>("/mission_waypoint_trigger", 10);
    
    ros::Rate r(10);
    
    while (ros::ok()) {
        // Process MQTT commands
        mqttCommandCallback();
        
        // Check if we have waypoints to send
        bool has_waypoints = false;
        {
            std::lock_guard<std::mutex> lock(wp_mtx);
            has_waypoints = !global_mission_waypoints.empty();
        }
        
        if (has_waypoints) {
            std::cout << "=== Starting MAVROS Mission with Waypoints ===" << std::endl;
            std_msgs::Float32MultiArray mqtt_waypoints_msg;
            {
                std::lock_guard<std::mutex> lock(wp_mtx);
                for (const auto &wp : global_mission_waypoints) {
                    for (float val : wp) {
                        mqtt_waypoints_msg.data.push_back(val);
                    }
                }
            }
            // Publish waypoints data to MAVROS mission system
            mqtt_waypoints_pub.publish(mqtt_waypoints_msg);
            ros::Duration(0.3).sleep(); // Wait for subscriber to process
            ROS_INFO("MAVROS mission waypoints data sent to mission controller");
            
            // Publish mission trigger signal to start MAVROS mission
            std_msgs::Bool mission_trigger;
            mission_trigger.data = true;
            mission_waypoint_trigger_pub.publish(mission_trigger);
            ROS_INFO("MAVROS Waypoint mission trigger sent - using AUTO.MISSION mode");
            
            // Clear used waypoints after triggering
            {
                std::lock_guard<std::mutex> lock(wp_mtx);
                global_mission_waypoints.clear();
            }
        }
        
        ros::spinOnce();
        r.sleep();
    }
    
    return 0;
}