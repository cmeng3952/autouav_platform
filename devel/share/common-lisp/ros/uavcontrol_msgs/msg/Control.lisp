; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude Control.msg.html

(cl:defclass <Control> (roslisp-msg-protocol:ros-message)
  ((mouse
    :reader mouse
    :initarg :mouse
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

(cl:defclass Control (<Control>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Control>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Control)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<Control> is deprecated: use uavcontrol_msgs-msg:Control instead.")))

(cl:ensure-generic-function 'mouse-val :lambda-list '(m))
(cl:defmethod mouse-val ((m <Control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:mouse-val is deprecated.  Use uavcontrol_msgs-msg:mouse instead.")
  (mouse m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <Control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:x-val is deprecated.  Use uavcontrol_msgs-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <Control>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:y-val is deprecated.  Use uavcontrol_msgs-msg:y instead.")
  (y m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Control>)))
    "Constants for message type '<Control>"
  '((:MOUSE_LEFT . 0)
    (:MOUSE_RIGHT . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Control)))
    "Constants for message type 'Control"
  '((:MOUSE_LEFT . 0)
    (:MOUSE_RIGHT . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Control>) ostream)
  "Serializes a message object of type '<Control>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'mouse)) ostream)
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Control>) istream)
  "Deserializes a message object of type '<Control>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'mouse)) (cl:read-byte istream))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Control>)))
  "Returns string type for a message object of type '<Control>"
  "uavcontrol_msgs/Control")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Control)))
  "Returns string type for a message object of type 'Control"
  "uavcontrol_msgs/Control")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Control>)))
  "Returns md5sum for a message object of type '<Control>"
  "d058b6a14f3e9c86c89eb0f109f6047d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Control)))
  "Returns md5sum for a message object of type 'Control"
  "d058b6a14f3e9c86c89eb0f109f6047d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Control>)))
  "Returns full string definition for message of type '<Control>"
  (cl:format cl:nil "uint8 mouse~%uint8 MOUSE_LEFT = 0~%uint8 MOUSE_RIGHT = 1~%~%float32 x~%float32 y~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Control)))
  "Returns full string definition for message of type 'Control"
  (cl:format cl:nil "uint8 mouse~%uint8 MOUSE_LEFT = 0~%uint8 MOUSE_RIGHT = 1~%~%float32 x~%float32 y~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Control>))
  (cl:+ 0
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Control>))
  "Converts a ROS message object to a list"
  (cl:list 'Control
    (cl:cons ':mouse (mouse msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
))
