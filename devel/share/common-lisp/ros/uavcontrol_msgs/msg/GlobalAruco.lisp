; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude GlobalAruco.msg.html

(cl:defclass <GlobalAruco> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (Aruco1
    :reader Aruco1
    :initarg :Aruco1
    :type uavcontrol_msgs-msg:ArucoInfo
    :initform (cl:make-instance 'uavcontrol_msgs-msg:ArucoInfo))
   (Aruco2
    :reader Aruco2
    :initarg :Aruco2
    :type uavcontrol_msgs-msg:ArucoInfo
    :initform (cl:make-instance 'uavcontrol_msgs-msg:ArucoInfo))
   (Aruco3
    :reader Aruco3
    :initarg :Aruco3
    :type uavcontrol_msgs-msg:ArucoInfo
    :initform (cl:make-instance 'uavcontrol_msgs-msg:ArucoInfo))
   (Aruco4
    :reader Aruco4
    :initarg :Aruco4
    :type uavcontrol_msgs-msg:ArucoInfo
    :initform (cl:make-instance 'uavcontrol_msgs-msg:ArucoInfo))
   (Aruco5
    :reader Aruco5
    :initarg :Aruco5
    :type uavcontrol_msgs-msg:ArucoInfo
    :initform (cl:make-instance 'uavcontrol_msgs-msg:ArucoInfo))
   (Aruco6
    :reader Aruco6
    :initarg :Aruco6
    :type uavcontrol_msgs-msg:ArucoInfo
    :initform (cl:make-instance 'uavcontrol_msgs-msg:ArucoInfo))
   (Aruco7
    :reader Aruco7
    :initarg :Aruco7
    :type uavcontrol_msgs-msg:ArucoInfo
    :initform (cl:make-instance 'uavcontrol_msgs-msg:ArucoInfo))
   (Aruco8
    :reader Aruco8
    :initarg :Aruco8
    :type uavcontrol_msgs-msg:ArucoInfo
    :initform (cl:make-instance 'uavcontrol_msgs-msg:ArucoInfo))
   (Aruco9
    :reader Aruco9
    :initarg :Aruco9
    :type uavcontrol_msgs-msg:ArucoInfo
    :initform (cl:make-instance 'uavcontrol_msgs-msg:ArucoInfo)))
)

(cl:defclass GlobalAruco (<GlobalAruco>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GlobalAruco>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GlobalAruco)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<GlobalAruco> is deprecated: use uavcontrol_msgs-msg:GlobalAruco instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <GlobalAruco>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'Aruco1-val :lambda-list '(m))
(cl:defmethod Aruco1-val ((m <GlobalAruco>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Aruco1-val is deprecated.  Use uavcontrol_msgs-msg:Aruco1 instead.")
  (Aruco1 m))

(cl:ensure-generic-function 'Aruco2-val :lambda-list '(m))
(cl:defmethod Aruco2-val ((m <GlobalAruco>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Aruco2-val is deprecated.  Use uavcontrol_msgs-msg:Aruco2 instead.")
  (Aruco2 m))

(cl:ensure-generic-function 'Aruco3-val :lambda-list '(m))
(cl:defmethod Aruco3-val ((m <GlobalAruco>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Aruco3-val is deprecated.  Use uavcontrol_msgs-msg:Aruco3 instead.")
  (Aruco3 m))

(cl:ensure-generic-function 'Aruco4-val :lambda-list '(m))
(cl:defmethod Aruco4-val ((m <GlobalAruco>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Aruco4-val is deprecated.  Use uavcontrol_msgs-msg:Aruco4 instead.")
  (Aruco4 m))

(cl:ensure-generic-function 'Aruco5-val :lambda-list '(m))
(cl:defmethod Aruco5-val ((m <GlobalAruco>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Aruco5-val is deprecated.  Use uavcontrol_msgs-msg:Aruco5 instead.")
  (Aruco5 m))

(cl:ensure-generic-function 'Aruco6-val :lambda-list '(m))
(cl:defmethod Aruco6-val ((m <GlobalAruco>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Aruco6-val is deprecated.  Use uavcontrol_msgs-msg:Aruco6 instead.")
  (Aruco6 m))

(cl:ensure-generic-function 'Aruco7-val :lambda-list '(m))
(cl:defmethod Aruco7-val ((m <GlobalAruco>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Aruco7-val is deprecated.  Use uavcontrol_msgs-msg:Aruco7 instead.")
  (Aruco7 m))

(cl:ensure-generic-function 'Aruco8-val :lambda-list '(m))
(cl:defmethod Aruco8-val ((m <GlobalAruco>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Aruco8-val is deprecated.  Use uavcontrol_msgs-msg:Aruco8 instead.")
  (Aruco8 m))

(cl:ensure-generic-function 'Aruco9-val :lambda-list '(m))
(cl:defmethod Aruco9-val ((m <GlobalAruco>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Aruco9-val is deprecated.  Use uavcontrol_msgs-msg:Aruco9 instead.")
  (Aruco9 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GlobalAruco>) ostream)
  "Serializes a message object of type '<GlobalAruco>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Aruco1) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Aruco2) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Aruco3) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Aruco4) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Aruco5) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Aruco6) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Aruco7) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Aruco8) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Aruco9) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GlobalAruco>) istream)
  "Deserializes a message object of type '<GlobalAruco>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Aruco1) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Aruco2) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Aruco3) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Aruco4) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Aruco5) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Aruco6) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Aruco7) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Aruco8) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Aruco9) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GlobalAruco>)))
  "Returns string type for a message object of type '<GlobalAruco>"
  "uavcontrol_msgs/GlobalAruco")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GlobalAruco)))
  "Returns string type for a message object of type 'GlobalAruco"
  "uavcontrol_msgs/GlobalAruco")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GlobalAruco>)))
  "Returns md5sum for a message object of type '<GlobalAruco>"
  "1ac5e7f2e18092c8685802c04fdbf69a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GlobalAruco)))
  "Returns md5sum for a message object of type 'GlobalAruco"
  "1ac5e7f2e18092c8685802c04fdbf69a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GlobalAruco>)))
  "Returns full string definition for message of type '<GlobalAruco>"
  (cl:format cl:nil "~%std_msgs/Header header~%~%ArucoInfo Aruco1~%ArucoInfo Aruco2~%ArucoInfo Aruco3~%ArucoInfo Aruco4~%ArucoInfo Aruco5~%ArucoInfo Aruco6~%ArucoInfo Aruco7~%ArucoInfo Aruco8~%ArucoInfo Aruco9~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: uavcontrol_msgs/ArucoInfo~%std_msgs/Header header~%~%## aruco编码~%int32 aruco_num~%~%## 是否检测到目标~%bool detected~%~%## 目标位置-相机坐标系-(x,y,z)~%## 从相机往前看，物体在相机右方x为正，下方y为正，前方z为正~%float32[3] position~%~%## 目标姿态-四元数-(qx,qy,qz,qw)~%float32[4] orientation~%~%## 视线角度-相机系下-(右方x角度为正,下方y角度为正)~%float32[2] sight_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GlobalAruco)))
  "Returns full string definition for message of type 'GlobalAruco"
  (cl:format cl:nil "~%std_msgs/Header header~%~%ArucoInfo Aruco1~%ArucoInfo Aruco2~%ArucoInfo Aruco3~%ArucoInfo Aruco4~%ArucoInfo Aruco5~%ArucoInfo Aruco6~%ArucoInfo Aruco7~%ArucoInfo Aruco8~%ArucoInfo Aruco9~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: uavcontrol_msgs/ArucoInfo~%std_msgs/Header header~%~%## aruco编码~%int32 aruco_num~%~%## 是否检测到目标~%bool detected~%~%## 目标位置-相机坐标系-(x,y,z)~%## 从相机往前看，物体在相机右方x为正，下方y为正，前方z为正~%float32[3] position~%~%## 目标姿态-四元数-(qx,qy,qz,qw)~%float32[4] orientation~%~%## 视线角度-相机系下-(右方x角度为正,下方y角度为正)~%float32[2] sight_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GlobalAruco>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Aruco1))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Aruco2))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Aruco3))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Aruco4))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Aruco5))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Aruco6))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Aruco7))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Aruco8))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Aruco9))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GlobalAruco>))
  "Converts a ROS message object to a list"
  (cl:list 'GlobalAruco
    (cl:cons ':header (header msg))
    (cl:cons ':Aruco1 (Aruco1 msg))
    (cl:cons ':Aruco2 (Aruco2 msg))
    (cl:cons ':Aruco3 (Aruco3 msg))
    (cl:cons ':Aruco4 (Aruco4 msg))
    (cl:cons ':Aruco5 (Aruco5 msg))
    (cl:cons ':Aruco6 (Aruco6 msg))
    (cl:cons ':Aruco7 (Aruco7 msg))
    (cl:cons ':Aruco8 (Aruco8 msg))
    (cl:cons ':Aruco9 (Aruco9 msg))
))
