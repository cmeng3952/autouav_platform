; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude MultiDetectionInfo.msg.html

(cl:defclass <MultiDetectionInfo> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (num_objs
    :reader num_objs
    :initarg :num_objs
    :type cl:integer
    :initform 0)
   (detect_or_track
    :reader detect_or_track
    :initarg :detect_or_track
    :type cl:integer
    :initform 0)
   (detection_infos
    :reader detection_infos
    :initarg :detection_infos
    :type (cl:vector uavcontrol_msgs-msg:DetectionInfo)
   :initform (cl:make-array 0 :element-type 'uavcontrol_msgs-msg:DetectionInfo :initial-element (cl:make-instance 'uavcontrol_msgs-msg:DetectionInfo))))
)

(cl:defclass MultiDetectionInfo (<MultiDetectionInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MultiDetectionInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MultiDetectionInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<MultiDetectionInfo> is deprecated: use uavcontrol_msgs-msg:MultiDetectionInfo instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MultiDetectionInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'num_objs-val :lambda-list '(m))
(cl:defmethod num_objs-val ((m <MultiDetectionInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:num_objs-val is deprecated.  Use uavcontrol_msgs-msg:num_objs instead.")
  (num_objs m))

(cl:ensure-generic-function 'detect_or_track-val :lambda-list '(m))
(cl:defmethod detect_or_track-val ((m <MultiDetectionInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:detect_or_track-val is deprecated.  Use uavcontrol_msgs-msg:detect_or_track instead.")
  (detect_or_track m))

(cl:ensure-generic-function 'detection_infos-val :lambda-list '(m))
(cl:defmethod detection_infos-val ((m <MultiDetectionInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:detection_infos-val is deprecated.  Use uavcontrol_msgs-msg:detection_infos instead.")
  (detection_infos m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MultiDetectionInfo>) ostream)
  "Serializes a message object of type '<MultiDetectionInfo>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'num_objs)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'detect_or_track)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'detection_infos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'detection_infos))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MultiDetectionInfo>) istream)
  "Deserializes a message object of type '<MultiDetectionInfo>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'num_objs) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'detect_or_track) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'detection_infos) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'detection_infos)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'uavcontrol_msgs-msg:DetectionInfo))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MultiDetectionInfo>)))
  "Returns string type for a message object of type '<MultiDetectionInfo>"
  "uavcontrol_msgs/MultiDetectionInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MultiDetectionInfo)))
  "Returns string type for a message object of type 'MultiDetectionInfo"
  "uavcontrol_msgs/MultiDetectionInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MultiDetectionInfo>)))
  "Returns md5sum for a message object of type '<MultiDetectionInfo>"
  "405c23f2d6cf2075daf7e96c3ccd5179")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MultiDetectionInfo)))
  "Returns md5sum for a message object of type 'MultiDetectionInfo"
  "405c23f2d6cf2075daf7e96c3ccd5179")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MultiDetectionInfo>)))
  "Returns full string definition for message of type '<MultiDetectionInfo>"
  (cl:format cl:nil "Header header~%~%## 检测到的目标数量~%int32 num_objs~%~%## Detecting or Tracking (0:detect, 1:track)~%int32 detect_or_track~%~%## 每个目标的检测结果~%DetectionInfo[] detection_infos~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: uavcontrol_msgs/DetectionInfo~%# 目标信息~%~%std_msgs/Header header~%~%## 目标类别名称~%string object_name~%~%## 是否检测到目标~%bool detected~%~%## 0表示相机坐标系, 1表示机体坐标系, 2表示惯性坐标系~%int32 frame~%~%## 目标位置[相机系下：右方x为正，下方y为正，前方z为正]~%float32[3] position~%~%## 目标姿态-欧拉角-(z,y,x)~%float32[3] attitude~%~%## 目标姿态-四元数-(qx,qy,qz,qw)~%float32[4] attitude_q~%~%## 视线角度[相机系下：右方x角度为正，下方y角度为正]~%float32[2] sight_angle~%~%## 像素位置[相机系下：右方x为正，下方y为正]~%int32[2] pixel_position~%~%## 偏航角误差~%float32 yaw_error~%~%## 类别~%int32 category~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MultiDetectionInfo)))
  "Returns full string definition for message of type 'MultiDetectionInfo"
  (cl:format cl:nil "Header header~%~%## 检测到的目标数量~%int32 num_objs~%~%## Detecting or Tracking (0:detect, 1:track)~%int32 detect_or_track~%~%## 每个目标的检测结果~%DetectionInfo[] detection_infos~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: uavcontrol_msgs/DetectionInfo~%# 目标信息~%~%std_msgs/Header header~%~%## 目标类别名称~%string object_name~%~%## 是否检测到目标~%bool detected~%~%## 0表示相机坐标系, 1表示机体坐标系, 2表示惯性坐标系~%int32 frame~%~%## 目标位置[相机系下：右方x为正，下方y为正，前方z为正]~%float32[3] position~%~%## 目标姿态-欧拉角-(z,y,x)~%float32[3] attitude~%~%## 目标姿态-四元数-(qx,qy,qz,qw)~%float32[4] attitude_q~%~%## 视线角度[相机系下：右方x角度为正，下方y角度为正]~%float32[2] sight_angle~%~%## 像素位置[相机系下：右方x为正，下方y为正]~%int32[2] pixel_position~%~%## 偏航角误差~%float32 yaw_error~%~%## 类别~%int32 category~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MultiDetectionInfo>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'detection_infos) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MultiDetectionInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'MultiDetectionInfo
    (cl:cons ':header (header msg))
    (cl:cons ':num_objs (num_objs msg))
    (cl:cons ':detect_or_track (detect_or_track msg))
    (cl:cons ':detection_infos (detection_infos msg))
))
