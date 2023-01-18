(defpackage :swat
  (:use #:cl #:stumpwm)
  (:export #:prepare-shell
           #:arun-program
           #:defun-cached))

(in-package :swat)

(defun prepare-shell (&optional (shell "bash"))
  (uiop:launch-program shell :input :stream :output :stream))

(defun arun-program (shell command &optional (wait-output nil))
  (let ((in-stream (uiop:process-info-input shell))
        (out-stream (uiop:process-info-output shell)))

    (write-line command in-stream)

    (force-output in-stream)
    (when wait-output
      (let ((output-string (read-line out-stream)))
        (loop while (listen out-stream)
              do (setf output-string (concatenate 'string output-string
                                                  (format nil "~%")
                                                  (read-line out-stream))))
        output-string))))


(defmacro defun-cached (name seconds args &rest body)
  "Define NAME function with ARGS and BODY.
It is like a usual `defun', except when the function is called, it is
evaluated only if the number of SECONDS has already been passed since
the last call.  If this time has not been passed yet, the previous value
of the function is returned without evaluation.

For example, the following `delayed-time' function will return a new
time string only every 10 seconds:

  (defun-cached
   10 delayed-time ()
   (time-format \"%H:%M:%S\"))
"
  (let ((next-time-var  (make-symbol "next-time"))
        (last-value-var (make-symbol "last-value")))
    `(let ((,next-time-var 0)
           ,last-value-var)
       (defun ,name ,args
         (let ((now (get-universal-time)))
           (if (< now ,next-time-var)
               ,last-value-var
               (setf ,next-time-var (+ now ,seconds)
                     ,last-value-var (progn ,@body))))))))


;; toggle window floating
(defcommand toggle-float () ()
  "Toggle weather window is floating or not"
  (if (typep (current-window) 'STUMPWM::FLOAT-WINDOW)
      (unfloat-this)
      (float-this)))
