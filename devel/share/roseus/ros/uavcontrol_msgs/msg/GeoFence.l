;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::GeoFence)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'GeoFence (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::GEOFENCE")
  (make-package "UAVCONTROL_MSGS::GEOFENCE"))

(in-package "ROS")
;;//! \htmlinclude GeoFence.msg.html


(defclass uavcontrol_msgs::GeoFence
  :super ros::object
  :slots (_x_min _x_max _y_min _y_max _z_min _z_max ))

(defmethod uavcontrol_msgs::GeoFence
  (:init
   (&key
    ((:x_min __x_min) 0.0)
    ((:x_max __x_max) 0.0)
    ((:y_min __y_min) 0.0)
    ((:y_max __y_max) 0.0)
    ((:z_min __z_min) 0.0)
    ((:z_max __z_max) 0.0)
    )
   (send-super :init)
   (setq _x_min (float __x_min))
   (setq _x_max (float __x_max))
   (setq _y_min (float __y_min))
   (setq _y_max (float __y_max))
   (setq _z_min (float __z_min))
   (setq _z_max (float __z_max))
   self)
  (:x_min
   (&optional __x_min)
   (if __x_min (setq _x_min __x_min)) _x_min)
  (:x_max
   (&optional __x_max)
   (if __x_max (setq _x_max __x_max)) _x_max)
  (:y_min
   (&optional __y_min)
   (if __y_min (setq _y_min __y_min)) _y_min)
  (:y_max
   (&optional __y_max)
   (if __y_max (setq _y_max __y_max)) _y_max)
  (:z_min
   (&optional __z_min)
   (if __z_min (setq _z_min __z_min)) _z_min)
  (:z_max
   (&optional __z_max)
   (if __z_max (setq _z_max __z_max)) _z_max)
  (:serialization-length
   ()
   (+
    ;; float64 _x_min
    8
    ;; float64 _x_max
    8
    ;; float64 _y_min
    8
    ;; float64 _y_max
    8
    ;; float64 _z_min
    8
    ;; float64 _z_max
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _x_min
       (sys::poke _x_min (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _x_max
       (sys::poke _x_max (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y_min
       (sys::poke _y_min (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y_max
       (sys::poke _y_max (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _z_min
       (sys::poke _z_min (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _z_max
       (sys::poke _z_max (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _x_min
     (setq _x_min (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _x_max
     (setq _x_max (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y_min
     (setq _y_min (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y_max
     (setq _y_max (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _z_min
     (setq _z_min (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _z_max
     (setq _z_max (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get uavcontrol_msgs::GeoFence :md5sum-) "ad99bb284c3254d76796e1b66efe44bd")
(setf (get uavcontrol_msgs::GeoFence :datatype-) "uavcontrol_msgs/GeoFence")
(setf (get uavcontrol_msgs::GeoFence :definition-)
      "float64 x_min
float64 x_max
float64 y_min
float64 y_max
float64 z_min
float64 z_max


")



(provide :uavcontrol_msgs/GeoFence "ad99bb284c3254d76796e1b66efe44bd")


