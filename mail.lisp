(defpackage :j/mail
  (:use #:cl #:stumpwm)
  (:export #:start-timer
           #:*unread-count*
           #:modeline))

(in-package :j/mail)

(defvar *unread-count* 0)
(defvar *notmuch-config-path* "~/.config/mail/notmuch")

(defun get-unread-count (name)
  (parse-integer
   (uiop:run-program (format nil "notmuch --config ~A/~A.conf search 'folder:important and tag:unread' | wc -l" *notmuch-config-path* name)
                     :output '(:string :stripped t))))

(defun start-timer ()
  (run-with-timer 0 10
                  #'(lambda ()
                      (bt:make-thread (lambda ()
                                        (setf *unread-count*
                                              (+ (get-unread-count "personal")
                                                 (get-unread-count "work"))))))))


(defun modeline ()
  (format nil "^[~A~2D^]" (bar-zone-color *unread-count* 0 1 5) *unread-count*))
