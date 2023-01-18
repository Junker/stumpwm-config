(in-package :junker)

(defun open-calendar-app ()
  (run-shell-command "gsimplecal"))

(defun ml-date-on-click (code id &rest rest)
  (declare (ignore rest))
  (declare (ignore id))
  (let ((button (stumpwm::decode-button-code code)))
    (case button
      ((:left-button)
       (open-calendar-app)))))

(register-ml-on-click-id :ml-date-on-click #'ml-date-on-click)

(setf stumpwm:*time-modeline-string*
      (format-with-on-click-id "%a %e/%m %k:%M:%S"
                               :ml-date-on-click nil))
