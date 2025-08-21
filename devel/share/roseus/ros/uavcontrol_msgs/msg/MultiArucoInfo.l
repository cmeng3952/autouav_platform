;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::MultiArucoInfo)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'MultiArucoInfo (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::MULTIARUCOINFO")
  (make-package "UAVCONTROL_MSGS::MULTIARUCOINFO"))

(in-package "ROS")
;;//! \htmlinclude MultiArucoInfo.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass uavcontrol_msgs::MultiArucoInfo
  :super ros::object
  :slots (_header _num_arucos _aruco_infos ))

(defmethod uavcontrol_msgs::MultiArucoInfo
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:num_arucos __num_arucos) 0)
    ((:aruco_infos __aruco_infos) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _num_arucos (round __num_arucos))
   (setq _aruco_infos __aruco_infos)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:num_arucos
   (&optional __num_arucos)
   (if __num_arucos (setq _num_arucos __num_arucos)) _num_arucos)
  (:aruco_infos
   (&rest __aruco_infos)
   (if (keywordp (car __aruco_infos))
       (send* _aruco_infos __aruco_infos)
     (progn
       (if __aruco_infos (setq _aruco_infos (car __aruco_infos)))
       _aruco_infos)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _num_arucos
    4
    ;; uavcontrol_msgs/ArucoInfo[] _aruco_infos
    (apply #'+ (send-all _aruco_infos :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _num_arucos
       (write-long _num_arucos s)
     ;; uavcontrol_msgs/ArucoInfo[] _aruco_infos
     (write-long (length _aruco_infos) s)
     (dolist (elem _aruco_infos)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _num_arucos
     (setq _num_arucos (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uavcontrol_msgs/ArucoInfo[] _aruco_infos
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _aruco_infos (let (r) (dotimes (i n) (push (instance uavcontrol_msgs::ArucoInfo :init) r)) r))
     (dolist (elem- _aruco_infos)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get uavcontrol_msgs::MultiArucoInfo :md5sum-) "ed01e66cfe7218a97aff05b031ab2f44")
(setf (get uavcontrol_msgs::MultiArucoInfo :datatype-) "uavcontrol_msgs/MultiArucoInfo")
(setf (get uavcontrol_msgs::MultiArucoInfo :definition-)
      "std_msgs/Header header

## 检测到的aruco码数量
int32 num_arucos

## 每个aruco码的检测结果
ArucoInfo[] aruco_infos

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
MSG: uavcontrol_msgs/ArucoInfo
std_msgs/Header header

## aruco编码
int32 aruco_num

## 是否检测到目标
bool detected

## 目标位置-相机坐标系-(x,y,z)
## 从相机往前看，物体在相机右方x为正，下方y为正，前方z为正
float32[3] position

## 目标姿态-四元数-(qx,qy,qz,qw)
float32[4] orientation

## 视线角度-相机系下-(右方x角度为正,下方y角度为正)
float32[2] sight_angle

")



(provide :uavcontrol_msgs/MultiArucoInfo "ed01e66cfe7218a97aff05b031ab2f44")


