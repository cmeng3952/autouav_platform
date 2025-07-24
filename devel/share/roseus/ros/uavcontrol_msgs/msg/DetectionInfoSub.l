;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::DetectionInfoSub)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'DetectionInfoSub (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::DETECTIONINFOSUB")
  (make-package "UAVCONTROL_MSGS::DETECTIONINFOSUB"))

(in-package "ROS")
;;//! \htmlinclude DetectionInfoSub.msg.html


(defclass uavcontrol_msgs::DetectionInfoSub
  :super ros::object
  :slots (_left _top _bot _right _trackIds ))

(defmethod uavcontrol_msgs::DetectionInfoSub
  (:init
   (&key
    ((:left __left) 0.0)
    ((:top __top) 0.0)
    ((:bot __bot) 0.0)
    ((:right __right) 0.0)
    ((:trackIds __trackIds) 0)
    )
   (send-super :init)
   (setq _left (float __left))
   (setq _top (float __top))
   (setq _bot (float __bot))
   (setq _right (float __right))
   (setq _trackIds (round __trackIds))
   self)
  (:left
   (&optional __left)
   (if __left (setq _left __left)) _left)
  (:top
   (&optional __top)
   (if __top (setq _top __top)) _top)
  (:bot
   (&optional __bot)
   (if __bot (setq _bot __bot)) _bot)
  (:right
   (&optional __right)
   (if __right (setq _right __right)) _right)
  (:trackIds
   (&optional __trackIds)
   (if __trackIds (setq _trackIds __trackIds)) _trackIds)
  (:serialization-length
   ()
   (+
    ;; float32 _left
    4
    ;; float32 _top
    4
    ;; float32 _bot
    4
    ;; float32 _right
    4
    ;; int32 _trackIds
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _left
       (sys::poke _left (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _top
       (sys::poke _top (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _bot
       (sys::poke _bot (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _right
       (sys::poke _right (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _trackIds
       (write-long _trackIds s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _left
     (setq _left (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _top
     (setq _top (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _bot
     (setq _bot (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _right
     (setq _right (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _trackIds
     (setq _trackIds (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get uavcontrol_msgs::DetectionInfoSub :md5sum-) "0acdf38ac4afc4c07844dc3ad8b9c432")
(setf (get uavcontrol_msgs::DetectionInfoSub :datatype-) "uavcontrol_msgs/DetectionInfoSub")
(setf (get uavcontrol_msgs::DetectionInfoSub :definition-)
      "#目标框的位置（主要斜对角两个点）
float32 left
float32 top
float32 bot
float32 right


## TRACK TARGET(目标框ID)
int32 trackIds

")



(provide :uavcontrol_msgs/DetectionInfoSub "0acdf38ac4afc4c07844dc3ad8b9c432")


