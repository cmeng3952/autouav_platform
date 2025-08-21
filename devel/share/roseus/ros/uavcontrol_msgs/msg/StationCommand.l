;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::StationCommand)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'StationCommand (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::STATIONCOMMAND")
  (make-package "UAVCONTROL_MSGS::STATIONCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude StationCommand.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*START*" (find-package "UAVCONTROL_MSGS::STATIONCOMMAND"))
(shadow '*START* (find-package "UAVCONTROL_MSGS::STATIONCOMMAND"))
(defconstant uavcontrol_msgs::StationCommand::*START* 0)
(intern "*RETURN*" (find-package "UAVCONTROL_MSGS::STATIONCOMMAND"))
(shadow '*RETURN* (find-package "UAVCONTROL_MSGS::STATIONCOMMAND"))
(defconstant uavcontrol_msgs::StationCommand::*RETURN* 1)
(intern "*STOP*" (find-package "UAVCONTROL_MSGS::STATIONCOMMAND"))
(shadow '*STOP* (find-package "UAVCONTROL_MSGS::STATIONCOMMAND"))
(defconstant uavcontrol_msgs::StationCommand::*STOP* 2)

(defun uavcontrol_msgs::StationCommand-to-symbol (const)
  (cond
        ((= const 0) 'uavcontrol_msgs::StationCommand::*Start*)
        ((= const 1) 'uavcontrol_msgs::StationCommand::*Return*)
        ((= const 2) 'uavcontrol_msgs::StationCommand::*Stop*)
        (t nil)))

(defclass uavcontrol_msgs::StationCommand
  :super ros::object
  :slots (_header _goal _Command ))

(defmethod uavcontrol_msgs::StationCommand
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:goal __goal) (instance geometry_msgs::PoseStamped :init))
    ((:Command __Command) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _goal __goal)
   (setq _Command (round __Command))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:goal
   (&rest __goal)
   (if (keywordp (car __goal))
       (send* _goal __goal)
     (progn
       (if __goal (setq _goal (car __goal)))
       _goal)))
  (:Command
   (&optional __Command)
   (if __Command (setq _Command __Command)) _Command)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/PoseStamped _goal
    (send _goal :serialization-length)
    ;; uint8 _Command
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; geometry_msgs/PoseStamped _goal
       (send _goal :serialize s)
     ;; uint8 _Command
       (write-byte _Command s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; geometry_msgs/PoseStamped _goal
     (send _goal :deserialize buf ptr-) (incf ptr- (send _goal :serialization-length))
   ;; uint8 _Command
     (setq _Command (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get uavcontrol_msgs::StationCommand :md5sum-) "e00e6d6f653e8118b518bbc80def5338")
(setf (get uavcontrol_msgs::StationCommand :datatype-) "uavcontrol_msgs/StationCommand")
(setf (get uavcontrol_msgs::StationCommand :definition-)
      "std_msgs/Header header

## 中途点
#geometry_msgs/PoseStamped first_goal

## 目标点
geometry_msgs/PoseStamped goal

## 控制命令的模式 
uint8 Command
# enum Command 控制模式枚举
uint8 Start=0
uint8 Return=1
uint8 Stop=2




================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

")



(provide :uavcontrol_msgs/StationCommand "e00e6d6f653e8118b518bbc80def5338")


