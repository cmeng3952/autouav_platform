; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude ParamSettings.msg.html

(cl:defclass <ParamSettings> (roslisp-msg-protocol:ros-message)
  ((param_name
    :reader param_name
    :initarg :param_name
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (param_value
    :reader param_value
    :initarg :param_value
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass ParamSettings (<ParamSettings>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParamSettings>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParamSettings)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<ParamSettings> is deprecated: use uavcontrol_msgs-msg:ParamSettings instead.")))

(cl:ensure-generic-function 'param_name-val :lambda-list '(m))
(cl:defmethod param_name-val ((m <ParamSettings>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:param_name-val is deprecated.  Use uavcontrol_msgs-msg:param_name instead.")
  (param_name m))

(cl:ensure-generic-function 'param_value-val :lambda-list '(m))
(cl:defmethod param_value-val ((m <ParamSettings>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:param_value-val is deprecated.  Use uavcontrol_msgs-msg:param_value instead.")
  (param_value m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParamSettings>) ostream)
  "Serializes a message object of type '<ParamSettings>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'param_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'param_name))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'param_value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'param_value))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParamSettings>) istream)
  "Deserializes a message object of type '<ParamSettings>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'param_name) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'param_name)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'param_value) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'param_value)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParamSettings>)))
  "Returns string type for a message object of type '<ParamSettings>"
  "uavcontrol_msgs/ParamSettings")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParamSettings)))
  "Returns string type for a message object of type 'ParamSettings"
  "uavcontrol_msgs/ParamSettings")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParamSettings>)))
  "Returns md5sum for a message object of type '<ParamSettings>"
  "75157f8febd181d39db292f566f5eebb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParamSettings)))
  "Returns md5sum for a message object of type 'ParamSettings"
  "75157f8febd181d39db292f566f5eebb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParamSettings>)))
  "Returns full string definition for message of type '<ParamSettings>"
  (cl:format cl:nil "string[] param_name~%string[] param_value~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParamSettings)))
  "Returns full string definition for message of type 'ParamSettings"
  (cl:format cl:nil "string[] param_name~%string[] param_value~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParamSettings>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'param_name) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'param_value) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParamSettings>))
  "Converts a ROS message object to a list"
  (cl:list 'ParamSettings
    (cl:cons ':param_name (param_name msg))
    (cl:cons ':param_value (param_value msg))
))
