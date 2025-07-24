; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude FormationAssign.msg.html

(cl:defclass <FormationAssign> (roslisp-msg-protocol:ros-message)
  ((formation_poses
    :reader formation_poses
    :initarg :formation_poses
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (assigned
    :reader assigned
    :initarg :assigned
    :type (cl:vector cl:boolean)
   :initform (cl:make-array 0 :element-type 'cl:boolean :initial-element cl:nil)))
)

(cl:defclass FormationAssign (<FormationAssign>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FormationAssign>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FormationAssign)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<FormationAssign> is deprecated: use uavcontrol_msgs-msg:FormationAssign instead.")))

(cl:ensure-generic-function 'formation_poses-val :lambda-list '(m))
(cl:defmethod formation_poses-val ((m <FormationAssign>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:formation_poses-val is deprecated.  Use uavcontrol_msgs-msg:formation_poses instead.")
  (formation_poses m))

(cl:ensure-generic-function 'assigned-val :lambda-list '(m))
(cl:defmethod assigned-val ((m <FormationAssign>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:assigned-val is deprecated.  Use uavcontrol_msgs-msg:assigned instead.")
  (assigned m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FormationAssign>) ostream)
  "Serializes a message object of type '<FormationAssign>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'formation_poses))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'formation_poses))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'assigned))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if ele 1 0)) ostream))
   (cl:slot-value msg 'assigned))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FormationAssign>) istream)
  "Deserializes a message object of type '<FormationAssign>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'formation_poses) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'formation_poses)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'assigned) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'assigned)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:not (cl:zerop (cl:read-byte istream)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FormationAssign>)))
  "Returns string type for a message object of type '<FormationAssign>"
  "uavcontrol_msgs/FormationAssign")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FormationAssign)))
  "Returns string type for a message object of type 'FormationAssign"
  "uavcontrol_msgs/FormationAssign")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FormationAssign>)))
  "Returns md5sum for a message object of type '<FormationAssign>"
  "8ecb1c52bd44cfc87c006bf62284d4ef")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FormationAssign)))
  "Returns md5sum for a message object of type 'FormationAssign"
  "8ecb1c52bd44cfc87c006bf62284d4ef")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FormationAssign>)))
  "Returns full string definition for message of type '<FormationAssign>"
  (cl:format cl:nil "#队形位置~%geometry_msgs/Point[] formation_poses~%~%#位置点是否选取~%bool[] assigned~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FormationAssign)))
  "Returns full string definition for message of type 'FormationAssign"
  (cl:format cl:nil "#队形位置~%geometry_msgs/Point[] formation_poses~%~%#位置点是否选取~%bool[] assigned~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FormationAssign>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'formation_poses) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'assigned) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FormationAssign>))
  "Converts a ROS message object to a list"
  (cl:list 'FormationAssign
    (cl:cons ':formation_poses (formation_poses msg))
    (cl:cons ':assigned (assigned msg))
))
