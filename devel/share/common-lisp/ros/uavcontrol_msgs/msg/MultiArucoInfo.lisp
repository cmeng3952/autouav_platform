; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude MultiArucoInfo.msg.html

(cl:defclass <MultiArucoInfo> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (num_arucos
    :reader num_arucos
    :initarg :num_arucos
    :type cl:integer
    :initform 0)
   (aruco_infos
    :reader aruco_infos
    :initarg :aruco_infos
    :type (cl:vector uavcontrol_msgs-msg:ArucoInfo)
   :initform (cl:make-array 0 :element-type 'uavcontrol_msgs-msg:ArucoInfo :initial-element (cl:make-instance 'uavcontrol_msgs-msg:ArucoInfo))))
)

(cl:defclass MultiArucoInfo (<MultiArucoInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MultiArucoInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MultiArucoInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<MultiArucoInfo> is deprecated: use uavcontrol_msgs-msg:MultiArucoInfo instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MultiArucoInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'num_arucos-val :lambda-list '(m))
(cl:defmethod num_arucos-val ((m <MultiArucoInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:num_arucos-val is deprecated.  Use uavcontrol_msgs-msg:num_arucos instead.")
  (num_arucos m))

(cl:ensure-generic-function 'aruco_infos-val :lambda-list '(m))
(cl:defmethod aruco_infos-val ((m <MultiArucoInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:aruco_infos-val is deprecated.  Use uavcontrol_msgs-msg:aruco_infos instead.")
  (aruco_infos m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MultiArucoInfo>) ostream)
  "Serializes a message object of type '<MultiArucoInfo>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'num_arucos)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'aruco_infos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'aruco_infos))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MultiArucoInfo>) istream)
  "Deserializes a message object of type '<MultiArucoInfo>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'num_arucos) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'aruco_infos) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'aruco_infos)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'uavcontrol_msgs-msg:ArucoInfo))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MultiArucoInfo>)))
  "Returns string type for a message object of type '<MultiArucoInfo>"
  "uavcontrol_msgs/MultiArucoInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MultiArucoInfo)))
  "Returns string type for a message object of type 'MultiArucoInfo"
  "uavcontrol_msgs/MultiArucoInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MultiArucoInfo>)))
  "Returns md5sum for a message object of type '<MultiArucoInfo>"
  "ed01e66cfe7218a97aff05b031ab2f44")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MultiArucoInfo)))
  "Returns md5sum for a message object of type 'MultiArucoInfo"
  "ed01e66cfe7218a97aff05b031ab2f44")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MultiArucoInfo>)))
  "Returns full string definition for message of type '<MultiArucoInfo>"
  (cl:format cl:nil "std_msgs/Header header~%~%## 检测到的aruco码数量~%int32 num_arucos~%~%## 每个aruco码的检测结果~%ArucoInfo[] aruco_infos~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: uavcontrol_msgs/ArucoInfo~%std_msgs/Header header~%~%## aruco编码~%int32 aruco_num~%~%## 是否检测到目标~%bool detected~%~%## 目标位置-相机坐标系-(x,y,z)~%## 从相机往前看，物体在相机右方x为正，下方y为正，前方z为正~%float32[3] position~%~%## 目标姿态-四元数-(qx,qy,qz,qw)~%float32[4] orientation~%~%## 视线角度-相机系下-(右方x角度为正,下方y角度为正)~%float32[2] sight_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MultiArucoInfo)))
  "Returns full string definition for message of type 'MultiArucoInfo"
  (cl:format cl:nil "std_msgs/Header header~%~%## 检测到的aruco码数量~%int32 num_arucos~%~%## 每个aruco码的检测结果~%ArucoInfo[] aruco_infos~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: uavcontrol_msgs/ArucoInfo~%std_msgs/Header header~%~%## aruco编码~%int32 aruco_num~%~%## 是否检测到目标~%bool detected~%~%## 目标位置-相机坐标系-(x,y,z)~%## 从相机往前看，物体在相机右方x为正，下方y为正，前方z为正~%float32[3] position~%~%## 目标姿态-四元数-(qx,qy,qz,qw)~%float32[4] orientation~%~%## 视线角度-相机系下-(右方x角度为正,下方y角度为正)~%float32[2] sight_angle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MultiArucoInfo>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'aruco_infos) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MultiArucoInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'MultiArucoInfo
    (cl:cons ':header (header msg))
    (cl:cons ':num_arucos (num_arucos msg))
    (cl:cons ':aruco_infos (aruco_infos msg))
))
