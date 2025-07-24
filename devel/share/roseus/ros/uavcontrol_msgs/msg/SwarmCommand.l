;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::SwarmCommand)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'SwarmCommand (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::SWARMCOMMAND")
  (make-package "UAVCONTROL_MSGS::SWARMCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude SwarmCommand.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*MOCAP*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*MOCAP* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*MOCAP* 0)
(intern "*GPS*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*GPS* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*GPS* 4)
(intern "*RTK*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*RTK* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*RTK* 5)
(intern "*UWB*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*UWB* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*UWB* 6)
(intern "*READY*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*READY* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*READY* 0)
(intern "*INIT*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*INIT* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*INIT* 1)
(intern "*START*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*START* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*START* 2)
(intern "*HOLD*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*HOLD* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*HOLD* 3)
(intern "*STOP*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*STOP* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*STOP* 4)
(intern "*FORMATION*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*FORMATION* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*FORMATION* 5)
(intern "*COL_AROUND_CIRCLE*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*COL_AROUND_CIRCLE* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*COL_AROUND_CIRCLE* 6)
(intern "*COL_FOLLOW_UAV*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*COL_FOLLOW_UAV* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*COL_FOLLOW_UAV* 7)
(intern "*COL_FOLLOW_UGV*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*COL_FOLLOW_UGV* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*COL_FOLLOW_UGV* 8)
(intern "*INITPLANNER*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*INITPLANNER* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*INITPLANNER* 9)
(intern "*SWARMFORMATIONPLANNER*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*SWARMFORMATIONPLANNER* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*SWARMFORMATIONPLANNER* 10)
(intern "*FOLLOW*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*FOLLOW* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*FOLLOW* 11)
(intern "*SEARCH*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*SEARCH* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*SEARCH* 12)
(intern "*ATTACK*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*ATTACK* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*ATTACK* 13)
(intern "*ONE_COLUMN*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*ONE_COLUMN* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*ONE_COLUMN* 0)
(intern "*TRIANGLE*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*TRIANGLE* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*TRIANGLE* 1)
(intern "*SQUARE*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*SQUARE* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*SQUARE* 2)
(intern "*CIRCULAR*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*CIRCULAR* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*CIRCULAR* 3)
(intern "*AROUND_CIRCLE*" (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(shadow '*AROUND_CIRCLE* (find-package "UAVCONTROL_MSGS::SWARMCOMMAND"))
(defconstant uavcontrol_msgs::SwarmCommand::*AROUND_CIRCLE* 4)

(defun uavcontrol_msgs::SwarmCommand-to-symbol (const)
  (cond
        ((= const 0) 'uavcontrol_msgs::SwarmCommand::*mocap*)
        ((= const 4) 'uavcontrol_msgs::SwarmCommand::*gps*)
        ((= const 5) 'uavcontrol_msgs::SwarmCommand::*rtk*)
        ((= const 6) 'uavcontrol_msgs::SwarmCommand::*uwb*)
        ((= const 0) 'uavcontrol_msgs::SwarmCommand::*Ready*)
        ((= const 1) 'uavcontrol_msgs::SwarmCommand::*Init*)
        ((= const 2) 'uavcontrol_msgs::SwarmCommand::*Start*)
        ((= const 3) 'uavcontrol_msgs::SwarmCommand::*Hold*)
        ((= const 4) 'uavcontrol_msgs::SwarmCommand::*Stop*)
        ((= const 5) 'uavcontrol_msgs::SwarmCommand::*Formation*)
        ((= const 6) 'uavcontrol_msgs::SwarmCommand::*Col_Around_Circle*)
        ((= const 7) 'uavcontrol_msgs::SwarmCommand::*Col_Follow_UAV*)
        ((= const 8) 'uavcontrol_msgs::SwarmCommand::*Col_Follow_UGV*)
        ((= const 9) 'uavcontrol_msgs::SwarmCommand::*InitPlanner*)
        ((= const 10) 'uavcontrol_msgs::SwarmCommand::*SwarmFormationPlanner*)
        ((= const 11) 'uavcontrol_msgs::SwarmCommand::*Follow*)
        ((= const 12) 'uavcontrol_msgs::SwarmCommand::*Search*)
        ((= const 13) 'uavcontrol_msgs::SwarmCommand::*Attack*)
        ((= const 0) 'uavcontrol_msgs::SwarmCommand::*One_column*)
        ((= const 1) 'uavcontrol_msgs::SwarmCommand::*Triangle*)
        ((= const 2) 'uavcontrol_msgs::SwarmCommand::*Square*)
        ((= const 3) 'uavcontrol_msgs::SwarmCommand::*Circular*)
        ((= const 4) 'uavcontrol_msgs::SwarmCommand::*around_Circle*)
        (t nil)))

(defclass uavcontrol_msgs::SwarmCommand
  :super ros::object
  :slots (_header _source _swarm_num _swarm_location_source _Swarm_CMD _leader_pos _leader_vel _swarm_size _swarm_shape _target_area_x_min _target_area_y_min _target_area_x_max _target_area_y_max _attack_target_pos _formation_poses ))

(defmethod uavcontrol_msgs::SwarmCommand
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:source __source) "")
    ((:swarm_num __swarm_num) 0)
    ((:swarm_location_source __swarm_location_source) 0)
    ((:Swarm_CMD __Swarm_CMD) 0)
    ((:leader_pos __leader_pos) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:leader_vel __leader_vel) (make-array 2 :initial-element 0.0 :element-type :float))
    ((:swarm_size __swarm_size) 0.0)
    ((:swarm_shape __swarm_shape) 0)
    ((:target_area_x_min __target_area_x_min) 0.0)
    ((:target_area_y_min __target_area_y_min) 0.0)
    ((:target_area_x_max __target_area_x_max) 0.0)
    ((:target_area_y_max __target_area_y_max) 0.0)
    ((:attack_target_pos __attack_target_pos) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:formation_poses __formation_poses) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _source (string __source))
   (setq _swarm_num (round __swarm_num))
   (setq _swarm_location_source (round __swarm_location_source))
   (setq _Swarm_CMD (round __Swarm_CMD))
   (setq _leader_pos __leader_pos)
   (setq _leader_vel __leader_vel)
   (setq _swarm_size (float __swarm_size))
   (setq _swarm_shape (round __swarm_shape))
   (setq _target_area_x_min (float __target_area_x_min))
   (setq _target_area_y_min (float __target_area_y_min))
   (setq _target_area_x_max (float __target_area_x_max))
   (setq _target_area_y_max (float __target_area_y_max))
   (setq _attack_target_pos __attack_target_pos)
   (setq _formation_poses __formation_poses)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:source
   (&optional __source)
   (if __source (setq _source __source)) _source)
  (:swarm_num
   (&optional __swarm_num)
   (if __swarm_num (setq _swarm_num __swarm_num)) _swarm_num)
  (:swarm_location_source
   (&optional __swarm_location_source)
   (if __swarm_location_source (setq _swarm_location_source __swarm_location_source)) _swarm_location_source)
  (:Swarm_CMD
   (&optional __Swarm_CMD)
   (if __Swarm_CMD (setq _Swarm_CMD __Swarm_CMD)) _Swarm_CMD)
  (:leader_pos
   (&optional __leader_pos)
   (if __leader_pos (setq _leader_pos __leader_pos)) _leader_pos)
  (:leader_vel
   (&optional __leader_vel)
   (if __leader_vel (setq _leader_vel __leader_vel)) _leader_vel)
  (:swarm_size
   (&optional __swarm_size)
   (if __swarm_size (setq _swarm_size __swarm_size)) _swarm_size)
  (:swarm_shape
   (&optional __swarm_shape)
   (if __swarm_shape (setq _swarm_shape __swarm_shape)) _swarm_shape)
  (:target_area_x_min
   (&optional __target_area_x_min)
   (if __target_area_x_min (setq _target_area_x_min __target_area_x_min)) _target_area_x_min)
  (:target_area_y_min
   (&optional __target_area_y_min)
   (if __target_area_y_min (setq _target_area_y_min __target_area_y_min)) _target_area_y_min)
  (:target_area_x_max
   (&optional __target_area_x_max)
   (if __target_area_x_max (setq _target_area_x_max __target_area_x_max)) _target_area_x_max)
  (:target_area_y_max
   (&optional __target_area_y_max)
   (if __target_area_y_max (setq _target_area_y_max __target_area_y_max)) _target_area_y_max)
  (:attack_target_pos
   (&optional __attack_target_pos)
   (if __attack_target_pos (setq _attack_target_pos __attack_target_pos)) _attack_target_pos)
  (:formation_poses
   (&rest __formation_poses)
   (if (keywordp (car __formation_poses))
       (send* _formation_poses __formation_poses)
     (progn
       (if __formation_poses (setq _formation_poses (car __formation_poses)))
       _formation_poses)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string _source
    4 (length _source)
    ;; uint8 _swarm_num
    1
    ;; uint8 _swarm_location_source
    1
    ;; uint8 _Swarm_CMD
    1
    ;; float32[3] _leader_pos
    (* 4    3)
    ;; float32[2] _leader_vel
    (* 4    2)
    ;; float32 _swarm_size
    4
    ;; uint8 _swarm_shape
    1
    ;; float32 _target_area_x_min
    4
    ;; float32 _target_area_y_min
    4
    ;; float32 _target_area_x_max
    4
    ;; float32 _target_area_y_max
    4
    ;; float32[3] _attack_target_pos
    (* 4    3)
    ;; geometry_msgs/Point[] _formation_poses
    (apply #'+ (send-all _formation_poses :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string _source
       (write-long (length _source) s) (princ _source s)
     ;; uint8 _swarm_num
       (write-byte _swarm_num s)
     ;; uint8 _swarm_location_source
       (write-byte _swarm_location_source s)
     ;; uint8 _Swarm_CMD
       (write-byte _Swarm_CMD s)
     ;; float32[3] _leader_pos
     (dotimes (i 3)
       (sys::poke (elt _leader_pos i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[2] _leader_vel
     (dotimes (i 2)
       (sys::poke (elt _leader_vel i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _swarm_size
       (sys::poke _swarm_size (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _swarm_shape
       (write-byte _swarm_shape s)
     ;; float32 _target_area_x_min
       (sys::poke _target_area_x_min (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _target_area_y_min
       (sys::poke _target_area_y_min (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _target_area_x_max
       (sys::poke _target_area_x_max (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _target_area_y_max
       (sys::poke _target_area_y_max (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[3] _attack_target_pos
     (dotimes (i 3)
       (sys::poke (elt _attack_target_pos i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; geometry_msgs/Point[] _formation_poses
     (write-long (length _formation_poses) s)
     (dolist (elem _formation_poses)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string _source
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _source (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint8 _swarm_num
     (setq _swarm_num (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _swarm_location_source
     (setq _swarm_location_source (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _Swarm_CMD
     (setq _Swarm_CMD (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32[3] _leader_pos
   (dotimes (i (length _leader_pos))
     (setf (elt _leader_pos i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[2] _leader_vel
   (dotimes (i (length _leader_vel))
     (setf (elt _leader_vel i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32 _swarm_size
     (setq _swarm_size (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _swarm_shape
     (setq _swarm_shape (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _target_area_x_min
     (setq _target_area_x_min (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _target_area_y_min
     (setq _target_area_y_min (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _target_area_x_max
     (setq _target_area_x_max (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _target_area_y_max
     (setq _target_area_y_max (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[3] _attack_target_pos
   (dotimes (i (length _attack_target_pos))
     (setf (elt _attack_target_pos i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; geometry_msgs/Point[] _formation_poses
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _formation_poses (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _formation_poses)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get uavcontrol_msgs::SwarmCommand :md5sum-) "280b61bf48e98d617871f1d573cf0c08")
(setf (get uavcontrol_msgs::SwarmCommand :datatype-) "uavcontrol_msgs/SwarmCommand")
(setf (get uavcontrol_msgs::SwarmCommand :definition-)
      "std_msgs/Header header

## 消息来源
string source

## 编队套件数量
uint8 swarm_num

uint8 swarm_location_source

# enum loc 定位来源枚举
uint8 mocap = 0
uint8 gps = 4
uint8 rtk = 5
uint8 uwb = 6

## 命令
uint8 Swarm_CMD
# enum CMD 控制模式枚举
uint8 Ready=0
uint8 Init=1
uint8 Start=2
uint8 Hold=3
uint8 Stop=4
uint8 Formation=5

uint8 Col_Around_Circle=6
uint8 Col_Follow_UAV=7
uint8 Col_Follow_UGV=8

uint8 InitPlanner=9
uint8 SwarmFormationPlanner=10

uint8 Follow=11
uint8 Search=12
uint8 Attack=13

## 编队控制参考量 
float32[3] leader_pos
float32[2] leader_vel
float32 swarm_size
uint8 swarm_shape
uint8 One_column=0
uint8 Triangle=1
uint8 Square=2
uint8 Circular=3
uint8 around_Circle=4

## 搜索控制参考量 
float32 target_area_x_min          ## [m]
float32 target_area_y_min          ## [m]
float32 target_area_x_max          ## [m]
float32 target_area_y_max          ## [m]

## 攻击控制参考量 
float32[3] attack_target_pos          ## [m]

#队形位置
geometry_msgs/Point[] formation_poses

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :uavcontrol_msgs/SwarmCommand "280b61bf48e98d617871f1d573cf0c08")


