#!/bin/bash
# 脚本名称: compile_control.sh
# 脚本描述: 编译UAVcontrol控制模块

# 编译基础模块
catkin_make --source src/uavcontrol_msgs --build build/uavcontrol_msgs
catkin_make --source src/communication --build build/communication

# 编译控制模块
catkin_make --source src/uavcontrol --build build/uavcontrol

# MID360
catkin_make --source src/livox_ros_driver2/ --build build/livox_ros_driver2/ -DROS_EDITION=ROS1 
catkin_make --source src/FAST_LIO/ --build build/FAST_LIO/
