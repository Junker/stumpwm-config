(in-package :junker)

(defcommand app-krusader () ()
  (run-or-raise "env QT_AUTO_SCREEN_SCALE_FACTOR=0 krusader" '(:class "krusader")))

(defcommand app-firefox () ()
  (run-or-raise "firefox" '(:class "firefox")))

(defcommand app-keepassxc () ()
  (run-or-raise "env QT_AUTO_SCREEN_SCALE_FACTOR=0 keepassxc" '(:class "KeePassXC")))

(defcommand app-qownnotes () ()
  (run-or-raise "QOwnNotes" '(:class "QOwnNotes")))

(defcommand app-emacs () ()
  (run-or-raise "emacs" '(:class "Emacs")))

(defcommand app-qbittorrent () ()
  (run-or-raise "qbittorrent" '(:class "qBittorrent")))

(defcommand app-telegram () ()
  (run-or-raise "telegram-desktop" '(:class "TelegramDesktop")))

(defcommand app-taskmanager () ()
  (run-or-raise "xfce4-taskmanager" '(:class "Xfce4-taskmanager")))

(defcommand app-thunderbird () ()
  (run-or-raise "thunderbird" '(:class "thunderbird")))

(defcommand app-kitty-ssh () ()
  (run-or-raise "kitty --class SSH --config ~/.config/kitty/kitty-remote.conf" '(:class "SSH")))

(defcommand app-wtfutil () ()
  (run-or-raise "st -f 'Liberation Mono:size=10' -c Wtf -e wtfutil" '(:class "Wtf")))

(defcommand app-mail () ()
  (run-or-raise "kitty --config ~/.config/mail/mics/kitty/kitty.conf --class Mail -e neomutt -F ~/.config/mail/neomutt/init.rc" '(:class "Mail")))

(defcommand app-rss () ()
  (run-or-raise "kitty --config ~/.config/kitty/kitty-single.conf --class RSS -e newsboat" '(:class "RSS")))
