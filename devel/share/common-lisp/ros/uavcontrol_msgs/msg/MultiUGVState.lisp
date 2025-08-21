; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude MultiUGVState.msg.html

(cl:defclass <MultiUGVState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (swarm_num_ugv
    :reader swarm_num_ugv
    :initarg :swarm_num_ugv
    :type cl:integer
    :initform 0)
   (ugv_state_all
    :reader ugv_state_all
    :initarg :ugv_state_all
    :type (cl:vector uavcontrol_msgs-msg:UGVState)
   :initform (cl:make-array 0 :element-type 'uavcontrol_msgs-msg:UGVState :initial-element (cl:make-instance 'uavcontrol_msgs-msg:UGVState))))
)

(cl:defclass MultiUGVState (<MultiUGVState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MultiUGVState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MultiUGVState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<MultiUGVState> is deprecated: use uavcontrol_msgs-msg:MultiUGVState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MultiUGVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'swarm_num_ugv-val :lambda-list '(m))
(cl:defmethod swarm_num_ugv-val ((m <MultiUGVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:swarm_num_ugv-val is deprecated.  Use uavcontrol_msgs-msg:swarm_num_ugv instead.")
  (swarm_num_ugv m))

(cl:ensure-generic-function 'ugv_state_all-val :lambda-list '(m))
(cl:defmethod ugv_state_all-val ((m <MultiUGVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:ugv_state_all-val is deprecated.  Use uavcontrol_msgs-msg:ugv_state_all instead.")
  (ugv_state_all m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MultiUGVState>) ostream)
  "Serializes a message object of type '<MultiUGVState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'swarm_num_ugv)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ugv_state_all))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'ugv_state_all))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MultiUGVState>) istream)
  "Deserializes a message object of type '<MultiUGVState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'swarm_num_ugv) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'ugv_state_all) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ugv_state_all)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'uavcontrol_msgs-msg:UGVState))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MultiUGVState>)))
  "Returns string type for a message object of type '<MultiUGVState>"
  "uavcontrol_msgs/MultiUGVState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MultiUGVState)))
  "Returns string type for a message object of type 'MultiUGVState"
  "uavcontrol_msgs/MultiUGVState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MultiUGVState>)))
  "Returns md5sum for a message object of type '<MultiUGVState>"
  "a186972accb0af8d487fa5c5c2db7013")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MultiUGVState)))
  "Returns md5sum for a message object of type 'MultiUGVState"
  "a186972accb0af8d487fa5c5c2db7013")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MultiUGVState>)))
  "Returns full string definition for message of type '<MultiUGVState>"
  (cl:format cl:nil "std_msgs/Header header~%~%## ~%int32 swarm_num_ugv~%~%## 从1开始~%UGVState[] ugv_state_all~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: uavcontrol_msgs/UGVState~%std_msgs/Header header~%~%## 无人机编号~%uint8 ugv_id~%~%## 电池电量~%float32 battery~%~%## 无人机状态量：位置、速度、姿态~%float32[3] position                 ## [m]~%float32[3] velocity                 ## [m/s]~%float32[3] attitude                 ## [rad]~%~%geometry_msgs/Quaternion attitude_q ## 四元数~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MultiUGVState)))
  "Returns full string definition for message of type 'MultiUGVState"
  (cl:format cl:nil "std_msgs/Header header~%~%## ~%int32 swarm_num_ugv~%~%## 从1开始~%UGVState[] ugv_state_all~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: uavcontrol_msgs/UGVState~%std_msgs/Header header~%~%## 无人机编号~%uint8 ugv_id~%~%## 电池电量~%float32 battery~%~%## 无人机状态量：位置、速度、姿态~%float32[3] position                 ## [m]~%float32[3] velocity                 ## [m/s]~%float32[3] attitude                 ## [rad]~%~%geometry_msgs/Quaternion attitude_q ## 四元数~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MultiUGVState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ugv_state_all) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MultiUGVState>))
  "Converts a ROS message object to a list"
  (cl:list 'MultiUGVState
    (cl:cons ':header (header msg))
    (cl:cons ':swarm_num_ugv (swarm_num_ugv msg))
    (cl:cons ':ugv_state_all (ugv_state_all msg))
))
