(in-package :junker)

(defvar *mem-modeline* nil)

(defun fmt-mem-percent (mem)
  (let* ((% (truncate (* 100 (nth 2 mem)))))
    (format nil "^[~A~2D% ^]" (bar-zone-color % 40 65 85) %)))

(setf mem::*mem-formatters-alist* (append mem::*mem-formatters-alist*
                                          '((#\x fmt-mem-percent))))

(setf mem::*mem-modeline-fmt* "%x")

(run-with-timer 0 1
                #'(lambda()
                    (setf *mem-modeline* (mem::mem-modeline nil))))
