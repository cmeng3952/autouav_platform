; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude GeoFence.msg.html

(cl:defclass <GeoFence> (roslisp-msg-protocol:ros-message)
  ((x_min
    :reader x_min
    :initarg :x_min
    :type cl:float
    :initform 0.0)
   (x_max
    :reader x_max
    :initarg :x_max
    :type cl:float
    :initform 0.0)
   (y_min
    :reader y_min
    :initarg :y_min
    :type cl:float
    :initform 0.0)
   (y_max
    :reader y_max
    :initarg :y_max
    :type cl:float
    :initform 0.0)
   (z_min
    :reader z_min
    :initarg :z_min
    :type cl:float
    :initform 0.0)
   (z_max
    :reader z_max
    :initarg :z_max
    :type cl:float
    :initform 0.0))
)

(cl:defclass GeoFence (<GeoFence>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GeoFence>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GeoFence)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<GeoFence> is deprecated: use uavcontrol_msgs-msg:GeoFence instead.")))

(cl:ensure-generic-function 'x_min-val :lambda-list '(m))
(cl:defmethod x_min-val ((m <GeoFence>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:x_min-val is deprecated.  Use uavcontrol_msgs-msg:x_min instead.")
  (x_min m))

(cl:ensure-generic-function 'x_max-val :lambda-list '(m))
(cl:defmethod x_max-val ((m <GeoFence>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:x_max-val is deprecated.  Use uavcontrol_msgs-msg:x_max instead.")
  (x_max m))

(cl:ensure-generic-function 'y_min-val :lambda-list '(m))
(cl:defmethod y_min-val ((m <GeoFence>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:y_min-val is deprecated.  Use uavcontrol_msgs-msg:y_min instead.")
  (y_min m))

(cl:ensure-generic-function 'y_max-val :lambda-list '(m))
(cl:defmethod y_max-val ((m <GeoFence>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:y_max-val is deprecated.  Use uavcontrol_msgs-msg:y_max instead.")
  (y_max m))

(cl:ensure-generic-function 'z_min-val :lambda-list '(m))
(cl:defmethod z_min-val ((m <GeoFence>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:z_min-val is deprecated.  Use uavcontrol_msgs-msg:z_min instead.")
  (z_min m))

(cl:ensure-generic-function 'z_max-val :lambda-list '(m))
(cl:defmethod z_max-val ((m <GeoFence>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:z_max-val is deprecated.  Use uavcontrol_msgs-msg:z_max instead.")
  (z_max m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GeoFence>) ostream)
  "Serializes a message object of type '<GeoFence>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x_min))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x_max))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y_min))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y_max))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'z_min))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'z_max))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GeoFence>) istream)
  "Deserializes a message object of type '<GeoFence>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x_min) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x_max) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y_min) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y_max) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'z_min) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'z_max) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GeoFence>)))
  "Returns string type for a message object of type '<GeoFence>"
  "uavcontrol_msgs/GeoFence")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GeoFence)))
  "Returns string type for a message object of type 'GeoFence"
  "uavcontrol_msgs/GeoFence")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GeoFence>)))
  "Returns md5sum for a message object of type '<GeoFence>"
  "d44785c3961c1071248f125a86fee65b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GeoFence)))
  "Returns md5sum for a message object of type 'GeoFence"
  "d44785c3961c1071248f125a86fee65b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GeoFence>)))
  "Returns full string definition for message of type '<GeoFence>"
  (cl:format cl:nil "float32 x_min~%float32 x_max~%float32 y_min~%float32 y_max~%float32 z_min~%float32 z_max~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GeoFence)))
  "Returns full string definition for message of type 'GeoFence"
  (cl:format cl:nil "float32 x_min~%float32 x_max~%float32 y_min~%float32 y_max~%float32 z_min~%float32 z_max~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GeoFence>))
  (cl:+ 0
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GeoFence>))
  "Converts a ROS message object to a list"
  (cl:list 'GeoFence
    (cl:cons ':x_min (x_min msg))
    (cl:cons ':x_max (x_max msg))
    (cl:cons ':y_min (y_min msg))
    (cl:cons ':y_max (y_max msg))
    (cl:cons ':z_min (z_min msg))
    (cl:cons ':z_max (z_max msg))
))
