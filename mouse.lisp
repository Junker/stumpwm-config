(in-package :junker)

;; Focus Follow Mouse
;;(setf *mouse-focus-policy* :sloppy)
(setf stumpwm:*mouse-focus-policy* :click)

;; bugfix for scrolling doesn't work with an external mouse in GTK+3 apps.
(setf (getenv "GDK_CORE_DEVICE_EVENTS") "1")


;; By default StumpWM leaves the cursor as XOrg's standard X shape with the hotspot in the centre. You can have the more usual left-facing pointer
(run-shell-command "xsetroot -cursor_name left_ptr")

;; Grabbed pointer
(setq stumpwm::*grab-pointer-character* 40
      stumpwm::*grab-pointer-character-mask* 41
      stumpwm::*grab-pointer-foreground* (stumpwm::hex-to-xlib-color "#3db270")
      stumpwm::*grab-pointer-background* (stumpwm::hex-to-xlib-color "#2c53ca"))
