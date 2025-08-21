;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::DetectionInfo)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'DetectionInfo (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::DETECTIONINFO")
  (make-package "UAVCONTROL_MSGS::DETECTIONINFO"))

(in-package "ROS")
;;//! \htmlinclude DetectionInfo.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass uavcontrol_msgs::DetectionInfo
  :super ros::object
  :slots (_header _object_name _detected _frame _position _attitude _attitude_q _sight_angle _pixel_position _yaw_error _category ))

(defmethod uavcontrol_msgs::DetectionInfo
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:object_name __object_name) "")
    ((:detected __detected) nil)
    ((:frame __frame) 0)
    ((:position __position) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:attitude __attitude) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:attitude_q __attitude_q) (make-array 4 :initial-element 0.0 :element-type :float))
    ((:sight_angle __sight_angle) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:pixel_position __pixel_position) (make-array 2 :initial-element 0 :element-type :integer))
    ((:yaw_error __yaw_error) 0.0)
    ((:category __category) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _object_name (string __object_name))
   (setq _detected __detected)
   (setq _frame (round __frame))
   (setq _position __position)
   (setq _attitude __attitude)
   (setq _attitude_q __attitude_q)
   (setq _sight_angle __sight_angle)
   (setq _pixel_position __pixel_position)
   (setq _yaw_error (float __yaw_error))
   (setq _category (round __category))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:object_name
   (&optional __object_name)
   (if __object_name (setq _object_name __object_name)) _object_name)
  (:detected
   (&optional (__detected :null))
   (if (not (eq __detected :null)) (setq _detected __detected)) _detected)
  (:frame
   (&optional __frame)
   (if __frame (setq _frame __frame)) _frame)
  (:position
   (&optional __position)
   (if __position (setq _position __position)) _position)
  (:attitude
   (&optional __attitude)
   (if __attitude (setq _attitude __attitude)) _attitude)
  (:attitude_q
   (&optional __attitude_q)
   (if __attitude_q (setq _attitude_q __attitude_q)) _attitude_q)
  (:sight_angle
   (&optional __sight_angle)
   (if __sight_angle (setq _sight_angle __sight_angle)) _sight_angle)
  (:pixel_position
   (&optional __pixel_position)
   (if __pixel_position (setq _pixel_position __pixel_position)) _pixel_position)
  (:yaw_error
   (&optional __yaw_error)
   (if __yaw_error (setq _yaw_error __yaw_error)) _yaw_error)
  (:category
   (&optional __category)
   (if __category (setq _category __category)) _category)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string _object_name
    4 (length _object_name)
    ;; bool _detected
    1
    ;; int32 _frame
    4
    ;; float32[3] _position
    (* 4    3)
    ;; float32[3] _attitude
    (* 4    3)
    ;; float32[4] _attitude_q
    (* 4    4)
    ;; float32[2] _sight_angle
    (* 4    2)
    ;; int32[2] _pixel_position
    (* 4    2)
    ;; float32 _yaw_error
    4
    ;; int32 _category
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string _object_name
       (write-long (length _object_name) s) (princ _object_name s)
     ;; bool _detected
       (if _detected (write-byte -1 s) (write-byte 0 s))
     ;; int32 _frame
       (write-long _frame s)
     ;; float32[3] _position
     (dotimes (i 3)
       (sys::poke (elt _position i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _attitude
     (dotimes (i 3)
       (sys::poke (elt _attitude i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[4] _attitude_q
     (dotimes (i 4)
       (sys::poke (elt _attitude_q i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[2] _sight_angle
     (dotimes (i 2)
       (sys::poke (elt _sight_angle i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int32[2] _pixel_position
     (dotimes (i 2)
       (write-long (elt _pixel_position i) s)
       )
     ;; float32 _yaw_error
       (sys::poke _yaw_error (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _category
       (write-long _category s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string _object_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _object_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _detected
     (setq _detected (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _frame
     (setq _frame (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32[3] _position
   (dotimes (i (length _position))
     (setf (elt _position i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _attitude
   (dotimes (i (length _attitude))
     (setf (elt _attitude i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[4] _attitude_q
   (dotimes (i (length _attitude_q))
     (setf (elt _attitude_q i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[2] _sight_angle
   (dotimes (i (length _sight_angle))
     (setf (elt _sight_angle i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; int32[2] _pixel_position
   (dotimes (i (length _pixel_position))
     (setf (elt _pixel_position i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     )
   ;; float32 _yaw_error
     (setq _yaw_error (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _category
     (setq _category (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get uavcontrol_msgs::DetectionInfo :md5sum-) "64a1138d8e77ba66759026fce69b90a9")
(setf (get uavcontrol_msgs::DetectionInfo :datatype-) "uavcontrol_msgs/DetectionInfo")
(setf (get uavcontrol_msgs::DetectionInfo :definition-)
      "# 目标信息

std_msgs/Header header

## 目标类别名称
string object_name

## 是否检测到目标
bool detected

## 0表示相机坐标系, 1表示机体坐标系, 2表示惯性坐标系
int32 frame

## 目标位置[相机系下：右方x为正，下方y为正，前方z为正]
float32[3] position

## 目标姿态-欧拉角-(z,y,x)
float32[3] attitude

## 目标姿态-四元数-(qx,qy,qz,qw)
float32[4] attitude_q

## 视线角度[相机系下：右方x角度为正，下方y角度为正]
float32[2] sight_angle

## 像素位置[相机系下：右方x为正，下方y为正]
int32[2] pixel_position

## 偏航角误差
float32 yaw_error

## 类别
int32 category

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



(provide :uavcontrol_msgs/DetectionInfo "64a1138d8e77ba66759026fce69b90a9")


