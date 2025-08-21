;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::CustomDataSegment)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'CustomDataSegment (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::CUSTOMDATASEGMENT")
  (make-package "UAVCONTROL_MSGS::CUSTOMDATASEGMENT"))

(in-package "ROS")
;;//! \htmlinclude CustomDataSegment.msg.html


(defclass uavcontrol_msgs::CustomDataSegment
  :super ros::object
  :slots (_datas ))

(defmethod uavcontrol_msgs::CustomDataSegment
  (:init
   (&key
    ((:datas __datas) ())
    )
   (send-super :init)
   (setq _datas __datas)
   self)
  (:datas
   (&rest __datas)
   (if (keywordp (car __datas))
       (send* _datas __datas)
     (progn
       (if __datas (setq _datas (car __datas)))
       _datas)))
  (:serialization-length
   ()
   (+
    ;; uavcontrol_msgs/BasicDataTypeAndValue[] _datas
    (apply #'+ (send-all _datas :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uavcontrol_msgs/BasicDataTypeAndValue[] _datas
     (write-long (length _datas) s)
     (dolist (elem _datas)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uavcontrol_msgs/BasicDataTypeAndValue[] _datas
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _datas (let (r) (dotimes (i n) (push (instance uavcontrol_msgs::BasicDataTypeAndValue :init) r)) r))
     (dolist (elem- _datas)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get uavcontrol_msgs::CustomDataSegment :md5sum-) "2c5eb9fae1fd643ad2bc94816d320d81")
(setf (get uavcontrol_msgs::CustomDataSegment :datatype-) "uavcontrol_msgs/CustomDataSegment")
(setf (get uavcontrol_msgs::CustomDataSegment :definition-)
      "BasicDataTypeAndValue[] datas
================================================================================
MSG: uavcontrol_msgs/BasicDataTypeAndValue
string name

uint8 type
uint8 INTEGER=1
uint8 BOOLEAN=2
uint8 FLOAT=3
uint8 DOUBLE=4
uint8 STRING=5

int32 integer_value
bool boolean_value
float32 float_value
float64 double_value
string string_value
")



(provide :uavcontrol_msgs/CustomDataSegment "2c5eb9fae1fd643ad2bc94816d320d81")


