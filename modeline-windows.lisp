(in-package :junker)

(defparameter *modeline-window-display-name-list* '(("redmine-nativefier-bab3c7" . "Redmine")
                                                    ("tasks-nativefier-78d9b6" . "Tasks")))


(defun ml-window-display-name (window)
  (or (cdr (assoc (window-class window)
                  *modeline-window-display-name-list*
                  :test #'string=))
      (window-class window)))

(setq stumpwm:*window-formatters* (cons '(#\Z ml-window-display-name) stumpwm:*window-formatters*))
(setq stumpwm:*window-format* " ^B%n^b.%30Z ")
