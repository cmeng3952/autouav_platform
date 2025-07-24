;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::UAVControlState)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'UAVControlState (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE")
  (make-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))

(in-package "ROS")
;;//! \htmlinclude UAVControlState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*INIT*" (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(shadow '*INIT* (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(defconstant uavcontrol_msgs::UAVControlState::*INIT* 0)
(intern "*RC_POS_CONTROL*" (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(shadow '*RC_POS_CONTROL* (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(defconstant uavcontrol_msgs::UAVControlState::*RC_POS_CONTROL* 1)
(intern "*COMMAND_CONTROL*" (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(shadow '*COMMAND_CONTROL* (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(defconstant uavcontrol_msgs::UAVControlState::*COMMAND_CONTROL* 2)
(intern "*LAND_CONTROL*" (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(shadow '*LAND_CONTROL* (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(defconstant uavcontrol_msgs::UAVControlState::*LAND_CONTROL* 3)
(intern "*PX4_ORIGIN*" (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(shadow '*PX4_ORIGIN* (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(defconstant uavcontrol_msgs::UAVControlState::*PX4_ORIGIN* 0)
(intern "*PID*" (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(shadow '*PID* (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(defconstant uavcontrol_msgs::UAVControlState::*PID* 1)
(intern "*UDE*" (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(shadow '*UDE* (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(defconstant uavcontrol_msgs::UAVControlState::*UDE* 2)
(intern "*NE*" (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(shadow '*NE* (find-package "UAVCONTROL_MSGS::UAVCONTROLSTATE"))
(defconstant uavcontrol_msgs::UAVControlState::*NE* 3)

(defun uavcontrol_msgs::UAVControlState-to-symbol (const)
  (cond
        ((= const 0) 'uavcontrol_msgs::UAVControlState::*INIT*)
        ((= const 1) 'uavcontrol_msgs::UAVControlState::*RC_POS_CONTROL*)
        ((= const 2) 'uavcontrol_msgs::UAVControlState::*COMMAND_CONTROL*)
        ((= const 3) 'uavcontrol_msgs::UAVControlState::*LAND_CONTROL*)
        ((= const 0) 'uavcontrol_msgs::UAVControlState::*PX4_ORIGIN*)
        ((= const 1) 'uavcontrol_msgs::UAVControlState::*PID*)
        ((= const 2) 'uavcontrol_msgs::UAVControlState::*UDE*)
        ((= const 3) 'uavcontrol_msgs::UAVControlState::*NE*)
        (t nil)))

(defclass uavcontrol_msgs::UAVControlState
  :super ros::object
  :slots (_header _uav_id _control_state _pos_controller _failsafe ))

(defmethod uavcontrol_msgs::UAVControlState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:uav_id __uav_id) 0)
    ((:control_state __control_state) 0)
    ((:pos_controller __pos_controller) 0)
    ((:failsafe __failsafe) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _uav_id (round __uav_id))
   (setq _control_state (round __control_state))
   (setq _pos_controller (round __pos_controller))
   (setq _failsafe __failsafe)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:uav_id
   (&optional __uav_id)
   (if __uav_id (setq _uav_id __uav_id)) _uav_id)
  (:control_state
   (&optional __control_state)
   (if __control_state (setq _control_state __control_state)) _control_state)
  (:pos_controller
   (&optional __pos_controller)
   (if __pos_controller (setq _pos_controller __pos_controller)) _pos_controller)
  (:failsafe
   (&optional (__failsafe :null))
   (if (not (eq __failsafe :null)) (setq _failsafe __failsafe)) _failsafe)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _uav_id
    1
    ;; uint8 _control_state
    1
    ;; uint8 _pos_controller
    1
    ;; bool _failsafe
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _uav_id
       (write-byte _uav_id s)
     ;; uint8 _control_state
       (write-byte _control_state s)
     ;; uint8 _pos_controller
       (write-byte _pos_controller s)
     ;; bool _failsafe
       (if _failsafe (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _uav_id
     (setq _uav_id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _control_state
     (setq _control_state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _pos_controller
     (setq _pos_controller (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _failsafe
     (setq _failsafe (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get uavcontrol_msgs::UAVControlState :md5sum-) "2f696ea290ca1c1f46b8e82d115caeea")
(setf (get uavcontrol_msgs::UAVControlState :datatype-) "uavcontrol_msgs/UAVControlState")
(setf (get uavcontrol_msgs::UAVControlState :definition-)
      "std_msgs/Header header

## 无人机编号 
uint8 uav_id

## 无人机控制状态
uint8 control_state
## 状态枚举
uint8 INIT=0
uint8 RC_POS_CONTROL=1
uint8 COMMAND_CONTROL=2
uint8 LAND_CONTROL=3

## 无人机控制器标志量
uint8 pos_controller
## 状态枚举
uint8 PX4_ORIGIN=0
uint8 PID=1
uint8 UDE=2
uint8 NE=3

# 无人机安全保护触发标志量
bool failsafe

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

")



(provide :uavcontrol_msgs/UAVControlState "2f696ea290ca1c1f46b8e82d115caeea")


