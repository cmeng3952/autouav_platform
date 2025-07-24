; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude UAVCommand.msg.html

(cl:defclass <UAVCommand> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (Agent_CMD
    :reader Agent_CMD
    :initarg :Agent_CMD
    :type cl:fixnum
    :initform 0)
   (Control_Level
    :reader Control_Level
    :initarg :Control_Level
    :type cl:fixnum
    :initform 0)
   (Move_mode
    :reader Move_mode
    :initarg :Move_mode
    :type cl:fixnum
    :initform 0)
   (position_ref
    :reader position_ref
    :initarg :position_ref
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (velocity_ref
    :reader velocity_ref
    :initarg :velocity_ref
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (acceleration_ref
    :reader acceleration_ref
    :initarg :acceleration_ref
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (yaw_ref
    :reader yaw_ref
    :initarg :yaw_ref
    :type cl:float
    :initform 0.0)
   (rtl_height
    :reader rtl_height
    :initarg :rtl_height
    :type cl:float
    :initform 0.0)
   (land_speed
    :reader land_speed
    :initarg :land_speed
    :type cl:float
    :initform 0.0)
   (Yaw_Rate_Mode
    :reader Yaw_Rate_Mode
    :initarg :Yaw_Rate_Mode
    :type cl:boolean
    :initform cl:nil)
   (yaw_rate_ref
    :reader yaw_rate_ref
    :initarg :yaw_rate_ref
    :type cl:float
    :initform 0.0)
   (att_ref
    :reader att_ref
    :initarg :att_ref
    :type (cl:vector cl:float)
   :initform (cl:make-array 4 :element-type 'cl:float :initial-element 0.0))
   (latitude
    :reader latitude
    :initarg :latitude
    :type cl:float
    :initform 0.0)
   (longitude
    :reader longitude
    :initarg :longitude
    :type cl:float
    :initform 0.0)
   (altitude
    :reader altitude
    :initarg :altitude
    :type cl:float
    :initform 0.0)
   (Command_ID
    :reader Command_ID
    :initarg :Command_ID
    :type cl:integer
    :initform 0))
)

(cl:defclass UAVCommand (<UAVCommand>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UAVCommand>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UAVCommand)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<UAVCommand> is deprecated: use uavcontrol_msgs-msg:UAVCommand instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'Agent_CMD-val :lambda-list '(m))
(cl:defmethod Agent_CMD-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Agent_CMD-val is deprecated.  Use uavcontrol_msgs-msg:Agent_CMD instead.")
  (Agent_CMD m))

(cl:ensure-generic-function 'Control_Level-val :lambda-list '(m))
(cl:defmethod Control_Level-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Control_Level-val is deprecated.  Use uavcontrol_msgs-msg:Control_Level instead.")
  (Control_Level m))

(cl:ensure-generic-function 'Move_mode-val :lambda-list '(m))
(cl:defmethod Move_mode-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Move_mode-val is deprecated.  Use uavcontrol_msgs-msg:Move_mode instead.")
  (Move_mode m))

(cl:ensure-generic-function 'position_ref-val :lambda-list '(m))
(cl:defmethod position_ref-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:position_ref-val is deprecated.  Use uavcontrol_msgs-msg:position_ref instead.")
  (position_ref m))

(cl:ensure-generic-function 'velocity_ref-val :lambda-list '(m))
(cl:defmethod velocity_ref-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:velocity_ref-val is deprecated.  Use uavcontrol_msgs-msg:velocity_ref instead.")
  (velocity_ref m))

(cl:ensure-generic-function 'acceleration_ref-val :lambda-list '(m))
(cl:defmethod acceleration_ref-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:acceleration_ref-val is deprecated.  Use uavcontrol_msgs-msg:acceleration_ref instead.")
  (acceleration_ref m))

(cl:ensure-generic-function 'yaw_ref-val :lambda-list '(m))
(cl:defmethod yaw_ref-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:yaw_ref-val is deprecated.  Use uavcontrol_msgs-msg:yaw_ref instead.")
  (yaw_ref m))

(cl:ensure-generic-function 'rtl_height-val :lambda-list '(m))
(cl:defmethod rtl_height-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:rtl_height-val is deprecated.  Use uavcontrol_msgs-msg:rtl_height instead.")
  (rtl_height m))

(cl:ensure-generic-function 'land_speed-val :lambda-list '(m))
(cl:defmethod land_speed-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:land_speed-val is deprecated.  Use uavcontrol_msgs-msg:land_speed instead.")
  (land_speed m))

(cl:ensure-generic-function 'Yaw_Rate_Mode-val :lambda-list '(m))
(cl:defmethod Yaw_Rate_Mode-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Yaw_Rate_Mode-val is deprecated.  Use uavcontrol_msgs-msg:Yaw_Rate_Mode instead.")
  (Yaw_Rate_Mode m))

(cl:ensure-generic-function 'yaw_rate_ref-val :lambda-list '(m))
(cl:defmethod yaw_rate_ref-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:yaw_rate_ref-val is deprecated.  Use uavcontrol_msgs-msg:yaw_rate_ref instead.")
  (yaw_rate_ref m))

(cl:ensure-generic-function 'att_ref-val :lambda-list '(m))
(cl:defmethod att_ref-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:att_ref-val is deprecated.  Use uavcontrol_msgs-msg:att_ref instead.")
  (att_ref m))

(cl:ensure-generic-function 'latitude-val :lambda-list '(m))
(cl:defmethod latitude-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:latitude-val is deprecated.  Use uavcontrol_msgs-msg:latitude instead.")
  (latitude m))

(cl:ensure-generic-function 'longitude-val :lambda-list '(m))
(cl:defmethod longitude-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:longitude-val is deprecated.  Use uavcontrol_msgs-msg:longitude instead.")
  (longitude m))

(cl:ensure-generic-function 'altitude-val :lambda-list '(m))
(cl:defmethod altitude-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:altitude-val is deprecated.  Use uavcontrol_msgs-msg:altitude instead.")
  (altitude m))

(cl:ensure-generic-function 'Command_ID-val :lambda-list '(m))
(cl:defmethod Command_ID-val ((m <UAVCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:Command_ID-val is deprecated.  Use uavcontrol_msgs-msg:Command_ID instead.")
  (Command_ID m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<UAVCommand>)))
    "Constants for message type '<UAVCommand>"
  '((:TAKEOFF . 1)
    (:LAND . 2)
    (:RTL . 3)
    (:MOVE . 4)
    (:USER_MODE . 5)
    (:INIT_POS_HOVER . 6)
    (:CURRENT_POS_HOVER . 7)
    (:MISSION . 8)
    (:ARUCO_LAND . 9)
    (:DEFAULT_CONTROL . 0)
    (:ABSOLUTE_CONTROL . 1)
    (:EXIT_ABSOLUTE_CONTROL . 2)
    (:XYZ_POS . 0)
    (:XY_VEL_Z_POS . 1)
    (:XYZ_VEL . 2)
    (:XYZ_POS_BODY . 3)
    (:XYZ_VEL_BODY . 4)
    (:XY_VEL_Z_POS_BODY . 5)
    (:TRAJECTORY . 6)
    (:XYZ_ATT . 7)
    (:LAT_LON_ALT . 8))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'UAVCommand)))
    "Constants for message type 'UAVCommand"
  '((:TAKEOFF . 1)
    (:LAND . 2)
    (:RTL . 3)
    (:MOVE . 4)
    (:USER_MODE . 5)
    (:INIT_POS_HOVER . 6)
    (:CURRENT_POS_HOVER . 7)
    (:MISSION . 8)
    (:ARUCO_LAND . 9)
    (:DEFAULT_CONTROL . 0)
    (:ABSOLUTE_CONTROL . 1)
    (:EXIT_ABSOLUTE_CONTROL . 2)
    (:XYZ_POS . 0)
    (:XY_VEL_Z_POS . 1)
    (:XYZ_VEL . 2)
    (:XYZ_POS_BODY . 3)
    (:XYZ_VEL_BODY . 4)
    (:XY_VEL_Z_POS_BODY . 5)
    (:TRAJECTORY . 6)
    (:XYZ_ATT . 7)
    (:LAT_LON_ALT . 8))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UAVCommand>) ostream)
  "Serializes a message object of type '<UAVCommand>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Agent_CMD)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Control_Level)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Move_mode)) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'position_ref))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'velocity_ref))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'acceleration_ref))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yaw_ref))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rtl_height))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'land_speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'Yaw_Rate_Mode) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yaw_rate_ref))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'att_ref))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'latitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'longitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'altitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Command_ID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'Command_ID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'Command_ID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'Command_ID)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UAVCommand>) istream)
  "Deserializes a message object of type '<UAVCommand>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Agent_CMD)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Control_Level)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Move_mode)) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'position_ref) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'position_ref)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'velocity_ref) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'velocity_ref)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'acceleration_ref) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'acceleration_ref)))
    (cl:dotimes (i 3)
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
    (cl:setf (cl:slot-value msg 'yaw_ref) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rtl_height) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'land_speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'Yaw_Rate_Mode) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yaw_rate_ref) (roslisp-utils:decode-single-float-bits bits)))
  (cl:setf (cl:slot-value msg 'att_ref) (cl:make-array 4))
  (cl:let ((vals (cl:slot-value msg 'att_ref)))
    (cl:dotimes (i 4)
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
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'latitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'longitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'altitude) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Command_ID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'Command_ID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'Command_ID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'Command_ID)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UAVCommand>)))
  "Returns string type for a message object of type '<UAVCommand>"
  "uavcontrol_msgs/UAVCommand")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UAVCommand)))
  "Returns string type for a message object of type 'UAVCommand"
  "uavcontrol_msgs/UAVCommand")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UAVCommand>)))
  "Returns md5sum for a message object of type '<UAVCommand>"
  "fd7212149442985f53521ffb85dcaa16")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UAVCommand)))
  "Returns md5sum for a message object of type 'UAVCommand"
  "fd7212149442985f53521ffb85dcaa16")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UAVCommand>)))
  "Returns full string definition for message of type '<UAVCommand>"
  (cl:format cl:nil "std_msgs/Header header~%~%## ---------------------------------控制命令的模式 ------------------------------~%uint8 Agent_CMD~%uint8 Takeoff=1           #起飞~%uint8 Land=2              #降落~%uint8 RTL=3               #返航~%uint8 Move=4              #移动~%uint8 User_Mode=5         #模式~%uint8 Init_Pos_Hover=6    # home点上方悬停~%uint8 Current_Pos_Hover=7 # 当前位置上方悬停~%uint8 Mission=8           #自主巡航~%uint8 aruco_land=9        #二维码识别降落~%~%~%## ---------------------------------------控制等级 -------------------------------~%uint8 Control_Level~%uint8 DEFAULT_CONTROL=0        ### 默认控制~%uint8 ABSOLUTE_CONTROL=1       ### 绝对控制，持续的Move模式应谨慎使用该优先级~%uint8 EXIT_ABSOLUTE_CONTROL=2  ### 退出绝对控制控制，在该控制下，会响应上述两种控制的指令~%~%## 移动命令下的子模式~%uint8 Move_mode~%uint8 XYZ_POS = 0               ### 惯性系定点控制~%uint8 XY_VEL_Z_POS = 1          ### 惯性系定高速度控制~%uint8 XYZ_VEL = 2               ### 惯性系速度控制~%uint8 XYZ_POS_BODY = 3          ### 机体系位置控制~%uint8 XYZ_VEL_BODY = 4          ### 机体系速度控制~%uint8 XY_VEL_Z_POS_BODY = 5     ### 机体系定高速度控制~%uint8 TRAJECTORY = 6            ### 轨迹追踪控制~%uint8 XYZ_ATT = 7               ### 姿态控制（来自外部控制器）~%uint8 LAT_LON_ALT = 8           ### 绝对坐标系下的经纬度~%~%## 控制参考量~%float32[3] position_ref                ## [m]~%float32[3] velocity_ref                ## [m/s]~%float32[3] acceleration_ref            ## [m/s^2]~%float32 yaw_ref                        ## [rad]~%float32 rtl_height                     ## [m]返航高度~%float32 land_speed~%bool Yaw_Rate_Mode                     ## True 代表控制偏航角速率~%float32 yaw_rate_ref                   ## [rad/s]~%float32[4] att_ref                     ## [rad] + [0-1]~%float64 latitude                       ## 无人机经度、纬度、高度                 ~%float64 longitude                      ## 无人机经度、纬度、高度~%float64 altitude                       ## 无人机经度、纬度、高度~%~%## 控制命令的编号 防止接收到错误命令， 编号应该逐次递加~%uint32 Command_ID~%~%~%~%~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UAVCommand)))
  "Returns full string definition for message of type 'UAVCommand"
  (cl:format cl:nil "std_msgs/Header header~%~%## ---------------------------------控制命令的模式 ------------------------------~%uint8 Agent_CMD~%uint8 Takeoff=1           #起飞~%uint8 Land=2              #降落~%uint8 RTL=3               #返航~%uint8 Move=4              #移动~%uint8 User_Mode=5         #模式~%uint8 Init_Pos_Hover=6    # home点上方悬停~%uint8 Current_Pos_Hover=7 # 当前位置上方悬停~%uint8 Mission=8           #自主巡航~%uint8 aruco_land=9        #二维码识别降落~%~%~%## ---------------------------------------控制等级 -------------------------------~%uint8 Control_Level~%uint8 DEFAULT_CONTROL=0        ### 默认控制~%uint8 ABSOLUTE_CONTROL=1       ### 绝对控制，持续的Move模式应谨慎使用该优先级~%uint8 EXIT_ABSOLUTE_CONTROL=2  ### 退出绝对控制控制，在该控制下，会响应上述两种控制的指令~%~%## 移动命令下的子模式~%uint8 Move_mode~%uint8 XYZ_POS = 0               ### 惯性系定点控制~%uint8 XY_VEL_Z_POS = 1          ### 惯性系定高速度控制~%uint8 XYZ_VEL = 2               ### 惯性系速度控制~%uint8 XYZ_POS_BODY = 3          ### 机体系位置控制~%uint8 XYZ_VEL_BODY = 4          ### 机体系速度控制~%uint8 XY_VEL_Z_POS_BODY = 5     ### 机体系定高速度控制~%uint8 TRAJECTORY = 6            ### 轨迹追踪控制~%uint8 XYZ_ATT = 7               ### 姿态控制（来自外部控制器）~%uint8 LAT_LON_ALT = 8           ### 绝对坐标系下的经纬度~%~%## 控制参考量~%float32[3] position_ref                ## [m]~%float32[3] velocity_ref                ## [m/s]~%float32[3] acceleration_ref            ## [m/s^2]~%float32 yaw_ref                        ## [rad]~%float32 rtl_height                     ## [m]返航高度~%float32 land_speed~%bool Yaw_Rate_Mode                     ## True 代表控制偏航角速率~%float32 yaw_rate_ref                   ## [rad/s]~%float32[4] att_ref                     ## [rad] + [0-1]~%float64 latitude                       ## 无人机经度、纬度、高度                 ~%float64 longitude                      ## 无人机经度、纬度、高度~%float64 altitude                       ## 无人机经度、纬度、高度~%~%## 控制命令的编号 防止接收到错误命令， 编号应该逐次递加~%uint32 Command_ID~%~%~%~%~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UAVCommand>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     1
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'position_ref) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'velocity_ref) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'acceleration_ref) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     4
     1
     4
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'att_ref) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     8
     8
     8
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UAVCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'UAVCommand
    (cl:cons ':header (header msg))
    (cl:cons ':Agent_CMD (Agent_CMD msg))
    (cl:cons ':Control_Level (Control_Level msg))
    (cl:cons ':Move_mode (Move_mode msg))
    (cl:cons ':position_ref (position_ref msg))
    (cl:cons ':velocity_ref (velocity_ref msg))
    (cl:cons ':acceleration_ref (acceleration_ref msg))
    (cl:cons ':yaw_ref (yaw_ref msg))
    (cl:cons ':rtl_height (rtl_height msg))
    (cl:cons ':land_speed (land_speed msg))
    (cl:cons ':Yaw_Rate_Mode (Yaw_Rate_Mode msg))
    (cl:cons ':yaw_rate_ref (yaw_rate_ref msg))
    (cl:cons ':att_ref (att_ref msg))
    (cl:cons ':latitude (latitude msg))
    (cl:cons ':longitude (longitude msg))
    (cl:cons ':altitude (altitude msg))
    (cl:cons ':Command_ID (Command_ID msg))
))
