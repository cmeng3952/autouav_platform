; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude OffsetPose.msg.html

(cl:defclass <OffsetPose> (roslisp-msg-protocol:ros-message)
  ((uav_id
    :reader uav_id
    :initarg :uav_id
    :type cl:fixnum
    :initform 0)
   (x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0))
)

(cl:defclass OffsetPose (<OffsetPose>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <OffsetPose>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'OffsetPose)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<OffsetPose> is deprecated: use uavcontrol_msgs-msg:OffsetPose instead.")))

(cl:ensure-generic-function 'uav_id-val :lambda-list '(m))
(cl:defmethod uav_id-val ((m <OffsetPose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:uav_id-val is deprecated.  Use uavcontrol_msgs-msg:uav_id instead.")
  (uav_id m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <OffsetPose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:x-val is deprecated.  Use uavcontrol_msgs-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <OffsetPose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:y-val is deprecated.  Use uavcontrol_msgs-msg:y instead.")
  (y m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <OffsetPose>) ostream)
  "Serializes a message object of type '<OffsetPose>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'uav_id)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <OffsetPose>) istream)
  "Deserializes a message object of type '<OffsetPose>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'uav_id)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<OffsetPose>)))
  "Returns string type for a message object of type '<OffsetPose>"
  "uavcontrol_msgs/OffsetPose")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'OffsetPose)))
  "Returns string type for a message object of type 'OffsetPose"
  "uavcontrol_msgs/OffsetPose")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<OffsetPose>)))
  "Returns md5sum for a message object of type '<OffsetPose>"
  "f20d15993ada6c6c2a861137ed3dcd2a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'OffsetPose)))
  "Returns md5sum for a message object of type 'OffsetPose"
  "f20d15993ada6c6c2a861137ed3dcd2a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<OffsetPose>)))
  "Returns full string definition for message of type '<OffsetPose>"
  (cl:format cl:nil "uint8 uav_id~%float32 x~%float32 y~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'OffsetPose)))
  "Returns full string definition for message of type 'OffsetPose"
  (cl:format cl:nil "uint8 uav_id~%float32 x~%float32 y~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <OffsetPose>))
  (cl:+ 0
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <OffsetPose>))
  "Converts a ROS message object to a list"
  (cl:list 'OffsetPose
    (cl:cons ':uav_id (uav_id msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
))
