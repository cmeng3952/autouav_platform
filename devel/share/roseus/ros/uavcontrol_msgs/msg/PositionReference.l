;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::PositionReference)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'PositionReference (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE")
  (make-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))

(in-package "ROS")
;;//! \htmlinclude PositionReference.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*XYZ_POS*" (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(shadow '*XYZ_POS* (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(defconstant uavcontrol_msgs::PositionReference::*XYZ_POS* 0)
(intern "*XY_POS_Z_VEL*" (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(shadow '*XY_POS_Z_VEL* (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(defconstant uavcontrol_msgs::PositionReference::*XY_POS_Z_VEL* 1)
(intern "*XY_VEL_Z_POS*" (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(shadow '*XY_VEL_Z_POS* (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(defconstant uavcontrol_msgs::PositionReference::*XY_VEL_Z_POS* 2)
(intern "*XYZ_VEL*" (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(shadow '*XYZ_VEL* (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(defconstant uavcontrol_msgs::PositionReference::*XYZ_VEL* 3)
(intern "*XYZ_ACC*" (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(shadow '*XYZ_ACC* (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(defconstant uavcontrol_msgs::PositionReference::*XYZ_ACC* 4)
(intern "*TRAJECTORY*" (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(shadow '*TRAJECTORY* (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(defconstant uavcontrol_msgs::PositionReference::*TRAJECTORY* 5)
(intern "*ENU_FRAME*" (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(shadow '*ENU_FRAME* (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(defconstant uavcontrol_msgs::PositionReference::*ENU_FRAME* 0)
(intern "*BODY_FRAME*" (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(shadow '*BODY_FRAME* (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(defconstant uavcontrol_msgs::PositionReference::*BODY_FRAME* 1)
(intern "*MIX_FRAME*" (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(shadow '*MIX_FRAME* (find-package "UAVCONTROL_MSGS::POSITIONREFERENCE"))
(defconstant uavcontrol_msgs::PositionReference::*MIX_FRAME* 2)

(defun uavcontrol_msgs::PositionReference-to-symbol (const)
  (cond
        ((= const 0) 'uavcontrol_msgs::PositionReference::*XYZ_POS*)
        ((= const 1) 'uavcontrol_msgs::PositionReference::*XY_POS_Z_VEL*)
        ((= const 2) 'uavcontrol_msgs::PositionReference::*XY_VEL_Z_POS*)
        ((= const 3) 'uavcontrol_msgs::PositionReference::*XYZ_VEL*)
        ((= const 4) 'uavcontrol_msgs::PositionReference::*XYZ_ACC*)
        ((= const 5) 'uavcontrol_msgs::PositionReference::*TRAJECTORY*)
        ((= const 0) 'uavcontrol_msgs::PositionReference::*ENU_FRAME*)
        ((= const 1) 'uavcontrol_msgs::PositionReference::*BODY_FRAME*)
        ((= const 2) 'uavcontrol_msgs::PositionReference::*MIX_FRAME*)
        (t nil)))

(defclass uavcontrol_msgs::PositionReference
  :super ros::object
  :slots (_header _Move_mode _Move_frame _time_from_start _position_ref _velocity_ref _acceleration_ref _yaw_ref ))

(defmethod uavcontrol_msgs::PositionReference
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:Move_mode __Move_mode) 0)
    ((:Move_frame __Move_frame) 0)
    ((:time_from_start __time_from_start) 0.0)
    ((:position_ref __position_ref) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:velocity_ref __velocity_ref) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:acceleration_ref __acceleration_ref) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:yaw_ref __yaw_ref) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _Move_mode (round __Move_mode))
   (setq _Move_frame (round __Move_frame))
   (setq _time_from_start (float __time_from_start))
   (setq _position_ref __position_ref)
   (setq _velocity_ref __velocity_ref)
   (setq _acceleration_ref __acceleration_ref)
   (setq _yaw_ref (float __yaw_ref))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:Move_mode
   (&optional __Move_mode)
   (if __Move_mode (setq _Move_mode __Move_mode)) _Move_mode)
  (:Move_frame
   (&optional __Move_frame)
   (if __Move_frame (setq _Move_frame __Move_frame)) _Move_frame)
  (:time_from_start
   (&optional __time_from_start)
   (if __time_from_start (setq _time_from_start __time_from_start)) _time_from_start)
  (:position_ref
   (&optional __position_ref)
   (if __position_ref (setq _position_ref __position_ref)) _position_ref)
  (:velocity_ref
   (&optional __velocity_ref)
   (if __velocity_ref (setq _velocity_ref __velocity_ref)) _velocity_ref)
  (:acceleration_ref
   (&optional __acceleration_ref)
   (if __acceleration_ref (setq _acceleration_ref __acceleration_ref)) _acceleration_ref)
  (:yaw_ref
   (&optional __yaw_ref)
   (if __yaw_ref (setq _yaw_ref __yaw_ref)) _yaw_ref)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _Move_mode
    1
    ;; uint8 _Move_frame
    1
    ;; float32 _time_from_start
    4
    ;; float32[3] _position_ref
    (* 4    3)
    ;; float32[3] _velocity_ref
    (* 4    3)
    ;; float32[3] _acceleration_ref
    (* 4    3)
    ;; float32 _yaw_ref
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _Move_mode
       (write-byte _Move_mode s)
     ;; uint8 _Move_frame
       (write-byte _Move_frame s)
     ;; float32 _time_from_start
       (sys::poke _time_from_start (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[3] _position_ref
     (dotimes (i 3)
       (sys::poke (elt _position_ref i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _velocity_ref
     (dotimes (i 3)
       (sys::poke (elt _velocity_ref i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _acceleration_ref
     (dotimes (i 3)
       (sys::poke (elt _acceleration_ref i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _yaw_ref
       (sys::poke _yaw_ref (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _Move_mode
     (setq _Move_mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _Move_frame
     (setq _Move_frame (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _time_from_start
     (setq _time_from_start (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[3] _position_ref
   (dotimes (i (length _position_ref))
     (setf (elt _position_ref i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _velocity_ref
   (dotimes (i (length _velocity_ref))
     (setf (elt _velocity_ref i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _acceleration_ref
   (dotimes (i (length _acceleration_ref))
     (setf (elt _acceleration_ref i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32 _yaw_ref
     (setq _yaw_ref (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get uavcontrol_msgs::PositionReference :md5sum-) "5aa100275600b3aa2239f15be9b50ba5")
(setf (get uavcontrol_msgs::PositionReference :datatype-) "uavcontrol_msgs/PositionReference")
(setf (get uavcontrol_msgs::PositionReference :definition-)
      "std_msgs/Header header

## 位置控制参考量

## 默认为 XYZ位置追踪模式 （sub_mode = 0）； 速度追踪启用时，控制器不考虑位置参考量及位置状态反馈
uint8 Move_mode

uint8 XYZ_POS      = 0  ##0b00
uint8 XY_POS_Z_VEL = 1  ##0b01
uint8 XY_VEL_Z_POS = 2  ##0b10
uint8 XYZ_VEL = 3       ##0b11
uint8 XYZ_ACC = 4
uint8 TRAJECTORY   = 5  

uint8 Move_frame
# 默认情况下均为ENU_FRAME,注意轨迹追踪和XYZ_ACC一定是ENU_FRAME
uint8 ENU_FRAME  = 0
uint8 BODY_FRAME = 1
uint8 MIX_FRAME = 2 ##2020.4.6 临时增加的模式，后期需要统一整合，该模式下，xy采用机体系控制，z采用enu系控制

## 时刻： 用于轨迹追踪
float32 time_from_start          ## [s]

## 参考量：位置、速度、加速度、加加速度、加加加速度
float32[3] position_ref          ## [m]
float32[3] velocity_ref          ## [m/s]
float32[3] acceleration_ref      ## [m/s^2]
## float32[3] jerk_ref              ## [m/s^3]
## float32[3] snap_ref              ## [m/s^4]

## 角度参考量：偏航角、偏航角速度、偏航角加速度
float32 yaw_ref                  ## [rad]
## float32 yaw_rate_ref             ## [rad/s] 
## float32 yaw_acceleration_ref     ## [rad/s] 
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



(provide :uavcontrol_msgs/PositionReference "5aa100275600b3aa2239f15be9b50ba5")


