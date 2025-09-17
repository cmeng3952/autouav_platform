cmake_minimum_required(VERSION 3.5)
project(uavcontrol)

set(CMAKE_CXX_STANDARD 17)


find_package(Boost REQUIRED COMPONENTS system)
find_package(mavlink REQUIRED)
find_package(nlohmann_json REQUIRED)
find_package(catkin REQUIRED COMPONENTS
  message_generation  
  roscpp
  geometry_msgs
  nav_msgs
  sensor_msgs
  mavros
  std_msgs
  std_srvs
  tf
  tf2_ros
  tf2_eigen
  mavros_msgs
  uavcontrol_msgs
  tf2_geometry_msgs
  vision_msgs
)


# 手动设置Paho MQTT的路径
set(PAHO_MQTT_C_INCLUDE_DIRS /usr/local/include)
set(PAHO_MQTT_CPP_INCLUDE_DIRS /usr/local/include/mqtt)
set(PAHO_MQTT_C_LIBRARIES paho-mqtt3as)
set(PAHO_MQTT_CPP_LIBRARIES paho-mqttpp3)
# 添加库目录
link_directories(/usr/local/lib)

generate_messages(DEPENDENCIES std_msgs)


catkin_package(
  INCLUDE_DIRS include
  CATKIN_DEPENDS message_runtime
)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
  include/Position_Controller
  ../uavcontrol_msgs/include
  ../communication/include
  /home/amov/spirecv-ros/devel/include
  ${mavlink_INCLUDE_DIRS}
  ${PAHO_MQTT_C_INCLUDE_DIRS}
  ${PAHO_MQTT_CPP_INCLUDE_DIRS}
)

# 声明库和可执行文件
add_library(uav_controller src/uav_controller.cpp ../communication/src/param_manager.cpp)
add_library(uav_estimator src/uav_estimator.cpp)
target_link_libraries(uav_estimator ${catkin_LIBRARIES})

add_executable(uav_control_main src/uav_control_node.cpp)
add_dependencies(uav_control_main uavcontrol_gencpp)
target_link_libraries(uav_control_main ${catkin_LIBRARIES} uav_controller uav_estimator)

# 添加独立的uav_estimator节点
add_executable(uav_estimator_node src/uav_estimator_node.cpp)
add_dependencies(uav_estimator_node uavcontrol_gencpp)
target_link_libraries(uav_estimator_node ${catkin_LIBRARIES} uav_estimator)



add_executable(uav_command_pub utils/uav_command_pub.cpp)
add_dependencies(uav_command_pub uavcontrol_gencpp)

target_link_libraries(uav_command_pub ${catkin_LIBRARIES}
${PAHO_MQTT_CPP_LIBRARIES}
${PAHO_MQTT_C_LIBRARIES}
modbus # 添加这一行
)



add_executable(rc_test utils/rc_test.cpp)
add_dependencies(rc_test uavcontrol_gencpp)
target_link_libraries(rc_test ${catkin_LIBRARIES})

add_executable(joy_node utils/joy_node.cpp)
target_link_libraries(joy_node ${catkin_LIBRARIES})

add_executable(aruco_land utils/aruco_land.cpp )
target_link_libraries(aruco_land ${catkin_LIBRARIES})


add_executable(aruco_trigger_node utils/aruco_trigger_node.cpp)
target_link_libraries(aruco_trigger_node ${catkin_LIBRARIES})




add_executable(mission_waypoint_node utils/mission_waypoint.cpp)
target_link_libraries(mission_waypoint_node ${catkin_LIBRARIES})

add_executable(mission_planner utils/mission_planner.cpp)
add_dependencies(mission_planner ${catkin_EXPORTED_TARGETS})
target_link_libraries(mission_planner 
${catkin_LIBRARIES}
${PAHO_MQTT_CPP_LIBRARIES}
${PAHO_MQTT_C_LIBRARIES}
)

add_executable(uavstate_mqtt_bridge utils/uavstate_mqtt_bridge.cpp)
add_dependencies(uavstate_mqtt_bridge ${catkin_EXPORTED_TARGETS})




target_link_libraries(uavstate_mqtt_bridge
${catkin_LIBRARIES}
${PAHO_MQTT_CPP_LIBRARIES}
${PAHO_MQTT_C_LIBRARIES}
modbus #
)



# Gimbal control node
add_executable(gimbal_control_node utils/gimbal_control_node.cpp)
add_dependencies(gimbal_control_node ${catkin_EXPORTED_TARGETS})


target_link_libraries(gimbal_control_node
${catkin_LIBRARIES}
${PAHO_MQTT_CPP_LIBRARIES}
${PAHO_MQTT_C_LIBRARIES}
)


# Hangar MQTT bridge (MQTT -> ROS std_msgs/UInt8)
add_executable(hangar_mqtt_bridge utils/hangar_mqtt_bridge.cpp)
add_dependencies(hangar_mqtt_bridge ${catkin_EXPORTED_TARGETS})
target_link_libraries(hangar_mqtt_bridge
  ${catkin_LIBRARIES}
  ${PAHO_MQTT_CPP_LIBRARIES}
  ${PAHO_MQTT_C_LIBRARIES}
)

add_library(sensor_mqtt_state utils/sensor_mqtt_state.cpp)
add_library(sensor_mqtt_control utils/sensor_mqtt_control.cpp)

add_executable(sensor_mqtt_main utils/sensor_mqtt_main.cpp)
target_link_libraries(sensor_mqtt_main
  ${catkin_LIBRARIES}
  ${PAHO_MQTT_CPP_LIBRARIES}
  ${PAHO_MQTT_C_LIBRARIES}
  /home/orangepi/autouav_platform/devel/lib/libsensor_mqtt_control.so
  /home/orangepi/autouav_platform/devel/lib/libsensor_mqtt_state.so
  /usr/local/lib/libpaho-mqtt3a.so /usr/local/lib/libpaho-mqttpp3.so
  sensor_mqtt_control  
  sensor_mqtt_state    
)

add_dependencies(sensor_mqtt_main
  sensor_mqtt_control
  sensor_mqtt_state
)

# EKF2 Reset Node
add_executable(ekf2_reset_node utils/ekf2_reset_node.cpp)
add_dependencies(ekf2_reset_node ${catkin_EXPORTED_TARGETS})
target_link_libraries(ekf2_reset_node ${catkin_LIBRARIES})

install(DIRECTORY include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  FILES_MATCHING PATTERN "*.h"
)

install(DIRECTORY launch/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch
)

