(in-package :junker)

(run-commands
 "grename Base"
 "gnewbg Mail"
 "gnewbg Console"
 "gnewbg Work"
 "gnewbg Chat"
 "gnewbg Stuff"
 "gnewbg Wtf"
 "gnewbg-dynamic Dynamic"
 "gnewbg-float Float")

(stumpwm::split-frame-eql-parts (stumpwm::find-group (current-screen) "Chat") :column 2)

(defvar *frame-preferences* '(("Base"
                               ;; frame-number raise lock
                               (0 t t :class "firefox")
                               (0 nil t :class "KeePassXC")
                               (0 nil t :class "QOwnNotes"))
                              ("Mail"
                               (0 nil t :class "Mail")
                               (0 nil t :class "tasks-nativefier-78d9b6")
                               (0 nil t :class "RSS"))
                              ("Console"
                               (0 nil t :class "kitty")
                               (0 nil t :class "SSH")
                               (0 nil t :class "xterm"))
                              ("Work"
                               (0 nil t :class "Emacs")
                               (0 nil t :class "Redmine")
                               (0 nil t :class "DBeaver"))
                              ("Chat"
                               (1 nil t :class "TelegramDesktop")
                               (0 nil t :class "Dino"))
                              ("Stuff"
                               (0 nil t :class "qBittorrent")
                               (0 nil t :class "Steam")
                               (0 nil t :class "steam")
                               (0 nil t :class "steam_app")
                               (0 nil t :class "nuclear")
                               (0 nil t :class "Lutris"))
                              ("Wtf"
                               (0 nil t :class "Wtf"))))


(loop for (name . prefs) in *frame-preferences*
      do (eval `(define-frame-preference ,name ,@prefs)))
