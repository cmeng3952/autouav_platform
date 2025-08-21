; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude DetectionInfoSub.msg.html

(cl:defclass <DetectionInfoSub> (roslisp-msg-protocol:ros-message)
  ((left
    :reader left
    :initarg :left
    :type cl:float
    :initform 0.0)
   (top
    :reader top
    :initarg :top
    :type cl:float
    :initform 0.0)
   (bot
    :reader bot
    :initarg :bot
    :type cl:float
    :initform 0.0)
   (right
    :reader right
    :initarg :right
    :type cl:float
    :initform 0.0)
   (trackIds
    :reader trackIds
    :initarg :trackIds
    :type cl:integer
    :initform 0))
)

(cl:defclass DetectionInfoSub (<DetectionInfoSub>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DetectionInfoSub>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DetectionInfoSub)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<DetectionInfoSub> is deprecated: use uavcontrol_msgs-msg:DetectionInfoSub instead.")))

(cl:ensure-generic-function 'left-val :lambda-list '(m))
(cl:defmethod left-val ((m <DetectionInfoSub>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:left-val is deprecated.  Use uavcontrol_msgs-msg:left instead.")
  (left m))

(cl:ensure-generic-function 'top-val :lambda-list '(m))
(cl:defmethod top-val ((m <DetectionInfoSub>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:top-val is deprecated.  Use uavcontrol_msgs-msg:top instead.")
  (top m))

(cl:ensure-generic-function 'bot-val :lambda-list '(m))
(cl:defmethod bot-val ((m <DetectionInfoSub>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:bot-val is deprecated.  Use uavcontrol_msgs-msg:bot instead.")
  (bot m))

(cl:ensure-generic-function 'right-val :lambda-list '(m))
(cl:defmethod right-val ((m <DetectionInfoSub>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:right-val is deprecated.  Use uavcontrol_msgs-msg:right instead.")
  (right m))

(cl:ensure-generic-function 'trackIds-val :lambda-list '(m))
(cl:defmethod trackIds-val ((m <DetectionInfoSub>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:trackIds-val is deprecated.  Use uavcontrol_msgs-msg:trackIds instead.")
  (trackIds m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DetectionInfoSub>) ostream)
  "Serializes a message object of type '<DetectionInfoSub>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'left))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'top))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'bot))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'right))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'trackIds)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DetectionInfoSub>) istream)
  "Deserializes a message object of type '<DetectionInfoSub>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'left) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'top) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'bot) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'right) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'trackIds) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DetectionInfoSub>)))
  "Returns string type for a message object of type '<DetectionInfoSub>"
  "uavcontrol_msgs/DetectionInfoSub")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DetectionInfoSub)))
  "Returns string type for a message object of type 'DetectionInfoSub"
  "uavcontrol_msgs/DetectionInfoSub")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DetectionInfoSub>)))
  "Returns md5sum for a message object of type '<DetectionInfoSub>"
  "0acdf38ac4afc4c07844dc3ad8b9c432")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DetectionInfoSub)))
  "Returns md5sum for a message object of type 'DetectionInfoSub"
  "0acdf38ac4afc4c07844dc3ad8b9c432")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DetectionInfoSub>)))
  "Returns full string definition for message of type '<DetectionInfoSub>"
  (cl:format cl:nil "#目标框的位置（主要斜对角两个点）~%float32 left~%float32 top~%float32 bot~%float32 right~%~%~%## TRACK TARGET(目标框ID)~%int32 trackIds~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DetectionInfoSub)))
  "Returns full string definition for message of type 'DetectionInfoSub"
  (cl:format cl:nil "#目标框的位置（主要斜对角两个点）~%float32 left~%float32 top~%float32 bot~%float32 right~%~%~%## TRACK TARGET(目标框ID)~%int32 trackIds~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DetectionInfoSub>))
  (cl:+ 0
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DetectionInfoSub>))
  "Converts a ROS message object to a list"
  (cl:list 'DetectionInfoSub
    (cl:cons ':left (left msg))
    (cl:cons ':top (top msg))
    (cl:cons ':bot (bot msg))
    (cl:cons ':right (right msg))
    (cl:cons ':trackIds (trackIds msg))
))
