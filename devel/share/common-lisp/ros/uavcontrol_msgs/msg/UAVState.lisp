; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude UAVState.msg.html

(cl:defclass <UAVState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (uav_id
    :reader uav_id
    :initarg :uav_id
    :type cl:fixnum
    :initform 0)
   (connected
    :reader connected
    :initarg :connected
    :type cl:boolean
    :initform cl:nil)
   (armed
    :reader armed
    :initarg :armed
    :type cl:boolean
    :initform cl:nil)
   (mode
    :reader mode
    :initarg :mode
    :type cl:string
    :initform "")
   (location_source
    :reader location_source
    :initarg :location_source
    :type cl:fixnum
    :initform 0)
   (odom_valid
    :reader odom_valid
    :initarg :odom_valid
    :type cl:boolean
    :initform cl:nil)
   (gps_status
    :reader gps_status
    :initarg :gps_status
    :type cl:fixnum
    :initform 0)
   (gps_num
    :reader gps_num
    :initarg :gps_num
    :type cl:fixnum
    :initform 0)
   (position
    :reader position
    :initarg :position
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (range
    :reader range
    :initarg :range
    :type cl:float
    :initform 0.0)
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
   (rel_alt
    :reader rel_alt
    :initarg :rel_alt
    :type cl:float
    :initform 0.0)
   (velocity
    :reader velocity
    :initarg :velocity
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (attitude
    :reader attitude
    :initarg :attitude
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (attitude_rpy
    :reader attitude_rpy
    :initarg :attitude_rpy
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (attitude_q
    :reader attitude_q
    :initarg :attitude_q
    :type geometry_msgs-msg:Quaternion
    :initform (cl:make-instance 'geometry_msgs-msg:Quaternion))
   (attitude_rate
    :reader attitude_rate
    :initarg :attitude_rate
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (battery_state
    :reader battery_state
    :initarg :battery_state
    :type cl:float
    :initform 0.0)
   (battery_percetage
    :reader battery_percetage
    :initarg :battery_percetage
    :type cl:float
    :initform 0.0)
   (landed
    :reader landed
    :initarg :landed
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass UAVState (<UAVState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UAVState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UAVState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<UAVState> is deprecated: use uavcontrol_msgs-msg:UAVState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'uav_id-val :lambda-list '(m))
(cl:defmethod uav_id-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:uav_id-val is deprecated.  Use uavcontrol_msgs-msg:uav_id instead.")
  (uav_id m))

(cl:ensure-generic-function 'connected-val :lambda-list '(m))
(cl:defmethod connected-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:connected-val is deprecated.  Use uavcontrol_msgs-msg:connected instead.")
  (connected m))

(cl:ensure-generic-function 'armed-val :lambda-list '(m))
(cl:defmethod armed-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:armed-val is deprecated.  Use uavcontrol_msgs-msg:armed instead.")
  (armed m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:mode-val is deprecated.  Use uavcontrol_msgs-msg:mode instead.")
  (mode m))

(cl:ensure-generic-function 'location_source-val :lambda-list '(m))
(cl:defmethod location_source-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:location_source-val is deprecated.  Use uavcontrol_msgs-msg:location_source instead.")
  (location_source m))

(cl:ensure-generic-function 'odom_valid-val :lambda-list '(m))
(cl:defmethod odom_valid-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:odom_valid-val is deprecated.  Use uavcontrol_msgs-msg:odom_valid instead.")
  (odom_valid m))

(cl:ensure-generic-function 'gps_status-val :lambda-list '(m))
(cl:defmethod gps_status-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:gps_status-val is deprecated.  Use uavcontrol_msgs-msg:gps_status instead.")
  (gps_status m))

(cl:ensure-generic-function 'gps_num-val :lambda-list '(m))
(cl:defmethod gps_num-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:gps_num-val is deprecated.  Use uavcontrol_msgs-msg:gps_num instead.")
  (gps_num m))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:position-val is deprecated.  Use uavcontrol_msgs-msg:position instead.")
  (position m))

(cl:ensure-generic-function 'range-val :lambda-list '(m))
(cl:defmethod range-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:range-val is deprecated.  Use uavcontrol_msgs-msg:range instead.")
  (range m))

(cl:ensure-generic-function 'latitude-val :lambda-list '(m))
(cl:defmethod latitude-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:latitude-val is deprecated.  Use uavcontrol_msgs-msg:latitude instead.")
  (latitude m))

(cl:ensure-generic-function 'longitude-val :lambda-list '(m))
(cl:defmethod longitude-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:longitude-val is deprecated.  Use uavcontrol_msgs-msg:longitude instead.")
  (longitude m))

(cl:ensure-generic-function 'altitude-val :lambda-list '(m))
(cl:defmethod altitude-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:altitude-val is deprecated.  Use uavcontrol_msgs-msg:altitude instead.")
  (altitude m))

(cl:ensure-generic-function 'rel_alt-val :lambda-list '(m))
(cl:defmethod rel_alt-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:rel_alt-val is deprecated.  Use uavcontrol_msgs-msg:rel_alt instead.")
  (rel_alt m))

(cl:ensure-generic-function 'velocity-val :lambda-list '(m))
(cl:defmethod velocity-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:velocity-val is deprecated.  Use uavcontrol_msgs-msg:velocity instead.")
  (velocity m))

(cl:ensure-generic-function 'attitude-val :lambda-list '(m))
(cl:defmethod attitude-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:attitude-val is deprecated.  Use uavcontrol_msgs-msg:attitude instead.")
  (attitude m))

(cl:ensure-generic-function 'attitude_rpy-val :lambda-list '(m))
(cl:defmethod attitude_rpy-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:attitude_rpy-val is deprecated.  Use uavcontrol_msgs-msg:attitude_rpy instead.")
  (attitude_rpy m))

(cl:ensure-generic-function 'attitude_q-val :lambda-list '(m))
(cl:defmethod attitude_q-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:attitude_q-val is deprecated.  Use uavcontrol_msgs-msg:attitude_q instead.")
  (attitude_q m))

(cl:ensure-generic-function 'attitude_rate-val :lambda-list '(m))
(cl:defmethod attitude_rate-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:attitude_rate-val is deprecated.  Use uavcontrol_msgs-msg:attitude_rate instead.")
  (attitude_rate m))

(cl:ensure-generic-function 'battery_state-val :lambda-list '(m))
(cl:defmethod battery_state-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:battery_state-val is deprecated.  Use uavcontrol_msgs-msg:battery_state instead.")
  (battery_state m))

(cl:ensure-generic-function 'battery_percetage-val :lambda-list '(m))
(cl:defmethod battery_percetage-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:battery_percetage-val is deprecated.  Use uavcontrol_msgs-msg:battery_percetage instead.")
  (battery_percetage m))

(cl:ensure-generic-function 'landed-val :lambda-list '(m))
(cl:defmethod landed-val ((m <UAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:landed-val is deprecated.  Use uavcontrol_msgs-msg:landed instead.")
  (landed m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<UAVState>)))
    "Constants for message type '<UAVState>"
  '((:MOCAP . 0)
    (:T265 . 1)
    (:GAZEBO . 2)
    (:FAKE_ODOM . 3)
    (:GPS . 4)
    (:RTK . 5)
    (:UWB . 6)
    (:VINS . 7)
    (:OPTICAL_FLOW . 8)
    (:VIOBOT . 9)
    (:MID360 . 10)
    (:BSA_SLAM . 11)
    (:GPS_FIX_TYPE_NO_GPS . 0)
    (:GPS_FIX_TYPE_NO_FIX . 1)
    (:GPS_FIX_TYPE_2D_FIX . 2)
    (:GPS_FIX_TYPE_3D_FIX . 3)
    (:GPS_FIX_TYPE_DGPS . 4)
    (:GPS_FIX_TYPE_RTK_FLOATR . 5)
    (:GPS_FIX_TYPE_RTK_FIXEDR . 6)
    (:GPS_FIX_TYPE_STATIC . 7)
    (:GPS_FIX_TYPE_PPP . 8))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'UAVState)))
    "Constants for message type 'UAVState"
  '((:MOCAP . 0)
    (:T265 . 1)
    (:GAZEBO . 2)
    (:FAKE_ODOM . 3)
    (:GPS . 4)
    (:RTK . 5)
    (:UWB . 6)
    (:VINS . 7)
    (:OPTICAL_FLOW . 8)
    (:VIOBOT . 9)
    (:MID360 . 10)
    (:BSA_SLAM . 11)
    (:GPS_FIX_TYPE_NO_GPS . 0)
    (:GPS_FIX_TYPE_NO_FIX . 1)
    (:GPS_FIX_TYPE_2D_FIX . 2)
    (:GPS_FIX_TYPE_3D_FIX . 3)
    (:GPS_FIX_TYPE_DGPS . 4)
    (:GPS_FIX_TYPE_RTK_FLOATR . 5)
    (:GPS_FIX_TYPE_RTK_FIXEDR . 6)
    (:GPS_FIX_TYPE_STATIC . 7)
    (:GPS_FIX_TYPE_PPP . 8))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UAVState>) ostream)
  "Serializes a message object of type '<UAVState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'uav_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'connected) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'armed) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'mode))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'mode))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'location_source)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'odom_valid) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_status)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_num)) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'position))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'range))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'latitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'longitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'altitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rel_alt))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'velocity))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'attitude))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'attitude_rpy))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'attitude_q) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'attitude_rate))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'battery_state))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'battery_percetage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'landed) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UAVState>) istream)
  "Deserializes a message object of type '<UAVState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'uav_id)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'connected) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'armed) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'mode) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'location_source)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'odom_valid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_status)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_num)) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'position) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'position)))
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
    (cl:setf (cl:slot-value msg 'range) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'latitude) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'longitude) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'altitude) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rel_alt) (roslisp-utils:decode-single-float-bits bits)))
  (cl:setf (cl:slot-value msg 'velocity) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'velocity)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'attitude) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'attitude)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'attitude_rpy) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'attitude_rpy)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'attitude_q) istream)
  (cl:setf (cl:slot-value msg 'attitude_rate) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'attitude_rate)))
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
    (cl:setf (cl:slot-value msg 'battery_state) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'battery_percetage) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'landed) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UAVState>)))
  "Returns string type for a message object of type '<UAVState>"
  "uavcontrol_msgs/UAVState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UAVState)))
  "Returns string type for a message object of type 'UAVState"
  "uavcontrol_msgs/UAVState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UAVState>)))
  "Returns md5sum for a message object of type '<UAVState>"
  "14fa9d3d6abb647e889d626f088b2192")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UAVState)))
  "Returns md5sum for a message object of type 'UAVState"
  "14fa9d3d6abb647e889d626f088b2192")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UAVState>)))
  "Returns full string definition for message of type '<UAVState>"
  (cl:format cl:nil "std_msgs/Header header~%~%## 无人机编号 ~%uint8 uav_id~%~%## 机载电脑是否连接上飞控，true已连接，false则不是~%bool connected~%## 是否解锁，true为已解锁，false则不是~%bool armed~%## PX4飞控当前飞行模式  int8~%string mode~%## 无人机定位来源~%uint8 location_source~%## 定位来源枚举~%uint8 MOCAP=0~%uint8 T265=1~%uint8 GAZEBO=2~%uint8 FAKE_ODOM=3~%uint8 GPS = 4~%uint8 RTK = 5~%uint8 UWB = 6~%uint8 VINS = 7~%uint8 OPTICAL_FLOW = 8~%uint8 viobot = 9~%uint8 MID360 = 10~%uint8 BSA_SLAM=11~%## odom标志位~%bool odom_valid~%~%## GPS状态,变量对应状态可参考mavros_msgs/GPSRAW中的fix_type~%uint8 gps_status~%## GPS状态枚举~%uint8 GPS_FIX_TYPE_NO_GPS=0~%uint8 GPS_FIX_TYPE_NO_FIX=1~%uint8 GPS_FIX_TYPE_2D_FIX=2~%uint8 GPS_FIX_TYPE_3D_FIX=3~%uint8 GPS_FIX_TYPE_DGPS=4~%uint8 GPS_FIX_TYPE_RTK_FLOATR=5~%uint8 GPS_FIX_TYPE_RTK_FIXEDR=6~%uint8 GPS_FIX_TYPE_STATIC=7~%uint8 GPS_FIX_TYPE_PPP=8~%## GPS卫星数量~%uint8 gps_num~%~%## 无人机位置、速度、姿态~%float32[3] position                 ## [m]~%## 无人机定高雷达                     ## [m]~%float32  range~%## 无人机经度、纬度、高度~%float32 latitude                 ##经度          ~%float32 longitude                ##纬度   ~%float32 altitude                 ##海拔高度   ~%float32 rel_alt~%## 无人机速度、姿态~%float32[3] velocity                 ## [m/s]~%## 无人机姿态（欧拉角、四元数）~%float32[3] attitude                 ## [rad]~%~%float32[3] attitude_rpy                ##[度] roll(横滚，左负-180度——右正180度)~%                                    ##[度] pitch（俯仰，下负-90度——上正90度）~%                                    ##[度] yaw（正北=0/正东=90/正南=180/正西=270）~%                    ~%geometry_msgs/Quaternion attitude_q ## 四元数~%## 无人机姿态角速度~%float32[3] attitude_rate            ## [rad/s]~%## 无人机电池状态~%float32 battery_state               ## [V]~%float32 battery_percetage           ## [0-1]~%~%bool landed             # 着陆标志~%~%~%~%    ~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UAVState)))
  "Returns full string definition for message of type 'UAVState"
  (cl:format cl:nil "std_msgs/Header header~%~%## 无人机编号 ~%uint8 uav_id~%~%## 机载电脑是否连接上飞控，true已连接，false则不是~%bool connected~%## 是否解锁，true为已解锁，false则不是~%bool armed~%## PX4飞控当前飞行模式  int8~%string mode~%## 无人机定位来源~%uint8 location_source~%## 定位来源枚举~%uint8 MOCAP=0~%uint8 T265=1~%uint8 GAZEBO=2~%uint8 FAKE_ODOM=3~%uint8 GPS = 4~%uint8 RTK = 5~%uint8 UWB = 6~%uint8 VINS = 7~%uint8 OPTICAL_FLOW = 8~%uint8 viobot = 9~%uint8 MID360 = 10~%uint8 BSA_SLAM=11~%## odom标志位~%bool odom_valid~%~%## GPS状态,变量对应状态可参考mavros_msgs/GPSRAW中的fix_type~%uint8 gps_status~%## GPS状态枚举~%uint8 GPS_FIX_TYPE_NO_GPS=0~%uint8 GPS_FIX_TYPE_NO_FIX=1~%uint8 GPS_FIX_TYPE_2D_FIX=2~%uint8 GPS_FIX_TYPE_3D_FIX=3~%uint8 GPS_FIX_TYPE_DGPS=4~%uint8 GPS_FIX_TYPE_RTK_FLOATR=5~%uint8 GPS_FIX_TYPE_RTK_FIXEDR=6~%uint8 GPS_FIX_TYPE_STATIC=7~%uint8 GPS_FIX_TYPE_PPP=8~%## GPS卫星数量~%uint8 gps_num~%~%## 无人机位置、速度、姿态~%float32[3] position                 ## [m]~%## 无人机定高雷达                     ## [m]~%float32  range~%## 无人机经度、纬度、高度~%float32 latitude                 ##经度          ~%float32 longitude                ##纬度   ~%float32 altitude                 ##海拔高度   ~%float32 rel_alt~%## 无人机速度、姿态~%float32[3] velocity                 ## [m/s]~%## 无人机姿态（欧拉角、四元数）~%float32[3] attitude                 ## [rad]~%~%float32[3] attitude_rpy                ##[度] roll(横滚，左负-180度——右正180度)~%                                    ##[度] pitch（俯仰，下负-90度——上正90度）~%                                    ##[度] yaw（正北=0/正东=90/正南=180/正西=270）~%                    ~%geometry_msgs/Quaternion attitude_q ## 四元数~%## 无人机姿态角速度~%float32[3] attitude_rate            ## [rad/s]~%## 无人机电池状态~%float32 battery_state               ## [V]~%float32 battery_percetage           ## [0-1]~%~%bool landed             # 着陆标志~%~%~%~%    ~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UAVState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     1
     4 (cl:length (cl:slot-value msg 'mode))
     1
     1
     1
     1
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'position) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     4
     4
     4
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'velocity) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'attitude) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'attitude_rpy) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'attitude_q))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'attitude_rate) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UAVState>))
  "Converts a ROS message object to a list"
  (cl:list 'UAVState
    (cl:cons ':header (header msg))
    (cl:cons ':uav_id (uav_id msg))
    (cl:cons ':connected (connected msg))
    (cl:cons ':armed (armed msg))
    (cl:cons ':mode (mode msg))
    (cl:cons ':location_source (location_source msg))
    (cl:cons ':odom_valid (odom_valid msg))
    (cl:cons ':gps_status (gps_status msg))
    (cl:cons ':gps_num (gps_num msg))
    (cl:cons ':position (position msg))
    (cl:cons ':range (range msg))
    (cl:cons ':latitude (latitude msg))
    (cl:cons ':longitude (longitude msg))
    (cl:cons ':altitude (altitude msg))
    (cl:cons ':rel_alt (rel_alt msg))
    (cl:cons ':velocity (velocity msg))
    (cl:cons ':attitude (attitude msg))
    (cl:cons ':attitude_rpy (attitude_rpy msg))
    (cl:cons ':attitude_q (attitude_q msg))
    (cl:cons ':attitude_rate (attitude_rate msg))
    (cl:cons ':battery_state (battery_state msg))
    (cl:cons ':battery_percetage (battery_percetage msg))
    (cl:cons ':landed (landed msg))
))
