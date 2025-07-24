; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude TextInfo.msg.html

(cl:defclass <TextInfo> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (MessageType
    :reader MessageType
    :initarg :MessageType
    :type cl:fixnum
    :initform 0)
   (Message
    :reader Message
    :initarg :Message
    :type cl:string
    :initform ""))
)

(cl:defclass TextInfo (<TextInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TextInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TextInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<TextInfo> is deprecated: use uavcontrol_msgs-msg:TextInfo instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TextInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'MessageType-val :lambda-list '(m))
(cl:defmethod MessageType-val ((m <TextInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:MessageType-val is deprecated.  Use uavcontrol_msgs-msg:MessageType instead.")
  (MessageType m))

(cl:ensure-generic-function 'Message-val :lambda-list '(m))
(cl:defmethod Message-val ((m <TextInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Message-val is deprecated.  Use uavcontrol_msgs-msg:Message instead.")
  (Message m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<TextInfo>)))
    "Constants for message type '<TextInfo>"
  '((:INFO . 0)
    (:WARN . 1)
    (:ERROR . 2)
    (:FATAL . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'TextInfo)))
    "Constants for message type 'TextInfo"
  '((:INFO . 0)
    (:WARN . 1)
    (:ERROR . 2)
    (:FATAL . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TextInfo>) ostream)
  "Serializes a message object of type '<TextInfo>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'MessageType)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'Message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'Message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TextInfo>) istream)
  "Deserializes a message object of type '<TextInfo>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'MessageType)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'Message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'Message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TextInfo>)))
  "Returns string type for a message object of type '<TextInfo>"
  "uavcontrol_msgs/TextInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TextInfo)))
  "Returns string type for a message object of type 'TextInfo"
  "uavcontrol_msgs/TextInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TextInfo>)))
  "Returns md5sum for a message object of type '<TextInfo>"
  "1c060392f27880babe5cdc68bd502409")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TextInfo)))
  "Returns md5sum for a message object of type 'TextInfo"
  "1c060392f27880babe5cdc68bd502409")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TextInfo>)))
  "Returns full string definition for message of type '<TextInfo>"
  (cl:format cl:nil "#INFO:正常运行状况下反馈给地面站的信息,例如程序正常启动,状态切换的提示信息等.~%uint8 INFO=0~%#WARN:无人机或软件程序出现意外情况,依然能正常启动或继续执行任务,小概率会出现危险状况,例如无人机RTK无法维持退出到GPS,视觉跟踪目标突然丢失重新搜寻目标等.~%uint8 WARN=1~%#ERROR:无人机或软件程序出现重大意外情况,无法正常启动或继续执行任务,极有可能会出现危险状况,需要中断任务以及人为接管控制无人机,例如通信中断,无人机定位发散,ROS节点无法正常启动等.~%uint8 ERROR=2~%#FATAL:任务执行过程中,软件崩溃或无人机飞控崩溃导致无人机完全失控,需要迅速人为接管控制无人机降落减少炸机损失.~%uint8 FATAL=3~%~%std_msgs/Header header~%uint8 MessageType~%string Message~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TextInfo)))
  "Returns full string definition for message of type 'TextInfo"
  (cl:format cl:nil "#INFO:正常运行状况下反馈给地面站的信息,例如程序正常启动,状态切换的提示信息等.~%uint8 INFO=0~%#WARN:无人机或软件程序出现意外情况,依然能正常启动或继续执行任务,小概率会出现危险状况,例如无人机RTK无法维持退出到GPS,视觉跟踪目标突然丢失重新搜寻目标等.~%uint8 WARN=1~%#ERROR:无人机或软件程序出现重大意外情况,无法正常启动或继续执行任务,极有可能会出现危险状况,需要中断任务以及人为接管控制无人机,例如通信中断,无人机定位发散,ROS节点无法正常启动等.~%uint8 ERROR=2~%#FATAL:任务执行过程中,软件崩溃或无人机飞控崩溃导致无人机完全失控,需要迅速人为接管控制无人机降落减少炸机损失.~%uint8 FATAL=3~%~%std_msgs/Header header~%uint8 MessageType~%string Message~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TextInfo>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4 (cl:length (cl:slot-value msg 'Message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TextInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'TextInfo
    (cl:cons ':header (header msg))
    (cl:cons ':MessageType (MessageType msg))
    (cl:cons ':Message (Message msg))
))
