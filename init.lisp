(defpackage :junker
  (:use #:cl #:stumpwm)
  (:import-from #:alexandria
                #:when-let
                #:when-let*))

(in-package :junker)


;; (setf stumpwm:*debug-level* 3)
;;DOESN'T WORK PROPERLY (redirect-all-output (data-dir-file "debug-output" "txt"))

(message "INIT STUMPWM")



(setf stumpwm:*startup-message* NIL)

(defvar *config-path* (uiop:native-namestring "~/.config/stumpwm/"))
(defvar *cache-path* (uiop:native-namestring "~/.cache/stumpwm/"))

(defun j/load (filename)
  (load (concat *config-path* filename ".lisp")))

(defvar *4k-screen* (eq (screen-width (current-screen)) 3840))


(j/load "env")

(message "INIT PACKAGE MANAGER")
;; load QuickLisp
(load "~/quicklisp/setup.lisp")
;; (ql-dist:install-dist "http://dist.ultralisp.org/" :prompt nil) ;; only once!
(j/load "qlot") ; read inside
;; (j/load "clpm")


(message "LOAD PACKAGES")
(ql:quickload "str")
(ql:quickload "cl-ppcre")
(ql:quickload "metabang-bind")

;; clx-truetype (from qlot)
;; https://wiki.archlinux.org/title/stumpwm#Set_font_for_messages_and_modeline
(ql:quickload "cacle")
(ql:quickload "clx-truetype")

(ql:quickload "xembed")

;; need pacman -S libfixposix
(ql:quickload "dbus")

;; for module "disk"
(ql:quickload "cl-mount-info")
(ql:quickload "cl-diskspace")

;; for lookup
(ql:quickload "quri")

;; for modeline-ha
(ql:quickload "dexador")
(ql:quickload "dns-client")
(setf org.shirakumo.dns-client:*dns-servers* '("192.168.1.20"))

;; for nuclear
(ql:quickload "cl-json")

;; cl-notify (https://github.com/Lautaro-Garcia/cl-notify)
(ql:quickload "stmx")
(ql:quickload "cl-notify")              ; from  Ultralisp


;; ========== LOAD MODULES
(message "LOAD STUMPWM MODULES")

;; https://github.com/Junker/stumpwm-pamixer
(qlot-load-system "pamixer")

;; https://github.com/Junker/stumpwm-kbdd
(qlot-load-system "kbdd")

;; https://github.com/Junker/stumpwm-acpi-backlight
(qlot-load-system "acpi-backlight")
(when (eq *env* :LAPTOP)
  ;;OLD LAPTOP (acpi-backlight:init "intel_backlight")
  (acpi-backlight:init "amdgpu_bl0")
  (setf acpi-backlight:*step* 10))

;; https://github.com/Junker/stumpwm-screenshot-maim
(qlot-load-system "screenshot-maim")

;; https://github.com/Junker/stumpwm-window-switch
(qlot-load-system "window-switch")

;; https://github.com/Junker/stumpwm-nuclear
(qlot-load-system "nuclear")

;; https://github.com/Junker/stumpwm-rofi
(qlot-load-system "rofi")

;; contrib
(asdf:load-system "ttf-fonts")
(asdf:load-system "cpu")
(asdf:load-system "mem")
(asdf:load-system "disk")
(asdf:load-system "stumptray")
(asdf:load-system "winner-mode")
(asdf:load-system "battery-portable")
;; (asdf:load-system "wifi")
(asdf:load-system "stump-nm")

(message "LOAD CONFIGS")
(j/load "core")
(j/load "swank")
(j/load "swat")
(j/load "lookup")
(j/load "ha")
(j/load "nm")

(j/load "keys")
(j/load "mouse")
(j/load "windows")
(j/load "apps")
(j/load "autostart")
(j/load "ui")
(j/load "frames")
(j/load "workrave")
(j/load "mail")
(j/load "modeline")
(j/load "groups")
(j/load "menu")
;;(j/load "urgent-window")

(when (eq *env* :LAPTOP)
  (j/load "laptop"))
