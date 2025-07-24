;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::UGVCommand)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'UGVCommand (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::UGVCOMMAND")
  (make-package "UAVCONTROL_MSGS::UGVCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude UGVCommand.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*HOLD*" (find-package "UAVCONTROL_MSGS::UGVCOMMAND"))
(shadow '*HOLD* (find-package "UAVCONTROL_MSGS::UGVCOMMAND"))
(defconstant uavcontrol_msgs::UGVCommand::*HOLD* 0)
(intern "*DIRECT_CONTROL_BODY*" (find-package "UAVCONTROL_MSGS::UGVCOMMAND"))
(shadow '*DIRECT_CONTROL_BODY* (find-package "UAVCONTROL_MSGS::UGVCOMMAND"))
(defconstant uavcontrol_msgs::UGVCommand::*DIRECT_CONTROL_BODY* 1)
(intern "*DIRECT_CONTROL_ENU*" (find-package "UAVCONTROL_MSGS::UGVCOMMAND"))
(shadow '*DIRECT_CONTROL_ENU* (find-package "UAVCONTROL_MSGS::UGVCOMMAND"))
(defconstant uavcontrol_msgs::UGVCommand::*DIRECT_CONTROL_ENU* 2)
(intern "*POINT_CONTROL*" (find-package "UAVCONTROL_MSGS::UGVCOMMAND"))
(shadow '*POINT_CONTROL* (find-package "UAVCONTROL_MSGS::UGVCOMMAND"))
(defconstant uavcontrol_msgs::UGVCommand::*POINT_CONTROL* 3)
(intern "*PATH_CONTROL*" (find-package "UAVCONTROL_MSGS::UGVCOMMAND"))
(shadow '*PATH_CONTROL* (find-package "UAVCONTROL_MSGS::UGVCOMMAND"))
(defconstant uavcontrol_msgs::UGVCommand::*PATH_CONTROL* 4)
(intern "*TEST*" (find-package "UAVCONTROL_MSGS::UGVCOMMAND"))
(shadow '*TEST* (find-package "UAVCONTROL_MSGS::UGVCOMMAND"))
(defconstant uavcontrol_msgs::UGVCommand::*TEST* 5)

(defun uavcontrol_msgs::UGVCommand-to-symbol (const)
  (cond
        ((= const 0) 'uavcontrol_msgs::UGVCommand::*Hold*)
        ((= const 1) 'uavcontrol_msgs::UGVCommand::*Direct_Control_BODY*)
        ((= const 2) 'uavcontrol_msgs::UGVCommand::*Direct_Control_ENU*)
        ((= const 3) 'uavcontrol_msgs::UGVCommand::*Point_Control*)
        ((= const 4) 'uavcontrol_msgs::UGVCommand::*Path_Control*)
        ((= const 5) 'uavcontrol_msgs::UGVCommand::*Test*)
        (t nil)))

(defclass uavcontrol_msgs::UGVCommand
  :super ros::object
  :slots (_header _Command_ID _Mode _position_ref _yaw_ref _linear_vel _angular_vel ))

(defmethod uavcontrol_msgs::UGVCommand
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:Command_ID __Command_ID) 0)
    ((:Mode __Mode) 0)
    ((:position_ref __position_ref) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:yaw_ref __yaw_ref) 0.0)
    ((:linear_vel __linear_vel) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:angular_vel __angular_vel) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _Command_ID (round __Command_ID))
   (setq _Mode (round __Mode))
   (setq _position_ref __position_ref)
   (setq _yaw_ref (float __yaw_ref))
   (setq _linear_vel __linear_vel)
   (setq _angular_vel (float __angular_vel))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:Command_ID
   (&optional __Command_ID)
   (if __Command_ID (setq _Command_ID __Command_ID)) _Command_ID)
  (:Mode
   (&optional __Mode)
   (if __Mode (setq _Mode __Mode)) _Mode)
  (:position_ref
   (&optional __position_ref)
   (if __position_ref (setq _position_ref __position_ref)) _position_ref)
  (:yaw_ref
   (&optional __yaw_ref)
   (if __yaw_ref (setq _yaw_ref __yaw_ref)) _yaw_ref)
  (:linear_vel
   (&optional __linear_vel)
   (if __linear_vel (setq _linear_vel __linear_vel)) _linear_vel)
  (:angular_vel
   (&optional __angular_vel)
   (if __angular_vel (setq _angular_vel __angular_vel)) _angular_vel)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _Command_ID
    4
    ;; uint8 _Mode
    1
    ;; float32[2] _position_ref
    (* 4    2)
    ;; float32 _yaw_ref
    4
    ;; float32[2] _linear_vel
    (* 4    2)
    ;; float32 _angular_vel
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _Command_ID
       (write-long _Command_ID s)
     ;; uint8 _Mode
       (write-byte _Mode s)
     ;; float32[2] _position_ref
     (dotimes (i 2)
       (sys::poke (elt _position_ref i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _yaw_ref
       (sys::poke _yaw_ref (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[2] _linear_vel
     (dotimes (i 2)
       (sys::poke (elt _linear_vel i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _angular_vel
       (sys::poke _angular_vel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _Command_ID
     (setq _Command_ID (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8 _Mode
     (setq _Mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32[2] _position_ref
   (dotimes (i (length _position_ref))
     (setf (elt _position_ref i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32 _yaw_ref
     (setq _yaw_ref (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[2] _linear_vel
   (dotimes (i (length _linear_vel))
     (setf (elt _linear_vel i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32 _angular_vel
     (setq _angular_vel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get uavcontrol_msgs::UGVCommand :md5sum-) "b962762976e3397032e3506cd36fbcbc")
(setf (get uavcontrol_msgs::UGVCommand :datatype-) "uavcontrol_msgs/UGVCommand")
(setf (get uavcontrol_msgs::UGVCommand :definition-)
      "std_msgs/Header header

## 控制命令的编号 防止接收到错误命令， 编号应该逐次递加
uint32 Command_ID

## 控制命令的模式 
uint8 Mode
# enum Mode 控制模式枚举
uint8 Hold=0
uint8 Direct_Control_BODY=1
uint8 Direct_Control_ENU=2
uint8 Point_Control=3
uint8 Path_Control=4
uint8 Test=5

float32[2] position_ref     ## [m]
float32 yaw_ref             ## [rad]

float32[2] linear_vel       ## [m/s]
float32 angular_vel         ## [rad/s]



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



(provide :uavcontrol_msgs/UGVCommand "b962762976e3397032e3506cd36fbcbc")


