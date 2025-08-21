; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude MultiDetectionInfoSub.msg.html

(cl:defclass <MultiDetectionInfoSub> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (mode
    :reader mode
    :initarg :mode
    :type cl:fixnum
    :initform 0)
   (num_objs
    :reader num_objs
    :initarg :num_objs
    :type cl:integer
    :initform 0)
   (detection_infos
    :reader detection_infos
    :initarg :detection_infos
    :type (cl:vector uavcontrol_msgs-msg:DetectionInfoSub)
   :initform (cl:make-array 0 :element-type 'uavcontrol_msgs-msg:DetectionInfoSub :initial-element (cl:make-instance 'uavcontrol_msgs-msg:DetectionInfoSub))))
)

(cl:defclass MultiDetectionInfoSub (<MultiDetectionInfoSub>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MultiDetectionInfoSub>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MultiDetectionInfoSub)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<MultiDetectionInfoSub> is deprecated: use uavcontrol_msgs-msg:MultiDetectionInfoSub instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MultiDetectionInfoSub>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <MultiDetectionInfoSub>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:mode-val is deprecated.  Use uavcontrol_msgs-msg:mode instead.")
  (mode m))

(cl:ensure-generic-function 'num_objs-val :lambda-list '(m))
(cl:defmethod num_objs-val ((m <MultiDetectionInfoSub>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:num_objs-val is deprecated.  Use uavcontrol_msgs-msg:num_objs instead.")
  (num_objs m))

(cl:ensure-generic-function 'detection_infos-val :lambda-list '(m))
(cl:defmethod detection_infos-val ((m <MultiDetectionInfoSub>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:detection_infos-val is deprecated.  Use uavcontrol_msgs-msg:detection_infos instead.")
  (detection_infos m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MultiDetectionInfoSub>) ostream)
  "Serializes a message object of type '<MultiDetectionInfoSub>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'mode)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'num_objs)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MultiDetectionInfoSub>) istream)
  "Deserializes a message object of type '<MultiDetectionInfoSub>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'mode)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'num_objs) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'detection_infos) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'detection_infos)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'uavcontrol_msgs-msg:DetectionInfoSub))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MultiDetectionInfoSub>)))
  "Returns string type for a message object of type '<MultiDetectionInfoSub>"
  "uavcontrol_msgs/MultiDetectionInfoSub")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MultiDetectionInfoSub)))
  "Returns string type for a message object of type 'MultiDetectionInfoSub"
  "uavcontrol_msgs/MultiDetectionInfoSub")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MultiDetectionInfoSub>)))
  "Returns md5sum for a message object of type '<MultiDetectionInfoSub>"
  "1b99fe4725befe6b93176dfa0544a074")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MultiDetectionInfoSub)))
  "Returns md5sum for a message object of type 'MultiDetectionInfoSub"
  "1b99fe4725befe6b93176dfa0544a074")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MultiDetectionInfoSub>)))
  "Returns full string definition for message of type '<MultiDetectionInfoSub>"
  (cl:format cl:nil "std_msgs/Header header~%~%#模式：0：空闲  2.simaRPN  3.deepsort/sort~%uint8 mode~%~%## 检测到的目标数量~%int32 num_objs~%~%## 每个目标的检测结果~%DetectionInfoSub[] detection_infos~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: uavcontrol_msgs/DetectionInfoSub~%#目标框的位置（主要斜对角两个点）~%float32 left~%float32 top~%float32 bot~%float32 right~%~%~%## TRACK TARGET(目标框ID)~%int32 trackIds~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MultiDetectionInfoSub)))
  "Returns full string definition for message of type 'MultiDetectionInfoSub"
  (cl:format cl:nil "std_msgs/Header header~%~%#模式：0：空闲  2.simaRPN  3.deepsort/sort~%uint8 mode~%~%## 检测到的目标数量~%int32 num_objs~%~%## 每个目标的检测结果~%DetectionInfoSub[] detection_infos~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: uavcontrol_msgs/DetectionInfoSub~%#目标框的位置（主要斜对角两个点）~%float32 left~%float32 top~%float32 bot~%float32 right~%~%~%## TRACK TARGET(目标框ID)~%int32 trackIds~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MultiDetectionInfoSub>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'detection_infos) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MultiDetectionInfoSub>))
  "Converts a ROS message object to a list"
  (cl:list 'MultiDetectionInfoSub
    (cl:cons ':header (header msg))
    (cl:cons ':mode (mode msg))
    (cl:cons ':num_objs (num_objs msg))
    (cl:cons ':detection_infos (detection_infos msg))
))
