#!/bin/bash

gnome-terminal --window -e 'bash -c "roscore; exec bash"' \
--tab -e 'bash -c "sleep 2;  roslaunch uavcontrol px4.launch; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch uavcontrol uav_estimator.launch; exec bash"' \
--tab -e 'bash -c "sleep 5; roslaunch uavcontrol arm_disarm_mqtt_bridge.launch; exec bash"' \
--tab -e 'bash -c "sleep 5; roslaunch uavcontrol uavstate_mqtt_bridge.launch; exec bash"' \

