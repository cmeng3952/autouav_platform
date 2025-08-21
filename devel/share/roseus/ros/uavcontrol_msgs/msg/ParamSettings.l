;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::ParamSettings)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'ParamSettings (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::PARAMSETTINGS")
  (make-package "UAVCONTROL_MSGS::PARAMSETTINGS"))

(in-package "ROS")
;;//! \htmlinclude ParamSettings.msg.html


(defclass uavcontrol_msgs::ParamSettings
  :super ros::object
  :slots (_param_name _param_value ))

(defmethod uavcontrol_msgs::ParamSettings
  (:init
   (&key
    ((:param_name __param_name) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:param_value __param_value) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _param_name __param_name)
   (setq _param_value __param_value)
   self)
  (:param_name
   (&optional __param_name)
   (if __param_name (setq _param_name __param_name)) _param_name)
  (:param_value
   (&optional __param_value)
   (if __param_value (setq _param_value __param_value)) _param_value)
  (:serialization-length
   ()
   (+
    ;; string[] _param_name
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _param_name)) 4
    ;; string[] _param_value
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _param_value)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string[] _param_name
     (write-long (length _param_name) s)
     (dolist (elem _param_name)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _param_value
     (write-long (length _param_value) s)
     (dolist (elem _param_value)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string[] _param_name
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _param_name (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _param_name i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _param_value
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _param_value (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _param_value i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get uavcontrol_msgs::ParamSettings :md5sum-) "75157f8febd181d39db292f566f5eebb")
(setf (get uavcontrol_msgs::ParamSettings :datatype-) "uavcontrol_msgs/ParamSettings")
(setf (get uavcontrol_msgs::ParamSettings :definition-)
      "string[] param_name
string[] param_value
")



(provide :uavcontrol_msgs/ParamSettings "75157f8febd181d39db292f566f5eebb")


