(in-package :junker)

(defvar *cpu-modeline* nil)

(defun ml-cpu-on-click (code id &rest rest)
  (declare (ignore rest))
  (declare (ignore id))
  (let ((button (stumpwm::decode-button-code code)))
    (case button
      ((:left-button)
       (app-taskmanager)))))

(register-ml-on-click-id :ml-cpu-on-click #'ml-cpu-on-click)


(setf cpu::*cpu-modeline-fmt* "%c")
(setf cpu::*cpu-usage-modeline-fmt* (format-with-on-click-id "^(:fg \"#97e400\")^f1^f2^n^[~A~3D% ^]^f0^n"
                                                             :ml-cpu-on-click nil))

(run-with-timer 0 1
                #'(lambda()
                    (setf *cpu-modeline* (cpu::cpu-modeline nil))))
