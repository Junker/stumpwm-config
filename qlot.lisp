(in-package #:junker)

;; USAGE:
;; first: ros install qlot
;; $ ~/.config/stumpwm/qlot.sh install

;; (stumpwm::init-load-path (concat *config-path* ".qlot/dists"))


(asdf:initialize-source-registry
 `(:source-registry
   (:tree ,(pathname (concat *cache-path* ".qlot/dists")))
   :inherit-configuration))

;; (asdf:load-system "qlot")

(defun qlot-load-system (name)
  (asdf:load-system name))
