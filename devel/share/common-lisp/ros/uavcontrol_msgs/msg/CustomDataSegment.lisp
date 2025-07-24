; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude CustomDataSegment.msg.html

(cl:defclass <CustomDataSegment> (roslisp-msg-protocol:ros-message)
  ((datas
    :reader datas
    :initarg :datas
    :type (cl:vector uavcontrol_msgs-msg:BasicDataTypeAndValue)
   :initform (cl:make-array 0 :element-type 'uavcontrol_msgs-msg:BasicDataTypeAndValue :initial-element (cl:make-instance 'uavcontrol_msgs-msg:BasicDataTypeAndValue))))
)

(cl:defclass CustomDataSegment (<CustomDataSegment>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CustomDataSegment>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CustomDataSegment)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<CustomDataSegment> is deprecated: use uavcontrol_msgs-msg:CustomDataSegment instead.")))

(cl:ensure-generic-function 'datas-val :lambda-list '(m))
(cl:defmethod datas-val ((m <CustomDataSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:datas-val is deprecated.  Use uavcontrol_msgs-msg:datas instead.")
  (datas m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CustomDataSegment>) ostream)
  "Serializes a message object of type '<CustomDataSegment>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'datas))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'datas))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CustomDataSegment>) istream)
  "Deserializes a message object of type '<CustomDataSegment>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'datas) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'datas)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'uavcontrol_msgs-msg:BasicDataTypeAndValue))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CustomDataSegment>)))
  "Returns string type for a message object of type '<CustomDataSegment>"
  "uavcontrol_msgs/CustomDataSegment")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CustomDataSegment)))
  "Returns string type for a message object of type 'CustomDataSegment"
  "uavcontrol_msgs/CustomDataSegment")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CustomDataSegment>)))
  "Returns md5sum for a message object of type '<CustomDataSegment>"
  "2c5eb9fae1fd643ad2bc94816d320d81")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CustomDataSegment)))
  "Returns md5sum for a message object of type 'CustomDataSegment"
  "2c5eb9fae1fd643ad2bc94816d320d81")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CustomDataSegment>)))
  "Returns full string definition for message of type '<CustomDataSegment>"
  (cl:format cl:nil "BasicDataTypeAndValue[] datas~%================================================================================~%MSG: uavcontrol_msgs/BasicDataTypeAndValue~%string name~%~%uint8 type~%uint8 INTEGER=1~%uint8 BOOLEAN=2~%uint8 FLOAT=3~%uint8 DOUBLE=4~%uint8 STRING=5~%~%int32 integer_value~%bool boolean_value~%float32 float_value~%float64 double_value~%string string_value~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CustomDataSegment)))
  "Returns full string definition for message of type 'CustomDataSegment"
  (cl:format cl:nil "BasicDataTypeAndValue[] datas~%================================================================================~%MSG: uavcontrol_msgs/BasicDataTypeAndValue~%string name~%~%uint8 type~%uint8 INTEGER=1~%uint8 BOOLEAN=2~%uint8 FLOAT=3~%uint8 DOUBLE=4~%uint8 STRING=5~%~%int32 integer_value~%bool boolean_value~%float32 float_value~%float64 double_value~%string string_value~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CustomDataSegment>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'datas) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CustomDataSegment>))
  "Converts a ROS message object to a list"
  (cl:list 'CustomDataSegment
    (cl:cons ':datas (datas msg))
))
