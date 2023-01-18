(defpackage :j/workrave
  (:use #:cl #:stumpwm #:alexandria)
  (:export #:init
           #:subscribe
           #:workrave
           #:modeline
           #:time-remaining
           #:time-overdue
           #:time-elapsed
           #:time-idle
           #:is-running
           #:is-active
           #:state
           #:*update-interval*))

(in-package :j/workrave)
;; DBUS example: https://www.reddit.com/r/lisp/comments/179zl1/has_anyone_else_used_the_dbus_package_much/
;; workrave dbus example: https://gist.github.com/kronn/d0841c304cad8abac8d3147eca9adfc3
;; more example: https://github.com/rcaelers/workrave/blob/main/contrib/send_dbus_command/kde/workrave-kde.sh

(defparameter *update-interval* 1)

(defvar *destination* "org.workrave.WorkraveApplication")
(defvar *ui-path* "/org/workrave/Workrave/UI")
(defvar *ui-interface* "org.workrave.ControlInterface")
(defvar *core-path* "/org/workrave/Workrave/Core")
(defvar *core-interface* "org.workrave.CoreInterface")
(defvar *config-interface* "org.workrave.ConfigInterface")
(defvar *timer-id* "restbreak")
(defvar *config-timer-id* "rest_break")

(defvar *dbus-conn* nil)
(defvar *dbus-bus* nil)
(defvar *ui-obj* nil)
(defvar *core-obj* nil)

(defvar *state* :none)
(defvar *time-left* 0)
(defvar *break-length* 0)

(defmacro dbus-core-call (fun-name &rest args)
  `(dbus:object-invoke *core-obj* *core-interface* ,fun-name ,@args))

(defmacro dbus-config-call (fun-name &rest args)
  `(dbus:object-invoke *core-obj* *config-interface* ,fun-name ,@args))

(defmacro dbus-ui-call (fun-name &rest args)
  `(dbus:object-invoke *ui-obj* *ui-interface* ,fun-name ,@args))

(defun time-remaining ()
  (dbus-core-call "GetTimerRemaining" *timer-id*))

(defun time-overdue ()
  (dbus-core-call "GetTimerOverdue" *timer-id*))

(defun time-elapsed ()
  (dbus-core-call "GetTimerElapsed" *timer-id*))

(defun time-idle ()
  (dbus-core-call "GetTimerIdle" *timer-id*))

(defun is-running ()
  (dbus-core-call "IsTimerRunning" *timer-id*))

(defun is-active ()
  (dbus-core-call "IsActive" *timer-id*))

(defun state ()
  (dbus-core-call "GetBreakState" *timer-id*))

(defun update ()
  (ignore-errors
   (setf *state* (make-keyword (string-upcase (state))))
   (setf *time-left* (case *state*
                       (:break (- *break-length* (time-idle)))
                       (t (if (> (time-remaining) 0)
                              (time-remaining)
                              (* (time-overdue) -1)))))))

(defun config-get-int (key)
  (dbus-config-call "GetInt" key))

(defun init ()
  (setf *dbus-conn*
	      (dbus:open-connection
	       (make-instance 'iolib.multiplex:event-base) (dbus:session-server-addresses)))

  (dbus:authenticate (dbus:supported-authentication-mechanisms *dbus-conn*)
                     *dbus-conn*)

  (setf *dbus-bus* (make-instance 'dbus::bus
                                  :name (dbus:hello *dbus-conn*)
                                  :connection *dbus-conn*))

  (setf *ui-obj* (dbus:make-object-from-introspection *dbus-conn*
                                                      *ui-path*
                                                      *destination*))

  (setf *core-obj* (dbus:make-object-from-introspection *dbus-conn*
                                                        *core-path*
                                                        *destination*))

  (setf *break-length* (config-get-int (concat "/timers/" *config-timer-id* "/auto_reset")))

  (when *update-interval*
    (run-with-timer 3 *update-interval* #'update)))

(defun workrave ()
  (handler-case (init)
    (t (err)
      (message (format nil "Workrave init error: ~a~%" err)))))


(defun modeline ()
  (let ((time-left-mins (floor *time-left* 60)))
    (case *state*
      (:none (if (> *time-left* 0)
                 (format nil "~2Dm" time-left-mins)
                 (format nil "^(:fg \"#ffffff\")^(:bg \"#991111\")~2Dm^n" time-left-mins)))
      (:break (format nil "^02~3Ds^n" *time-left*)))))


(defcommand workrave-brake () ()
  (dbus:object-invoke *ui-obj* *ui-interface* "RestBreak"))

(defcommand workrave-skip () ()
  (dbus-core-call "SkipBreak" *timer-id*))

(defcommand workrave-postpone () ()
  (dbus-core-call "PostponeBreak" *timer-id*))
