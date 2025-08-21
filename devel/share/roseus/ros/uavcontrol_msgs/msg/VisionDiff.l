;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::VisionDiff)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'VisionDiff (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::VISIONDIFF")
  (make-package "UAVCONTROL_MSGS::VISIONDIFF"))

(in-package "ROS")
;;//! \htmlinclude VisionDiff.msg.html


(intern "*YAWPITCH*" (find-package "UAVCONTROL_MSGS::VISIONDIFF"))
(shadow '*YAWPITCH* (find-package "UAVCONTROL_MSGS::VISIONDIFF"))
(defconstant uavcontrol_msgs::VisionDiff::*YAWPITCH* 0)
(intern "*ROLLPITCH*" (find-package "UAVCONTROL_MSGS::VISIONDIFF"))
(shadow '*ROLLPITCH* (find-package "UAVCONTROL_MSGS::VISIONDIFF"))
(defconstant uavcontrol_msgs::VisionDiff::*ROLLPITCH* 1)
(intern "*MIX*" (find-package "UAVCONTROL_MSGS::VISIONDIFF"))
(shadow '*MIX* (find-package "UAVCONTROL_MSGS::VISIONDIFF"))
(defconstant uavcontrol_msgs::VisionDiff::*MIX* 3)

(defun uavcontrol_msgs::VisionDiff-to-symbol (const)
  (cond
        ((= const 0) 'uavcontrol_msgs::VisionDiff::*yawPitch*)
        ((= const 1) 'uavcontrol_msgs::VisionDiff::*rollPitch*)
        ((= const 3) 'uavcontrol_msgs::VisionDiff::*mix*)
        (t nil)))

(defclass uavcontrol_msgs::VisionDiff
  :super ros::object
  :slots (_Id _detect _objectX _objectY _objectWidth _objectHeight _frameWidth _frameHeight _kp _ki _kd _ctlMode _currSize _maxSize _minSize _trackIgnoreError _autoZoom ))

(defmethod uavcontrol_msgs::VisionDiff
  (:init
   (&key
    ((:Id __Id) 0)
    ((:detect __detect) 0)
    ((:objectX __objectX) 0)
    ((:objectY __objectY) 0)
    ((:objectWidth __objectWidth) 0)
    ((:objectHeight __objectHeight) 0)
    ((:frameWidth __frameWidth) 0)
    ((:frameHeight __frameHeight) 0)
    ((:kp __kp) 0.0)
    ((:ki __ki) 0.0)
    ((:kd __kd) 0.0)
    ((:ctlMode __ctlMode) 0)
    ((:currSize __currSize) 0.0)
    ((:maxSize __maxSize) 0.0)
    ((:minSize __minSize) 0.0)
    ((:trackIgnoreError __trackIgnoreError) 0.0)
    ((:autoZoom __autoZoom) nil)
    )
   (send-super :init)
   (setq _Id (round __Id))
   (setq _detect (round __detect))
   (setq _objectX (round __objectX))
   (setq _objectY (round __objectY))
   (setq _objectWidth (round __objectWidth))
   (setq _objectHeight (round __objectHeight))
   (setq _frameWidth (round __frameWidth))
   (setq _frameHeight (round __frameHeight))
   (setq _kp (float __kp))
   (setq _ki (float __ki))
   (setq _kd (float __kd))
   (setq _ctlMode (round __ctlMode))
   (setq _currSize (float __currSize))
   (setq _maxSize (float __maxSize))
   (setq _minSize (float __minSize))
   (setq _trackIgnoreError (float __trackIgnoreError))
   (setq _autoZoom __autoZoom)
   self)
  (:Id
   (&optional __Id)
   (if __Id (setq _Id __Id)) _Id)
  (:detect
   (&optional __detect)
   (if __detect (setq _detect __detect)) _detect)
  (:objectX
   (&optional __objectX)
   (if __objectX (setq _objectX __objectX)) _objectX)
  (:objectY
   (&optional __objectY)
   (if __objectY (setq _objectY __objectY)) _objectY)
  (:objectWidth
   (&optional __objectWidth)
   (if __objectWidth (setq _objectWidth __objectWidth)) _objectWidth)
  (:objectHeight
   (&optional __objectHeight)
   (if __objectHeight (setq _objectHeight __objectHeight)) _objectHeight)
  (:frameWidth
   (&optional __frameWidth)
   (if __frameWidth (setq _frameWidth __frameWidth)) _frameWidth)
  (:frameHeight
   (&optional __frameHeight)
   (if __frameHeight (setq _frameHeight __frameHeight)) _frameHeight)
  (:kp
   (&optional __kp)
   (if __kp (setq _kp __kp)) _kp)
  (:ki
   (&optional __ki)
   (if __ki (setq _ki __ki)) _ki)
  (:kd
   (&optional __kd)
   (if __kd (setq _kd __kd)) _kd)
  (:ctlMode
   (&optional __ctlMode)
   (if __ctlMode (setq _ctlMode __ctlMode)) _ctlMode)
  (:currSize
   (&optional __currSize)
   (if __currSize (setq _currSize __currSize)) _currSize)
  (:maxSize
   (&optional __maxSize)
   (if __maxSize (setq _maxSize __maxSize)) _maxSize)
  (:minSize
   (&optional __minSize)
   (if __minSize (setq _minSize __minSize)) _minSize)
  (:trackIgnoreError
   (&optional __trackIgnoreError)
   (if __trackIgnoreError (setq _trackIgnoreError __trackIgnoreError)) _trackIgnoreError)
  (:autoZoom
   (&optional (__autoZoom :null))
   (if (not (eq __autoZoom :null)) (setq _autoZoom __autoZoom)) _autoZoom)
  (:serialization-length
   ()
   (+
    ;; uint8 _Id
    1
    ;; uint8 _detect
    1
    ;; uint16 _objectX
    2
    ;; uint16 _objectY
    2
    ;; uint16 _objectWidth
    2
    ;; uint16 _objectHeight
    2
    ;; uint16 _frameWidth
    2
    ;; uint16 _frameHeight
    2
    ;; float32 _kp
    4
    ;; float32 _ki
    4
    ;; float32 _kd
    4
    ;; int8 _ctlMode
    1
    ;; float32 _currSize
    4
    ;; float32 _maxSize
    4
    ;; float32 _minSize
    4
    ;; float32 _trackIgnoreError
    4
    ;; bool _autoZoom
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _Id
       (write-byte _Id s)
     ;; uint8 _detect
       (write-byte _detect s)
     ;; uint16 _objectX
       (write-word _objectX s)
     ;; uint16 _objectY
       (write-word _objectY s)
     ;; uint16 _objectWidth
       (write-word _objectWidth s)
     ;; uint16 _objectHeight
       (write-word _objectHeight s)
     ;; uint16 _frameWidth
       (write-word _frameWidth s)
     ;; uint16 _frameHeight
       (write-word _frameHeight s)
     ;; float32 _kp
       (sys::poke _kp (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _ki
       (sys::poke _ki (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _kd
       (sys::poke _kd (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int8 _ctlMode
       (write-byte _ctlMode s)
     ;; float32 _currSize
       (sys::poke _currSize (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _maxSize
       (sys::poke _maxSize (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _minSize
       (sys::poke _minSize (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _trackIgnoreError
       (sys::poke _trackIgnoreError (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _autoZoom
       (if _autoZoom (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _Id
     (setq _Id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _detect
     (setq _detect (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint16 _objectX
     (setq _objectX (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _objectY
     (setq _objectY (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _objectWidth
     (setq _objectWidth (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _objectHeight
     (setq _objectHeight (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _frameWidth
     (setq _frameWidth (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _frameHeight
     (setq _frameHeight (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; float32 _kp
     (setq _kp (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _ki
     (setq _ki (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _kd
     (setq _kd (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int8 _ctlMode
     (setq _ctlMode (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _ctlMode 127) (setq _ctlMode (- _ctlMode 256)))
   ;; float32 _currSize
     (setq _currSize (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _maxSize
     (setq _maxSize (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _minSize
     (setq _minSize (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _trackIgnoreError
     (setq _trackIgnoreError (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _autoZoom
     (setq _autoZoom (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get uavcontrol_msgs::VisionDiff :md5sum-) "42ea811a55788f015447302191910a5c")
(setf (get uavcontrol_msgs::VisionDiff :datatype-) "uavcontrol_msgs/VisionDiff")
(setf (get uavcontrol_msgs::VisionDiff :definition-)
      "uint8 Id
uint8 detect

uint16 objectX # 左上角
uint16 objectY # 左上角
uint16 objectWidth
uint16 objectHeight

uint16 frameWidth
uint16 frameHeight

# Gimbal 跟踪pid
float32 kp
float32 ki
float32 kd

int8 ctlMode # 0: yaw+pitch, 1: roll+pitch 3:混合(未实现)
int8 yawPitch = 0
int8 rollPitch = 1
int8 mix=3

# 用于自动缩放
float32 currSize    #框选近大远小
float32 maxSize
float32 minSize #框选大小

float32 trackIgnoreError
bool autoZoom
")



(provide :uavcontrol_msgs/VisionDiff "42ea811a55788f015447302191910a5c")


