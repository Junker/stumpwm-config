(in-package :junker)

(defun ml-group-on-click (code id &rest rest)
  (declare (ignore rest))
  (declare (ignore id))
  (let ((button (stumpwm::decode-button-code code)))
    (case button
      ((:left-button)
       (j-menu))
      ((:wheel-up)
       (gprev))
      ((:wheel-down)
       (gnext)))))

(register-ml-on-click-id :ml-group-on-click #'ml-group-on-click)

(defvar *ml-group-string* (format-with-on-click-id "^(:bg \"#202020\")[^B%n^b]^n^(:fg \"#202020\")^f1^f0^n" :ml-group-on-click nil))
