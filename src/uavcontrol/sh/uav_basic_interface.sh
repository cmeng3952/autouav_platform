#!/bin/bash

gnome-terminal --window -e 'bash -c "roslaunch uavcontrol uav_control.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol px4.launch; exec bash"'\
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol uav_command_pub.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch spirecv_ros aruco_detection.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol mqtt_bridge.launch; exec bash"' \


