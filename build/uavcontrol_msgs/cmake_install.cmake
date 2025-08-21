# Install script for directory: /home/amov/autouav_platform/src/uavcontrol_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/amov/autouav_platform/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/amov/autouav_platform/install/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/amov/autouav_platform/install" TYPE PROGRAM FILES "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/_setup_util.py")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/amov/autouav_platform/install/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/amov/autouav_platform/install" TYPE PROGRAM FILES "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/env.sh")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/amov/autouav_platform/install/setup.bash;/home/amov/autouav_platform/install/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/amov/autouav_platform/install" TYPE FILE FILES
    "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/setup.bash"
    "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/local_setup.bash"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/amov/autouav_platform/install/setup.sh;/home/amov/autouav_platform/install/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/amov/autouav_platform/install" TYPE FILE FILES
    "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/setup.sh"
    "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/local_setup.sh"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/amov/autouav_platform/install/setup.zsh;/home/amov/autouav_platform/install/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/amov/autouav_platform/install" TYPE FILE FILES
    "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/setup.zsh"
    "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/amov/autouav_platform/install/setup.fish;/home/amov/autouav_platform/install/local_setup.fish")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/amov/autouav_platform/install" TYPE FILE FILES
    "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/setup.fish"
    "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/local_setup.fish"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/amov/autouav_platform/install/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/home/amov/autouav_platform/install" TYPE FILE FILES "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/.rosinstall")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uavcontrol_msgs/msg" TYPE FILE FILES
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVState.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUAVState.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVCommand.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVControlState.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UAVSetup.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TextInfo.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GlobalAruco.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVState.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/UGVCommand.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiUGVState.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionReference.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StationCommand.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ArucoInfo.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiArucoInfo.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfo.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfo.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBox.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BoundingBoxes.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SwarmCommand.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/FormationAssign.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OffsetPose.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GPSData.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/AuxCommand.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Corrections.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Gains.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/OutputData.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PositionCommand.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PPROutputData.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Serial.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/SO3Command.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/StatusData.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/TRPYCommand.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Odometry.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/PolynomialTrajectory.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LQRTrajectory.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Px4ctrlDebug.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNode2.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LinktrackNodeframe2.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/DetectionInfoSub.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalControl.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GimbalState.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiDetectionInfoSub.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/VisionDiff.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/WindowPosition.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Bspline.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/MultiBsplines.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/Control.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/BasicDataTypeAndValue.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/CustomDataSegment.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ParamSettings.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomMsg.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LivoxCustomPoint.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/LedStates.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/ShoutStates.msg"
    "/home/amov/autouav_platform/src/uavcontrol_msgs/msg/GeoFence.msg"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uavcontrol_msgs/srv" TYPE FILE FILES "/home/amov/autouav_platform/src/uavcontrol_msgs/srv/arucoTrigger.srv")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uavcontrol_msgs/action" TYPE FILE FILES "/home/amov/autouav_platform/src/uavcontrol_msgs/action/CheckForObjects.action")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uavcontrol_msgs/msg" TYPE FILE FILES
    "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsAction.msg"
    "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionGoal.msg"
    "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionResult.msg"
    "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsActionFeedback.msg"
    "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsGoal.msg"
    "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsResult.msg"
    "/home/amov/autouav_platform/devel/share/uavcontrol_msgs/msg/CheckForObjectsFeedback.msg"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uavcontrol_msgs/cmake" TYPE FILE FILES "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/uavcontrol_msgs-msg-paths.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/amov/autouav_platform/devel/include/uavcontrol_msgs")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/amov/autouav_platform/devel/share/roseus/ros/uavcontrol_msgs")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/amov/autouav_platform/devel/share/common-lisp/ros/uavcontrol_msgs")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/amov/autouav_platform/devel/share/gennodejs/ros/uavcontrol_msgs")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/amov/autouav_platform/devel/lib/python3/dist-packages/uavcontrol_msgs")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/amov/autouav_platform/devel/lib/python3/dist-packages/uavcontrol_msgs")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/uavcontrol_msgs.pc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uavcontrol_msgs/cmake" TYPE FILE FILES "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/uavcontrol_msgs-msg-extras.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uavcontrol_msgs/cmake" TYPE FILE FILES
    "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/uavcontrol_msgsConfig.cmake"
    "/home/amov/autouav_platform/build/uavcontrol_msgs/catkin_generated/installspace/uavcontrol_msgsConfig-version.cmake"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uavcontrol_msgs" TYPE FILE FILES "/home/amov/autouav_platform/src/uavcontrol_msgs/package.xml")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/uavcontrol_msgs" TYPE DIRECTORY FILES "/home/amov/autouav_platform/src/uavcontrol_msgs/include/uavcontrol_msgs/" FILES_MATCHING REGEX "/[^/]*\\.h$")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/uavcontrol_msgs/launch" TYPE DIRECTORY FILES "/home/amov/autouav_platform/src/uavcontrol_msgs/launch/")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/amov/autouav_platform/build/uavcontrol_msgs/gtest/cmake_install.cmake")

endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
if(CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/home/amov/autouav_platform/build/uavcontrol_msgs/install_local_manifest.txt"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
if(CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_COMPONENT MATCHES "^[a-zA-Z0-9_.+-]+$")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
  else()
    string(MD5 CMAKE_INST_COMP_HASH "${CMAKE_INSTALL_COMPONENT}")
    set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INST_COMP_HASH}.txt")
    unset(CMAKE_INST_COMP_HASH)
  endif()
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  file(WRITE "/home/amov/autouav_platform/build/uavcontrol_msgs/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
endif()
