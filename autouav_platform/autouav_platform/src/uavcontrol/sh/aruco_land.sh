#!/bin/bash

gnome-terminal --window -e 'bash -c "roscore; exec bash"' \
--tab -e 'bash -c "sleep 3;  roslaunch uavcontrol px4.launch; exec bash"' \
--tab -e 'bash -c "sleep 4; roslaunch uavcontrol uav_estimator.launch; exec bash"' \
--tab -e 'bash -c "sleep 5; roslaunch cloudfly_cv detect_AruUco.launch; exec bash"' \
--tab -e 'bash -c "sleep 6; roslaunch uavcontrol aruco_land_with_offset.launch; exec bash"' \


