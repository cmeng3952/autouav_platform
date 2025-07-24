cmake_minimum_required(VERSION 2.8.3)
project(uavcontrol_msgs)

find_package(catkin REQUIRED COMPONENTS
  message_generation  
  roscpp
  geometry_msgs
  actionlib_msgs
  sensor_msgs
  nav_msgs
  std_msgs
  std_srvs
  tf2_ros
  tf2_eigen
  mavros_msgs
  spirecv_msgs
)
find_package(spirecv_msgs REQUIRED)  

find_package(Boost REQUIRED COMPONENTS system)
find_package(PCL REQUIRED)
add_message_files(
  DIRECTORY msg
  FILES
  UAVState.msg
  MultiUAVState.msg
  UAVCommand.msg
  UAVControlState.msg
  UAVSetup.msg
  TextInfo.msg
  GlobalAruco.msg
  UGVState.msg
  UGVCommand.msg
  MultiUGVState.msg
  PositionReference.msg
  StationCommand.msg

  ArucoInfo.msg
  MultiArucoInfo.msg
  DetectionInfo.msg
  MultiDetectionInfo.msg
  BoundingBox.msg
  BoundingBoxes.msg

  SwarmCommand.msg
  FormationAssign.msg
  OffsetPose.msg
  GPSData.msg
  
  AuxCommand.msg
  Corrections.msg
  Gains.msg
  OutputData.msg
  PositionCommand.msg
  PPROutputData.msg
  Serial.msg
  SO3Command.msg
  StatusData.msg
  TRPYCommand.msg
  Odometry.msg
  PolynomialTrajectory.msg
  LQRTrajectory.msg
  Px4ctrlDebug.msg
  
  
  

  # UWB msg
  LinktrackNode2.msg
  LinktrackNodeframe2.msg

  #communication
  DetectionInfoSub.msg
  GimbalControl.msg
  GimbalState.msg
  MultiDetectionInfoSub.msg
  VisionDiff.msg
  WindowPosition.msg
  Bspline.msg
  MultiBsplines.msg
  Control.msg
  BasicDataTypeAndValue.msg
  CustomDataSegment.msg
  ParamSettings.msg


  #livox mid360 msg
  LivoxCustomMsg.msg
  LivoxCustomPoint.msg
  
  LedStates.msg
  ShoutStates.msg
)

add_service_files(
  DIRECTORY srv
  FILES
  arucoTrigger.srv
)

add_action_files(
  DIRECTORY action
  FILES
  CheckForObjects.action
)

generate_messages(DEPENDENCIES
  DEPENDENCIES
  actionlib_msgs
  geometry_msgs 
  sensor_msgs
  std_msgs
  nav_msgs
  std_srvs
)

catkin_package(
  CATKIN_DEPENDS
  message_runtime
  #message_generation
  std_srvs
  actionlib_msgs
  geometry_msgs
  sensor_msgs
  message_runtime
  std_msgs
)

find_package(Eigen3 REQUIRED)
include_directories(${EIGEN3_INCLUDE_DIR})



include_directories(
  include
  ${catkin_INCLUDE_DIRS}
  ${PCL_INCLUDE_DIRS}
)


install(DIRECTORY include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  FILES_MATCHING PATTERN "*.h"
)

install(DIRECTORY launch/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch
)
