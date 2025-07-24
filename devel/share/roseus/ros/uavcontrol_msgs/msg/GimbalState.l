;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::GimbalState)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'GimbalState (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::GIMBALSTATE")
  (make-package "UAVCONTROL_MSGS::GIMBALSTATE"))

(in-package "ROS")
;;//! \htmlinclude GimbalState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass uavcontrol_msgs::GimbalState
  :super ros::object
  :slots (_header _type _moveMode _imageMode _isZoom _isRec _fov _angleRT _angleRTRate _angleRateSet ))

(defmethod uavcontrol_msgs::GimbalState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:type __type) 0)
    ((:moveMode __moveMode) 0)
    ((:imageMode __imageMode) 0)
    ((:isZoom __isZoom) nil)
    ((:isRec __isRec) 0)
    ((:fov __fov) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:angleRT __angleRT) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:angleRTRate __angleRTRate) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:angleRateSet __angleRateSet) (make-array 3 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _type (round __type))
   (setq _moveMode (round __moveMode))
   (setq _imageMode (round __imageMode))
   (setq _isZoom __isZoom)
   (setq _isRec (round __isRec))
   (setq _fov __fov)
   (setq _angleRT __angleRT)
   (setq _angleRTRate __angleRTRate)
   (setq _angleRateSet __angleRateSet)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:moveMode
   (&optional __moveMode)
   (if __moveMode (setq _moveMode __moveMode)) _moveMode)
  (:imageMode
   (&optional __imageMode)
   (if __imageMode (setq _imageMode __imageMode)) _imageMode)
  (:isZoom
   (&optional (__isZoom :null))
   (if (not (eq __isZoom :null)) (setq _isZoom __isZoom)) _isZoom)
  (:isRec
   (&optional __isRec)
   (if __isRec (setq _isRec __isRec)) _isRec)
  (:fov
   (&optional __fov)
   (if __fov (setq _fov __fov)) _fov)
  (:angleRT
   (&optional __angleRT)
   (if __angleRT (setq _angleRT __angleRT)) _angleRT)
  (:angleRTRate
   (&optional __angleRTRate)
   (if __angleRTRate (setq _angleRTRate __angleRTRate)) _angleRTRate)
  (:angleRateSet
   (&optional __angleRateSet)
   (if __angleRateSet (setq _angleRateSet __angleRateSet)) _angleRateSet)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _type
    1
    ;; uint8 _moveMode
    1
    ;; uint8 _imageMode
    1
    ;; bool _isZoom
    1
    ;; uint8 _isRec
    1
    ;; float32[2] _fov
    (* 4    2)
    ;; float32[3] _angleRT
    (* 4    3)
    ;; float32[3] _angleRTRate
    (* 4    3)
    ;; float32[3] _angleRateSet
    (* 4    3)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _type
       (write-byte _type s)
     ;; uint8 _moveMode
       (write-byte _moveMode s)
     ;; uint8 _imageMode
       (write-byte _imageMode s)
     ;; bool _isZoom
       (if _isZoom (write-byte -1 s) (write-byte 0 s))
     ;; uint8 _isRec
       (write-byte _isRec s)
     ;; float32[2] _fov
     (dotimes (i 2)
       (sys::poke (elt _fov i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _angleRT
     (dotimes (i 3)
       (sys::poke (elt _angleRT i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _angleRTRate
     (dotimes (i 3)
       (sys::poke (elt _angleRTRate i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _angleRateSet
     (dotimes (i 3)
       (sys::poke (elt _angleRateSet i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _type
     (setq _type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _moveMode
     (setq _moveMode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _imageMode
     (setq _imageMode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _isZoom
     (setq _isZoom (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint8 _isRec
     (setq _isRec (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32[2] _fov
   (dotimes (i (length _fov))
     (setf (elt _fov i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _angleRT
   (dotimes (i (length _angleRT))
     (setf (elt _angleRT i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _angleRTRate
   (dotimes (i (length _angleRTRate))
     (setf (elt _angleRTRate i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _angleRateSet
   (dotimes (i (length _angleRateSet))
     (setf (elt _angleRateSet i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;;
   self)
  )

(setf (get uavcontrol_msgs::GimbalState :md5sum-) "17d9d9f817a22490d422f0f90e0623a4")
(setf (get uavcontrol_msgs::GimbalState :datatype-) "uavcontrol_msgs/GimbalState")
(setf (get uavcontrol_msgs::GimbalState :definition-)
      "Header header

# gimbal type; value = {SV::GimbalType};0:G1;1:Q10F;2:AT10;3:GX40;4:SU17
uint8 type
# gimbal movement mode; 0:None; 1:lock head; 2：unlock head; 3: tracking;
uint8 moveMode
# gimbal image type; 0:normal; 1:infrared; 2:merge;
uint8 imageMode
# gimbal zoom
bool isZoom
# gimbal rec; 0:none; 1:gimbal rec; 2:local rec; 3:gimbal & local rec;
uint8 isRec
# gimbal fov, XY
float32[2] fov
# gimbal real time angle, RPY <deg>
float32[3] angleRT
# gimbal real time angle rate, RPY <deg/s> <if gimbal supported>
float32[3] angleRTRate
# gimbal setted max angle rate <deg/s> <if gimbal supported>
float32[3] angleRateSet

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



(provide :uavcontrol_msgs/GimbalState "17d9d9f817a22490d422f0f90e0623a4")


