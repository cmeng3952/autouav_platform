; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude ArucoInfo.msg.html

(cl:defclass <ArucoInfo> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (aruco_num
    :reader aruco_num
    :initarg :aruco_num
    :type cl:integer
    :initform 0)
   (detected
    :reader detected
    :initarg :detected
    :type cl:boolean
    :initform cl:nil)
   (position
    :reader position
    :initarg :position
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (orientation
    :reader orientation
    :initarg :orientation
    :type (cl:vector cl:float)
   :initform (cl:make-array 4 :element-type 'cl:float :initial-element 0.0))
   (sight_angle
    :reader sight_angle
    :initarg :sight_angle
    :type (cl:vector cl:float)
   :initform (cl:make-array 2 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass ArucoInfo (<ArucoInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ArucoInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ArucoInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<ArucoInfo> is deprecated: use uavcontrol_msgs-msg:ArucoInfo instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ArucoInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'aruco_num-val :lambda-list '(m))
(cl:defmethod aruco_num-val ((m <ArucoInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:aruco_num-val is deprecated.  Use uavcontrol_msgs-msg:aruco_num instead.")
  (aruco_num m))

(cl:ensure-generic-function 'detected-val :lambda-list '(m))
(cl:defmethod detected-val ((m <ArucoInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:detected-val is deprecated.  Use uavcontrol_msgs-msg:detected instead.")
  (detected m))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <ArucoInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:position-val is deprecated.  Use uavcontrol_msgs-msg:position instead.")
  (position m))

(cl:ensure-generic-function 'orientation-val :lambda-list '(m))
(cl:defmethod orientation-val ((m <ArucoInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:orientation-val is deprecated.  Use uavcontrol_msgs-msg:orientation instead.")
  (orientation m))

(cl:ensure-generic-function 'sight_angle-val :lambda-list '(m))
(cl:defmethod sight_angle-val ((m <ArucoInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:sight_angle-val is deprecated.  Use uavcontrol_msgs-msg:sight_angle instead.")
  (sight_angle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ArucoInfo>) ostream)
  "Serializes a message object of type '<ArucoInfo>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'aruco_num)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'detected) 1 0)) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'position))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'orientation))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'sight_angle))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ArucoInfo>) istream)
  "Deserializes a message object of type '<ArucoInfo>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'aruco_num) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'detected) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:setf (cl:slot-value msg 'position) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'position)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'orientation) (cl:make-array 4))
  (cl:let ((vals (cl:slot-value msg 'orientation)))
    (cl:dotimes (i 4)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'sight_angle) (cl:make-array 2))
  (cl:let ((vals (cl:slot-value msg 'sight_angle)))
    (cl:dotimes (i 2)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ArucoInfo>)))
  "Returns string type for a message object of type '<ArucoInfo>"
  "uavcontrol_msgs/ArucoInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ArucoInfo)))
  "Returns string type for a message object of type 'ArucoInfo"
  "uavcontrol_msgs/ArucoInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ArucoInfo>)))
  "Returns md5sum for a message object of type '<ArucoInfo>"
  "4317d8c5571fc3b7219e3fa681ec1bab")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ArucoInfo)))
  "Returns md5sum for a message object of type 'ArucoInfo"
  "4317d8c5571fc3b7219e3fa681ec1bab")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ArucoInfo>)))
  "Returns full string definition for message of type '<ArucoInfo>"
  (cl:format cl:nil "std_msgs/Header header~%~%## aruco编码~%int32 aruco_num~%~%## 是否检测到目标~%bool detected~%~%## 目标位置-相机坐标系-(x,y,z)~%## 从相机往前看，物体在相机右方x为正，下方y为正，前方z为正~%float32[3] position~%~%## 目标姿态-四元数-(qx,qy,qz,qw)~%float32[4] orientation~%~%## 视线角度-相机系下-(右方x角度为正,下方y角度为正)~%float32[2] sight_angle~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ArucoInfo)))
  "Returns full string definition for message of type 'ArucoInfo"
  (cl:format cl:nil "std_msgs/Header header~%~%## aruco编码~%int32 aruco_num~%~%## 是否检测到目标~%bool detected~%~%## 目标位置-相机坐标系-(x,y,z)~%## 从相机往前看，物体在相机右方x为正，下方y为正，前方z为正~%float32[3] position~%~%## 目标姿态-四元数-(qx,qy,qz,qw)~%float32[4] orientation~%~%## 视线角度-相机系下-(右方x角度为正,下方y角度为正)~%float32[2] sight_angle~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ArucoInfo>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     1
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'position) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'orientation) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'sight_angle) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ArucoInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'ArucoInfo
    (cl:cons ':header (header msg))
    (cl:cons ':aruco_num (aruco_num msg))
    (cl:cons ':detected (detected msg))
    (cl:cons ':position (position msg))
    (cl:cons ':orientation (orientation msg))
    (cl:cons ':sight_angle (sight_angle msg))
))
