#!/bin/bash

gnome-terminal --window -e 'bash -c "roslaunch uavcontrol px4.launch; exec bash"' \
--tab -e 'bash -c "sleep 1; roslaunch uavcontrol uav_estimator.launch; exec bash"' \
--tab -e 'bash -c "sleep 2; roslaunch uavcontrol uavstate_mqtt_bridge.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol mission_planning.launch; exec bash"' \
--tab -e 'bash -c "sleep 5; roslaunch spirecv_ros aruco_detection.launch; exec bash"' \
--tab -e 'bash -c "sleep 6; roslaunch uavcontrol aruco_land.launch; exec bash"' \


