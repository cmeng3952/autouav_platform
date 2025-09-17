#!/bin/bash

gnome-terminal --window -e 'bash -c "roscore; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol px4.launch; exec bash"' \
--tab -e 'bash -c "sleep 4; roslaunch uavcontrol uav_estimator.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol uavstate_mqtt_bridge.launch; exec bash"' \
--tab -e 'bash -c "sleep 4; roslaunch uavcontrol mission_planning.launch; exec bash"' \
--tab -e 'bash -c "sleep 5; roslaunch cloudfly_cv detect_AruUco.launch; exec bash"' \
--tab -e 'bash -c "sleep 6; roslaunch uavcontrol aruco_land.launch; exec bash"' \
--tab -e 'bash -c "sleep 7; roslaunch uavcontrol arm_disarm_mqtt_bridge.launch; exec bash"' \
--tab -e 'bash -c "sleep 8; roslaunch uavcontrol sensor_mqtt_bridge.launch; exec bash"' 

