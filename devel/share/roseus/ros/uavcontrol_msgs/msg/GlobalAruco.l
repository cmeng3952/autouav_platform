;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::GlobalAruco)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'GlobalAruco (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::GLOBALARUCO")
  (make-package "UAVCONTROL_MSGS::GLOBALARUCO"))

(in-package "ROS")
;;//! \htmlinclude GlobalAruco.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass uavcontrol_msgs::GlobalAruco
  :super ros::object
  :slots (_header _Aruco1 _Aruco2 _Aruco3 _Aruco4 _Aruco5 _Aruco6 _Aruco7 _Aruco8 _Aruco9 ))

(defmethod uavcontrol_msgs::GlobalAruco
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:Aruco1 __Aruco1) (instance uavcontrol_msgs::ArucoInfo :init))
    ((:Aruco2 __Aruco2) (instance uavcontrol_msgs::ArucoInfo :init))
    ((:Aruco3 __Aruco3) (instance uavcontrol_msgs::ArucoInfo :init))
    ((:Aruco4 __Aruco4) (instance uavcontrol_msgs::ArucoInfo :init))
    ((:Aruco5 __Aruco5) (instance uavcontrol_msgs::ArucoInfo :init))
    ((:Aruco6 __Aruco6) (instance uavcontrol_msgs::ArucoInfo :init))
    ((:Aruco7 __Aruco7) (instance uavcontrol_msgs::ArucoInfo :init))
    ((:Aruco8 __Aruco8) (instance uavcontrol_msgs::ArucoInfo :init))
    ((:Aruco9 __Aruco9) (instance uavcontrol_msgs::ArucoInfo :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _Aruco1 __Aruco1)
   (setq _Aruco2 __Aruco2)
   (setq _Aruco3 __Aruco3)
   (setq _Aruco4 __Aruco4)
   (setq _Aruco5 __Aruco5)
   (setq _Aruco6 __Aruco6)
   (setq _Aruco7 __Aruco7)
   (setq _Aruco8 __Aruco8)
   (setq _Aruco9 __Aruco9)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:Aruco1
   (&rest __Aruco1)
   (if (keywordp (car __Aruco1))
       (send* _Aruco1 __Aruco1)
     (progn
       (if __Aruco1 (setq _Aruco1 (car __Aruco1)))
       _Aruco1)))
  (:Aruco2
   (&rest __Aruco2)
   (if (keywordp (car __Aruco2))
       (send* _Aruco2 __Aruco2)
     (progn
       (if __Aruco2 (setq _Aruco2 (car __Aruco2)))
       _Aruco2)))
  (:Aruco3
   (&rest __Aruco3)
   (if (keywordp (car __Aruco3))
       (send* _Aruco3 __Aruco3)
     (progn
       (if __Aruco3 (setq _Aruco3 (car __Aruco3)))
       _Aruco3)))
  (:Aruco4
   (&rest __Aruco4)
   (if (keywordp (car __Aruco4))
       (send* _Aruco4 __Aruco4)
     (progn
       (if __Aruco4 (setq _Aruco4 (car __Aruco4)))
       _Aruco4)))
  (:Aruco5
   (&rest __Aruco5)
   (if (keywordp (car __Aruco5))
       (send* _Aruco5 __Aruco5)
     (progn
       (if __Aruco5 (setq _Aruco5 (car __Aruco5)))
       _Aruco5)))
  (:Aruco6
   (&rest __Aruco6)
   (if (keywordp (car __Aruco6))
       (send* _Aruco6 __Aruco6)
     (progn
       (if __Aruco6 (setq _Aruco6 (car __Aruco6)))
       _Aruco6)))
  (:Aruco7
   (&rest __Aruco7)
   (if (keywordp (car __Aruco7))
       (send* _Aruco7 __Aruco7)
     (progn
       (if __Aruco7 (setq _Aruco7 (car __Aruco7)))
       _Aruco7)))
  (:Aruco8
   (&rest __Aruco8)
   (if (keywordp (car __Aruco8))
       (send* _Aruco8 __Aruco8)
     (progn
       (if __Aruco8 (setq _Aruco8 (car __Aruco8)))
       _Aruco8)))
  (:Aruco9
   (&rest __Aruco9)
   (if (keywordp (car __Aruco9))
       (send* _Aruco9 __Aruco9)
     (progn
       (if __Aruco9 (setq _Aruco9 (car __Aruco9)))
       _Aruco9)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uavcontrol_msgs/ArucoInfo _Aruco1
    (send _Aruco1 :serialization-length)
    ;; uavcontrol_msgs/ArucoInfo _Aruco2
    (send _Aruco2 :serialization-length)
    ;; uavcontrol_msgs/ArucoInfo _Aruco3
    (send _Aruco3 :serialization-length)
    ;; uavcontrol_msgs/ArucoInfo _Aruco4
    (send _Aruco4 :serialization-length)
    ;; uavcontrol_msgs/ArucoInfo _Aruco5
    (send _Aruco5 :serialization-length)
    ;; uavcontrol_msgs/ArucoInfo _Aruco6
    (send _Aruco6 :serialization-length)
    ;; uavcontrol_msgs/ArucoInfo _Aruco7
    (send _Aruco7 :serialization-length)
    ;; uavcontrol_msgs/ArucoInfo _Aruco8
    (send _Aruco8 :serialization-length)
    ;; uavcontrol_msgs/ArucoInfo _Aruco9
    (send _Aruco9 :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uavcontrol_msgs/ArucoInfo _Aruco1
       (send _Aruco1 :serialize s)
     ;; uavcontrol_msgs/ArucoInfo _Aruco2
       (send _Aruco2 :serialize s)
     ;; uavcontrol_msgs/ArucoInfo _Aruco3
       (send _Aruco3 :serialize s)
     ;; uavcontrol_msgs/ArucoInfo _Aruco4
       (send _Aruco4 :serialize s)
     ;; uavcontrol_msgs/ArucoInfo _Aruco5
       (send _Aruco5 :serialize s)
     ;; uavcontrol_msgs/ArucoInfo _Aruco6
       (send _Aruco6 :serialize s)
     ;; uavcontrol_msgs/ArucoInfo _Aruco7
       (send _Aruco7 :serialize s)
     ;; uavcontrol_msgs/ArucoInfo _Aruco8
       (send _Aruco8 :serialize s)
     ;; uavcontrol_msgs/ArucoInfo _Aruco9
       (send _Aruco9 :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uavcontrol_msgs/ArucoInfo _Aruco1
     (send _Aruco1 :deserialize buf ptr-) (incf ptr- (send _Aruco1 :serialization-length))
   ;; uavcontrol_msgs/ArucoInfo _Aruco2
     (send _Aruco2 :deserialize buf ptr-) (incf ptr- (send _Aruco2 :serialization-length))
   ;; uavcontrol_msgs/ArucoInfo _Aruco3
     (send _Aruco3 :deserialize buf ptr-) (incf ptr- (send _Aruco3 :serialization-length))
   ;; uavcontrol_msgs/ArucoInfo _Aruco4
     (send _Aruco4 :deserialize buf ptr-) (incf ptr- (send _Aruco4 :serialization-length))
   ;; uavcontrol_msgs/ArucoInfo _Aruco5
     (send _Aruco5 :deserialize buf ptr-) (incf ptr- (send _Aruco5 :serialization-length))
   ;; uavcontrol_msgs/ArucoInfo _Aruco6
     (send _Aruco6 :deserialize buf ptr-) (incf ptr- (send _Aruco6 :serialization-length))
   ;; uavcontrol_msgs/ArucoInfo _Aruco7
     (send _Aruco7 :deserialize buf ptr-) (incf ptr- (send _Aruco7 :serialization-length))
   ;; uavcontrol_msgs/ArucoInfo _Aruco8
     (send _Aruco8 :deserialize buf ptr-) (incf ptr- (send _Aruco8 :serialization-length))
   ;; uavcontrol_msgs/ArucoInfo _Aruco9
     (send _Aruco9 :deserialize buf ptr-) (incf ptr- (send _Aruco9 :serialization-length))
   ;;
   self)
  )

(setf (get uavcontrol_msgs::GlobalAruco :md5sum-) "1ac5e7f2e18092c8685802c04fdbf69a")
(setf (get uavcontrol_msgs::GlobalAruco :datatype-) "uavcontrol_msgs/GlobalAruco")
(setf (get uavcontrol_msgs::GlobalAruco :definition-)
      "
std_msgs/Header header

ArucoInfo Aruco1
ArucoInfo Aruco2
ArucoInfo Aruco3
ArucoInfo Aruco4
ArucoInfo Aruco5
ArucoInfo Aruco6
ArucoInfo Aruco7
ArucoInfo Aruco8
ArucoInfo Aruco9

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



(provide :uavcontrol_msgs/GlobalAruco "1ac5e7f2e18092c8685802c04fdbf69a")


