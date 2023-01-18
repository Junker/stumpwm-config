(in-package :junker)

(defvar *renumber-window-commands* '(gmove-and-follow))

(defun renumber-window-by-class (win)
  "Renumber window if its class matches *window-class-renumber*."

  (when-let* ((class (window-class win))
              (target-number (cdr (assoc class *window-class-renumber*
                                         :test #'string=))))

             (let ((other-win (find-if #'(lambda (win)
                                           (= (window-number win) target-number))
                                       (group-windows (window-group win)))))
               (if other-win
                   (when (string-not-equal class (window-class other-win))
                     ;; other window, different class; switch numbers
                     (setf (window-number other-win) (window-number win))
                     (setf (window-number win) target-number))
                   ;; if there's already a window of this class, do nothing.
                   ;; just keep the new number for this window.

                   ;; else: no other window; target number is free.
                   (setf (window-number win) target-number))

               ;; finally
               (stumpwm::update-all-mode-lines))))



(add-hook stumpwm:*new-window-hook* #'renumber-window-by-class)

;; Heavy multitasking can result in gaps in your window ordering.
;; This hook automatically repacks your windows when one is killed or withdrawn:
(add-hook stumpwm:*destroy-window-hook*
          #'(lambda (win) (repack-window-numbers)))

(add-hook stumpwm:*post-command-hook*
          #'(lambda (command)
              (when (member command *renumber-window-commands*)
                (renumber-window-by-class (current-window)))))
