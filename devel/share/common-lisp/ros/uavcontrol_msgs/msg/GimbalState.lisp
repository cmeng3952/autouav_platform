; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude GimbalState.msg.html

(cl:defclass <GimbalState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (type
    :reader type
    :initarg :type
    :type cl:fixnum
    :initform 0)
   (moveMode
    :reader moveMode
    :initarg :moveMode
    :type cl:fixnum
    :initform 0)
   (imageMode
    :reader imageMode
    :initarg :imageMode
    :type cl:fixnum
    :initform 0)
   (isZoom
    :reader isZoom
    :initarg :isZoom
    :type cl:boolean
    :initform cl:nil)
   (isRec
    :reader isRec
    :initarg :isRec
    :type cl:fixnum
    :initform 0)
   (fov
    :reader fov
    :initarg :fov
    :type (cl:vector cl:float)
   :initform (cl:make-array 2 :element-type 'cl:float :initial-element 0.0))
   (angleRT
    :reader angleRT
    :initarg :angleRT
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (angleRTRate
    :reader angleRTRate
    :initarg :angleRTRate
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (angleRateSet
    :reader angleRateSet
    :initarg :angleRateSet
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass GimbalState (<GimbalState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GimbalState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GimbalState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<GimbalState> is deprecated: use uavcontrol_msgs-msg:GimbalState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <GimbalState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <GimbalState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:type-val is deprecated.  Use uavcontrol_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'moveMode-val :lambda-list '(m))
(cl:defmethod moveMode-val ((m <GimbalState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:moveMode-val is deprecated.  Use uavcontrol_msgs-msg:moveMode instead.")
  (moveMode m))

(cl:ensure-generic-function 'imageMode-val :lambda-list '(m))
(cl:defmethod imageMode-val ((m <GimbalState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:imageMode-val is deprecated.  Use uavcontrol_msgs-msg:imageMode instead.")
  (imageMode m))

(cl:ensure-generic-function 'isZoom-val :lambda-list '(m))
(cl:defmethod isZoom-val ((m <GimbalState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:isZoom-val is deprecated.  Use uavcontrol_msgs-msg:isZoom instead.")
  (isZoom m))

(cl:ensure-generic-function 'isRec-val :lambda-list '(m))
(cl:defmethod isRec-val ((m <GimbalState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:isRec-val is deprecated.  Use uavcontrol_msgs-msg:isRec instead.")
  (isRec m))

(cl:ensure-generic-function 'fov-val :lambda-list '(m))
(cl:defmethod fov-val ((m <GimbalState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:fov-val is deprecated.  Use uavcontrol_msgs-msg:fov instead.")
  (fov m))

(cl:ensure-generic-function 'angleRT-val :lambda-list '(m))
(cl:defmethod angleRT-val ((m <GimbalState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:angleRT-val is deprecated.  Use uavcontrol_msgs-msg:angleRT instead.")
  (angleRT m))

(cl:ensure-generic-function 'angleRTRate-val :lambda-list '(m))
(cl:defmethod angleRTRate-val ((m <GimbalState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:angleRTRate-val is deprecated.  Use uavcontrol_msgs-msg:angleRTRate instead.")
  (angleRTRate m))

(cl:ensure-generic-function 'angleRateSet-val :lambda-list '(m))
(cl:defmethod angleRateSet-val ((m <GimbalState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:angleRateSet-val is deprecated.  Use uavcontrol_msgs-msg:angleRateSet instead.")
  (angleRateSet m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GimbalState>) ostream)
  "Serializes a message object of type '<GimbalState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'moveMode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'imageMode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isZoom) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'isRec)) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'fov))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'angleRT))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'angleRTRate))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'angleRateSet))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GimbalState>) istream)
  "Deserializes a message object of type '<GimbalState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'moveMode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'imageMode)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'isZoom) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'isRec)) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'fov) (cl:make-array 2))
  (cl:let ((vals (cl:slot-value msg 'fov)))
    (cl:dotimes (i 2)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'angleRT) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'angleRT)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'angleRTRate) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'angleRTRate)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'angleRateSet) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'angleRateSet)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GimbalState>)))
  "Returns string type for a message object of type '<GimbalState>"
  "uavcontrol_msgs/GimbalState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GimbalState)))
  "Returns string type for a message object of type 'GimbalState"
  "uavcontrol_msgs/GimbalState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GimbalState>)))
  "Returns md5sum for a message object of type '<GimbalState>"
  "17d9d9f817a22490d422f0f90e0623a4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GimbalState)))
  "Returns md5sum for a message object of type 'GimbalState"
  "17d9d9f817a22490d422f0f90e0623a4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GimbalState>)))
  "Returns full string definition for message of type '<GimbalState>"
  (cl:format cl:nil "Header header~%~%# gimbal type; value = {SV::GimbalType};0:G1;1:Q10F;2:AT10;3:GX40;4:SU17~%uint8 type~%# gimbal movement mode; 0:None; 1:lock head; 2：unlock head; 3: tracking;~%uint8 moveMode~%# gimbal image type; 0:normal; 1:infrared; 2:merge;~%uint8 imageMode~%# gimbal zoom~%bool isZoom~%# gimbal rec; 0:none; 1:gimbal rec; 2:local rec; 3:gimbal & local rec;~%uint8 isRec~%# gimbal fov, XY~%float32[2] fov~%# gimbal real time angle, RPY <deg>~%float32[3] angleRT~%# gimbal real time angle rate, RPY <deg/s> <if gimbal supported>~%float32[3] angleRTRate~%# gimbal setted max angle rate <deg/s> <if gimbal supported>~%float32[3] angleRateSet~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GimbalState)))
  "Returns full string definition for message of type 'GimbalState"
  (cl:format cl:nil "Header header~%~%# gimbal type; value = {SV::GimbalType};0:G1;1:Q10F;2:AT10;3:GX40;4:SU17~%uint8 type~%# gimbal movement mode; 0:None; 1:lock head; 2：unlock head; 3: tracking;~%uint8 moveMode~%# gimbal image type; 0:normal; 1:infrared; 2:merge;~%uint8 imageMode~%# gimbal zoom~%bool isZoom~%# gimbal rec; 0:none; 1:gimbal rec; 2:local rec; 3:gimbal & local rec;~%uint8 isRec~%# gimbal fov, XY~%float32[2] fov~%# gimbal real time angle, RPY <deg>~%float32[3] angleRT~%# gimbal real time angle rate, RPY <deg/s> <if gimbal supported>~%float32[3] angleRTRate~%# gimbal setted max angle rate <deg/s> <if gimbal supported>~%float32[3] angleRateSet~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GimbalState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     1
     1
     1
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'fov) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'angleRT) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'angleRTRate) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'angleRateSet) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GimbalState>))
  "Converts a ROS message object to a list"
  (cl:list 'GimbalState
    (cl:cons ':header (header msg))
    (cl:cons ':type (type msg))
    (cl:cons ':moveMode (moveMode msg))
    (cl:cons ':imageMode (imageMode msg))
    (cl:cons ':isZoom (isZoom msg))
    (cl:cons ':isRec (isRec msg))
    (cl:cons ':fov (fov msg))
    (cl:cons ':angleRT (angleRT msg))
    (cl:cons ':angleRTRate (angleRTRate msg))
    (cl:cons ':angleRateSet (angleRateSet msg))
))
