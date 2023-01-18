(defpackage :j/ha
  (:use #:cl)
  (:import-from #:stumpwm
                #:defcommand
                #:concat
                #:bar-zone-color
                #:run-with-timer)
  (:export #:*co2-level*
           #:start-timer
           #:co2-modeline))

(in-package :j/ha)

(defvar *co2-level* 0)
(defvar *ha-host* "homeasistant.local")
(defvar *ha-token* (uiop:run-program "secret-tool lookup api-token home-assistant"
                                     :ignore-error-status t
                                     :output '(:string :stripped t)))

(setf dex:*not-verify-ssl* t)


(defun get-co2-level ()
  (ignore-errors
   (multiple-value-bind (body status) (dex:get (format nil "https://~a/api/states/sensor.~a" *ha-host* "working_room_co2")
                                               :connect-timeout 2
                                               :read-timeout 5
                                               :keep-alive nil
                                               :headers `(("Authorization" . ,(str:concat "Bearer " *ha-token*))
                                                          ("Content-Type" . "application/json")))
     (if (= status 200)
         (multiple-value-bind (result vals) (ppcre:scan-to-strings "\"state\":\\s*\"(\\d+)\.*?\"" body)
           (declare (ignore result))
           (multiple-value-bind (co2) (parse-integer (aref vals 0))
             co2))
         -1))))

(defun co2-modeline ()
  (format nil "^[~A~4D^]" (bar-zone-color *co2-level* 600 800 1000) *co2-level*))

(defun start-timer ()
  (run-with-timer 0 120
                  #'(lambda ()
                      (bt:make-thread (lambda ()
                                        (setf *co2-level* (get-co2-level)))))))
