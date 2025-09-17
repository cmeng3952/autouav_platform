#!/bin/bash

gnome-terminal --window -e 'bash -c "roscore; exec bash"' \
--tab -e 'bash -c "sleep 1; roslaunch uavcontrol uav_indor_control.launch; exec bash"' \
--tab -e 'bash -c "sleep 2; roslaunch uavcontrol px4.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol uav_command_pub.launch; exec bash"' \
--tab -e 'bash -c "sleep 4; roslaunch spirecv_ros aruco_detection.launch; exec bash"' \
--tab -e 'bash -c "sleep 5; roslaunch uavcontrol uavstate_mqtt_bridge.launch; exec bash"' \
--tab -e 'bash -c "sleep 6; roslaunch uavcontrol aruco_land.launch; exec bash"' \
--tab -e 'bash -c "sleep 7; roslaunch uavcontrol start_sensor_bridges.launch; exec bash"' \
