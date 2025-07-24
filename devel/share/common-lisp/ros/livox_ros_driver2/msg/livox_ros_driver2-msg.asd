
(cl:in-package :asdf)

(defsystem "livox_ros_driver2-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "LivoxCustomMsg" :depends-on ("_package_LivoxCustomMsg"))
    (:file "_package_LivoxCustomMsg" :depends-on ("_package"))
    (:file "LivoxCustomPoint" :depends-on ("_package_LivoxCustomPoint"))
    (:file "_package_LivoxCustomPoint" :depends-on ("_package"))
  ))