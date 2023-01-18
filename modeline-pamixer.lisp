(in-package :junker)

(defvar *pamixer-shell* (swat:prepare-shell))

;; redefine
(defun pamixer::run (args &optional (wait-output nil))
  (swat:arun-program *pamixer-shell* (concat "pamixer " args) wait-output))


(setf pamixer:*modeline-fmt* "^(:fg \"#00baff\")^f1^f2^n%v^f0")
(setf pamixer:*allow-boost* (eq *env* :LAPTOP))
