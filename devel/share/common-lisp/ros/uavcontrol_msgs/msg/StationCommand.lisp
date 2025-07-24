; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude StationCommand.msg.html

(cl:defclass <StationCommand> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (goal
    :reader goal
    :initarg :goal
    :type geometry_msgs-msg:PoseStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PoseStamped))
   (Command
    :reader Command
    :initarg :Command
    :type cl:fixnum
    :initform 0))
)

(cl:defclass StationCommand (<StationCommand>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StationCommand>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StationCommand)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<StationCommand> is deprecated: use uavcontrol_msgs-msg:StationCommand instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <StationCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'goal-val :lambda-list '(m))
(cl:defmethod goal-val ((m <StationCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:goal-val is deprecated.  Use uavcontrol_msgs-msg:goal instead.")
  (goal m))

(cl:ensure-generic-function 'Command-val :lambda-list '(m))
(cl:defmethod Command-val ((m <StationCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Command-val is deprecated.  Use uavcontrol_msgs-msg:Command instead.")
  (Command m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<StationCommand>)))
    "Constants for message type '<StationCommand>"
  '((:START . 0)
    (:RETURN . 1)
    (:STOP . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'StationCommand)))
    "Constants for message type 'StationCommand"
  '((:START . 0)
    (:RETURN . 1)
    (:STOP . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StationCommand>) ostream)
  "Serializes a message object of type '<StationCommand>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'goal) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Command)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StationCommand>) istream)
  "Deserializes a message object of type '<StationCommand>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'goal) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Command)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StationCommand>)))
  "Returns string type for a message object of type '<StationCommand>"
  "uavcontrol_msgs/StationCommand")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StationCommand)))
  "Returns string type for a message object of type 'StationCommand"
  "uavcontrol_msgs/StationCommand")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StationCommand>)))
  "Returns md5sum for a message object of type '<StationCommand>"
  "e00e6d6f653e8118b518bbc80def5338")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StationCommand)))
  "Returns md5sum for a message object of type 'StationCommand"
  "e00e6d6f653e8118b518bbc80def5338")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StationCommand>)))
  "Returns full string definition for message of type '<StationCommand>"
  (cl:format cl:nil "std_msgs/Header header~%~%## 中途点~%#geometry_msgs/PoseStamped first_goal~%~%## 目标点~%geometry_msgs/PoseStamped goal~%~%## 控制命令的模式 ~%uint8 Command~%# enum Command 控制模式枚举~%uint8 Start=0~%uint8 Return=1~%uint8 Stop=2~%~%~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StationCommand)))
  "Returns full string definition for message of type 'StationCommand"
  (cl:format cl:nil "std_msgs/Header header~%~%## 中途点~%#geometry_msgs/PoseStamped first_goal~%~%## 目标点~%geometry_msgs/PoseStamped goal~%~%## 控制命令的模式 ~%uint8 Command~%# enum Command 控制模式枚举~%uint8 Start=0~%uint8 Return=1~%uint8 Stop=2~%~%~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StationCommand>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'goal))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StationCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'StationCommand
    (cl:cons ':header (header msg))
    (cl:cons ':goal (goal msg))
    (cl:cons ':Command (Command msg))
))
