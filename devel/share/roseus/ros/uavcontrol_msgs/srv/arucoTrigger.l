;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::arucoTrigger)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'arucoTrigger (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::ARUCOTRIGGER")
  (make-package "UAVCONTROL_MSGS::ARUCOTRIGGER"))
(unless (find-package "UAVCONTROL_MSGS::ARUCOTRIGGERREQUEST")
  (make-package "UAVCONTROL_MSGS::ARUCOTRIGGERREQUEST"))
(unless (find-package "UAVCONTROL_MSGS::ARUCOTRIGGERRESPONSE")
  (make-package "UAVCONTROL_MSGS::ARUCOTRIGGERRESPONSE"))

(in-package "ROS")





(defclass uavcontrol_msgs::arucoTriggerRequest
  :super ros::object
  :slots (_request ))

(defmethod uavcontrol_msgs::arucoTriggerRequest
  (:init
   (&key
    ((:request __request) nil)
    )
   (send-super :init)
   (setq _request __request)
   self)
  (:request
   (&optional (__request :null))
   (if (not (eq __request :null)) (setq _request __request)) _request)
  (:serialization-length
   ()
   (+
    ;; bool _request
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _request
       (if _request (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _request
     (setq _request (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass uavcontrol_msgs::arucoTriggerResponse
  :super ros::object
  :slots (_response ))

(defmethod uavcontrol_msgs::arucoTriggerResponse
  (:init
   (&key
    ((:response __response) nil)
    )
   (send-super :init)
   (setq _response __response)
   self)
  (:response
   (&optional (__response :null))
   (if (not (eq __response :null)) (setq _response __response)) _response)
  (:serialization-length
   ()
   (+
    ;; bool _response
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _response
       (if _response (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _response
     (setq _response (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass uavcontrol_msgs::arucoTrigger
  :super ros::object
  :slots ())

(setf (get uavcontrol_msgs::arucoTrigger :md5sum-) "9a74408ed4558f2d49b9e90001338a55")
(setf (get uavcontrol_msgs::arucoTrigger :datatype-) "uavcontrol_msgs/arucoTrigger")
(setf (get uavcontrol_msgs::arucoTrigger :request) uavcontrol_msgs::arucoTriggerRequest)
(setf (get uavcontrol_msgs::arucoTrigger :response) uavcontrol_msgs::arucoTriggerResponse)

(defmethod uavcontrol_msgs::arucoTriggerRequest
  (:response () (instance uavcontrol_msgs::arucoTriggerResponse :init)))

(setf (get uavcontrol_msgs::arucoTriggerRequest :md5sum-) "9a74408ed4558f2d49b9e90001338a55")
(setf (get uavcontrol_msgs::arucoTriggerRequest :datatype-) "uavcontrol_msgs/arucoTriggerRequest")
(setf (get uavcontrol_msgs::arucoTriggerRequest :definition-)
      "bool request 
---
bool response

")

(setf (get uavcontrol_msgs::arucoTriggerResponse :md5sum-) "9a74408ed4558f2d49b9e90001338a55")
(setf (get uavcontrol_msgs::arucoTriggerResponse :datatype-) "uavcontrol_msgs/arucoTriggerResponse")
(setf (get uavcontrol_msgs::arucoTriggerResponse :definition-)
      "bool request 
---
bool response

")



(provide :uavcontrol_msgs/arucoTrigger "9a74408ed4558f2d49b9e90001338a55")


