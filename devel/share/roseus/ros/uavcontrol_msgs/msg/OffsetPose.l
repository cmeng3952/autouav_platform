;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::OffsetPose)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'OffsetPose (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::OFFSETPOSE")
  (make-package "UAVCONTROL_MSGS::OFFSETPOSE"))

(in-package "ROS")
;;//! \htmlinclude OffsetPose.msg.html


(defclass uavcontrol_msgs::OffsetPose
  :super ros::object
  :slots (_uav_id _x _y ))

(defmethod uavcontrol_msgs::OffsetPose
  (:init
   (&key
    ((:uav_id __uav_id) 0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    )
   (send-super :init)
   (setq _uav_id (round __uav_id))
   (setq _x (float __x))
   (setq _y (float __y))
   self)
  (:uav_id
   (&optional __uav_id)
   (if __uav_id (setq _uav_id __uav_id)) _uav_id)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:serialization-length
   ()
   (+
    ;; uint8 _uav_id
    1
    ;; float32 _x
    4
    ;; float32 _y
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _uav_id
       (write-byte _uav_id s)
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _uav_id
     (setq _uav_id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get uavcontrol_msgs::OffsetPose :md5sum-) "f20d15993ada6c6c2a861137ed3dcd2a")
(setf (get uavcontrol_msgs::OffsetPose :datatype-) "uavcontrol_msgs/OffsetPose")
(setf (get uavcontrol_msgs::OffsetPose :definition-)
      "uint8 uav_id
float32 x
float32 y
")



(provide :uavcontrol_msgs/OffsetPose "f20d15993ada6c6c2a861137ed3dcd2a")


