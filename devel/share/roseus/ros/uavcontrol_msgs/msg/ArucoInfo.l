;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::ArucoInfo)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'ArucoInfo (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::ARUCOINFO")
  (make-package "UAVCONTROL_MSGS::ARUCOINFO"))

(in-package "ROS")
;;//! \htmlinclude ArucoInfo.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass uavcontrol_msgs::ArucoInfo
  :super ros::object
  :slots (_header _aruco_num _detected _position _orientation _sight_angle ))

(defmethod uavcontrol_msgs::ArucoInfo
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:aruco_num __aruco_num) 0)
    ((:detected __detected) nil)
    ((:position __position) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:orientation __orientation) (make-array 4 :initial-element 0.0 :element-type :float))
    ((:sight_angle __sight_angle) (make-array 2 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _aruco_num (round __aruco_num))
   (setq _detected __detected)
   (setq _position __position)
   (setq _orientation __orientation)
   (setq _sight_angle __sight_angle)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:aruco_num
   (&optional __aruco_num)
   (if __aruco_num (setq _aruco_num __aruco_num)) _aruco_num)
  (:detected
   (&optional (__detected :null))
   (if (not (eq __detected :null)) (setq _detected __detected)) _detected)
  (:position
   (&optional __position)
   (if __position (setq _position __position)) _position)
  (:orientation
   (&optional __orientation)
   (if __orientation (setq _orientation __orientation)) _orientation)
  (:sight_angle
   (&optional __sight_angle)
   (if __sight_angle (setq _sight_angle __sight_angle)) _sight_angle)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _aruco_num
    4
    ;; bool _detected
    1
    ;; float32[3] _position
    (* 4    3)
    ;; float32[4] _orientation
    (* 4    4)
    ;; float32[2] _sight_angle
    (* 4    2)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _aruco_num
       (write-long _aruco_num s)
     ;; bool _detected
       (if _detected (write-byte -1 s) (write-byte 0 s))
     ;; float32[3] _position
     (dotimes (i 3)
       (sys::poke (elt _position i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[4] _orientation
     (dotimes (i 4)
       (sys::poke (elt _orientation i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[2] _sight_angle
     (dotimes (i 2)
       (sys::poke (elt _sight_angle i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _aruco_num
     (setq _aruco_num (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _detected
     (setq _detected (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32[3] _position
   (dotimes (i (length _position))
     (setf (elt _position i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[4] _orientation
   (dotimes (i (length _orientation))
     (setf (elt _orientation i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[2] _sight_angle
   (dotimes (i (length _sight_angle))
     (setf (elt _sight_angle i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;;
   self)
  )

(setf (get uavcontrol_msgs::ArucoInfo :md5sum-) "4317d8c5571fc3b7219e3fa681ec1bab")
(setf (get uavcontrol_msgs::ArucoInfo :datatype-) "uavcontrol_msgs/ArucoInfo")
(setf (get uavcontrol_msgs::ArucoInfo :definition-)
      "std_msgs/Header header

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



(provide :uavcontrol_msgs/ArucoInfo "4317d8c5571fc3b7219e3fa681ec1bab")


