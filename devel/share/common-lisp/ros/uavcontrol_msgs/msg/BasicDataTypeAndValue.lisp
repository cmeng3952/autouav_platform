; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude BasicDataTypeAndValue.msg.html

(cl:defclass <BasicDataTypeAndValue> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (type
    :reader type
    :initarg :type
    :type cl:fixnum
    :initform 0)
   (integer_value
    :reader integer_value
    :initarg :integer_value
    :type cl:integer
    :initform 0)
   (boolean_value
    :reader boolean_value
    :initarg :boolean_value
    :type cl:boolean
    :initform cl:nil)
   (float_value
    :reader float_value
    :initarg :float_value
    :type cl:float
    :initform 0.0)
   (double_value
    :reader double_value
    :initarg :double_value
    :type cl:float
    :initform 0.0)
   (string_value
    :reader string_value
    :initarg :string_value
    :type cl:string
    :initform ""))
)

(cl:defclass BasicDataTypeAndValue (<BasicDataTypeAndValue>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BasicDataTypeAndValue>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BasicDataTypeAndValue)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<BasicDataTypeAndValue> is deprecated: use uavcontrol_msgs-msg:BasicDataTypeAndValue instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <BasicDataTypeAndValue>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:name-val is deprecated.  Use uavcontrol_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <BasicDataTypeAndValue>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:type-val is deprecated.  Use uavcontrol_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'integer_value-val :lambda-list '(m))
(cl:defmethod integer_value-val ((m <BasicDataTypeAndValue>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:integer_value-val is deprecated.  Use uavcontrol_msgs-msg:integer_value instead.")
  (integer_value m))

(cl:ensure-generic-function 'boolean_value-val :lambda-list '(m))
(cl:defmethod boolean_value-val ((m <BasicDataTypeAndValue>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:boolean_value-val is deprecated.  Use uavcontrol_msgs-msg:boolean_value instead.")
  (boolean_value m))

(cl:ensure-generic-function 'float_value-val :lambda-list '(m))
(cl:defmethod float_value-val ((m <BasicDataTypeAndValue>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:float_value-val is deprecated.  Use uavcontrol_msgs-msg:float_value instead.")
  (float_value m))

(cl:ensure-generic-function 'double_value-val :lambda-list '(m))
(cl:defmethod double_value-val ((m <BasicDataTypeAndValue>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:double_value-val is deprecated.  Use uavcontrol_msgs-msg:double_value instead.")
  (double_value m))

(cl:ensure-generic-function 'string_value-val :lambda-list '(m))
(cl:defmethod string_value-val ((m <BasicDataTypeAndValue>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:string_value-val is deprecated.  Use uavcontrol_msgs-msg:string_value instead.")
  (string_value m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<BasicDataTypeAndValue>)))
    "Constants for message type '<BasicDataTypeAndValue>"
  '((:INTEGER . 1)
    (:BOOLEAN . 2)
    (:FLOAT . 3)
    (:DOUBLE . 4)
    (:STRING . 5))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'BasicDataTypeAndValue)))
    "Constants for message type 'BasicDataTypeAndValue"
  '((:INTEGER . 1)
    (:BOOLEAN . 2)
    (:FLOAT . 3)
    (:DOUBLE . 4)
    (:STRING . 5))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BasicDataTypeAndValue>) ostream)
  "Serializes a message object of type '<BasicDataTypeAndValue>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'integer_value)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'boolean_value) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'float_value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'double_value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'string_value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'string_value))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BasicDataTypeAndValue>) istream)
  "Deserializes a message object of type '<BasicDataTypeAndValue>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'integer_value) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'boolean_value) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'float_value) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'double_value) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'string_value) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'string_value) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BasicDataTypeAndValue>)))
  "Returns string type for a message object of type '<BasicDataTypeAndValue>"
  "uavcontrol_msgs/BasicDataTypeAndValue")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BasicDataTypeAndValue)))
  "Returns string type for a message object of type 'BasicDataTypeAndValue"
  "uavcontrol_msgs/BasicDataTypeAndValue")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BasicDataTypeAndValue>)))
  "Returns md5sum for a message object of type '<BasicDataTypeAndValue>"
  "43928e1d51d365ceca1cc00365d754f1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BasicDataTypeAndValue)))
  "Returns md5sum for a message object of type 'BasicDataTypeAndValue"
  "43928e1d51d365ceca1cc00365d754f1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BasicDataTypeAndValue>)))
  "Returns full string definition for message of type '<BasicDataTypeAndValue>"
  (cl:format cl:nil "string name~%~%uint8 type~%uint8 INTEGER=1~%uint8 BOOLEAN=2~%uint8 FLOAT=3~%uint8 DOUBLE=4~%uint8 STRING=5~%~%int32 integer_value~%bool boolean_value~%float32 float_value~%float64 double_value~%string string_value~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BasicDataTypeAndValue)))
  "Returns full string definition for message of type 'BasicDataTypeAndValue"
  (cl:format cl:nil "string name~%~%uint8 type~%uint8 INTEGER=1~%uint8 BOOLEAN=2~%uint8 FLOAT=3~%uint8 DOUBLE=4~%uint8 STRING=5~%~%int32 integer_value~%bool boolean_value~%float32 float_value~%float64 double_value~%string string_value~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BasicDataTypeAndValue>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     1
     4
     1
     4
     8
     4 (cl:length (cl:slot-value msg 'string_value))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BasicDataTypeAndValue>))
  "Converts a ROS message object to a list"
  (cl:list 'BasicDataTypeAndValue
    (cl:cons ':name (name msg))
    (cl:cons ':type (type msg))
    (cl:cons ':integer_value (integer_value msg))
    (cl:cons ':boolean_value (boolean_value msg))
    (cl:cons ':float_value (float_value msg))
    (cl:cons ':double_value (double_value msg))
    (cl:cons ':string_value (string_value msg))
))
