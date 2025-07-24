; Auto-generated. Do not edit!


(cl:in-package uavcontrol_msgs-msg)


;//! \htmlinclude LinktrackNodeframe2.msg.html

(cl:defclass <LinktrackNodeframe2> (roslisp-msg-protocol:ros-message)
  ((role
    :reader role
    :initarg :role
    :type cl:fixnum
    :initform 0)
   (id
    :reader id
    :initarg :id
    :type cl:fixnum
    :initform 0)
   (local_time
    :reader local_time
    :initarg :local_time
    :type cl:integer
    :initform 0)
   (system_time
    :reader system_time
    :initarg :system_time
    :type cl:integer
    :initform 0)
   (voltage
    :reader voltage
    :initarg :voltage
    :type cl:float
    :initform 0.0)
   (pos_3d
    :reader pos_3d
    :initarg :pos_3d
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (eop_3d
    :reader eop_3d
    :initarg :eop_3d
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (vel_3d
    :reader vel_3d
    :initarg :vel_3d
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (angle_3d
    :reader angle_3d
    :initarg :angle_3d
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (quaternion
    :reader quaternion
    :initarg :quaternion
    :type (cl:vector cl:float)
   :initform (cl:make-array 4 :element-type 'cl:float :initial-element 0.0))
   (imu_gyro_3d
    :reader imu_gyro_3d
    :initarg :imu_gyro_3d
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (imu_acc_3d
    :reader imu_acc_3d
    :initarg :imu_acc_3d
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (nodes
    :reader nodes
    :initarg :nodes
    :type (cl:vector uavcontrol_msgs-msg:LinktrackNode2)
   :initform (cl:make-array 0 :element-type 'uavcontrol_msgs-msg:LinktrackNode2 :initial-element (cl:make-instance 'uavcontrol_msgs-msg:LinktrackNode2))))
)

(cl:defclass LinktrackNodeframe2 (<LinktrackNodeframe2>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LinktrackNodeframe2>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LinktrackNodeframe2)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uavcontrol_msgs-msg:<LinktrackNodeframe2> is deprecated: use uavcontrol_msgs-msg:LinktrackNodeframe2 instead.")))

(cl:ensure-generic-function 'role-val :lambda-list '(m))
(cl:defmethod role-val ((m <LinktrackNodeframe2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:role-val is deprecated.  Use uavcontrol_msgs-msg:role instead.")
  (role m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <LinktrackNodeframe2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:id-val is deprecated.  Use uavcontrol_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'local_time-val :lambda-list '(m))
(cl:defmethod local_time-val ((m <LinktrackNodeframe2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:local_time-val is deprecated.  Use uavcontrol_msgs-msg:local_time instead.")
  (local_time m))

(cl:ensure-generic-function 'system_time-val :lambda-list '(m))
(cl:defmethod system_time-val ((m <LinktrackNodeframe2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:system_time-val is deprecated.  Use uavcontrol_msgs-msg:system_time instead.")
  (system_time m))

(cl:ensure-generic-function 'voltage-val :lambda-list '(m))
(cl:defmethod voltage-val ((m <LinktrackNodeframe2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:voltage-val is deprecated.  Use uavcontrol_msgs-msg:voltage instead.")
  (voltage m))

(cl:ensure-generic-function 'pos_3d-val :lambda-list '(m))
(cl:defmethod pos_3d-val ((m <LinktrackNodeframe2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:pos_3d-val is deprecated.  Use uavcontrol_msgs-msg:pos_3d instead.")
  (pos_3d m))

(cl:ensure-generic-function 'eop_3d-val :lambda-list '(m))
(cl:defmethod eop_3d-val ((m <LinktrackNodeframe2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:eop_3d-val is deprecated.  Use uavcontrol_msgs-msg:eop_3d instead.")
  (eop_3d m))

(cl:ensure-generic-function 'vel_3d-val :lambda-list '(m))
(cl:defmethod vel_3d-val ((m <LinktrackNodeframe2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:vel_3d-val is deprecated.  Use uavcontrol_msgs-msg:vel_3d instead.")
  (vel_3d m))

(cl:ensure-generic-function 'angle_3d-val :lambda-list '(m))
(cl:defmethod angle_3d-val ((m <LinktrackNodeframe2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:angle_3d-val is deprecated.  Use uavcontrol_msgs-msg:angle_3d instead.")
  (angle_3d m))

(cl:ensure-generic-function 'quaternion-val :lambda-list '(m))
(cl:defmethod quaternion-val ((m <LinktrackNodeframe2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:quaternion-val is deprecated.  Use uavcontrol_msgs-msg:quaternion instead.")
  (quaternion m))

(cl:ensure-generic-function 'imu_gyro_3d-val :lambda-list '(m))
(cl:defmethod imu_gyro_3d-val ((m <LinktrackNodeframe2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:imu_gyro_3d-val is deprecated.  Use uavcontrol_msgs-msg:imu_gyro_3d instead.")
  (imu_gyro_3d m))

(cl:ensure-generic-function 'imu_acc_3d-val :lambda-list '(m))
(cl:defmethod imu_acc_3d-val ((m <LinktrackNodeframe2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:imu_acc_3d-val is deprecated.  Use uavcontrol_msgs-msg:imu_acc_3d instead.")
  (imu_acc_3d m))

(cl:ensure-generic-function 'nodes-val :lambda-list '(m))
(cl:defmethod nodes-val ((m <LinktrackNodeframe2>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uavcontrol_msgs-msg:nodes-val is deprecated.  Use uavcontrol_msgs-msg:nodes instead.")
  (nodes m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LinktrackNodeframe2>) ostream)
  "Serializes a message object of type '<LinktrackNodeframe2>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'role)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'local_time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'local_time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'local_time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'local_time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'system_time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'system_time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'system_time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'system_time)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'voltage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'pos_3d))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'eop_3d))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'vel_3d))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'angle_3d))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'quaternion))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'imu_gyro_3d))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'imu_acc_3d))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'nodes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'nodes))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LinktrackNodeframe2>) istream)
  "Deserializes a message object of type '<LinktrackNodeframe2>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'role)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'local_time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'local_time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'local_time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'local_time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'system_time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'system_time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'system_time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'system_time)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'voltage) (roslisp-utils:decode-single-float-bits bits)))
  (cl:setf (cl:slot-value msg 'pos_3d) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'pos_3d)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'eop_3d) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'eop_3d)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'vel_3d) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'vel_3d)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'angle_3d) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'angle_3d)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'quaternion) (cl:make-array 4))
  (cl:let ((vals (cl:slot-value msg 'quaternion)))
    (cl:dotimes (i 4)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'imu_gyro_3d) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'imu_gyro_3d)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'imu_acc_3d) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'imu_acc_3d)))
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
  (cl:setf (cl:slot-value msg 'nodes) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'nodes)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'uavcontrol_msgs-msg:LinktrackNode2))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LinktrackNodeframe2>)))
  "Returns string type for a message object of type '<LinktrackNodeframe2>"
  "uavcontrol_msgs/LinktrackNodeframe2")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LinktrackNodeframe2)))
  "Returns string type for a message object of type 'LinktrackNodeframe2"
  "uavcontrol_msgs/LinktrackNodeframe2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LinktrackNodeframe2>)))
  "Returns md5sum for a message object of type '<LinktrackNodeframe2>"
  "5e015baafc881617fa57f6ba7fd27747")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LinktrackNodeframe2)))
  "Returns md5sum for a message object of type 'LinktrackNodeframe2"
  "5e015baafc881617fa57f6ba7fd27747")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LinktrackNodeframe2>)))
  "Returns full string definition for message of type '<LinktrackNodeframe2>"
  (cl:format cl:nil "uint8 role~%uint8 id~%uint32 local_time~%uint32 system_time~%float32 voltage~%float32[3] pos_3d~%float32[3] eop_3d~%float32[3] vel_3d~%float32[3] angle_3d~%float32[4] quaternion~%float32[3] imu_gyro_3d~%float32[3] imu_acc_3d~%LinktrackNode2[] nodes~%================================================================================~%MSG: uavcontrol_msgs/LinktrackNode2~%uint8 role~%uint8 id~%float32 dis~%float32 fp_rssi~%float32 rx_rssi~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LinktrackNodeframe2)))
  "Returns full string definition for message of type 'LinktrackNodeframe2"
  (cl:format cl:nil "uint8 role~%uint8 id~%uint32 local_time~%uint32 system_time~%float32 voltage~%float32[3] pos_3d~%float32[3] eop_3d~%float32[3] vel_3d~%float32[3] angle_3d~%float32[4] quaternion~%float32[3] imu_gyro_3d~%float32[3] imu_acc_3d~%LinktrackNode2[] nodes~%================================================================================~%MSG: uavcontrol_msgs/LinktrackNode2~%uint8 role~%uint8 id~%float32 dis~%float32 fp_rssi~%float32 rx_rssi~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LinktrackNodeframe2>))
  (cl:+ 0
     1
     1
     4
     4
     4
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'pos_3d) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'eop_3d) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'vel_3d) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'angle_3d) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'quaternion) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'imu_gyro_3d) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'imu_acc_3d) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'nodes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LinktrackNodeframe2>))
  "Converts a ROS message object to a list"
  (cl:list 'LinktrackNodeframe2
    (cl:cons ':role (role msg))
    (cl:cons ':id (id msg))
    (cl:cons ':local_time (local_time msg))
    (cl:cons ':system_time (system_time msg))
    (cl:cons ':voltage (voltage msg))
    (cl:cons ':pos_3d (pos_3d msg))
    (cl:cons ':eop_3d (eop_3d msg))
    (cl:cons ':vel_3d (vel_3d msg))
    (cl:cons ':angle_3d (angle_3d msg))
    (cl:cons ':quaternion (quaternion msg))
    (cl:cons ':imu_gyro_3d (imu_gyro_3d msg))
    (cl:cons ':imu_acc_3d (imu_acc_3d msg))
    (cl:cons ':nodes (nodes msg))
))
