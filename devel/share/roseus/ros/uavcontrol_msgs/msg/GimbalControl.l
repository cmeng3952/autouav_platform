;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::GimbalControl)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'GimbalControl (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::GIMBALCONTROL")
  (make-package "UAVCONTROL_MSGS::GIMBALCONTROL"))

(in-package "ROS")
;;//! \htmlinclude GimbalControl.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass uavcontrol_msgs::GimbalControl
  :super ros::object
  :slots (_header _mode _angle _speed ))

(defmethod uavcontrol_msgs::GimbalControl
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:mode __mode) 0)
    ((:angle __angle) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:speed __speed) (make-array 3 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _mode (round __mode))
   (setq _angle __angle)
   (setq _speed __speed)
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
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _mode
    1
    ;; float32[3] _angle
    (* 4    3)
    ;; float32[3] _speed
    (* 4    3)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _mode
       (write-byte _mode s)
     ;; float32[3] _angle
     (dotimes (i 3)
       (sys::poke (elt _angle i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _speed
     (dotimes (i 3)
       (sys::poke (elt _speed i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _mode
     (setq _mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32[3] _angle
   (dotimes (i (length _angle))
     (setf (elt _angle i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _speed
   (dotimes (i (length _speed))
     (setf (elt _speed i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;;
   self)
  )

(setf (get uavcontrol_msgs::GimbalControl :md5sum-) "4aeedd102efdc9f13f7618059be5fcb8")
(setf (get uavcontrol_msgs::GimbalControl :datatype-) "uavcontrol_msgs/GimbalControl")
(setf (get uavcontrol_msgs::GimbalControl :definition-)
      "Header header

# gimbal commod mode; 0:None; 1:speed; 2:angle; 3:mixed
uint8 mode
# RPY <deg>
float32[3] angle
# RPY <deg/s>
float32[3] speed
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



(provide :uavcontrol_msgs/GimbalControl "4aeedd102efdc9f13f7618059be5fcb8")


