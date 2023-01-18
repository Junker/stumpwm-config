(in-package :junker)

(j/load "windows-renumber")

(defparameter *window-class-renumber*
  '(("krusader" . 0)
    ("firefox" . 1)
    ("QOwnNotes" . 2)
    ("KeePassXC" . 3)
    ("Mail" . 0)
    ("RSS" . 1)
    ("Emacs" . 0)
    ("redmine" . 1)
    ("kitty" . 0)))

(defparameter *window-close-confirm-list*
  '("Qemu-system-x86_64"))


;; new window autofocus
(defvar *window-auto-focus-disabled* nil)
(add-hook stumpwm:*new-window-hook* #'(lambda (win)
                                        (when  (and (not *window-auto-focus-disabled*)
                                                    (member (window-type win) '(:normal :dialog))
                                                    (not (eq (window-group win) (current-group))))
                                          (ignore-errors (stumpwm::focus-all win)))))




;; =============== OTHER FUNCSs

(defcommand window-size-decrease () ()
  (when-let* ((window (current-window))
              (w (window-width window))
              (h (window-height window))
              (x (window-x window))
              (y (window-y window)))
	           (stumpwm::float-window-move-resize window
                                                :x (+ x 50)
                                                :y (+ y 50)
                                                :width (- w 100)
                                                :height (- h 100))))


(defcommand window-size-increase () ()
  (when-let* ((window (current-window))
              (w (window-width window))
              (h (window-height window))
              (x (window-x window))
              (y (window-y window)))
	  (stumpwm::float-window-move-resize window
                                       :x (max 0 (- x 50))
                                       :y (max 0 (- y 50))
                                       :width (+ w 100)
                                       :height (+ h 100))))

(defcommand float-window-move-left () ()
  (when-let* ((window (current-window))
              (x (window-x window)))
	  (stumpwm::float-window-move-resize window :x (- x 50))))

(defcommand float-window-move-right () ()
  (when-let* ((window (current-window))
              (x (window-x window)))
	  (stumpwm::float-window-move-resize window :x (+ x 50))))

(defcommand float-window-move-up () ()
  (when-let* ((window (current-window))
              (y (window-y window)))
	  (stumpwm::float-window-move-resize window :y (- y 50))))

(defcommand float-window-move-down () ()
  (when-let* ((window (current-window))
              (y (window-y window)))
	  (stumpwm::float-window-move-resize window :y (+ y 50))))

(defcommand float-window-fullhd () ()
  (float-this)
	(stumpwm::float-window-move-resize (current-window)
                                     :x 1000
                                     :y 1000
                                     :width 1920
                                     :height 1080))

(defcommand j-delete-window (&optional (window (current-window))) ()
  (let ((need-confirm (member (window-class window)
                              *window-close-confirm-list*
                              :test #'string=)))
    (when (or (not need-confirm)
              (and need-confirm (y-or-n-p "Close window?")))
      (delete-window window))))
