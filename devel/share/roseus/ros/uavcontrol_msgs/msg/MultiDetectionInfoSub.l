;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::MultiDetectionInfoSub)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'MultiDetectionInfoSub (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::MULTIDETECTIONINFOSUB")
  (make-package "UAVCONTROL_MSGS::MULTIDETECTIONINFOSUB"))

(in-package "ROS")
;;//! \htmlinclude MultiDetectionInfoSub.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass uavcontrol_msgs::MultiDetectionInfoSub
  :super ros::object
  :slots (_header _mode _num_objs _detection_infos ))

(defmethod uavcontrol_msgs::MultiDetectionInfoSub
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:mode __mode) 0)
    ((:num_objs __num_objs) 0)
    ((:detection_infos __detection_infos) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _mode (round __mode))
   (setq _num_objs (round __num_objs))
   (setq _detection_infos __detection_infos)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:num_objs
   (&optional __num_objs)
   (if __num_objs (setq _num_objs __num_objs)) _num_objs)
  (:detection_infos
   (&rest __detection_infos)
   (if (keywordp (car __detection_infos))
       (send* _detection_infos __detection_infos)
     (progn
       (if __detection_infos (setq _detection_infos (car __detection_infos)))
       _detection_infos)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _mode
    1
    ;; int32 _num_objs
    4
    ;; uavcontrol_msgs/DetectionInfoSub[] _detection_infos
    (apply #'+ (send-all _detection_infos :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _mode
       (write-byte _mode s)
     ;; int32 _num_objs
       (write-long _num_objs s)
     ;; uavcontrol_msgs/DetectionInfoSub[] _detection_infos
     (write-long (length _detection_infos) s)
     (dolist (elem _detection_infos)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _mode
     (setq _mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; int32 _num_objs
     (setq _num_objs (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uavcontrol_msgs/DetectionInfoSub[] _detection_infos
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _detection_infos (let (r) (dotimes (i n) (push (instance uavcontrol_msgs::DetectionInfoSub :init) r)) r))
     (dolist (elem- _detection_infos)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get uavcontrol_msgs::MultiDetectionInfoSub :md5sum-) "1b99fe4725befe6b93176dfa0544a074")
(setf (get uavcontrol_msgs::MultiDetectionInfoSub :datatype-) "uavcontrol_msgs/MultiDetectionInfoSub")
(setf (get uavcontrol_msgs::MultiDetectionInfoSub :definition-)
      "std_msgs/Header header

#模式：0：空闲  2.simaRPN  3.deepsort/sort
uint8 mode

## 检测到的目标数量
int32 num_objs

## 每个目标的检测结果
DetectionInfoSub[] detection_infos

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
MSG: uavcontrol_msgs/DetectionInfoSub
#目标框的位置（主要斜对角两个点）
float32 left
float32 top
float32 bot
float32 right


## TRACK TARGET(目标框ID)
int32 trackIds

")



(provide :uavcontrol_msgs/MultiDetectionInfoSub "1b99fe4725befe6b93176dfa0544a074")


