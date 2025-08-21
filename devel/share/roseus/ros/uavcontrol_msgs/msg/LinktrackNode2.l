;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::LinktrackNode2)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'LinktrackNode2 (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::LINKTRACKNODE2")
  (make-package "UAVCONTROL_MSGS::LINKTRACKNODE2"))

(in-package "ROS")
;;//! \htmlinclude LinktrackNode2.msg.html


(defclass uavcontrol_msgs::LinktrackNode2
  :super ros::object
  :slots (_role _id _dis _fp_rssi _rx_rssi ))

(defmethod uavcontrol_msgs::LinktrackNode2
  (:init
   (&key
    ((:role __role) 0)
    ((:id __id) 0)
    ((:dis __dis) 0.0)
    ((:fp_rssi __fp_rssi) 0.0)
    ((:rx_rssi __rx_rssi) 0.0)
    )
   (send-super :init)
   (setq _role (round __role))
   (setq _id (round __id))
   (setq _dis (float __dis))
   (setq _fp_rssi (float __fp_rssi))
   (setq _rx_rssi (float __rx_rssi))
   self)
  (:role
   (&optional __role)
   (if __role (setq _role __role)) _role)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:dis
   (&optional __dis)
   (if __dis (setq _dis __dis)) _dis)
  (:fp_rssi
   (&optional __fp_rssi)
   (if __fp_rssi (setq _fp_rssi __fp_rssi)) _fp_rssi)
  (:rx_rssi
   (&optional __rx_rssi)
   (if __rx_rssi (setq _rx_rssi __rx_rssi)) _rx_rssi)
  (:serialization-length
   ()
   (+
    ;; uint8 _role
    1
    ;; uint8 _id
    1
    ;; float32 _dis
    4
    ;; float32 _fp_rssi
    4
    ;; float32 _rx_rssi
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _role
       (write-byte _role s)
     ;; uint8 _id
       (write-byte _id s)
     ;; float32 _dis
       (sys::poke _dis (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _fp_rssi
       (sys::poke _fp_rssi (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rx_rssi
       (sys::poke _rx_rssi (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _role
     (setq _role (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _id
     (setq _id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _dis
     (setq _dis (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _fp_rssi
     (setq _fp_rssi (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rx_rssi
     (setq _rx_rssi (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get uavcontrol_msgs::LinktrackNode2 :md5sum-) "ebc34feb8e11fb1b06d65ee49880b996")
(setf (get uavcontrol_msgs::LinktrackNode2 :datatype-) "uavcontrol_msgs/LinktrackNode2")
(setf (get uavcontrol_msgs::LinktrackNode2 :definition-)
      "uint8 role
uint8 id
float32 dis
float32 fp_rssi
float32 rx_rssi
")



(provide :uavcontrol_msgs/LinktrackNode2 "ebc34feb8e11fb1b06d65ee49880b996")


