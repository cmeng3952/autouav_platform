; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude ShoutStates.msg.html

(cl:defclass <ShoutStates> (roslisp-msg-protocol:ros-message)
  ((is_active
    :reader is_active
    :initarg :is_active
    :type cl:boolean
    :initform cl:nil)
   (state
    :reader state
    :initarg :state
    :type cl:string
    :initform ""))
)

(cl:defclass ShoutStates (<ShoutStates>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ShoutStates>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ShoutStates)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<ShoutStates> is deprecated: use uavcontrol_msgs-msg:ShoutStates instead.")))

(cl:ensure-generic-function 'is_active-val :lambda-list '(m))
(cl:defmethod is_active-val ((m <ShoutStates>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:is_active-val is deprecated.  Use uavcontrol_msgs-msg:is_active instead.")
  (is_active m))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <ShoutStates>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:state-val is deprecated.  Use uavcontrol_msgs-msg:state instead.")
  (state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ShoutStates>) ostream)
  "Serializes a message object of type '<ShoutStates>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_active) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'state))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'state))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ShoutStates>) istream)
  "Deserializes a message object of type '<ShoutStates>"
    (cl:setf (cl:slot-value msg 'is_active) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'state) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'state) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ShoutStates>)))
  "Returns string type for a message object of type '<ShoutStates>"
  "uavcontrol_msgs/ShoutStates")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ShoutStates)))
  "Returns string type for a message object of type 'ShoutStates"
  "uavcontrol_msgs/ShoutStates")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ShoutStates>)))
  "Returns md5sum for a message object of type '<ShoutStates>"
  "1165944cad65c58bd2d119eb4ad9c08c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ShoutStates)))
  "Returns md5sum for a message object of type 'ShoutStates"
  "1165944cad65c58bd2d119eb4ad9c08c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ShoutStates>)))
  "Returns full string definition for message of type '<ShoutStates>"
  (cl:format cl:nil "bool is_active  # 喊话开关状态：true=开启，false=关闭~%string state~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ShoutStates)))
  "Returns full string definition for message of type 'ShoutStates"
  (cl:format cl:nil "bool is_active  # 喊话开关状态：true=开启，false=关闭~%string state~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ShoutStates>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'state))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ShoutStates>))
  "Converts a ROS message object to a list"
  (cl:list 'ShoutStates
    (cl:cons ':is_active (is_active msg))
    (cl:cons ':state (state msg))
))
