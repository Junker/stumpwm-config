(in-package :junker)

;; ====== HOTKEYS ===========
;; Free hotkeys
;; F3,F5->F12
;; C-1->C-0
;; M-1->M-0
;;


(set-prefix-key (kbd "s-t"))

(defun list-define-keys (map alist)
  "define key using alist."
  (loop for (key . command) in alist
        do (define-key map (kbd key) command)))

;; (define-key *top-map* (kbd "s-Left") "pull-hidden-previous")
;; (define-key *top-map* (kbd "s-Right") "pull-hidden-next")
(list-define-keys stumpwm:*top-map*
                  '(("s-Return" . "only")
                    ("s-r" . "iresize")

                    ("s-;" . "colon")

                    ("s-1" . "gselect Base")
                    ("s-2" . "gselect Mail")
                    ("s-3" . "gselect Console")
                    ("s-4" . "gselect Work")
                    ("s-F1" . "gselect Chat")
                    ("s-F2" . "gselect Stuff")
                    ("s-F3" . "gselect Dynamic")
                    ("s-F4" . "gselect Float")
                    ("s-F5" . "gselect Wtf")

                    ("s-C-Tab" . "exec rofi -show window -theme lb")
                    ("s-Tab" . "select-previous-window")
                    ("s-C-1" . "select-window-by-number 1")
                    ("s-C-2" . "select-window-by-number 2")
                    ("s-C-3" . "select-window-by-number 3")
                    ("s-C-4" . "select-window-by-number 4")
                    ("s-C-5" . "select-window-by-number 5")
                    ("s-C-6" . "select-window-by-number 6")
                    ("s-C-7" . "select-window-by-number 7")
                    ("s-C-8" . "select-window-by-number 8")
                    ("s-C-9" . "select-window-by-number 9")

                    ("s-u" . "next-urgent")

                    ("s-minus" . "vsplit")
                    ("s-backslash" . "hsplit")

                    ("s-f" . "toggle-float")

                    ("s-s" . "search-lookup")

                    ("XF86AudioRaiseVolume" . "pamixer-volume-up")
                    ("XF86AudioLowerVolume" . "pamixer-volume-down")
                    ("XF86AudioMute" . "pamixer-toggle-mute")
                    ("s-KP_Add" . "pamixer-volume-up")
                    ("s-KP_Subtract" . "pamixer-volume-down")

                    ;; Nuclear
                    ("XF86AudioPlay" . "nuclear-play-pause")
                    ("XF86AudioPrev" . "nuclear-previous")
                    ("XF86AudioNext" . "nuclear-next")
                    ("XF86AudioStop" . "nuclear-stop")

                    ("XF86Calculator" . "exec rofi -show calc -modi calc -no-show-match -no-sort")

                    ("s-`" . "exec rofi -modi 'drun,run' -show drun -show-icons -theme fancy")
                    ("s-a" . "exec rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'")
                    ("s-p" . "exec keepmenu")
                    ("s-l" . "exec loginctl lock-session")

                    ("s-x" . "j-menu")

                    ("s-Pause" . "exec dunstctl close-all")
                    ("s-M-Pause" . "exec dunstctl history-pop")

                    ("s-M-KP_Add" . "window-size-increase")
                    ("s-M-KP_Subtract" . "window-size-decrease")

                    ("XF86MonBrightnessUp" . "backlight-up")
                    ("XF86MonBrightnessDown" . "backlight-down")
                    ("s-S-KP_Add" . "backlight-up")
                    ("s-S-KP_Subtract" . "backlight-down")

                    ("Print" . "screenshot")
                    ("C-Print" . "screenshot-window")
                    ("M-Print" . "screenshot-area")


                    ("s-Escape". "j-delete-window")
                    ("s-C-Escape". "kill-window")))

(list-define-keys stumpwm::*tile-group-top-map*
                  '(("s-M-Left" . "move-window left")
                    ("s-M-Right" . "move-window right")
                    ("s-M-Down" . "move-window down")
                    ("s-M-Up" . "move-window up")
                    ("s-C-Left" . "move-focus left")
                    ("s-C-Right" . "move-focus right")
                    ("s-C-Up" . "move-focus up")
                    ("s-C-Down" . "move-focus down")
                    ("s-C-q" . "move-focus left")
                    ("s-C-w" . "move-focus right")
                    ("s-Left" . "prev-in-frame")
                    ("s-Right" . "next-in-frame")
                    ("s-w" . "next-in-frame")
                    ("s-q" . "prev-in-frame")
                    ("s-W" . "next")
                    ("s-Q" . "prev")
                    ("s-S-Left" . "next")
                    ("s-S-Right" . "prev")))

(list-define-keys stumpwm::*float-group-top-map*
                  '(("s-Left" . "prev")
                    ("s-Right" . "next")
                    ("s-w" . "next")
                    ("s-q" . "prev")
                    ("s-M-Left" . "float-window-move-left")
                    ("s-M-Right" . "float-window-move-right")
                    ("s-M-Down" . "float-window-move-down")
                    ("s-M-Up" . "float-window-move-up")))

(defparameter *junker-map* (make-sparse-keymap))
(define-key stumpwm:*top-map* (kbd "s-z") *junker-map*)
(list-define-keys *junker-map*
                  '(("1" . "gmove-and-follow Base")
                    ("2" . "gmove-and-follow Mail")
                    ("3" . "gmove-and-follow Console")
                    ("4" . "gmove-and-follow Work")
                    ("F1" . "gmove-and-follow Chat")
                    ("F2" . "gmove-and-follow Stuff")
                    ("F3" . "gmove-and-follow Dynamic")
                    ("F4" . "gmove-and-follow Float")

                    ("f" . "app-firefox")
                    ("Cyrillic_a" . "app-firefox")

                    ("k" . "app-krusader")
                    ("Cyrillic_el" . "app-krusader")

                    ("p" . "app-keepassxc")
                    ("Cyrillic_ze" . "app-keepassxc")

                    ("q" . "app-qownnotes")
                    ("Cyrillic_shorti" . "app-qownnotes")

                    ("m" . "app-thunderbird")

                    ("Left" . "winner-undo")
                    ("Right" . "winner-redo")))
