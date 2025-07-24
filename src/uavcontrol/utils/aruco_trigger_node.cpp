#include <ros/ros.h>
#include <std_msgs/Bool.h>
#include <iostream>
#include <string>
#include <cctype> // Required for std::tolower

class ArucoTriggerNode {
public:
    ArucoTriggerNode() : nh_("~") {
        // 发布到 /aruco_landing 话题
        trigger_pub_ = nh_.advertise<std_msgs::Bool>("/aruco_landing", 10);
        
        ROS_INFO("Aruco Trigger Node initialized");
        ROS_INFO("Publishing to topic: /aruco_landing");
    }
    
    void publishTrigger(bool trigger_value) {
        std_msgs::Bool msg;
        msg.data = trigger_value;
        
        trigger_pub_.publish(msg);
        
        ROS_INFO("Published trigger: %s", trigger_value ? "START" : "STOP");
    }
    
    void runInteractiveMode() {
        std::string input;
        
        std::cout << "\n========== Aruco Landing Trigger Control ==========" << std::endl;
        std::cout << "Commands:" << std::endl;
        std::cout << "  start / s / 1    - Start aruco landing" << std::endl;
        std::cout << "  stop / t / 0     - Stop aruco landing" << std::endl;
        std::cout << "  quit / q         - Quit program" << std::endl;
        std::cout << "===================================================" << std::endl;
        
        while (ros::ok()) {
            std::cout << "\nEnter command: ";
            std::getline(std::cin, input);
            
            // 转换为小写
            std::transform(input.begin(), input.end(), input.begin(), ::tolower);
            
            if (input == "start" || input == "s" || input == "1") {
                publishTrigger(true);
            }
            else if (input == "stop" || input == "t" || input == "0") {
                publishTrigger(false);
            }
            else if (input == "quit" || input == "q") {
                ROS_INFO("Exiting...");
                break;
            }
            else {
                std::cout << "Invalid command. Use 'start', 'stop', or 'quit'" << std::endl;
            }
            
            ros::spinOnce();
        }
    }

private:
    ros::NodeHandle nh_;
    ros::Publisher trigger_pub_;
};

void printUsage(const char* program_name) {
    std::cout << "Usage:" << std::endl;
    std::cout << "  " << program_name << " [start|stop]" << std::endl;
    std::cout << "  " << program_name << " interactive" << std::endl;
    std::cout << std::endl;
    std::cout << "Examples:" << std::endl;
    std::cout << "  " << program_name << " start        # Send start trigger and exit" << std::endl;
    std::cout << "  " << program_name << " stop         # Send stop trigger and exit" << std::endl;
    std::cout << "  " << program_name << " interactive  # Enter interactive mode" << std::endl;
    std::cout << "  " << program_name << "              # Default to interactive mode" << std::endl;
}

int main(int argc, char** argv) {
    ros::init(argc, argv, "aruco_trigger_node");
    
    ArucoTriggerNode trigger_node;
    
    // 等待发布者建立连接
    ros::Duration(0.5).sleep();
    
    if (argc > 1) {
        std::string command = argv[1];
        std::transform(command.begin(), command.end(), command.begin(), ::tolower);
        
        if (command == "start") {
            trigger_node.publishTrigger(true);
            ROS_INFO("Start trigger sent. Exiting...");
            return 0;
        }
        else if (command == "stop") {
            trigger_node.publishTrigger(false);
            ROS_INFO("Stop trigger sent. Exiting...");
            return 0;
        }
        else if (command == "interactive") {
            trigger_node.runInteractiveMode();
            return 0;
        }
        else if (command == "help" || command == "-h" || command == "--help") {
            printUsage(argv[0]);
            return 0;
        }
        else {
            std::cout << "Unknown command: " << command << std::endl;
            printUsage(argv[0]);
            return 1;
        }
    }
    else {
        // 默认进入交互模式
        trigger_node.runInteractiveMode();
    }
    
    return 0;
} 
