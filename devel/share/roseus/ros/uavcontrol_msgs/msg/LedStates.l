;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::LedStates)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'LedStates (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::LEDSTATES")
  (make-package "UAVCONTROL_MSGS::LEDSTATES"))

(in-package "ROS")
;;//! \htmlinclude LedStates.msg.html


(defclass uavcontrol_msgs::LedStates
  :super ros::object
  :slots (_is_active _state ))

(defmethod uavcontrol_msgs::LedStates
  (:init
   (&key
    ((:is_active __is_active) nil)
    ((:state __state) "")
    )
   (send-super :init)
   (setq _is_active __is_active)
   (setq _state (string __state))
   self)
  (:is_active
   (&optional (__is_active :null))
   (if (not (eq __is_active :null)) (setq _is_active __is_active)) _is_active)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:serialization-length
   ()
   (+
    ;; bool _is_active
    1
    ;; string _state
    4 (length _state)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _is_active
       (if _is_active (write-byte -1 s) (write-byte 0 s))
     ;; string _state
       (write-long (length _state) s) (princ _state s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _is_active
     (setq _is_active (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _state
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _state (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get uavcontrol_msgs::LedStates :md5sum-) "1165944cad65c58bd2d119eb4ad9c08c")
(setf (get uavcontrol_msgs::LedStates :datatype-) "uavcontrol_msgs/LedStates")
(setf (get uavcontrol_msgs::LedStates :definition-)
      "bool is_active  # 喊话开关状态：1开启，0关闭
string state
")



(provide :uavcontrol_msgs/LedStates "1165944cad65c58bd2d119eb4ad9c08c")


