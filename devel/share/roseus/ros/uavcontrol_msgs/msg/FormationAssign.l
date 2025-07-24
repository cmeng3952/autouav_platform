;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::FormationAssign)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'FormationAssign (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::FORMATIONASSIGN")
  (make-package "UAVCONTROL_MSGS::FORMATIONASSIGN"))

(in-package "ROS")
;;//! \htmlinclude FormationAssign.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass uavcontrol_msgs::FormationAssign
  :super ros::object
  :slots (_formation_poses _assigned ))

(defmethod uavcontrol_msgs::FormationAssign
  (:init
   (&key
    ((:formation_poses __formation_poses) ())
    ((:assigned __assigned) (let (r) (dotimes (i 0) (push nil r)) r))
    )
   (send-super :init)
   (setq _formation_poses __formation_poses)
   (setq _assigned __assigned)
   self)
  (:formation_poses
   (&rest __formation_poses)
   (if (keywordp (car __formation_poses))
       (send* _formation_poses __formation_poses)
     (progn
       (if __formation_poses (setq _formation_poses (car __formation_poses)))
       _formation_poses)))
  (:assigned
   (&optional __assigned)
   (if __assigned (setq _assigned __assigned)) _assigned)
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Point[] _formation_poses
    (apply #'+ (send-all _formation_poses :serialization-length)) 4
    ;; bool[] _assigned
    (* 1    (length _assigned)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Point[] _formation_poses
     (write-long (length _formation_poses) s)
     (dolist (elem _formation_poses)
       (send elem :serialize s)
       )
     ;; bool[] _assigned
     (write-long (length _assigned) s)
     (dotimes (i (length _assigned))
       (if (elt _assigned i) (write-byte -1 s) (write-byte 0 s))
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Point[] _formation_poses
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _formation_poses (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _formation_poses)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; bool[] _assigned
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _assigned (make-list n))
     (dotimes (i n)
     (setf (elt _assigned i) (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
     ))
   ;;
   self)
  )

(setf (get uavcontrol_msgs::FormationAssign :md5sum-) "8ecb1c52bd44cfc87c006bf62284d4ef")
(setf (get uavcontrol_msgs::FormationAssign :datatype-) "uavcontrol_msgs/FormationAssign")
(setf (get uavcontrol_msgs::FormationAssign :definition-)
      "#队形位置
geometry_msgs/Point[] formation_poses

#位置点是否选取
bool[] assigned
================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :uavcontrol_msgs/FormationAssign "8ecb1c52bd44cfc87c006bf62284d4ef")


