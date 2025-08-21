#include <ros/ros.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/State.h>
#include <iostream>

// 保存当前飞控状态
mavros_msgs::State current_state;

// 状态回调
void state_cb(const mavros_msgs::State::ConstPtr& msg)
{
    current_state = *msg;
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "arm_disarm_console");
    ros::NodeHandle nh;

    // 订阅 /mavros/state
    ros::Subscriber state_sub = nh.subscribe<mavros_msgs::State>(
        "/uav1/mavros/state", 10, state_cb);

    // Service 客户端
    ros::ServiceClient arming_client =
        nh.serviceClient<mavros_msgs::CommandBool>("uav2/mavros/cmd/arming");

    ros::Rate rate(10.0);

    // 等待连接
    ROS_INFO("等待与飞控建立 MAVROS 连接...");
    while (ros::ok() && !current_state.connected) {
        ros::spinOnce();
        rate.sleep();
    }
    ROS_INFO("MAVROS 已连接飞控！");

    while (ros::ok())
    {
        int input;
        std::cout << "\n请输入指令：1 = 解锁，0 = 上锁，其他 = 退出\n>> ";
        std::cin >> input;

        if (input != 0 && input != 1)
        {
            std::cout << "退出程序\n";
            break;
        }

        mavros_msgs::CommandBool arm_cmd;
        arm_cmd.request.value = (input == 1);

        if (arming_client.call(arm_cmd))
        {
            if (arm_cmd.response.success)
            {
                if (input == 1)
                    std::cout << "飞控已解锁\n";
                else
                    std::cout << "飞控已上锁\n";
            }
            else
            {
                std::cout << "指令发送成功，但飞控拒绝执行\n";
            }
        }
        else
        {
            std::cout << "发送失败，请检查 MAVROS 连接\n";
        }
    }

    return 0;
}
