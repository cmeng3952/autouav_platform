; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude MultiUAVState.msg.html

(cl:defclass <MultiUAVState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (uav_num
    :reader uav_num
    :initarg :uav_num
    :type cl:integer
    :initform 0)
   (uav_state_all
    :reader uav_state_all
    :initarg :uav_state_all
    :type (cl:vector uavcontrol_msgs-msg:UAVState)
   :initform (cl:make-array 0 :element-type 'uavcontrol_msgs-msg:UAVState :initial-element (cl:make-instance 'uavcontrol_msgs-msg:UAVState))))
)

(cl:defclass MultiUAVState (<MultiUAVState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MultiUAVState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MultiUAVState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<MultiUAVState> is deprecated: use uavcontrol_msgs-msg:MultiUAVState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MultiUAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:header-val is deprecated.  Use uavcontrol_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'uav_num-val :lambda-list '(m))
(cl:defmethod uav_num-val ((m <MultiUAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:uav_num-val is deprecated.  Use uavcontrol_msgs-msg:uav_num instead.")
  (uav_num m))

(cl:ensure-generic-function 'uav_state_all-val :lambda-list '(m))
(cl:defmethod uav_state_all-val ((m <MultiUAVState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:uav_state_all-val is deprecated.  Use uavcontrol_msgs-msg:uav_state_all instead.")
  (uav_state_all m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MultiUAVState>) ostream)
  "Serializes a message object of type '<MultiUAVState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'uav_num)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'uav_state_all))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'uav_state_all))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MultiUAVState>) istream)
  "Deserializes a message object of type '<MultiUAVState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'uav_num) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'uav_state_all) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'uav_state_all)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'uavcontrol_msgs-msg:UAVState))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MultiUAVState>)))
  "Returns string type for a message object of type '<MultiUAVState>"
  "uavcontrol_msgs/MultiUAVState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MultiUAVState)))
  "Returns string type for a message object of type 'MultiUAVState"
  "uavcontrol_msgs/MultiUAVState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MultiUAVState>)))
  "Returns md5sum for a message object of type '<MultiUAVState>"
  "72627e48e74480de1a52aedffff0dfea")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MultiUAVState)))
  "Returns md5sum for a message object of type 'MultiUAVState"
  "72627e48e74480de1a52aedffff0dfea")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MultiUAVState>)))
  "Returns full string definition for message of type '<MultiUAVState>"
  (cl:format cl:nil "std_msgs/Header header~%~%## ~%int32 uav_num~%~%## 从1开始~%UAVState[] uav_state_all~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: uavcontrol_msgs/UAVState~%std_msgs/Header header~%~%## 无人机编号 ~%uint8 uav_id~%~%## 机载电脑是否连接上飞控，true已连接，false则不是~%bool connected~%## 是否解锁，true为已解锁，false则不是~%bool armed~%## PX4飞控当前飞行模式  int8~%string mode~%## 无人机定位来源~%uint8 location_source~%## 定位来源枚举~%uint8 MOCAP=0~%uint8 T265=1~%uint8 GAZEBO=2~%uint8 FAKE_ODOM=3~%uint8 GPS = 4~%uint8 RTK = 5~%uint8 UWB = 6~%uint8 VINS = 7~%uint8 OPTICAL_FLOW = 8~%uint8 viobot = 9~%uint8 MID360 = 10~%uint8 BSA_SLAM=11~%## odom标志位~%bool odom_valid~%~%## GPS状态,变量对应状态可参考mavros_msgs/GPSRAW中的fix_type~%uint8 gps_status~%## GPS状态枚举~%uint8 GPS_FIX_TYPE_NO_GPS=0~%uint8 GPS_FIX_TYPE_NO_FIX=1~%uint8 GPS_FIX_TYPE_2D_FIX=2~%uint8 GPS_FIX_TYPE_3D_FIX=3~%uint8 GPS_FIX_TYPE_DGPS=4~%uint8 GPS_FIX_TYPE_RTK_FLOATR=5~%uint8 GPS_FIX_TYPE_RTK_FIXEDR=6~%uint8 GPS_FIX_TYPE_STATIC=7~%uint8 GPS_FIX_TYPE_PPP=8~%## GPS卫星数量~%uint8 gps_num~%~%## 无人机位置、速度、姿态~%float32[3] position                 ## [m]~%## 无人机定高雷达                     ## [m]~%float32  range~%## 无人机经度、纬度、高度~%float32 latitude                 ##经度          ~%float32 longitude                ##纬度   ~%float32 altitude                 ##海拔高度   ~%float32 rel_alt~%## 无人机速度、姿态~%float32[3] velocity                 ## [m/s]~%## 无人机姿态（欧拉角、四元数）~%float32[3] attitude                 ## [rad]~%~%float32[3] attitude_rpy                ##[度] roll(横滚，左负-180度——右正180度)~%                                    ##[度] pitch（俯仰，下负-90度——上正90度）~%                                    ##[度] yaw（正北=0/正东=90/正南=180/正西=270）~%                    ~%geometry_msgs/Quaternion attitude_q ## 四元数~%## 无人机姿态角速度~%float32[3] attitude_rate            ## [rad/s]~%## 无人机电池状态~%float32 battery_state               ## [V]~%float32 battery_percetage           ## [0-1]~%~%bool landed             # 着陆标志~%~%~%~%    ~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MultiUAVState)))
  "Returns full string definition for message of type 'MultiUAVState"
  (cl:format cl:nil "std_msgs/Header header~%~%## ~%int32 uav_num~%~%## 从1开始~%UAVState[] uav_state_all~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: uavcontrol_msgs/UAVState~%std_msgs/Header header~%~%## 无人机编号 ~%uint8 uav_id~%~%## 机载电脑是否连接上飞控，true已连接，false则不是~%bool connected~%## 是否解锁，true为已解锁，false则不是~%bool armed~%## PX4飞控当前飞行模式  int8~%string mode~%## 无人机定位来源~%uint8 location_source~%## 定位来源枚举~%uint8 MOCAP=0~%uint8 T265=1~%uint8 GAZEBO=2~%uint8 FAKE_ODOM=3~%uint8 GPS = 4~%uint8 RTK = 5~%uint8 UWB = 6~%uint8 VINS = 7~%uint8 OPTICAL_FLOW = 8~%uint8 viobot = 9~%uint8 MID360 = 10~%uint8 BSA_SLAM=11~%## odom标志位~%bool odom_valid~%~%## GPS状态,变量对应状态可参考mavros_msgs/GPSRAW中的fix_type~%uint8 gps_status~%## GPS状态枚举~%uint8 GPS_FIX_TYPE_NO_GPS=0~%uint8 GPS_FIX_TYPE_NO_FIX=1~%uint8 GPS_FIX_TYPE_2D_FIX=2~%uint8 GPS_FIX_TYPE_3D_FIX=3~%uint8 GPS_FIX_TYPE_DGPS=4~%uint8 GPS_FIX_TYPE_RTK_FLOATR=5~%uint8 GPS_FIX_TYPE_RTK_FIXEDR=6~%uint8 GPS_FIX_TYPE_STATIC=7~%uint8 GPS_FIX_TYPE_PPP=8~%## GPS卫星数量~%uint8 gps_num~%~%## 无人机位置、速度、姿态~%float32[3] position                 ## [m]~%## 无人机定高雷达                     ## [m]~%float32  range~%## 无人机经度、纬度、高度~%float32 latitude                 ##经度          ~%float32 longitude                ##纬度   ~%float32 altitude                 ##海拔高度   ~%float32 rel_alt~%## 无人机速度、姿态~%float32[3] velocity                 ## [m/s]~%## 无人机姿态（欧拉角、四元数）~%float32[3] attitude                 ## [rad]~%~%float32[3] attitude_rpy                ##[度] roll(横滚，左负-180度——右正180度)~%                                    ##[度] pitch（俯仰，下负-90度——上正90度）~%                                    ##[度] yaw（正北=0/正东=90/正南=180/正西=270）~%                    ~%geometry_msgs/Quaternion attitude_q ## 四元数~%## 无人机姿态角速度~%float32[3] attitude_rate            ## [rad/s]~%## 无人机电池状态~%float32 battery_state               ## [V]~%float32 battery_percetage           ## [0-1]~%~%bool landed             # 着陆标志~%~%~%~%    ~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MultiUAVState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'uav_state_all) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MultiUAVState>))
  "Converts a ROS message object to a list"
  (cl:list 'MultiUAVState
    (cl:cons ':header (header msg))
    (cl:cons ':uav_num (uav_num msg))
    (cl:cons ':uav_state_all (uav_state_all msg))
))
