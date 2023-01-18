(defpackage #:lookup
  (:use #:cl #:stumpwm #:alexandria))

(in-package :lookup)

;; Search Engine Lookup
;; (defparameter *search-engine*
;;   "https://www.google.com/search?q=~a")
(defparameter *search-engine*
  "https://search.searx.local/search?q=~a")

(defun %search-lookup ()
  (let ((url (format nil *search-engine*
                     (quri::url-encode (get-x-selection)))))
    (run-shell-command (format nil "xdg-open '~a'" url))))

(defcommand search-lookup () ()
  (%search-lookup))
