(in-package :junker)

;; CHECK systemd user units: systemctl list-unit-files --state=enabled --user
(defvar *autostart-commands*
  '(;; =============== GET FROM /etc/xdg/autostart/
    ;; STARTED FROM SYSTEMD "gnome-keyring-daemon --start --components=ssh,secrets,pkcs11"

    "exec gsettings-data-convert"

    ;; ================

    ;; "/usr/lib/pam_kwallet_init" ; unlock kwallet
    "exec systemctl --user start dunst.service"  ; notification daemon
    "exec xset s 540 59"     ;screensaver settings (xss-lock dimmer)

    "exec bgs /usr/share/backgrounds/archlinux/simple.png"


    ;; greenclip start TEMP
    "exec sleep 20 && systemctl --user start greenclip.service"

    ;; XKB LAYOUT PER WINDOW
    "exec kbdd"

    "app-krusader"
    "exec mictray"
    "exec pa-notify"
    "exec crow"

    ;; KEYBOARD DELAYS
    "exec xset r rate 250 20"
    "exec xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock"
    ))

;; ==== PC
(defvar *pc-autostart-commands*
  '(
    "exec numlockx"
    "exec system-config-printer-applet"

    ;; REMAP MOUSE BUTTONS
    "exec xbindkeys -f ~/.xbindkeysrc"

    "exec workrave"
    ))

;; ==== LAPTOP
(defvar *laptop-autostart-commands*
  '("exec nm-applet"))


(defun run-shell-commands (cmd-list)
  (dolist (cmd cmd-list)
    (run-shell-command cmd)))

(mapcar #'run-commands *autostart-commands*)

(when (eq *env* :PC)
  (mapcar #'run-commands *pc-autostart-commands*))

(when (eq *env* :LAPTOP)
  (mapcar #'run-commands *laptop-autostart-commands*))

;; ============= START ALL
(defvar *startall-commands*
  '("app-keepassxc"
    "app-firefox"
    "exec kitty"
    "app-emacs"
    "app-kitty-ssh"
    "app-telegram"
    "exec dino"))

(defvar *pc-startall-commands*
  '(
    ;; "nvidia-settings --assign CurrentMetaMode=\"DP-2: nvidia-auto-select +0+0 {AllowGSYNCCompatible=On}\"" ; enable G-SYNC
    "exec nextcloud"
    "app-mail"
    "app-wtfutil"
    "app-rss"
    "app-qownnotes"))

(defvar *laptop-startall-commands*
  '())

(defcommand j-start-all () ()
  (setf *window-auto-focus-disabled* t)

  (mapcar #'run-commands *startall-commands*)
  (when (eq *env* :PC)
    (mapcar #'run-commands *pc-startall-commands*))
  (when (eq *env* :LAPTOP)
    (mapcar #'run-commands *laptop-startall-commands*))

  (run-with-timer 15 nil #'(lambda ()
                             (setf *window-auto-focus-disabled* nil))))
