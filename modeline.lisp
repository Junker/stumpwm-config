(in-package :junker)

(j/load "modeline-group")
(j/load "modeline-disk")
(j/load "modeline-mem")
(j/load "modeline-cpu")
(j/load "modeline-pamixer")
(j/load "modeline-battery")
(j/load "modeline-date")
(j/load "modeline-windows")

;; Modeline

(setf stumpwm:*mode-line-background-color* (car *colors*)
      stumpwm:*mode-line-foreground-color* (car (last *colors*))
      stumpwm:*mode-line-highlight-template* "^(:bg \"#003e6b\")^(:fg \"#eeeeee\")~A^n"
      stumpwm:*mode-line-border-color* "#3d3d3d"
      stumpwm:*mode-line-border-width* 1
      stumpwm:*mode-line-position* :bottom
      stumpwm:*mode-line-timeout* 1
      stumpwm:*mode-line-pad-y* 5)

(setf stumptray::*tray-placeholder-pixels-per-space* (if *4k-screen*
                                                         12
                                                         8))

(kbdd:kbdd)
(setf kbdd:*locales* '((0 . :EN) (1 . :RU)))

(when (eq *env* :PC)
  (j/ha:start-timer)
  (j/mail:start-timer)
  (sleep 2) ; for workrave, need to wait
  (j/workrave:workrave))

(when (eq *env* :LAPTOP)
  (stump-nm::init))


(defun ml-current-window-name ()
  (str:shorten 150 (str:replace-all "^" " " (window-title (current-window)))))

(defun ml-formatted-current-window-title ()
  (when (current-window)
    (concat "  ^(:fg \"#202020\")^f1 ^(:fg \"#575453\")^f3" (window-title (current-window)) "^f0^n")))

(setf stumpwm:*screen-mode-line-format*
      (append
       (list
        *ml-group-string*                ; [group]
        "%W"                             ; windows
        '(:eval (ml-formatted-current-window-title)) ; current-window name
        "^>"                             ; to right side
        "%P") ; pamixer
       (when (eq *env* :LAPTOP)
         (list " ^(:fg \"#5c5ece\")^f1^f2^n%I^f0^n" ; WIFI
               " ^(:fg \"#bc4e4e\")^f1^f2^n%Q^f0^n" ; Backlight
               " ^(:fg \"#7c3eae\")^f1^f2^n%B^f0^n")) ; Battery
       (when (eq *env* :PC)
         (list " ^(:fg \"#874450\")^f1^f2^n" '(:eval (j/workrave:modeline)) "^f0^n"  ; Workrave
               " ^(:fg \"#37a4a0\")^f1^f2^n" '(:eval (j/ha:co2-modeline)) "^f0^n"    ; CO2
               " ^(:fg \"#cccccc\")^f1^f2^n" '(:eval (j/mail:modeline)) "^f0^n"))    ; Mail
       (list
        " |"
        " " '(:eval *cpu-modeline*)  ; CPU
        " ^(:fg \"#ee8f00\")^f1^f2^n" '(:eval *mem-modeline*) "^f0^n") ; Memory
       (when (eq *env* :PC)
         (list " | " '(:eval (disk-modeline))))   ; Disk
       (list
        "^(:bg \"#27273a\") ^B^f2%L^f0 ^n"      ; keyboard layout KBDD
        " ^f2%d^f0"                             ; date
        "%T")                                   ; stumptray
       ))

(enable-mode-line (current-screen) (current-head) t)

;; Tray
(stumptray::stumptray)
