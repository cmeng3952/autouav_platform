#!/bin/bash

gnome-terminal --window -e 'bash -c "roslaunch uavcontrol uav_outdor_control.launch; exec bash"' \
--tab -e 'bash -c "sleep 2; roslaunch uavcontrol px4.launch; exec bash"' \
--tab -e 'bash -c "sleep 2; roslaunch uavcontrol uav_command_pub.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch spirecv_ros aruco_detection.launch; exec bash"' \
--tab -e 'bash -c "sleep 5; roslaunch uavcontrol uavstate_mqtt_bridge.launch; exec bash"' \
--tab -e 'bash -c "sleep 6; roslaunch uavcontrol aruco_land.launch; exec bash"' \


