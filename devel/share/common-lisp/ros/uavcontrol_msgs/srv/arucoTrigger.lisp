; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-srv)


;//! \htmlinclude arucoTrigger-request.msg.html

(cl:defclass <arucoTrigger-request> (roslisp-msg-protocol:ros-message)
  ((request
    :reader request
    :initarg :request
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass arucoTrigger-request (<arucoTrigger-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <arucoTrigger-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'arucoTrigger-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-srv:<arucoTrigger-request> is deprecated: use uavcontrol_msgs-srv:arucoTrigger-request instead.")))

(cl:ensure-generic-function 'request-val :lambda-list '(m))
(cl:defmethod request-val ((m <arucoTrigger-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-srv:request-val is deprecated.  Use uavcontrol_msgs-srv:request instead.")
  (request m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <arucoTrigger-request>) ostream)
  "Serializes a message object of type '<arucoTrigger-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'request) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <arucoTrigger-request>) istream)
  "Deserializes a message object of type '<arucoTrigger-request>"
    (cl:setf (cl:slot-value msg 'request) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<arucoTrigger-request>)))
  "Returns string type for a service object of type '<arucoTrigger-request>"
  "uavcontrol_msgs/arucoTriggerRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'arucoTrigger-request)))
  "Returns string type for a service object of type 'arucoTrigger-request"
  "uavcontrol_msgs/arucoTriggerRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<arucoTrigger-request>)))
  "Returns md5sum for a message object of type '<arucoTrigger-request>"
  "9a74408ed4558f2d49b9e90001338a55")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'arucoTrigger-request)))
  "Returns md5sum for a message object of type 'arucoTrigger-request"
  "9a74408ed4558f2d49b9e90001338a55")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<arucoTrigger-request>)))
  "Returns full string definition for message of type '<arucoTrigger-request>"
  (cl:format cl:nil "bool request ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'arucoTrigger-request)))
  "Returns full string definition for message of type 'arucoTrigger-request"
  (cl:format cl:nil "bool request ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <arucoTrigger-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <arucoTrigger-request>))
  "Converts a ROS message object to a list"
  (cl:list 'arucoTrigger-request
    (cl:cons ':request (request msg))
))
;//! \htmlinclude arucoTrigger-response.msg.html

(cl:defclass <arucoTrigger-response> (roslisp-msg-protocol:ros-message)
  ((response
    :reader response
    :initarg :response
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass arucoTrigger-response (<arucoTrigger-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <arucoTrigger-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'arucoTrigger-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-srv:<arucoTrigger-response> is deprecated: use uavcontrol_msgs-srv:arucoTrigger-response instead.")))

(cl:ensure-generic-function 'response-val :lambda-list '(m))
(cl:defmethod response-val ((m <arucoTrigger-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-srv:response-val is deprecated.  Use uavcontrol_msgs-srv:response instead.")
  (response m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <arucoTrigger-response>) ostream)
  "Serializes a message object of type '<arucoTrigger-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'response) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <arucoTrigger-response>) istream)
  "Deserializes a message object of type '<arucoTrigger-response>"
    (cl:setf (cl:slot-value msg 'response) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<arucoTrigger-response>)))
  "Returns string type for a service object of type '<arucoTrigger-response>"
  "uavcontrol_msgs/arucoTriggerResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'arucoTrigger-response)))
  "Returns string type for a service object of type 'arucoTrigger-response"
  "uavcontrol_msgs/arucoTriggerResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<arucoTrigger-response>)))
  "Returns md5sum for a message object of type '<arucoTrigger-response>"
  "9a74408ed4558f2d49b9e90001338a55")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'arucoTrigger-response)))
  "Returns md5sum for a message object of type 'arucoTrigger-response"
  "9a74408ed4558f2d49b9e90001338a55")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<arucoTrigger-response>)))
  "Returns full string definition for message of type '<arucoTrigger-response>"
  (cl:format cl:nil "bool response~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'arucoTrigger-response)))
  "Returns full string definition for message of type 'arucoTrigger-response"
  (cl:format cl:nil "bool response~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <arucoTrigger-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <arucoTrigger-response>))
  "Converts a ROS message object to a list"
  (cl:list 'arucoTrigger-response
    (cl:cons ':response (response msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'arucoTrigger)))
  'arucoTrigger-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'arucoTrigger)))
  'arucoTrigger-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'arucoTrigger)))
  "Returns string type for a service object of type '<arucoTrigger>"
  "uavcontrol_msgs/arucoTrigger")