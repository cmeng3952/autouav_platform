;; Auto-generated. Do not edit!


(when (boundp 'uavcontrol_msgs::ShoutStates)
  (if (not (find-package "UAVCONTROL_MSGS"))
    (make-package "UAVCONTROL_MSGS"))
  (shadow 'ShoutStates (find-package "UAVCONTROL_MSGS")))
(unless (find-package "UAVCONTROL_MSGS::SHOUTSTATES")
  (make-package "UAVCONTROL_MSGS::SHOUTSTATES"))

(in-package "ROS")
;;//! \htmlinclude ShoutStates.msg.html


(defclass uavcontrol_msgs::ShoutStates
  :super ros::object
  :slots (_is_active _state ))

(defmethod uavcontrol_msgs::ShoutStates
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

(setf (get uavcontrol_msgs::ShoutStates :md5sum-) "1165944cad65c58bd2d119eb4ad9c08c")
(setf (get uavcontrol_msgs::ShoutStates :datatype-) "uavcontrol_msgs/ShoutStates")
(setf (get uavcontrol_msgs::ShoutStates :definition-)
      "bool is_active  # 喊话开关状态：true=开启，false=关闭
string state
")



(provide :uavcontrol_msgs/ShoutStates "1165944cad65c58bd2d119eb4ad9c08c")


