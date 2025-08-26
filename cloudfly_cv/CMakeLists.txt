cmake_minimum_required(VERSION 2.8.3)

project(cloudfly_cv)
set(CMAKE_BUILD_TYPE "Release")
add_compile_options(-std=c++17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(PCL_LIBRARY_DIRS /usr/local/lib/)
set(PCL_INCLUDE_DIRS /usr/local/lib/)
set(PahoMqttCpp_INCLUDE_DIRS /usr/local/lib/)
find_package(catkin REQUIRED COMPONENTS
  roscpp
  sensor_msgs
  pcl_ros
  pcl_conversions
  std_srvs
  message_generation 
  std_msgs
  cv_bridge
  image_transport
)

# find_package(PahoMqttC REQUIRED)

add_message_files(
  FILES
  position.msg
)
generate_messages(
  DEPENDENCIES
  std_msgs
)
catkin_package(
 CATKIN_DEPENDS roscpp rospy std_msgs message_runtime 
 DEPENDS EIGEN3 PCL OpenCV
#  LIBRARIES mqtt_ros_bridge
)
# set(OpenCV_INCLUDE_DIRS /lib/aarch64-linux-gnu/)
set(JSONCPP_INCLUDE_DIRS /usr/lib/aarch64-linux-gnu/)
include_directories(
  ${catkin_INCLUDE_DIRS}
  ${EIGEN3_INCLUDE_DIR}
  ${PCL_INCLUDE_DIRS}
  ${OpenCV_INCLUDE_DIRS}
  include
  ${PahoMqttCpp_INCLUDE_DIRS}
  ${JSONCPP_INCLUDE_DIRS}
  # ${PahoMqttC_INCLUDE_DIRS}
  # /usr/local/lib
  # /usr/include/opencv4
)
# find_package(YAML-CPP REQUIRED)
# set(YAML_CPP_ROOT "/usr/include/yaml-cpp")
find_package(Ceres REQUIRED)
find_package(OpenCV 4.2.0 REQUIRED)

find_package(PCL 1.10 REQUIRED)
find_package(catkin REQUIRED COMPONENTS ${PACKbhAGE_DEPENDENCIES})
find_package(jsoncpp REQUIRED)
# find_package(PahoMqttCpp REQUIRED)
include_directories(include ${catkin_INCLUDE_DIRS} ${PCL_INCLUDE_DIRS} ${OpenCV_INCLUDE_DIRS} ${JSONCPP_INCLUDE_DIRS})
link_directories(${PCL_LIBRARY_DIRS} ${JSONCPP_INCLUDE_DIRS})
add_definitions(${PCL_DEFINITIONS})
# add_executable(mqtt_pub src/mqtt_message.cpp)
# add_executable(video_dual_pub src/video_dual_pub.cpp)
add_executable(push_rtmp_stream src/push_rtmp_stream.cpp)
add_executable(detect_ArUco src/detect_ArUco.cpp include/common.h include/kalman_filter_3d.h include/marker_tracker.h
                src/kalman_filter_3d.cpp src/marker_tracker.cpp src/kalman_filter_2d.cpp include/kalman_filter_2d.h 
                src/rotation_kalman.cpp include/rotation_kalman.h)

target_link_libraries(detect_ArUco ${PCL_LIBRARIES}  ${catkin_LIBRARIES}  ${OpenCV_LIBS} /usr/lib/x86_64-linux-gnu/libjsoncpp.so 
                      /usr/local/lib/libpaho-mqtt3a.so /usr/local/lib/libpaho-mqttpp3.so)
# target_link_libraries(mqtt_pub  ${catkin_LIBRARIES}  ${OpenCV_LIBS} ${JSONCPP_LIBRARIES} /usr/lib/aarch64-linux-gnu/libjsoncpp.so 
# /usr/local/lib/libpaho-mqtt3a.so /usr/local/lib/libpaho-mqttpp3.so)

target_link_libraries(push_rtmp_stream ${catkin_LIBRARIES}  ${OpenCV_LIBS} ${JSONCPP_LIBRARIES} /usr/lib/x86_64-linux-gnu/libjsoncpp.so 
/usr/local/lib/libpaho-mqtt3a.so /usr/local/lib/libpaho-mqttpp3.so)
# target_link_libraries(video_dual_pub ${OpenCV_LIBS} ${catkin_LIBRARIES})

# python
# install(PROGRAMS
#   scripts/test.py
#   DESTINATION &{CATKIN_PACKAGE_BIN_DESTINATION}
# )
# install(
#   DIRECTORY
#   launch/
#   DESTINATION &{CATKIN_PACKAGE_SHARE_DESTINATION}/launch
# )
