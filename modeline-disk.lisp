(in-package :junker)

(defun disk-name (path)
  (if (string= path "/")
      path
      (str:substring 5 t path)))

(defun disk-free (path)
  (let* ((bytes (disk::disk-get-available-size-as-number path))
         (terabytes (/ bytes (expt 1024 4)))
         (gigabytes (floor (* terabytes 1024))))
    (cond ((< gigabytes 5) (format nil "^[^(:fg \"#ff3333\")~dGB^]" gigabytes))
          ((> terabytes 1) (format nil "~,2fTB" terabytes))
          (t (format nil "~dGB" gigabytes)))))

(swat:defun-cached disk-modeline 30 ()
  (disk::disk-modeline nil))

(setf disk::*disk-formatters-alist* (append disk::*disk-formatters-alist*
                                            '((#\x disk-free)
                                              (#\y disk-name))))

(setf disk::*disk-modeline-fmt* "^(:fg \"#37e468\")^f1^f2^n%x^f0"
      disk::*disk-usage-paths* '("/" "/mnt/hard2"))
