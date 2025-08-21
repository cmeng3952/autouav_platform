;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::MultiUAVState)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'MultiUAVState (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::MULTIUAVSTATE")
  (make-package "UAVCONTROL_MSGS::MULTIUAVSTATE"))

(in-package "ROS")
;;//! \htmlinclude MultiUAVState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass uavcontrol_msgs::MultiUAVState
  :super ros::object
  :slots (_header _uav_num _uav_state_all ))

(defmethod uavcontrol_msgs::MultiUAVState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:uav_num __uav_num) 0)
    ((:uav_state_all __uav_state_all) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _uav_num (round __uav_num))
   (setq _uav_state_all __uav_state_all)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:uav_num
   (&optional __uav_num)
   (if __uav_num (setq _uav_num __uav_num)) _uav_num)
  (:uav_state_all
   (&rest __uav_state_all)
   (if (keywordp (car __uav_state_all))
       (send* _uav_state_all __uav_state_all)
     (progn
       (if __uav_state_all (setq _uav_state_all (car __uav_state_all)))
       _uav_state_all)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _uav_num
    4
    ;; uavcontrol_msgs/UAVState[] _uav_state_all
    (apply #'+ (send-all _uav_state_all :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _uav_num
       (write-long _uav_num s)
     ;; uavcontrol_msgs/UAVState[] _uav_state_all
     (write-long (length _uav_state_all) s)
     (dolist (elem _uav_state_all)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _uav_num
     (setq _uav_num (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uavcontrol_msgs/UAVState[] _uav_state_all
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _uav_state_all (let (r) (dotimes (i n) (push (instance uavcontrol_msgs::UAVState :init) r)) r))
     (dolist (elem- _uav_state_all)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get uavcontrol_msgs::MultiUAVState :md5sum-) "72627e48e74480de1a52aedffff0dfea")
(setf (get uavcontrol_msgs::MultiUAVState :datatype-) "uavcontrol_msgs/MultiUAVState")
(setf (get uavcontrol_msgs::MultiUAVState :definition-)
      "std_msgs/Header header

## 
int32 uav_num

## 从1开始
UAVState[] uav_state_all

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
MSG: uavcontrol_msgs/UAVState
std_msgs/Header header

## 无人机编号 
uint8 uav_id

## 机载电脑是否连接上飞控，true已连接，false则不是
bool connected
## 是否解锁，true为已解锁，false则不是
bool armed
## PX4飞控当前飞行模式  int8
string mode
## 无人机定位来源
uint8 location_source
## 定位来源枚举
uint8 MOCAP=0
uint8 T265=1
uint8 GAZEBO=2
uint8 FAKE_ODOM=3
uint8 GPS = 4
uint8 RTK = 5
uint8 UWB = 6
uint8 VINS = 7
uint8 OPTICAL_FLOW = 8
uint8 viobot = 9
uint8 MID360 = 10
uint8 BSA_SLAM=11
## odom标志位
bool odom_valid

## GPS状态,变量对应状态可参考mavros_msgs/GPSRAW中的fix_type
uint8 gps_status
## GPS状态枚举
uint8 GPS_FIX_TYPE_NO_GPS=0
uint8 GPS_FIX_TYPE_NO_FIX=1
uint8 GPS_FIX_TYPE_2D_FIX=2
uint8 GPS_FIX_TYPE_3D_FIX=3
uint8 GPS_FIX_TYPE_DGPS=4
uint8 GPS_FIX_TYPE_RTK_FLOATR=5
uint8 GPS_FIX_TYPE_RTK_FIXEDR=6
uint8 GPS_FIX_TYPE_STATIC=7
uint8 GPS_FIX_TYPE_PPP=8
## GPS卫星数量
uint8 gps_num

## 无人机位置、速度、姿态
float32[3] position                 ## [m]
## 无人机定高雷达                     ## [m]
float32  range
## 无人机经度、纬度、高度
float32 latitude                 ##经度          
float32 longitude                ##纬度   
float32 altitude                 ##海拔高度   
float32 rel_alt
## 无人机速度、姿态
float32[3] velocity                 ## [m/s]
## 无人机姿态（欧拉角、四元数）
float32[3] attitude                 ## [rad]

float32[3] attitude_rpy                ##[度] roll(横滚，左负-180度——右正180度)
                                    ##[度] pitch（俯仰，下负-90度——上正90度）
                                    ##[度] yaw（正北=0/正东=90/正南=180/正西=270）
                    
geometry_msgs/Quaternion attitude_q ## 四元数
## 无人机姿态角速度
float32[3] attitude_rate            ## [rad/s]
## 无人机电池状态
float32 battery_state               ## [V]
float32 battery_percetage           ## [0-1]

bool landed             # 着陆标志



    

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

")



(provide :uavcontrol_msgs/MultiUAVState "72627e48e74480de1a52aedffff0dfea")


