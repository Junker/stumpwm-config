sudo pacman -S libfixposix --needed
paru -S siji-ttf --needed
paru -S ttf-economica --needed
sudo pacman -S ttf-fira-sans --needed
paru -S bgs-git --needed

sbcl --load '/usr/share/quicklisp/quicklisp.lisp' --eval '(quicklisp-quickstart:install)' --quit
sbcl --load "$HOME/quicklisp/setup.lisp" --eval '(ql-dist:install-dist "http://dist.ultralisp.org/" :prompt nil)' --quit
sh ./update.sh
