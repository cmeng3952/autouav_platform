;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::WindowPosition)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'WindowPosition (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::WINDOWPOSITION")
  (make-package "UAVCONTROL_MSGS::WINDOWPOSITION"))

(in-package "ROS")
;;//! \htmlinclude WindowPosition.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass uavcontrol_msgs::WindowPosition
  :super ros::object
  :slots (_header _mode _origin_x _origin_y _width _height _window_position_x _window_position_y _track_id ))

(defmethod uavcontrol_msgs::WindowPosition
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:mode __mode) 0)
    ((:origin_x __origin_x) 0)
    ((:origin_y __origin_y) 0)
    ((:width __width) 0)
    ((:height __height) 0)
    ((:window_position_x __window_position_x) 0)
    ((:window_position_y __window_position_y) 0)
    ((:track_id __track_id) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _mode (round __mode))
   (setq _origin_x (round __origin_x))
   (setq _origin_y (round __origin_y))
   (setq _width (round __width))
   (setq _height (round __height))
   (setq _window_position_x (round __window_position_x))
   (setq _window_position_y (round __window_position_y))
   (setq _track_id (round __track_id))
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
  (:origin_x
   (&optional __origin_x)
   (if __origin_x (setq _origin_x __origin_x)) _origin_x)
  (:origin_y
   (&optional __origin_y)
   (if __origin_y (setq _origin_y __origin_y)) _origin_y)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:window_position_x
   (&optional __window_position_x)
   (if __window_position_x (setq _window_position_x __window_position_x)) _window_position_x)
  (:window_position_y
   (&optional __window_position_y)
   (if __window_position_y (setq _window_position_y __window_position_y)) _window_position_y)
  (:track_id
   (&optional __track_id)
   (if __track_id (setq _track_id __track_id)) _track_id)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _mode
    1
    ;; int16 _origin_x
    2
    ;; int16 _origin_y
    2
    ;; int16 _width
    2
    ;; int16 _height
    2
    ;; int16 _window_position_x
    2
    ;; int16 _window_position_y
    2
    ;; int32 _track_id
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _mode
       (write-byte _mode s)
     ;; int16 _origin_x
       (write-word _origin_x s)
     ;; int16 _origin_y
       (write-word _origin_y s)
     ;; int16 _width
       (write-word _width s)
     ;; int16 _height
       (write-word _height s)
     ;; int16 _window_position_x
       (write-word _window_position_x s)
     ;; int16 _window_position_y
       (write-word _window_position_y s)
     ;; int32 _track_id
       (write-long _track_id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _mode
     (setq _mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; int16 _origin_x
     (setq _origin_x (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _origin_y
     (setq _origin_y (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _width
     (setq _width (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _height
     (setq _height (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _window_position_x
     (setq _window_position_x (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _window_position_y
     (setq _window_position_y (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int32 _track_id
     (setq _track_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get uavcontrol_msgs::WindowPosition :md5sum-) "89d76cf2a4942da77237e3ebfe45c4de")
(setf (get uavcontrol_msgs::WindowPosition :datatype-) "uavcontrol_msgs/WindowPosition")
(setf (get uavcontrol_msgs::WindowPosition :definition-)
      "std_msgs/Header header

#模式：0：空闲  1.kcf   3.deepsort/sort(点击的id) 
uint8 mode


#波门位置X,#波门位置Y(kcf,点击画面的功能的时候使用),左上角为（0,0）
int16 origin_x
int16 origin_y
int16 width
int16 height 

#波门位置X,#波门位置Y
#int16 window_position_x = origin_x + width/2
#int16 window_position_y = origin_y + height/2
int16 window_position_x
int16 window_position_y

#算法检测结果的ID
int32 track_id

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



(provide :uavcontrol_msgs/WindowPosition "89d76cf2a4942da77237e3ebfe45c4de")


