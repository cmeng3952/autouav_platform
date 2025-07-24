# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "uavcontrol_msgs: 62 messages, 1 services")

set(MSG_I_FLAGS "-Iuavcontrol_msgs:/home/amov/autouav_platform/src/uavcontrol_msgs/msg;-Iuavcontrol_msgs:/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg;-Iactionlib_msgs:/opt/ros/noetic/share/actionlib_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Inav_msgs:/opt/ros/noetic/share/nav_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(uavcontrol_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg" "geometry_msgs/Quaternion:std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUAVState.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUAVState.msg" "geometry_msgs/Quaternion:uavcontrol_msgs/UAVState:std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVCommand.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVCommand.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVControlState.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVControlState.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVSetup.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVSetup.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TextInfo.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TextInfo.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GlobalAruco.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GlobalAruco.msg" "uavcontrol_msgs/ArucoInfo:std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg" "geometry_msgs/Quaternion:std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVCommand.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVCommand.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUGVState.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUGVState.msg" "geometry_msgs/Quaternion:uavcontrol_msgs/UGVState:std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionReference.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionReference.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StationCommand.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StationCommand.msg" "geometry_msgs/Point:std_msgs/Header:geometry_msgs/PoseStamped:geometry_msgs/Pose:geometry_msgs/Quaternion"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiArucoInfo.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiArucoInfo.msg" "uavcontrol_msgs/ArucoInfo:std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfo.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfo.msg" "std_msgs/Header:uavcontrol_msgs/DetectionInfo"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg" "std_msgs/Header:uavcontrol_msgs/BoundingBox"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SwarmCommand.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SwarmCommand.msg" "geometry_msgs/Point:std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/FormationAssign.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/FormationAssign.msg" "geometry_msgs/Point"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OffsetPose.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OffsetPose.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GPSData.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GPSData.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Corrections.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Corrections.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Gains.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Gains.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OutputData.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OutputData.msg" "geometry_msgs/Vector3:geometry_msgs/Quaternion:std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionCommand.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionCommand.msg" "geometry_msgs/Vector3:geometry_msgs/Point:std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PPROutputData.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PPROutputData.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Serial.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Serial.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SO3Command.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SO3Command.msg" "geometry_msgs/Vector3:geometry_msgs/Quaternion:uavcontrol_msgs/AuxCommand:std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StatusData.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StatusData.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TRPYCommand.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TRPYCommand.msg" "uavcontrol_msgs/AuxCommand:std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Odometry.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Odometry.msg" "geometry_msgs/Twist:geometry_msgs/Point:std_msgs/Header:geometry_msgs/Vector3:geometry_msgs/TwistWithCovariance:geometry_msgs/Pose:nav_msgs/Odometry:geometry_msgs/Quaternion:geometry_msgs/PoseWithCovariance"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PolynomialTrajectory.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PolynomialTrajectory.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LQRTrajectory.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LQRTrajectory.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Px4ctrlDebug.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Px4ctrlDebug.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNodeframe2.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNodeframe2.msg" "uavcontrol_msgs/LinktrackNode2"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalControl.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalControl.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalState.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalState.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfoSub.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfoSub.msg" "std_msgs/Header:uavcontrol_msgs/DetectionInfoSub"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/VisionDiff.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/VisionDiff.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/WindowPosition.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/WindowPosition.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg" "geometry_msgs/Point"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiBsplines.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiBsplines.msg" "uavcontrol_msgs/Bspline:geometry_msgs/Point"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Control.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Control.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/CustomDataSegment.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/CustomDataSegment.msg" "uavcontrol_msgs/BasicDataTypeAndValue"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ParamSettings.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ParamSettings.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomMsg.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomMsg.msg" "uavcontrol_msgs/LivoxCustomPoint:std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LedStates.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LedStates.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ShoutStates.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ShoutStates.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GeoFence.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GeoFence.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsAction.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsAction.msg" "uavcontrol_msgs/BoundingBox:uavcontrol_msgs/CheckForObjectsResult:std_msgs/Header:uavcontrol_msgs/CheckForObjectsActionGoal:uavcontrol_msgs/CheckForObjectsGoal:uavcontrol_msgs/BoundingBoxes:uavcontrol_msgs/CheckForObjectsActionFeedback:sensor_msgs/Image:uavcontrol_msgs/CheckForObjectsFeedback:uavcontrol_msgs/CheckForObjectsActionResult:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID"
)

