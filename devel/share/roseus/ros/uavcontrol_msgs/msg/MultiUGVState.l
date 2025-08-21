;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::MultiUGVState)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'MultiUGVState (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::MULTIUGVSTATE")
  (make-package "UAVCONTROL_MSGS::MULTIUGVSTATE"))

(in-package "ROS")
;;//! \htmlinclude MultiUGVState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass uavcontrol_msgs::MultiUGVState
  :super ros::object
  :slots (_header _swarm_num_ugv _ugv_state_all ))

(defmethod uavcontrol_msgs::MultiUGVState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:swarm_num_ugv __swarm_num_ugv) 0)
    ((:ugv_state_all __ugv_state_all) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _swarm_num_ugv (round __swarm_num_ugv))
   (setq _ugv_state_all __ugv_state_all)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:swarm_num_ugv
   (&optional __swarm_num_ugv)
   (if __swarm_num_ugv (setq _swarm_num_ugv __swarm_num_ugv)) _swarm_num_ugv)
  (:ugv_state_all
   (&rest __ugv_state_all)
   (if (keywordp (car __ugv_state_all))
       (send* _ugv_state_all __ugv_state_all)
     (progn
       (if __ugv_state_all (setq _ugv_state_all (car __ugv_state_all)))
       _ugv_state_all)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _swarm_num_ugv
    4
    ;; uavcontrol_msgs/UGVState[] _ugv_state_all
    (apply #'+ (send-all _ugv_state_all :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _swarm_num_ugv
       (write-long _swarm_num_ugv s)
     ;; uavcontrol_msgs/UGVState[] _ugv_state_all
     (write-long (length _ugv_state_all) s)
     (dolist (elem _ugv_state_all)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _swarm_num_ugv
     (setq _swarm_num_ugv (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uavcontrol_msgs/UGVState[] _ugv_state_all
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ugv_state_all (let (r) (dotimes (i n) (push (instance uavcontrol_msgs::UGVState :init) r)) r))
     (dolist (elem- _ugv_state_all)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get uavcontrol_msgs::MultiUGVState :md5sum-) "a186972accb0af8d487fa5c5c2db7013")
(setf (get uavcontrol_msgs::MultiUGVState :datatype-) "uavcontrol_msgs/MultiUGVState")
(setf (get uavcontrol_msgs::MultiUGVState :definition-)
      "std_msgs/Header header

## 
int32 swarm_num_ugv

## 从1开始
UGVState[] ugv_state_all

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
MSG: uavcontrol_msgs/UGVState
std_msgs/Header header

## 无人机编号
uint8 ugv_id

## 电池电量
float32 battery

## 无人机状态量：位置、速度、姿态
float32[3] position                 ## [m]
float32[3] velocity                 ## [m/s]
float32[3] attitude                 ## [rad]

geometry_msgs/Quaternion attitude_q ## 四元数

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

")



(provide :uavcontrol_msgs/MultiUGVState "a186972accb0af8d487fa5c5c2db7013")


