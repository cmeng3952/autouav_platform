;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::UAVSetup)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'UAVSetup (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::UAVSETUP")
  (make-package "UAVCONTROL_MSGS::UAVSETUP"))

(in-package "ROS")
;;//! \htmlinclude UAVSetup.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*ARMING*" (find-package "UAVCONTROL_MSGS::UAVSETUP"))
(shadow '*ARMING* (find-package "UAVCONTROL_MSGS::UAVSETUP"))
(defconstant uavcontrol_msgs::UAVSetup::*ARMING* 0)
(intern "*SET_PX4_MODE*" (find-package "UAVCONTROL_MSGS::UAVSETUP"))
(shadow '*SET_PX4_MODE* (find-package "UAVCONTROL_MSGS::UAVSETUP"))
(defconstant uavcontrol_msgs::UAVSetup::*SET_PX4_MODE* 1)
(intern "*REBOOT_PX4*" (find-package "UAVCONTROL_MSGS::UAVSETUP"))
(shadow '*REBOOT_PX4* (find-package "UAVCONTROL_MSGS::UAVSETUP"))
(defconstant uavcontrol_msgs::UAVSetup::*REBOOT_PX4* 2)
(intern "*SET_CONTROL_MODE*" (find-package "UAVCONTROL_MSGS::UAVSETUP"))
(shadow '*SET_CONTROL_MODE* (find-package "UAVCONTROL_MSGS::UAVSETUP"))
(defconstant uavcontrol_msgs::UAVSetup::*SET_CONTROL_MODE* 3)

(defun uavcontrol_msgs::UAVSetup-to-symbol (const)
  (cond
        ((= const 0) 'uavcontrol_msgs::UAVSetup::*ARMING*)
        ((= const 1) 'uavcontrol_msgs::UAVSetup::*SET_PX4_MODE*)
        ((= const 2) 'uavcontrol_msgs::UAVSetup::*REBOOT_PX4*)
        ((= const 3) 'uavcontrol_msgs::UAVSetup::*SET_CONTROL_MODE*)
        (t nil)))

(defclass uavcontrol_msgs::UAVSetup
  :super ros::object
  :slots (_header _cmd _arming _px4_mode _control_state ))

(defmethod uavcontrol_msgs::UAVSetup
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:cmd __cmd) 0)
    ((:arming __arming) nil)
    ((:px4_mode __px4_mode) "")
    ((:control_state __control_state) "")
    )
   (send-super :init)
   (setq _header __header)
   (setq _cmd (round __cmd))
   (setq _arming __arming)
   (setq _px4_mode (string __px4_mode))
   (setq _control_state (string __control_state))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:cmd
   (&optional __cmd)
   (if __cmd (setq _cmd __cmd)) _cmd)
  (:arming
   (&optional (__arming :null))
   (if (not (eq __arming :null)) (setq _arming __arming)) _arming)
  (:px4_mode
   (&optional __px4_mode)
   (if __px4_mode (setq _px4_mode __px4_mode)) _px4_mode)
  (:control_state
   (&optional __control_state)
   (if __control_state (setq _control_state __control_state)) _control_state)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _cmd
    1
    ;; bool _arming
    1
    ;; string _px4_mode
    4 (length _px4_mode)
    ;; string _control_state
    4 (length _control_state)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _cmd
       (write-byte _cmd s)
     ;; bool _arming
       (if _arming (write-byte -1 s) (write-byte 0 s))
     ;; string _px4_mode
       (write-long (length _px4_mode) s) (princ _px4_mode s)
     ;; string _control_state
       (write-long (length _control_state) s) (princ _control_state s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _cmd
     (setq _cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _arming
     (setq _arming (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _px4_mode
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _px4_mode (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _control_state
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _control_state (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get uavcontrol_msgs::UAVSetup :md5sum-) "393031ce25ae40233f2be809a2db33df")
(setf (get uavcontrol_msgs::UAVSetup :datatype-) "uavcontrol_msgs/UAVSetup")
(setf (get uavcontrol_msgs::UAVSetup :definition-)
      "std_msgs/Header header

## 无人机Setup类型（可用于模拟遥控器）
uint8 cmd
uint8 ARMING = 0
uint8 SET_PX4_MODE = 1
uint8 REBOOT_PX4 = 2
uint8 SET_CONTROL_MODE = 3

bool arming

## PX4模式名查询:http://wiki.ros.org/mavros/CustomModes
## 常用模式名:OFFBOARD,AUTO.LAND,AUTO.RTL,POSCTL
string px4_mode

## INIT,MANUAL_CONTROL,HOVER_CONTROL,COMMAND_CONTROL,LAND_CONTROL
string control_state

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



(provide :uavcontrol_msgs/UAVSetup "393031ce25ae40233f2be809a2db33df")