get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg" "actionlib_msgs/GoalID:sensor_msgs/Image:std_msgs/Header:uavcontrol_msgs/CheckForObjectsGoal"
)

get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg" "uavcontrol_msgs/BoundingBox:uavcontrol_msgs/CheckForObjectsResult:std_msgs/Header:uavcontrol_msgs/BoundingBoxes:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID"
)

get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg" "actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:std_msgs/Header:uavcontrol_msgs/CheckForObjectsFeedback"
)

get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg" "sensor_msgs/Image:std_msgs/Header"
)

get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg" "uavcontrol_msgs/BoundingBox:std_msgs/Header:uavcontrol_msgs/BoundingBoxes"
)

get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg" ""
)

get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/srv/arucoTrigger.srv" NAME_WE)
add_custom_target(_uavcontrol_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uavcontrol_msgs" "/home/amov/autouav_platform/src/uavcontrol_msgs/srv/arucoTrigger.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVControlState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVSetup.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TextInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GlobalAruco.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionReference.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StationCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiArucoInfo.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SwarmCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/FormationAssign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OffsetPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GPSData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Corrections.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Gains.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OutputData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PPROutputData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Serial.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SO3Command.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StatusData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TRPYCommand.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Odometry.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/nav_msgs/cmake/../msg/Odometry.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PolynomialTrajectory.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LQRTrajectory.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Px4ctrlDebug.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNodeframe2.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalControl.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfoSub.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/VisionDiff.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/WindowPosition.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiBsplines.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Control.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/CustomDataSegment.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ParamSettings.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomMsg.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LedStates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ShoutStates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GeoFence.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsAction.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)

### Generating Services
_generate_srv_cpp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/srv/arucoTrigger.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
)

