#!/bin/bash


gnome-terminal --window -e 'bash -c "roscore; exec bash"' \
--tab -e 'bash -c "sleep 2; roslaunch uavcontrol px4.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol uav_outdor_control.launch; exec bash"' \
--tab -e 'bash -c "sleep 4; roslaunch uavcontrol uav_command_pub.launch; exec bash"' \
--tab -e 'bash -c "sleep 5; roslaunch uavcontrol uavstate_mqtt_bridge.launch; exec bash"' \
--tab -e 'bash -c "sleep 6; roslaunch uavcontrol aruco_land.launch; exec bash"' \
--tab -e 'bash -c "sleep 7; roslaunch uavcontrol sensor_mqtt_bridge.launch; exec bash"' \
--tab -e 'bash -c "sleep 8; roslaunch cloudfly_cv detect_AruUco.launch; exec bash"' \
--tab -e 'bash -c "sleep 9; roslaunch uavcontrol arm_disarm_mqtt_bridge.launch; exec bash"' \
