; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude LinktrackNode2.msg.html

(cl:defclass <LinktrackNode2> (roslisp-msg-protocol:ros-message)
  ((role
    :reader role
    :initarg :role
    :type cl:fixnum
    :initform 0)
   (id
    :reader id
    :initarg :id
    :type cl:fixnum
    :initform 0)
   (dis
    :reader dis
    :initarg :dis
    :type cl:float
    :initform 0.0)
   (fp_rssi
    :reader fp_rssi
    :initarg :fp_rssi
    :type cl:float
    :initform 0.0)
   (rx_rssi
    :reader rx_rssi
    :initarg :rx_rssi
    :type cl:float
    :initform 0.0))
)

(cl:defclass LinktrackNode2 (<LinktrackNode2>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LinktrackNode2>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LinktrackNode2)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<LinktrackNode2> is deprecated: use uavcontrol_msgs-msg:LinktrackNode2 instead.")))

(cl:ensure-generic-function 'role-val :lambda-list '(m))
(cl:defmethod role-val ((m <LinktrackNode2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:role-val is deprecated.  Use uavcontrol_msgs-msg:role instead.")
  (role m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <LinktrackNode2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:id-val is deprecated.  Use uavcontrol_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'dis-val :lambda-list '(m))
(cl:defmethod dis-val ((m <LinktrackNode2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:dis-val is deprecated.  Use uavcontrol_msgs-msg:dis instead.")
  (dis m))

(cl:ensure-generic-function 'fp_rssi-val :lambda-list '(m))
(cl:defmethod fp_rssi-val ((m <LinktrackNode2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:fp_rssi-val is deprecated.  Use uavcontrol_msgs-msg:fp_rssi instead.")
  (fp_rssi m))

(cl:ensure-generic-function 'rx_rssi-val :lambda-list '(m))
(cl:defmethod rx_rssi-val ((m <LinktrackNode2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:rx_rssi-val is deprecated.  Use uavcontrol_msgs-msg:rx_rssi instead.")
  (rx_rssi m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LinktrackNode2>) ostream)
  "Serializes a message object of type '<LinktrackNode2>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'role)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dis))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fp_rssi))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rx_rssi))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LinktrackNode2>) istream)
  "Deserializes a message object of type '<LinktrackNode2>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'role)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dis) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fp_rssi) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rx_rssi) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LinktrackNode2>)))
  "Returns string type for a message object of type '<LinktrackNode2>"
  "uavcontrol_msgs/LinktrackNode2")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LinktrackNode2)))
  "Returns string type for a message object of type 'LinktrackNode2"
  "uavcontrol_msgs/LinktrackNode2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LinktrackNode2>)))
  "Returns md5sum for a message object of type '<LinktrackNode2>"
  "ebc34feb8e11fb1b06d65ee49880b996")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LinktrackNode2)))
  "Returns md5sum for a message object of type 'LinktrackNode2"
  "ebc34feb8e11fb1b06d65ee49880b996")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LinktrackNode2>)))
  "Returns full string definition for message of type '<LinktrackNode2>"
  (cl:format cl:nil "uint8 role~%uint8 id~%float32 dis~%float32 fp_rssi~%float32 rx_rssi~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LinktrackNode2)))
  "Returns full string definition for message of type 'LinktrackNode2"
  (cl:format cl:nil "uint8 role~%uint8 id~%float32 dis~%float32 fp_rssi~%float32 rx_rssi~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LinktrackNode2>))
  (cl:+ 0
     1
     1
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LinktrackNode2>))
  "Converts a ROS message object to a list"
  (cl:list 'LinktrackNode2
    (cl:cons ':role (role msg))
    (cl:cons ':id (id msg))
    (cl:cons ':dis (dis msg))
    (cl:cons ':fp_rssi (fp_rssi msg))
    (cl:cons ':rx_rssi (rx_rssi msg))
))