### Generating Module File
_generate_module_cpp(uavcontrol_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(uavcontrol_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(uavcontrol_msgs_generate_messages uavcontrol_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUAVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVControlState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVSetup.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TextInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GlobalAruco.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUGVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionReference.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StationCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiArucoInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SwarmCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/FormationAssign.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OffsetPose.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GPSData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Corrections.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Gains.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OutputData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PPROutputData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Serial.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SO3Command.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StatusData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TRPYCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Odometry.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PolynomialTrajectory.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LQRTrajectory.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Px4ctrlDebug.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNodeframe2.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalControl.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfoSub.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/VisionDiff.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/WindowPosition.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiBsplines.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Control.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/CustomDataSegment.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ParamSettings.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomMsg.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LedStates.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ShoutStates.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GeoFence.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsAction.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/srv/arucoTrigger.srv" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_cpp _uavcontrol_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uavcontrol_msgs_gencpp)
add_dependencies(uavcontrol_msgs_gencpp uavcontrol_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uavcontrol_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVControlState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVSetup.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TextInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GlobalAruco.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionReference.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StationCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiArucoInfo.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SwarmCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/FormationAssign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OffsetPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GPSData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Corrections.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Gains.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OutputData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PPROutputData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Serial.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SO3Command.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StatusData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TRPYCommand.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Odometry.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/nav_msgs/cmake/../msg/Odometry.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PolynomialTrajectory.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LQRTrajectory.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Px4ctrlDebug.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNodeframe2.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalControl.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfoSub.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/VisionDiff.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/WindowPosition.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiBsplines.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Control.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/CustomDataSegment.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ParamSettings.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomMsg.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LedStates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ShoutStates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GeoFence.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsAction.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)

### Generating Services
_generate_srv_eus(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/srv/arucoTrigger.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
)

### Generating Module File
_generate_module_eus(uavcontrol_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(uavcontrol_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(uavcontrol_msgs_generate_messages uavcontrol_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUAVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVControlState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVSetup.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TextInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GlobalAruco.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUGVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionReference.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StationCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiArucoInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SwarmCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/FormationAssign.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OffsetPose.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GPSData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Corrections.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Gains.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OutputData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PPROutputData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Serial.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SO3Command.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StatusData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TRPYCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Odometry.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PolynomialTrajectory.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LQRTrajectory.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Px4ctrlDebug.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNodeframe2.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalControl.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfoSub.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/VisionDiff.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/WindowPosition.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiBsplines.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Control.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/CustomDataSegment.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ParamSettings.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomMsg.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LedStates.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ShoutStates.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GeoFence.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsAction.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/srv/arucoTrigger.srv" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_eus _uavcontrol_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uavcontrol_msgs_geneus)
add_dependencies(uavcontrol_msgs_geneus uavcontrol_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uavcontrol_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVControlState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVSetup.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TextInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GlobalAruco.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionReference.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StationCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiArucoInfo.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SwarmCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/FormationAssign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OffsetPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GPSData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Corrections.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Gains.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OutputData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PPROutputData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Serial.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SO3Command.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StatusData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TRPYCommand.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Odometry.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/nav_msgs/cmake/../msg/Odometry.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PolynomialTrajectory.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LQRTrajectory.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Px4ctrlDebug.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNodeframe2.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalControl.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfoSub.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/VisionDiff.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/WindowPosition.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiBsplines.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Control.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/CustomDataSegment.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ParamSettings.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomMsg.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LedStates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ShoutStates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GeoFence.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsAction.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)

### Generating Services
_generate_srv_lisp(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/srv/arucoTrigger.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
)

### Generating Module File
_generate_module_lisp(uavcontrol_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(uavcontrol_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(uavcontrol_msgs_generate_messages uavcontrol_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUAVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVControlState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVSetup.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TextInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GlobalAruco.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUGVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionReference.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StationCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiArucoInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SwarmCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/FormationAssign.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OffsetPose.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GPSData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Corrections.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Gains.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OutputData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PPROutputData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Serial.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SO3Command.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StatusData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TRPYCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Odometry.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PolynomialTrajectory.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LQRTrajectory.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Px4ctrlDebug.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNodeframe2.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalControl.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfoSub.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/VisionDiff.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/WindowPosition.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiBsplines.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Control.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/CustomDataSegment.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ParamSettings.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomMsg.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LedStates.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ShoutStates.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GeoFence.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsAction.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/srv/arucoTrigger.srv" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_lisp _uavcontrol_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uavcontrol_msgs_genlisp)
add_dependencies(uavcontrol_msgs_genlisp uavcontrol_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uavcontrol_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVControlState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVSetup.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TextInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GlobalAruco.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionReference.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StationCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiArucoInfo.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SwarmCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/FormationAssign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OffsetPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GPSData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Corrections.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Gains.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OutputData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PPROutputData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Serial.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SO3Command.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StatusData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TRPYCommand.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Odometry.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/nav_msgs/cmake/../msg/Odometry.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PolynomialTrajectory.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LQRTrajectory.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Px4ctrlDebug.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNodeframe2.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalControl.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfoSub.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/VisionDiff.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/WindowPosition.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiBsplines.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Control.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/CustomDataSegment.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ParamSettings.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomMsg.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LedStates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ShoutStates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GeoFence.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsAction.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)

### Generating Services
_generate_srv_nodejs(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/srv/arucoTrigger.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
)

### Generating Module File
_generate_module_nodejs(uavcontrol_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(uavcontrol_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(uavcontrol_msgs_generate_messages uavcontrol_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUAVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVControlState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVSetup.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TextInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GlobalAruco.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUGVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionReference.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StationCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiArucoInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SwarmCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/FormationAssign.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OffsetPose.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GPSData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Corrections.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Gains.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OutputData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PPROutputData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Serial.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SO3Command.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StatusData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TRPYCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Odometry.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PolynomialTrajectory.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LQRTrajectory.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Px4ctrlDebug.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNodeframe2.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalControl.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfoSub.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/VisionDiff.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/WindowPosition.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiBsplines.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Control.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/CustomDataSegment.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ParamSettings.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomMsg.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LedStates.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ShoutStates.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GeoFence.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsAction.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/srv/arucoTrigger.srv" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_nodejs _uavcontrol_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uavcontrol_msgs_gennodejs)
add_dependencies(uavcontrol_msgs_gennodejs uavcontrol_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uavcontrol_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVControlState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVSetup.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TextInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GlobalAruco.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionReference.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StationCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiArucoInfo.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SwarmCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/FormationAssign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OffsetPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GPSData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Corrections.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Gains.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OutputData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PPROutputData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Serial.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SO3Command.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StatusData.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TRPYCommand.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Odometry.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/nav_msgs/cmake/../msg/Odometry.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PolynomialTrajectory.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LQRTrajectory.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Px4ctrlDebug.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNodeframe2.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalControl.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfoSub.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/VisionDiff.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/WindowPosition.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiBsplines.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Control.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/CustomDataSegment.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ParamSettings.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomMsg.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LedStates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ShoutStates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GeoFence.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsAction.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg"
  "${MSG_I_FLAGS}"
  "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)
_generate_msg_py(uavcontrol_msgs
  "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)

### Generating Services
_generate_srv_py(uavcontrol_msgs
  "/home/amov/autouav_platform/src/uavcontrol_msgs/srv/arucoTrigger.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
)

### Generating Module File
_generate_module_py(uavcontrol_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(uavcontrol_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(uavcontrol_msgs_generate_messages uavcontrol_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUAVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVControlState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVSetup.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TextInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GlobalAruco.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUGVState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionReference.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StationCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiArucoInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfo.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SwarmCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/FormationAssign.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OffsetPose.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GPSData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Corrections.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Gains.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OutputData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PPROutputData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Serial.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SO3Command.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StatusData.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TRPYCommand.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Odometry.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PolynomialTrajectory.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LQRTrajectory.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Px4ctrlDebug.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNodeframe2.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalControl.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalState.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfoSub.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/VisionDiff.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/WindowPosition.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiBsplines.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Control.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/CustomDataSegment.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ParamSettings.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomMsg.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LedStates.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ShoutStates.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GeoFence.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsAction.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/amov/autouav_platform/src/uavcontrol_msgs/srv/arucoTrigger.srv" NAME_WE)
add_dependencies(uavcontrol_msgs_generate_messages_py _uavcontrol_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uavcontrol_msgs_genpy)
add_dependencies(uavcontrol_msgs_genpy uavcontrol_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uavcontrol_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uavcontrol_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_cpp)
  add_dependencies(uavcontrol_msgs_generate_messages_cpp actionlib_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(uavcontrol_msgs_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(uavcontrol_msgs_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(uavcontrol_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET nav_msgs_generate_messages_cpp)
  add_dependencies(uavcontrol_msgs_generate_messages_cpp nav_msgs_generate_messages_cpp)
endif()
if(TARGET std_srvs_generate_messages_cpp)
  add_dependencies(uavcontrol_msgs_generate_messages_cpp std_srvs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uavcontrol_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_eus)
  add_dependencies(uavcontrol_msgs_generate_messages_eus actionlib_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(uavcontrol_msgs_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(uavcontrol_msgs_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(uavcontrol_msgs_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET nav_msgs_generate_messages_eus)
  add_dependencies(uavcontrol_msgs_generate_messages_eus nav_msgs_generate_messages_eus)
endif()
if(TARGET std_srvs_generate_messages_eus)
  add_dependencies(uavcontrol_msgs_generate_messages_eus std_srvs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uavcontrol_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_lisp)
  add_dependencies(uavcontrol_msgs_generate_messages_lisp actionlib_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(uavcontrol_msgs_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(uavcontrol_msgs_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(uavcontrol_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET nav_msgs_generate_messages_lisp)
  add_dependencies(uavcontrol_msgs_generate_messages_lisp nav_msgs_generate_messages_lisp)
endif()
if(TARGET std_srvs_generate_messages_lisp)
  add_dependencies(uavcontrol_msgs_generate_messages_lisp std_srvs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uavcontrol_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_nodejs)
  add_dependencies(uavcontrol_msgs_generate_messages_nodejs actionlib_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(uavcontrol_msgs_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(uavcontrol_msgs_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(uavcontrol_msgs_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET nav_msgs_generate_messages_nodejs)
  add_dependencies(uavcontrol_msgs_generate_messages_nodejs nav_msgs_generate_messages_nodejs)
endif()
if(TARGET std_srvs_generate_messages_nodejs)
  add_dependencies(uavcontrol_msgs_generate_messages_nodejs std_srvs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uavcontrol_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET actionlib_msgs_generate_messages_py)
  add_dependencies(uavcontrol_msgs_generate_messages_py actionlib_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(uavcontrol_msgs_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(uavcontrol_msgs_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(uavcontrol_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET nav_msgs_generate_messages_py)
  add_dependencies(uavcontrol_msgs_generate_messages_py nav_msgs_generate_messages_py)
endif()
if(TARGET std_srvs_generate_messages_py)
  add_dependencies(uavcontrol_msgs_generate_messages_py std_srvs_generate_messages_py)
endif()
