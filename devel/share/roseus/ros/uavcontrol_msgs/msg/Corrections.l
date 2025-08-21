;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::Corrections)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'Corrections (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::CORRECTIONS")
  (make-package "UAVCONTROL_MSGS::CORRECTIONS"))

(in-package "ROS")
;;//! \htmlinclude Corrections.msg.html


(defclass uavcontrol_msgs::Corrections
  :super ros::object
  :slots (_kf_correction _angle_corrections ))

(defmethod uavcontrol_msgs::Corrections
  (:init
   (&key
    ((:kf_correction __kf_correction) 0.0)
    ((:angle_corrections __angle_corrections) (make-array 2 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _kf_correction (float __kf_correction))
   (setq _angle_corrections __angle_corrections)
   self)
  (:kf_correction
   (&optional __kf_correction)
   (if __kf_correction (setq _kf_correction __kf_correction)) _kf_correction)
  (:angle_corrections
   (&optional __angle_corrections)
   (if __angle_corrections (setq _angle_corrections __angle_corrections)) _angle_corrections)
  (:serialization-length
   ()
   (+
    ;; float64 _kf_correction
    8
    ;; float64[2] _angle_corrections
    (* 8    2)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _kf_correction
       (sys::poke _kf_correction (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64[2] _angle_corrections
     (dotimes (i 2)
       (sys::poke (elt _angle_corrections i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _kf_correction
     (setq _kf_correction (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64[2] _angle_corrections
   (dotimes (i (length _angle_corrections))
     (setf (elt _angle_corrections i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;;
   self)
  )

(setf (get uavcontrol_msgs::Corrections :md5sum-) "61e86887a75fe520847d3256306360f5")
(setf (get uavcontrol_msgs::Corrections :datatype-) "uavcontrol_msgs/Corrections")
(setf (get uavcontrol_msgs::Corrections :definition-)
      "float64 kf_correction
float64[2] angle_corrections

")



(provide :uavcontrol_msgs/Corrections "61e86887a75fe520847d3256306360f5")


