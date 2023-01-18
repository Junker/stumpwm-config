(in-package #:stump-nm)

(defvar *dbus-bus* nil)
(defvar *dbus-root* nil)


(defparameter *modeline-fmt* "%e %p"
  "The default value for displaying NM information on the modeline.")

(defparameter *formatters-alist*
  '((#\e  ml-ssid)
    (#\p  ml-strength)))


(defun init ()
  (let ((dbus-conn (dbus:open-connection
	                  (make-instance 'iolib.multiplex:event-base) (dbus:system-server-addresses))))

    (dbus:authenticate (dbus:supported-authentication-mechanisms dbus-conn)
                       dbus-conn)

    (setf *dbus-bus* (make-instance 'dbus::bus
                                    :name (dbus:hello dbus-conn)
                                    :connection dbus-conn))

    (setf *dbus-root* (make-root *dbus-bus*))))

(defun get-active-connection ()
  (first (get-active-connections *dbus-root*)))


(defun get-connection-access-point (conn)
  (if conn
      (when-let ((path (getprop conn "SpecificObject")))
        (when (str:starts-with? "/org/freedesktop/NetworkManager/AccessPoint" path)
          (make-instance 'access-point
                         :path path
                         :bus *dbus-bus*)))))

(defun access-point-strength (ap)
  (getprop ap "Strength"))

(defun modeline (ml)
  (declare (ignore ml))
  (stumpwm:format-expand *formatters-alist*
                         *modeline-fmt*
                         (ignore-errors (get-connection-access-point (get-active-connection)))))

(defun ml-ssid (ap)
  (if ap
      (access-point-ssid ap)
      "no link"))

(defun ml-strength (ap)
  (if ap
      (let ((strength (access-point-strength ap)))
        (format nil "~A~A%" (stumpwm:bar-zone-color strength 80 60 40 t) strength))
      ""))


;; modeline formatter.
(stumpwm:add-screen-mode-line-formatter #\I #'modeline)
