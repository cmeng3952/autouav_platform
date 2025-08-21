; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude UAVSetup.msg.html

(cl:defclass <UAVSetup> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (cmd
    :reader cmd
    :initarg :cmd
    :type cl:fixnum
    :initform 0)
   (arming
    :reader arming
    :initarg :arming
    :type cl:boolean
    :initform cl:nil)
   (px4_mode
    :reader px4_mode
    :initarg :px4_mode
    :type cl:string
    :initform "")
   (control_state
    :reader control_state
    :initarg :control_state
    :type cl:string
    :initform ""))
)

(cl:defclass UAVSetup (<UAVSetup>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UAVSetup>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UAVSetup)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<UAVSetup> is deprecated: use uavcontrol_msgs-msg:UAVSetup instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <UAVSetup>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'cmd-val :lambda-list '(m))
(cl:defmethod cmd-val ((m <UAVSetup>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:cmd-val is deprecated.  Use uavcontrol_msgs-msg:cmd instead.")
  (cmd m))

(cl:ensure-generic-function 'arming-val :lambda-list '(m))
(cl:defmethod arming-val ((m <UAVSetup>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:arming-val is deprecated.  Use uavcontrol_msgs-msg:arming instead.")
  (arming m))

(cl:ensure-generic-function 'px4_mode-val :lambda-list '(m))
(cl:defmethod px4_mode-val ((m <UAVSetup>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:px4_mode-val is deprecated.  Use uavcontrol_msgs-msg:px4_mode instead.")
  (px4_mode m))

(cl:ensure-generic-function 'control_state-val :lambda-list '(m))
(cl:defmethod control_state-val ((m <UAVSetup>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:control_state-val is deprecated.  Use uavcontrol_msgs-msg:control_state instead.")
  (control_state m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<UAVSetup>)))
    "Constants for message type '<UAVSetup>"
  '((:ARMING . 0)
    (:SET_PX4_MODE . 1)
    (:REBOOT_PX4 . 2)
    (:SET_CONTROL_MODE . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'UAVSetup)))
    "Constants for message type 'UAVSetup"
  '((:ARMING . 0)
    (:SET_PX4_MODE . 1)
    (:REBOOT_PX4 . 2)
    (:SET_CONTROL_MODE . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UAVSetup>) ostream)
  "Serializes a message object of type '<UAVSetup>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'cmd)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'arming) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'px4_mode))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'px4_mode))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'control_state))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'control_state))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UAVSetup>) istream)
  "Deserializes a message object of type '<UAVSetup>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'cmd)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'arming) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'px4_mode) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'px4_mode) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'control_state) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'control_state) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UAVSetup>)))
  "Returns string type for a message object of type '<UAVSetup>"
  "uavcontrol_msgs/UAVSetup")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UAVSetup)))
  "Returns string type for a message object of type 'UAVSetup"
  "uavcontrol_msgs/UAVSetup")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UAVSetup>)))
  "Returns md5sum for a message object of type '<UAVSetup>"
  "393031ce25ae40233f2be809a2db33df")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UAVSetup)))
  "Returns md5sum for a message object of type 'UAVSetup"
  "393031ce25ae40233f2be809a2db33df")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UAVSetup>)))
  "Returns full string definition for message of type '<UAVSetup>"
  (cl:format cl:nil "std_msgs/Header header~%~%## 无人机Setup类型（可用于模拟遥控器）~%uint8 cmd~%uint8 ARMING = 0~%uint8 SET_PX4_MODE = 1~%uint8 REBOOT_PX4 = 2~%uint8 SET_CONTROL_MODE = 3~%~%bool arming~%~%## PX4模式名查询:http://wiki.ros.org/mavros/CustomModes~%## 常用模式名:OFFBOARD,AUTO.LAND,AUTO.RTL,POSCTL~%string px4_mode~%~%## INIT,MANUAL_CONTROL,HOVER_CONTROL,COMMAND_CONTROL,LAND_CONTROL~%string control_state~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UAVSetup)))
  "Returns full string definition for message of type 'UAVSetup"
  (cl:format cl:nil "std_msgs/Header header~%~%## 无人机Setup类型（可用于模拟遥控器）~%uint8 cmd~%uint8 ARMING = 0~%uint8 SET_PX4_MODE = 1~%uint8 REBOOT_PX4 = 2~%uint8 SET_CONTROL_MODE = 3~%~%bool arming~%~%## PX4模式名查询:http://wiki.ros.org/mavros/CustomModes~%## 常用模式名:OFFBOARD,AUTO.LAND,AUTO.RTL,POSCTL~%string px4_mode~%~%## INIT,MANUAL_CONTROL,HOVER_CONTROL,COMMAND_CONTROL,LAND_CONTROL~%string control_state~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UAVSetup>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     4 (cl:length (cl:slot-value msg 'px4_mode))
     4 (cl:length (cl:slot-value msg 'control_state))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UAVSetup>))
  "Converts a ROS message object to a list"
  (cl:list 'UAVSetup
    (cl:cons ':header (header msg))
    (cl:cons ':cmd (cmd msg))
    (cl:cons ':arming (arming msg))
    (cl:cons ':px4_mode (px4_mode msg))
    (cl:cons ':control_state (control_state msg))
))
