; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude UAVControlState.msg.html

(cl:defclass <UAVControlState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (uav_id
    :reader uav_id
    :initarg :uav_id
    :type cl:fixnum
    :initform 0)
   (control_state
    :reader control_state
    :initarg :control_state
    :type cl:fixnum
    :initform 0)
   (pos_controller
    :reader pos_controller
    :initarg :pos_controller
    :type cl:fixnum
    :initform 0)
   (failsafe
    :reader failsafe
    :initarg :failsafe
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass UAVControlState (<UAVControlState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UAVControlState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UAVControlState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<UAVControlState> is deprecated: use uavcontrol_msgs-msg:UAVControlState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'uav_id-val :lambda-list '(m))
(cl:defmethod uav_id-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:uav_id-val is deprecated.  Use uavcontrol_msgs-msg:uav_id instead.")
  (uav_id m))

(cl:ensure-generic-function 'control_state-val :lambda-list '(m))
(cl:defmethod control_state-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:control_state-val is deprecated.  Use uavcontrol_msgs-msg:control_state instead.")
  (control_state m))

(cl:ensure-generic-function 'pos_controller-val :lambda-list '(m))
(cl:defmethod pos_controller-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:pos_controller-val is deprecated.  Use uavcontrol_msgs-msg:pos_controller instead.")
  (pos_controller m))

(cl:ensure-generic-function 'failsafe-val :lambda-list '(m))
(cl:defmethod failsafe-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:failsafe-val is deprecated.  Use uavcontrol_msgs-msg:failsafe instead.")
  (failsafe m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<UAVControlState>)))
    "Constants for message type '<UAVControlState>"
  '((:INIT . 0)
    (:RC_POS_CONTROL . 1)
    (:COMMAND_CONTROL . 2)
    (:LAND_CONTROL . 3)
    (:PX4_ORIGIN . 0)
    (:PID . 1)
    (:UDE . 2)
    (:NE . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'UAVControlState)))
    "Constants for message type 'UAVControlState"
  '((:INIT . 0)
    (:RC_POS_CONTROL . 1)
    (:COMMAND_CONTROL . 2)
    (:LAND_CONTROL . 3)
    (:PX4_ORIGIN . 0)
    (:PID . 1)
    (:UDE . 2)
    (:NE . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UAVControlState>) ostream)
  "Serializes a message object of type '<UAVControlState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'uav_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'control_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'pos_controller)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'failsafe) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UAVControlState>) istream)
  "Deserializes a message object of type '<UAVControlState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'uav_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'control_state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'pos_controller)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'failsafe) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UAVControlState>)))
  "Returns string type for a message object of type '<UAVControlState>"
  "uavcontrol_msgs/UAVControlState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UAVControlState)))
  "Returns string type for a message object of type 'UAVControlState"
  "uavcontrol_msgs/UAVControlState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UAVControlState>)))
  "Returns md5sum for a message object of type '<UAVControlState>"
  "2f696ea290ca1c1f46b8e82d115caeea")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UAVControlState)))
  "Returns md5sum for a message object of type 'UAVControlState"
  "2f696ea290ca1c1f46b8e82d115caeea")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UAVControlState>)))
  "Returns full string definition for message of type '<UAVControlState>"
  (cl:format cl:nil "std_msgs/Header header~%~%## 无人机编号 ~%uint8 uav_id~%~%## 无人机控制状态~%uint8 control_state~%## 状态枚举~%uint8 INIT=0~%uint8 RC_POS_CONTROL=1~%uint8 COMMAND_CONTROL=2~%uint8 LAND_CONTROL=3~%~%## 无人机控制器标志量~%uint8 pos_controller~%## 状态枚举~%uint8 PX4_ORIGIN=0~%uint8 PID=1~%uint8 UDE=2~%uint8 NE=3~%~%# 无人机安全保护触发标志量~%bool failsafe~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UAVControlState)))
  "Returns full string definition for message of type 'UAVControlState"
  (cl:format cl:nil "std_msgs/Header header~%~%## 无人机编号 ~%uint8 uav_id~%~%## 无人机控制状态~%uint8 control_state~%## 状态枚举~%uint8 INIT=0~%uint8 RC_POS_CONTROL=1~%uint8 COMMAND_CONTROL=2~%uint8 LAND_CONTROL=3~%~%## 无人机控制器标志量~%uint8 pos_controller~%## 状态枚举~%uint8 PX4_ORIGIN=0~%uint8 PID=1~%uint8 UDE=2~%uint8 NE=3~%~%# 无人机安全保护触发标志量~%bool failsafe~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UAVControlState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UAVControlState>))
  "Converts a ROS message object to a list"
  (cl:list 'UAVControlState
    (cl:cons ':header (header msg))
    (cl:cons ':uav_id (uav_id msg))
    (cl:cons ':control_state (control_state msg))
    (cl:cons ':pos_controller (pos_controller msg))
    (cl:cons ':failsafe (failsafe msg))
))
