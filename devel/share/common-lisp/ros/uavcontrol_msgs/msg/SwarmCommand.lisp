; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude SwarmCommand.msg.html

(cl:defclass <SwarmCommand> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (source
    :reader source
    :initarg :source
    :type cl:string
    :initform "")
   (swarm_num
    :reader swarm_num
    :initarg :swarm_num
    :type cl:fixnum
    :initform 0)
   (swarm_location_source
    :reader swarm_location_source
    :initarg :swarm_location_source
    :type cl:fixnum
    :initform 0)
   (Swarm_CMD
    :reader Swarm_CMD
    :initarg :Swarm_CMD
    :type cl:fixnum
    :initform 0)
   (leader_pos
    :reader leader_pos
    :initarg :leader_pos
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (leader_vel
    :reader leader_vel
    :initarg :leader_vel
    :type (cl:vector cl:float)
   :initform (cl:make-array 2 :element-type 'cl:float :initial-element 0.0))
   (swarm_size
    :reader swarm_size
    :initarg :swarm_size
    :type cl:float
    :initform 0.0)
   (swarm_shape
    :reader swarm_shape
    :initarg :swarm_shape
    :type cl:fixnum
    :initform 0)
   (target_area_x_min
    :reader target_area_x_min
    :initarg :target_area_x_min
    :type cl:float
    :initform 0.0)
   (target_area_y_min
    :reader target_area_y_min
    :initarg :target_area_y_min
    :type cl:float
    :initform 0.0)
   (target_area_x_max
    :reader target_area_x_max
    :initarg :target_area_x_max
    :type cl:float
    :initform 0.0)
   (target_area_y_max
    :reader target_area_y_max
    :initarg :target_area_y_max
    :type cl:float
    :initform 0.0)
   (attack_target_pos
    :reader attack_target_pos
    :initarg :attack_target_pos
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (formation_poses
    :reader formation_poses
    :initarg :formation_poses
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point))))
)

(cl:defclass SwarmCommand (<SwarmCommand>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SwarmCommand>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SwarmCommand)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<SwarmCommand> is deprecated: use uavcontrol_msgs-msg:SwarmCommand instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'source-val :lambda-list '(m))
(cl:defmethod source-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:source-val is deprecated.  Use uavcontrol_msgs-msg:source instead.")
  (source m))

(cl:ensure-generic-function 'swarm_num-val :lambda-list '(m))
(cl:defmethod swarm_num-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:swarm_num-val is deprecated.  Use uavcontrol_msgs-msg:swarm_num instead.")
  (swarm_num m))

(cl:ensure-generic-function 'swarm_location_source-val :lambda-list '(m))
(cl:defmethod swarm_location_source-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:swarm_location_source-val is deprecated.  Use uavcontrol_msgs-msg:swarm_location_source instead.")
  (swarm_location_source m))

(cl:ensure-generic-function 'Swarm_CMD-val :lambda-list '(m))
(cl:defmethod Swarm_CMD-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Swarm_CMD-val is deprecated.  Use uavcontrol_msgs-msg:Swarm_CMD instead.")
  (Swarm_CMD m))

(cl:ensure-generic-function 'leader_pos-val :lambda-list '(m))
(cl:defmethod leader_pos-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:leader_pos-val is deprecated.  Use uavcontrol_msgs-msg:leader_pos instead.")
  (leader_pos m))

(cl:ensure-generic-function 'leader_vel-val :lambda-list '(m))
(cl:defmethod leader_vel-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:leader_vel-val is deprecated.  Use uavcontrol_msgs-msg:leader_vel instead.")
  (leader_vel m))

(cl:ensure-generic-function 'swarm_size-val :lambda-list '(m))
(cl:defmethod swarm_size-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:swarm_size-val is deprecated.  Use uavcontrol_msgs-msg:swarm_size instead.")
  (swarm_size m))

(cl:ensure-generic-function 'swarm_shape-val :lambda-list '(m))
(cl:defmethod swarm_shape-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:swarm_shape-val is deprecated.  Use uavcontrol_msgs-msg:swarm_shape instead.")
  (swarm_shape m))

(cl:ensure-generic-function 'target_area_x_min-val :lambda-list '(m))
(cl:defmethod target_area_x_min-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:target_area_x_min-val is deprecated.  Use uavcontrol_msgs-msg:target_area_x_min instead.")
  (target_area_x_min m))

(cl:ensure-generic-function 'target_area_y_min-val :lambda-list '(m))
(cl:defmethod target_area_y_min-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:target_area_y_min-val is deprecated.  Use uavcontrol_msgs-msg:target_area_y_min instead.")
  (target_area_y_min m))

(cl:ensure-generic-function 'target_area_x_max-val :lambda-list '(m))
(cl:defmethod target_area_x_max-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:target_area_x_max-val is deprecated.  Use uavcontrol_msgs-msg:target_area_x_max instead.")
  (target_area_x_max m))

(cl:ensure-generic-function 'target_area_y_max-val :lambda-list '(m))
(cl:defmethod target_area_y_max-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:target_area_y_max-val is deprecated.  Use uavcontrol_msgs-msg:target_area_y_max instead.")
  (target_area_y_max m))

(cl:ensure-generic-function 'attack_target_pos-val :lambda-list '(m))
(cl:defmethod attack_target_pos-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:attack_target_pos-val is deprecated.  Use uavcontrol_msgs-msg:attack_target_pos instead.")
  (attack_target_pos m))

(cl:ensure-generic-function 'formation_poses-val :lambda-list '(m))
(cl:defmethod formation_poses-val ((m <SwarmCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:formation_poses-val is deprecated.  Use uavcontrol_msgs-msg:formation_poses instead.")
  (formation_poses m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SwarmCommand>)))
    "Constants for message type '<SwarmCommand>"
  '((:MOCAP . 0)
    (:GPS . 4)
    (:RTK . 5)
    (:UWB . 6)
    (:READY . 0)
    (:INIT . 1)
    (:START . 2)
    (:HOLD . 3)
    (:STOP . 4)
    (:FORMATION . 5)
    (:COL_AROUND_CIRCLE . 6)
    (:COL_FOLLOW_UAV . 7)
    (:COL_FOLLOW_UGV . 8)
    (:INITPLANNER . 9)
    (:SWARMFORMATIONPLANNER . 10)
    (:FOLLOW . 11)
    (:SEARCH . 12)
    (:ATTACK . 13)
    (:ONE_COLUMN . 0)
    (:TRIANGLE . 1)
    (:SQUARE . 2)
    (:CIRCULAR . 3)
    (:AROUND_CIRCLE . 4))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SwarmCommand)))
    "Constants for message type 'SwarmCommand"
  '((:MOCAP . 0)
    (:GPS . 4)
    (:RTK . 5)
    (:UWB . 6)
    (:READY . 0)
    (:INIT . 1)
    (:START . 2)
    (:HOLD . 3)
    (:STOP . 4)
    (:FORMATION . 5)
    (:COL_AROUND_CIRCLE . 6)
    (:COL_FOLLOW_UAV . 7)
    (:COL_FOLLOW_UGV . 8)
    (:INITPLANNER . 9)
    (:SWARMFORMATIONPLANNER . 10)
    (:FOLLOW . 11)
    (:SEARCH . 12)
    (:ATTACK . 13)
    (:ONE_COLUMN . 0)
    (:TRIANGLE . 1)
    (:SQUARE . 2)
    (:CIRCULAR . 3)
    (:AROUND_CIRCLE . 4))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SwarmCommand>) ostream)
  "Serializes a message object of type '<SwarmCommand>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'source))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'source))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'swarm_num)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'swarm_location_source)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Swarm_CMD)) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'leader_pos))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'leader_vel))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'swarm_size))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'swarm_shape)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'target_area_x_min))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'target_area_y_min))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'target_area_x_max))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'target_area_y_max))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'attack_target_pos))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'formation_poses))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'formation_poses))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SwarmCommand>) istream)
  "Deserializes a message object of type '<SwarmCommand>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'source) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'source) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'swarm_num)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'swarm_location_source)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Swarm_CMD)) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'leader_pos) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'leader_pos)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'leader_vel) (cl:make-array 2))
  (cl:let ((vals (cl:slot-value msg 'leader_vel)))
    (cl:dotimes (i 2)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'swarm_size) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'swarm_shape)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_area_x_min) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_area_y_min) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_area_x_max) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_area_y_max) (roslisp-utils:decode-single-float-bits bits)))
  (cl:setf (cl:slot-value msg 'attack_target_pos) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'attack_target_pos)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SwarmCommand>)))
  "Returns string type for a message object of type '<SwarmCommand>"
  "uavcontrol_msgs/SwarmCommand")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SwarmCommand)))
  "Returns string type for a message object of type 'SwarmCommand"
  "uavcontrol_msgs/SwarmCommand")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SwarmCommand>)))
  "Returns md5sum for a message object of type '<SwarmCommand>"
  "280b61bf48e98d617871f1d573cf0c08")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SwarmCommand)))
  "Returns md5sum for a message object of type 'SwarmCommand"
  "280b61bf48e98d617871f1d573cf0c08")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SwarmCommand>)))
  "Returns full string definition for message of type '<SwarmCommand>"
  (cl:format cl:nil "std_msgs/Header header~%~%## 消息来源~%string source~%~%## 编队套件数量~%uint8 swarm_num~%~%uint8 swarm_location_source~%~%# enum loc 定位来源枚举~%uint8 mocap = 0~%uint8 gps = 4~%uint8 rtk = 5~%uint8 uwb = 6~%~%## 命令~%uint8 Swarm_CMD~%# enum CMD 控制模式枚举~%uint8 Ready=0~%uint8 Init=1~%uint8 Start=2~%uint8 Hold=3~%uint8 Stop=4~%uint8 Formation=5~%~%uint8 Col_Around_Circle=6~%uint8 Col_Follow_UAV=7~%uint8 Col_Follow_UGV=8~%~%uint8 InitPlanner=9~%uint8 SwarmFormationPlanner=10~%~%uint8 Follow=11~%uint8 Search=12~%uint8 Attack=13~%~%## 编队控制参考量 ~%float32[3] leader_pos~%float32[2] leader_vel~%float32 swarm_size~%uint8 swarm_shape~%uint8 One_column=0~%uint8 Triangle=1~%uint8 Square=2~%uint8 Circular=3~%uint8 around_Circle=4~%~%## 搜索控制参考量 ~%float32 target_area_x_min          ## [m]~%float32 target_area_y_min          ## [m]~%float32 target_area_x_max          ## [m]~%float32 target_area_y_max          ## [m]~%~%## 攻击控制参考量 ~%float32[3] attack_target_pos          ## [m]~%~%#队形位置~%geometry_msgs/Point[] formation_poses~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SwarmCommand)))
  "Returns full string definition for message of type 'SwarmCommand"
  (cl:format cl:nil "std_msgs/Header header~%~%## 消息来源~%string source~%~%## 编队套件数量~%uint8 swarm_num~%~%uint8 swarm_location_source~%~%# enum loc 定位来源枚举~%uint8 mocap = 0~%uint8 gps = 4~%uint8 rtk = 5~%uint8 uwb = 6~%~%## 命令~%uint8 Swarm_CMD~%# enum CMD 控制模式枚举~%uint8 Ready=0~%uint8 Init=1~%uint8 Start=2~%uint8 Hold=3~%uint8 Stop=4~%uint8 Formation=5~%~%uint8 Col_Around_Circle=6~%uint8 Col_Follow_UAV=7~%uint8 Col_Follow_UGV=8~%~%uint8 InitPlanner=9~%uint8 SwarmFormationPlanner=10~%~%uint8 Follow=11~%uint8 Search=12~%uint8 Attack=13~%~%## 编队控制参考量 ~%float32[3] leader_pos~%float32[2] leader_vel~%float32 swarm_size~%uint8 swarm_shape~%uint8 One_column=0~%uint8 Triangle=1~%uint8 Square=2~%uint8 Circular=3~%uint8 around_Circle=4~%~%## 搜索控制参考量 ~%float32 target_area_x_min          ## [m]~%float32 target_area_y_min          ## [m]~%float32 target_area_x_max          ## [m]~%float32 target_area_y_max          ## [m]~%~%## 攻击控制参考量 ~%float32[3] attack_target_pos          ## [m]~%~%#队形位置~%geometry_msgs/Point[] formation_poses~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SwarmCommand>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:length (cl:slot-value msg 'source))
     1
     1
     1
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'leader_pos) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'leader_vel) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     1
     4
     4
     4
     4
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'attack_target_pos) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'formation_poses) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SwarmCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'SwarmCommand
    (cl:cons ':header (header msg))
    (cl:cons ':source (source msg))
    (cl:cons ':swarm_num (swarm_num msg))
    (cl:cons ':swarm_location_source (swarm_location_source msg))
    (cl:cons ':Swarm_CMD (Swarm_CMD msg))
    (cl:cons ':leader_pos (leader_pos msg))
    (cl:cons ':leader_vel (leader_vel msg))
    (cl:cons ':swarm_size (swarm_size msg))
    (cl:cons ':swarm_shape (swarm_shape msg))
    (cl:cons ':target_area_x_min (target_area_x_min msg))
    (cl:cons ':target_area_y_min (target_area_y_min msg))
    (cl:cons ':target_area_x_max (target_area_x_max msg))
    (cl:cons ':target_area_y_max (target_area_y_max msg))
    (cl:cons ':attack_target_pos (attack_target_pos msg))
    (cl:cons ':formation_poses (formation_poses msg))
))
