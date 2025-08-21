
(cl:in-package :asdf)

(defsystem "uavcontrol_msgs-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "arucoTrigger" :depends-on ("_package_arucoTrigger"))
    (:file "_package_arucoTrigger" :depends-on ("_package"))
  ))