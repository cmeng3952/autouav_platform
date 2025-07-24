; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude WindowPosition.msg.html

(cl:defclass <WindowPosition> (roslisp-msg-protocol:ros-message)
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
   (origin_x
    :reader origin_x
    :initarg :origin_x
    :type cl:fixnum
    :initform 0)
   (origin_y
    :reader origin_y
    :initarg :origin_y
    :type cl:fixnum
    :initform 0)
   (width
    :reader width
    :initarg :width
    :type cl:fixnum
    :initform 0)
   (height
    :reader height
    :initarg :height
    :type cl:fixnum
    :initform 0)
   (window_position_x
    :reader window_position_x
    :initarg :window_position_x
    :type cl:fixnum
    :initform 0)
   (window_position_y
    :reader window_position_y
    :initarg :window_position_y
    :type cl:fixnum
    :initform 0)
   (track_id
    :reader track_id
    :initarg :track_id
    :type cl:integer
    :initform 0))
)

(cl:defclass WindowPosition (<WindowPosition>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WindowPosition>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WindowPosition)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<WindowPosition> is deprecated: use uavcontrol_msgs-msg:WindowPosition instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <WindowPosition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <WindowPosition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:mode-val is deprecated.  Use uavcontrol_msgs-msg:mode instead.")
  (mode m))

(cl:ensure-generic-function 'origin_x-val :lambda-list '(m))
(cl:defmethod origin_x-val ((m <WindowPosition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:origin_x-val is deprecated.  Use uavcontrol_msgs-msg:origin_x instead.")
  (origin_x m))

(cl:ensure-generic-function 'origin_y-val :lambda-list '(m))
(cl:defmethod origin_y-val ((m <WindowPosition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:origin_y-val is deprecated.  Use uavcontrol_msgs-msg:origin_y instead.")
  (origin_y m))

(cl:ensure-generic-function 'width-val :lambda-list '(m))
(cl:defmethod width-val ((m <WindowPosition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:width-val is deprecated.  Use uavcontrol_msgs-msg:width instead.")
  (width m))

(cl:ensure-generic-function 'height-val :lambda-list '(m))
(cl:defmethod height-val ((m <WindowPosition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:height-val is deprecated.  Use uavcontrol_msgs-msg:height instead.")
  (height m))

(cl:ensure-generic-function 'window_position_x-val :lambda-list '(m))
(cl:defmethod window_position_x-val ((m <WindowPosition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:window_position_x-val is deprecated.  Use uavcontrol_msgs-msg:window_position_x instead.")
  (window_position_x m))

(cl:ensure-generic-function 'window_position_y-val :lambda-list '(m))
(cl:defmethod window_position_y-val ((m <WindowPosition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:window_position_y-val is deprecated.  Use uavcontrol_msgs-msg:window_position_y instead.")
  (window_position_y m))

(cl:ensure-generic-function 'track_id-val :lambda-list '(m))
(cl:defmethod track_id-val ((m <WindowPosition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:track_id-val is deprecated.  Use uavcontrol_msgs-msg:track_id instead.")
  (track_id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WindowPosition>) ostream)
  "Serializes a message object of type '<WindowPosition>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'mode)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'origin_x)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'origin_y)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'width)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'height)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'window_position_x)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'window_position_y)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'track_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WindowPosition>) istream)
  "Deserializes a message object of type '<WindowPosition>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'mode)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'origin_x) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'origin_y) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'width) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'height) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'window_position_x) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'window_position_y) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'track_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WindowPosition>)))
  "Returns string type for a message object of type '<WindowPosition>"
  "uavcontrol_msgs/WindowPosition")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WindowPosition)))
  "Returns string type for a message object of type 'WindowPosition"
  "uavcontrol_msgs/WindowPosition")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WindowPosition>)))
  "Returns md5sum for a message object of type '<WindowPosition>"
  "89d76cf2a4942da77237e3ebfe45c4de")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WindowPosition)))
  "Returns md5sum for a message object of type 'WindowPosition"
  "89d76cf2a4942da77237e3ebfe45c4de")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WindowPosition>)))
  "Returns full string definition for message of type '<WindowPosition>"
  (cl:format cl:nil "std_msgs/Header header~%~%#模式：0：空闲  1.kcf   3.deepsort/sort(点击的id) ~%uint8 mode~%~%~%#波门位置X,#波门位置Y(kcf,点击画面的功能的时候使用),左上角为（0,0）~%int16 origin_x~%int16 origin_y~%int16 width~%int16 height ~%~%#波门位置X,#波门位置Y~%#int16 window_position_x = origin_x + width/2~%#int16 window_position_y = origin_y + height/2~%int16 window_position_x~%int16 window_position_y~%~%#算法检测结果的ID~%int32 track_id~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WindowPosition)))
  "Returns full string definition for message of type 'WindowPosition"
  (cl:format cl:nil "std_msgs/Header header~%~%#模式：0：空闲  1.kcf   3.deepsort/sort(点击的id) ~%uint8 mode~%~%~%#波门位置X,#波门位置Y(kcf,点击画面的功能的时候使用),左上角为（0,0）~%int16 origin_x~%int16 origin_y~%int16 width~%int16 height ~%~%#波门位置X,#波门位置Y~%#int16 window_position_x = origin_x + width/2~%#int16 window_position_y = origin_y + height/2~%int16 window_position_x~%int16 window_position_y~%~%#算法检测结果的ID~%int32 track_id~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WindowPosition>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     2
     2
     2
     2
     2
     2
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WindowPosition>))
  "Converts a ROS message object to a list"
  (cl:list 'WindowPosition
    (cl:cons ':header (header msg))
    (cl:cons ':mode (mode msg))
    (cl:cons ':origin_x (origin_x msg))
    (cl:cons ':origin_y (origin_y msg))
    (cl:cons ':width (width msg))
    (cl:cons ':height (height msg))
    (cl:cons ':window_position_x (window_position_x msg))
    (cl:cons ':window_position_y (window_position_y msg))
    (cl:cons ':track_id (track_id msg))
))
