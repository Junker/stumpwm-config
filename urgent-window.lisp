(defpackage :urgent-window
  (:use #:cl #:stumpwm)
  (:import-from #:cl-notify
                #:send-notification
                #:define-callback)
  (:export #:raise-urgent
           #:*urgent-window-message*))


(in-package #:urgent-window)

(defvar *urgent-window*)
(defvar *urgent-window-message* "~a needs your attention.")
(defvar *timeout* 7000)
(defvar *window-focus-on-close* nil)

(defun handle-urgent-window (win)
  (send-notification "StumpWM"
                     :body (format nil *urgent-window-message* (window-class win))
                     :app-icon "system"
                     :timeout-in-millis *timeout*))

(define-callback on-close :close (notification-id reason)
  (message "The notification ~a was closed! The reason was ~a" notification-id reason))

;; ==== INIT
(add-hook stumpwm:*urgent-window-hook* #'handle-urgent-window)
