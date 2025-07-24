; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude UGVCommand.msg.html

(cl:defclass <UGVCommand> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (Command_ID
    :reader Command_ID
    :initarg :Command_ID
    :type cl:integer
    :initform 0)
   (Mode
    :reader Mode
    :initarg :Mode
    :type cl:fixnum
    :initform 0)
   (position_ref
    :reader position_ref
    :initarg :position_ref
    :type (cl:vector cl:float)
   :initform (cl:make-array 2 :element-type 'cl:float :initial-element 0.0))
   (yaw_ref
    :reader yaw_ref
    :initarg :yaw_ref
    :type cl:float
    :initform 0.0)
   (linear_vel
    :reader linear_vel
    :initarg :linear_vel
    :type (cl:vector cl:float)
   :initform (cl:make-array 2 :element-type 'cl:float :initial-element 0.0))
   (angular_vel
    :reader angular_vel
    :initarg :angular_vel
    :type cl:float
    :initform 0.0))
)

(cl:defclass UGVCommand (<UGVCommand>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UGVCommand>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UGVCommand)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<UGVCommand> is deprecated: use uavcontrol_msgs-msg:UGVCommand instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <UGVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'Command_ID-val :lambda-list '(m))
(cl:defmethod Command_ID-val ((m <UGVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Command_ID-val is deprecated.  Use uavcontrol_msgs-msg:Command_ID instead.")
  (Command_ID m))

(cl:ensure-generic-function 'Mode-val :lambda-list '(m))
(cl:defmethod Mode-val ((m <UGVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Mode-val is deprecated.  Use uavcontrol_msgs-msg:Mode instead.")
  (Mode m))

(cl:ensure-generic-function 'position_ref-val :lambda-list '(m))
(cl:defmethod position_ref-val ((m <UGVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:position_ref-val is deprecated.  Use uavcontrol_msgs-msg:position_ref instead.")
  (position_ref m))

(cl:ensure-generic-function 'yaw_ref-val :lambda-list '(m))
(cl:defmethod yaw_ref-val ((m <UGVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:yaw_ref-val is deprecated.  Use uavcontrol_msgs-msg:yaw_ref instead.")
  (yaw_ref m))

(cl:ensure-generic-function 'linear_vel-val :lambda-list '(m))
(cl:defmethod linear_vel-val ((m <UGVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:linear_vel-val is deprecated.  Use uavcontrol_msgs-msg:linear_vel instead.")
  (linear_vel m))

(cl:ensure-generic-function 'angular_vel-val :lambda-list '(m))
(cl:defmethod angular_vel-val ((m <UGVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:angular_vel-val is deprecated.  Use uavcontrol_msgs-msg:angular_vel instead.")
  (angular_vel m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<UGVCommand>)))
    "Constants for message type '<UGVCommand>"
  '((:HOLD . 0)
    (:DIRECT_CONTROL_BODY . 1)
    (:DIRECT_CONTROL_ENU . 2)
    (:POINT_CONTROL . 3)
    (:PATH_CONTROL . 4)
    (:TEST . 5))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'UGVCommand)))
    "Constants for message type 'UGVCommand"
  '((:HOLD . 0)
    (:DIRECT_CONTROL_BODY . 1)
    (:DIRECT_CONTROL_ENU . 2)
    (:POINT_CONTROL . 3)
    (:PATH_CONTROL . 4)
    (:TEST . 5))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UGVCommand>) ostream)
  "Serializes a message object of type '<UGVCommand>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Command_ID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'Command_ID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'Command_ID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'Command_ID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Mode)) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'position_ref))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yaw_ref))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'linear_vel))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angular_vel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UGVCommand>) istream)
  "Deserializes a message object of type '<UGVCommand>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Command_ID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'Command_ID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'Command_ID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'Command_ID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Mode)) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'position_ref) (cl:make-array 2))
  (cl:let ((vals (cl:slot-value msg 'position_ref)))
    (cl:dotimes (i 2)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yaw_ref) (roslisp-utils:decode-single-float-bits bits)))
  (cl:setf (cl:slot-value msg 'linear_vel) (cl:make-array 2))
  (cl:let ((vals (cl:slot-value msg 'linear_vel)))
    (cl:dotimes (i 2)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angular_vel) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UGVCommand>)))
  "Returns string type for a message object of type '<UGVCommand>"
  "uavcontrol_msgs/UGVCommand")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UGVCommand)))
  "Returns string type for a message object of type 'UGVCommand"
  "uavcontrol_msgs/UGVCommand")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UGVCommand>)))
  "Returns md5sum for a message object of type '<UGVCommand>"
  "b962762976e3397032e3506cd36fbcbc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UGVCommand)))
  "Returns md5sum for a message object of type 'UGVCommand"
  "b962762976e3397032e3506cd36fbcbc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UGVCommand>)))
  "Returns full string definition for message of type '<UGVCommand>"
  (cl:format cl:nil "std_msgs/Header header~%~%## 控制命令的编号 防止接收到错误命令， 编号应该逐次递加~%uint32 Command_ID~%~%## 控制命令的模式 ~%uint8 Mode~%# enum Mode 控制模式枚举~%uint8 Hold=0~%uint8 Direct_Control_BODY=1~%uint8 Direct_Control_ENU=2~%uint8 Point_Control=3~%uint8 Path_Control=4~%uint8 Test=5~%~%float32[2] position_ref     ## [m]~%float32 yaw_ref             ## [rad]~%~%float32[2] linear_vel       ## [m/s]~%float32 angular_vel         ## [rad/s]~%~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UGVCommand)))
  "Returns full string definition for message of type 'UGVCommand"
  (cl:format cl:nil "std_msgs/Header header~%~%## 控制命令的编号 防止接收到错误命令， 编号应该逐次递加~%uint32 Command_ID~%~%## 控制命令的模式 ~%uint8 Mode~%# enum Mode 控制模式枚举~%uint8 Hold=0~%uint8 Direct_Control_BODY=1~%uint8 Direct_Control_ENU=2~%uint8 Point_Control=3~%uint8 Path_Control=4~%uint8 Test=5~%~%float32[2] position_ref     ## [m]~%float32 yaw_ref             ## [rad]~%~%float32[2] linear_vel       ## [m/s]~%float32 angular_vel         ## [rad/s]~%~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UGVCommand>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     1
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'position_ref) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'linear_vel) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UGVCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'UGVCommand
    (cl:cons ':header (header msg))
    (cl:cons ':Command_ID (Command_ID msg))
    (cl:cons ':Mode (Mode msg))
    (cl:cons ':position_ref (position_ref msg))
    (cl:cons ':yaw_ref (yaw_ref msg))
    (cl:cons ':linear_vel (linear_vel msg))
    (cl:cons ':angular_vel (angular_vel msg))
))
