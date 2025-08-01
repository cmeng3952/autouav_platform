#include <ros/ros.h>
#include "uav_estimator.h"
#include <signal.h>

void mySigintHandler(int sig)
{
    ROS_INFO("[uav_estimator_node] exit...");
    ros::shutdown();
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "uav_estimator_node");
    ros::NodeHandle nh("~");
    ros::Rate rate(50.0);

    signal(SIGINT, mySigintHandler);
    ros::Duration(1.0).sleep();

    bool sim_mode, flag_printf;
    nh.param<bool>("sim_mode", sim_mode, true);
    nh.param<bool>("flag_printf", flag_printf, true);

    // 只创建UAV_estimator实例
    UAV_estimator uav_estimator(nh);

    // 检查PX4连接状态
    while (ros::ok() && !uav_estimator.uav_state.connected)
    {
        ROS_ERROR_STREAM_ONCE("Waiting for connect PX4!");
        ros::spinOnce();
        //此处需设置4或4以上的值,不然将导致uav_estimator启动失败的BUG
        ros::Duration(4).sleep();
    }

    ros::spinOnce();
    ros::Duration(1.0).sleep();

    ros::Time time_now = ros::Time::now();
    ros::Time time_last = ros::Time::now();
    time_last.sec = time_last.sec - 10;

    ROS_INFO("[uav_estimator_node] started successfully!");

    // 主循环 - 只运行estimator相关逻辑
    while (ros::ok())
    {
        // 回调函数处理
        ros::spinOnce();

        // 定时状态打印
        time_now = ros::Time::now();
        if ((time_now - time_last).toSec() > 5.0 /* 秒 */ && flag_printf)
        {
            uav_estimator.printf_uav_state();
            time_last = time_now;
        }

        rate.sleep();
    }

    return 0;
} 