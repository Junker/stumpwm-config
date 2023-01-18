(in-package :junker)

;; use instead of winner-mode:dump-group-to-file. cuz that one shows message "Group dumped" on every command
(defun winner-dump-group-to-file (&rest args)
  (declare (ignore args))
  (let* ((group-number (winner-mode::current-group-number)))
    (winner-mode::check-ids group-number winner-mode::*current-ids* winner-mode::*max-ids*)
    (stumpwm::dump-to-file (dump-group (current-group))
                           (winner-mode::dump-name group-number (incf (gethash group-number winner-mode::*current-ids*))))
    (when (> (gethash group-number winner-mode::*current-ids*)
             (gethash group-number winner-mode::*max-ids*))
      (setf (gethash group-number winner-mode::*max-ids*)
            (gethash group-number winner-mode::*current-ids*)))))

(add-hook stumpwm:*post-command-hook* (lambda (command)
                                        (when (and (member command winner-mode:*default-commands*)
                                                   (eq (type-of (current-group)) 'tilse-group))
                                          (winner-dump-group-to-file))))
