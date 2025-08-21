;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::BasicDataTypeAndValue)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'BasicDataTypeAndValue (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::BASICDATATYPEANDVALUE")
  (make-package "UAVCONTROL_MSGS::BASICDATATYPEANDVALUE"))

(in-package "ROS")
;;//! \htmlinclude BasicDataTypeAndValue.msg.html


(intern "*INTEGER*" (find-package "UAVCONTROL_MSGS::BASICDATATYPEANDVALUE"))
(shadow '*INTEGER* (find-package "UAVCONTROL_MSGS::BASICDATATYPEANDVALUE"))
(defconstant uavcontrol_msgs::BasicDataTypeAndValue::*INTEGER* 1)
(intern "*BOOLEAN*" (find-package "UAVCONTROL_MSGS::BASICDATATYPEANDVALUE"))
(shadow '*BOOLEAN* (find-package "UAVCONTROL_MSGS::BASICDATATYPEANDVALUE"))
(defconstant uavcontrol_msgs::BasicDataTypeAndValue::*BOOLEAN* 2)
(intern "*FLOAT*" (find-package "UAVCONTROL_MSGS::BASICDATATYPEANDVALUE"))
(shadow '*FLOAT* (find-package "UAVCONTROL_MSGS::BASICDATATYPEANDVALUE"))
(defconstant uavcontrol_msgs::BasicDataTypeAndValue::*FLOAT* 3)
(intern "*DOUBLE*" (find-package "UAVCONTROL_MSGS::BASICDATATYPEANDVALUE"))
(shadow '*DOUBLE* (find-package "UAVCONTROL_MSGS::BASICDATATYPEANDVALUE"))
(defconstant uavcontrol_msgs::BasicDataTypeAndValue::*DOUBLE* 4)
(intern "*STRING*" (find-package "UAVCONTROL_MSGS::BASICDATATYPEANDVALUE"))
(shadow '*STRING* (find-package "UAVCONTROL_MSGS::BASICDATATYPEANDVALUE"))
(defconstant uavcontrol_msgs::BasicDataTypeAndValue::*STRING* 5)

(defun uavcontrol_msgs::BasicDataTypeAndValue-to-symbol (const)
  (cond
        ((= const 1) 'uavcontrol_msgs::BasicDataTypeAndValue::*INTEGER*)
        ((= const 2) 'uavcontrol_msgs::BasicDataTypeAndValue::*BOOLEAN*)
        ((= const 3) 'uavcontrol_msgs::BasicDataTypeAndValue::*FLOAT*)
        ((= const 4) 'uavcontrol_msgs::BasicDataTypeAndValue::*DOUBLE*)
        ((= const 5) 'uavcontrol_msgs::BasicDataTypeAndValue::*STRING*)
        (t nil)))

(defclass uavcontrol_msgs::BasicDataTypeAndValue
  :super ros::object
  :slots (_name _type _integer_value _boolean_value _float_value _double_value _string_value ))

(defmethod uavcontrol_msgs::BasicDataTypeAndValue
  (:init
   (&key
    ((:name __name) "")
    ((:type __type) 0)
    ((:integer_value __integer_value) 0)
    ((:boolean_value __boolean_value) nil)
    ((:float_value __float_value) 0.0)
    ((:double_value __double_value) 0.0)
    ((:string_value __string_value) "")
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _type (round __type))
   (setq _integer_value (round __integer_value))
   (setq _boolean_value __boolean_value)
   (setq _float_value (float __float_value))
   (setq _double_value (float __double_value))
   (setq _string_value (string __string_value))
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:integer_value
   (&optional __integer_value)
   (if __integer_value (setq _integer_value __integer_value)) _integer_value)
  (:boolean_value
   (&optional (__boolean_value :null))
   (if (not (eq __boolean_value :null)) (setq _boolean_value __boolean_value)) _boolean_value)
  (:float_value
   (&optional __float_value)
   (if __float_value (setq _float_value __float_value)) _float_value)
  (:double_value
   (&optional __double_value)
   (if __double_value (setq _double_value __double_value)) _double_value)
  (:string_value
   (&optional __string_value)
   (if __string_value (setq _string_value __string_value)) _string_value)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; uint8 _type
    1
    ;; int32 _integer_value
    4
    ;; bool _boolean_value
    1
    ;; float32 _float_value
    4
    ;; float64 _double_value
    8
    ;; string _string_value
    4 (length _string_value)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; uint8 _type
       (write-byte _type s)
     ;; int32 _integer_value
       (write-long _integer_value s)
     ;; bool _boolean_value
       (if _boolean_value (write-byte -1 s) (write-byte 0 s))
     ;; float32 _float_value
       (sys::poke _float_value (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float64 _double_value
       (sys::poke _double_value (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string _string_value
       (write-long (length _string_value) s) (princ _string_value s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint8 _type
     (setq _type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; int32 _integer_value
     (setq _integer_value (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _boolean_value
     (setq _boolean_value (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _float_value
     (setq _float_value (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float64 _double_value
     (setq _double_value (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string _string_value
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _string_value (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get uavcontrol_msgs::BasicDataTypeAndValue :md5sum-) "43928e1d51d365ceca1cc00365d754f1")
(setf (get uavcontrol_msgs::BasicDataTypeAndValue :datatype-) "uavcontrol_msgs/BasicDataTypeAndValue")
(setf (get uavcontrol_msgs::BasicDataTypeAndValue :definition-)
      "string name

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



(provide :uavcontrol_msgs/BasicDataTypeAndValue "43928e1d51d365ceca1cc00365d754f1")


