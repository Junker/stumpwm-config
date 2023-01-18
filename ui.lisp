(in-package :junker)

;;; Fonts
;; only first time
(defvar *fonts-cached-lock-file* (concat *cache-path* "fonts-cached.lck"))
(when (not (uiop:file-exists-p *fonts-cached-lock-file*))
  (xft:cache-fonts) ; need to do only once
  (clx-truetype:cache-fonts) ; need to do only once
  (open *fonts-cached-lock-file* :direction :probe :if-does-not-exist :create))

(set-font `(,(make-instance 'xft:font   ;f0
                            :family "Liberation Mono"
                            :subfamily "Regular"
                            :size 10
                            :antialias t)
             ,(make-instance 'xft:font  ;f1
                             :family "siji"
                             :subfamily "Medium"
                             :size 10
                             :antialias t)
             ,(make-instance 'xft:font  ;f2
                             :family "Economica"
                             :subfamily "Regular"
                             :size 10
                             :antialias t)
             ,(make-instance 'xft:font  ;f3
                             :family "Fira Sans Compressed Light"
                             :subfamily "Regular"
                             :size 9
                             :antialias t)))


;;; Theme
(setf stumpwm:*colors*
      '("#000000"   ;black
        "#BF6262"   ;red
        "#a1bf78"   ;green
        "#dbb774"   ;yellow
        "#7D8FA3"   ;blue
        "#ff99ff"   ;magenta
        "#53cdbd"   ;cyan
        "#b7bec9")) ;white

(setf stumpwm:*default-bg-color* "#e699cc")

(update-color-map (current-screen))

;;; Basic Settings
(setf stumpwm::*message-window-gravity* :center
      stumpwm::*input-window-gravity* :center
      stumpwm::*window-border-style* :thin
      stumpwm::*message-window-padding* 10
      stumpwm::*message-window-y-padding* 10
      stumpwm::*maxsize-border-width* 2
      stumpwm::*normal-border-width* 2
      stumpwm::*transient-border-width* 2
      stumpwm::*float-window-border* 1
      stumpwm::*float-window-title-height* 15
      stumpwm::*hidden-window-color* "^(:fg \"#887888\")")
