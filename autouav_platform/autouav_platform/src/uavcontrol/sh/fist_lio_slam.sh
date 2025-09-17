#!/bin/bash

gnome-terminal --window -e 'bash -c "roscore; exec bash"' \

--tab -e 'bash -c "sleep 3; roslaunch livox_ros_driver2 msg_MID360.launch; exec bash"' \
--tab -e 'bash -c "sleep 4; roslaunch fast_lio mapping_mid360.launch; exec bash"' \

