; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude VisionDiff.msg.html

(cl:defclass <VisionDiff> (roslisp-msg-protocol:ros-message)
  ((Id
    :reader Id
    :initarg :Id
    :type cl:fixnum
    :initform 0)
   (detect
    :reader detect
    :initarg :detect
    :type cl:fixnum
    :initform 0)
   (objectX
    :reader objectX
    :initarg :objectX
    :type cl:fixnum
    :initform 0)
   (objectY
    :reader objectY
    :initarg :objectY
    :type cl:fixnum
    :initform 0)
   (objectWidth
    :reader objectWidth
    :initarg :objectWidth
    :type cl:fixnum
    :initform 0)
   (objectHeight
    :reader objectHeight
    :initarg :objectHeight
    :type cl:fixnum
    :initform 0)
   (frameWidth
    :reader frameWidth
    :initarg :frameWidth
    :type cl:fixnum
    :initform 0)
   (frameHeight
    :reader frameHeight
    :initarg :frameHeight
    :type cl:fixnum
    :initform 0)
   (kp
    :reader kp
    :initarg :kp
    :type cl:float
    :initform 0.0)
   (ki
    :reader ki
    :initarg :ki
    :type cl:float
    :initform 0.0)
   (kd
    :reader kd
    :initarg :kd
    :type cl:float
    :initform 0.0)
   (ctlMode
    :reader ctlMode
    :initarg :ctlMode
    :type cl:fixnum
    :initform 0)
   (currSize
    :reader currSize
    :initarg :currSize
    :type cl:float
    :initform 0.0)
   (maxSize
    :reader maxSize
    :initarg :maxSize
    :type cl:float
    :initform 0.0)
   (minSize
    :reader minSize
    :initarg :minSize
    :type cl:float
    :initform 0.0)
   (trackIgnoreError
    :reader trackIgnoreError
    :initarg :trackIgnoreError
    :type cl:float
    :initform 0.0)
   (autoZoom
    :reader autoZoom
    :initarg :autoZoom
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass VisionDiff (<VisionDiff>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <VisionDiff>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'VisionDiff)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<VisionDiff> is deprecated: use uavcontrol_msgs-msg:VisionDiff instead.")))

(cl:ensure-generic-function 'Id-val :lambda-list '(m))
(cl:defmethod Id-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Id-val is deprecated.  Use uavcontrol_msgs-msg:Id instead.")
  (Id m))

(cl:ensure-generic-function 'detect-val :lambda-list '(m))
(cl:defmethod detect-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:detect-val is deprecated.  Use uavcontrol_msgs-msg:detect instead.")
  (detect m))

(cl:ensure-generic-function 'objectX-val :lambda-list '(m))
(cl:defmethod objectX-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:objectX-val is deprecated.  Use uavcontrol_msgs-msg:objectX instead.")
  (objectX m))

(cl:ensure-generic-function 'objectY-val :lambda-list '(m))
(cl:defmethod objectY-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:objectY-val is deprecated.  Use uavcontrol_msgs-msg:objectY instead.")
  (objectY m))

(cl:ensure-generic-function 'objectWidth-val :lambda-list '(m))
(cl:defmethod objectWidth-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:objectWidth-val is deprecated.  Use uavcontrol_msgs-msg:objectWidth instead.")
  (objectWidth m))

(cl:ensure-generic-function 'objectHeight-val :lambda-list '(m))
(cl:defmethod objectHeight-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:objectHeight-val is deprecated.  Use uavcontrol_msgs-msg:objectHeight instead.")
  (objectHeight m))

(cl:ensure-generic-function 'frameWidth-val :lambda-list '(m))
(cl:defmethod frameWidth-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:frameWidth-val is deprecated.  Use uavcontrol_msgs-msg:frameWidth instead.")
  (frameWidth m))

(cl:ensure-generic-function 'frameHeight-val :lambda-list '(m))
(cl:defmethod frameHeight-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:frameHeight-val is deprecated.  Use uavcontrol_msgs-msg:frameHeight instead.")
  (frameHeight m))

(cl:ensure-generic-function 'kp-val :lambda-list '(m))
(cl:defmethod kp-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:kp-val is deprecated.  Use uavcontrol_msgs-msg:kp instead.")
  (kp m))

(cl:ensure-generic-function 'ki-val :lambda-list '(m))
(cl:defmethod ki-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:ki-val is deprecated.  Use uavcontrol_msgs-msg:ki instead.")
  (ki m))

(cl:ensure-generic-function 'kd-val :lambda-list '(m))
(cl:defmethod kd-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:kd-val is deprecated.  Use uavcontrol_msgs-msg:kd instead.")
  (kd m))

(cl:ensure-generic-function 'ctlMode-val :lambda-list '(m))
(cl:defmethod ctlMode-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:ctlMode-val is deprecated.  Use uavcontrol_msgs-msg:ctlMode instead.")
  (ctlMode m))

(cl:ensure-generic-function 'currSize-val :lambda-list '(m))
(cl:defmethod currSize-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:currSize-val is deprecated.  Use uavcontrol_msgs-msg:currSize instead.")
  (currSize m))

(cl:ensure-generic-function 'maxSize-val :lambda-list '(m))
(cl:defmethod maxSize-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:maxSize-val is deprecated.  Use uavcontrol_msgs-msg:maxSize instead.")
  (maxSize m))

(cl:ensure-generic-function 'minSize-val :lambda-list '(m))
(cl:defmethod minSize-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:minSize-val is deprecated.  Use uavcontrol_msgs-msg:minSize instead.")
  (minSize m))

(cl:ensure-generic-function 'trackIgnoreError-val :lambda-list '(m))
(cl:defmethod trackIgnoreError-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:trackIgnoreError-val is deprecated.  Use uavcontrol_msgs-msg:trackIgnoreError instead.")
  (trackIgnoreError m))

(cl:ensure-generic-function 'autoZoom-val :lambda-list '(m))
(cl:defmethod autoZoom-val ((m <VisionDiff>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:autoZoom-val is deprecated.  Use uavcontrol_msgs-msg:autoZoom instead.")
  (autoZoom m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<VisionDiff>)))
    "Constants for message type '<VisionDiff>"
  '((:YAWPITCH . 0)
    (:ROLLPITCH . 1)
    (:MIX . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'VisionDiff)))
    "Constants for message type 'VisionDiff"
  '((:YAWPITCH . 0)
    (:ROLLPITCH . 1)
    (:MIX . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <VisionDiff>) ostream)
  "Serializes a message object of type '<VisionDiff>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'detect)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'objectX)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'objectX)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'objectY)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'objectY)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'objectWidth)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'objectWidth)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'objectHeight)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'objectHeight)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frameWidth)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'frameWidth)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frameHeight)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'frameHeight)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'kp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ki))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'kd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'ctlMode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'currSize))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'maxSize))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'minSize))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'trackIgnoreError))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'autoZoom) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <VisionDiff>) istream)
  "Deserializes a message object of type '<VisionDiff>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'detect)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'objectX)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'objectX)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'objectY)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'objectY)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'objectWidth)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'objectWidth)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'objectHeight)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'objectHeight)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frameWidth)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'frameWidth)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frameHeight)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'frameHeight)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'kp) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ki) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'kd) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ctlMode) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'currSize) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'maxSize) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'minSize) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'trackIgnoreError) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'autoZoom) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<VisionDiff>)))
  "Returns string type for a message object of type '<VisionDiff>"
  "uavcontrol_msgs/VisionDiff")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'VisionDiff)))
  "Returns string type for a message object of type 'VisionDiff"
  "uavcontrol_msgs/VisionDiff")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<VisionDiff>)))
  "Returns md5sum for a message object of type '<VisionDiff>"
  "42ea811a55788f015447302191910a5c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'VisionDiff)))
  "Returns md5sum for a message object of type 'VisionDiff"
  "42ea811a55788f015447302191910a5c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<VisionDiff>)))
  "Returns full string definition for message of type '<VisionDiff>"
  (cl:format cl:nil "uint8 Id~%uint8 detect~%~%uint16 objectX # 左上角~%uint16 objectY # 左上角~%uint16 objectWidth~%uint16 objectHeight~%~%uint16 frameWidth~%uint16 frameHeight~%~%# Gimbal 跟踪pid~%float32 kp~%float32 ki~%float32 kd~%~%int8 ctlMode # 0: yaw+pitch, 1: roll+pitch 3:混合(未实现)~%int8 yawPitch = 0~%int8 rollPitch = 1~%int8 mix=3~%~%# 用于自动缩放~%float32 currSize    #框选近大远小~%float32 maxSize~%float32 minSize #框选大小~%~%float32 trackIgnoreError~%bool autoZoom~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'VisionDiff)))
  "Returns full string definition for message of type 'VisionDiff"
  (cl:format cl:nil "uint8 Id~%uint8 detect~%~%uint16 objectX # 左上角~%uint16 objectY # 左上角~%uint16 objectWidth~%uint16 objectHeight~%~%uint16 frameWidth~%uint16 frameHeight~%~%# Gimbal 跟踪pid~%float32 kp~%float32 ki~%float32 kd~%~%int8 ctlMode # 0: yaw+pitch, 1: roll+pitch 3:混合(未实现)~%int8 yawPitch = 0~%int8 rollPitch = 1~%int8 mix=3~%~%# 用于自动缩放~%float32 currSize    #框选近大远小~%float32 maxSize~%float32 minSize #框选大小~%~%float32 trackIgnoreError~%bool autoZoom~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <VisionDiff>))
  (cl:+ 0
     1
     1
     2
     2
     2
     2
     2
     2
     4
     4
     4
     1
     4
     4
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <VisionDiff>))
  "Converts a ROS message object to a list"
  (cl:list 'VisionDiff
    (cl:cons ':Id (Id msg))
    (cl:cons ':detect (detect msg))
    (cl:cons ':objectX (objectX msg))
    (cl:cons ':objectY (objectY msg))
    (cl:cons ':objectWidth (objectWidth msg))
    (cl:cons ':objectHeight (objectHeight msg))
    (cl:cons ':frameWidth (frameWidth msg))
    (cl:cons ':frameHeight (frameHeight msg))
    (cl:cons ':kp (kp msg))
    (cl:cons ':ki (ki msg))
    (cl:cons ':kd (kd msg))
    (cl:cons ':ctlMode (ctlMode msg))
    (cl:cons ':currSize (currSize msg))
    (cl:cons ':maxSize (maxSize msg))
    (cl:cons ':minSize (minSize msg))
    (cl:cons ':trackIgnoreError (trackIgnoreError msg))
    (cl:cons ':autoZoom (autoZoom msg))
))
