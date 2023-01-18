(in-package :junker)

;; OLD LAPTOP
;; (defvar *laptop-keyboard-xinput-id* "14")
;; (defvar *laptop-touchpad-xinput-id* "11")

(defvar *laptop-keyboard-xinput-id* "13")
(defvar *laptop-touchpad-xinput-id* "12")

(defun xinput-disable-device (id)
  (run-shell-command (concat "xinput disable " id)))

(defun xinput-enable-device (id)
  (run-shell-command (concat "xinput enable " id)))

(defcommand j-laptop-disable-keyboard () ()
  (xinput-disable-device *laptop-keyboard-xinput-id*))

(defcommand j-laptop-disable-touchpad () ()
  (xinput-disable-device *laptop-touchpad-xinput-id*))

(defcommand j-laptop-enable-keyboard () ()
  (xinput-enable-device *laptop-keyboard-xinput-id*))

(defcommand j-laptop-enable-touchpad () ()
  (xinput-enable-device *laptop-touchpad-xinput-id*))
