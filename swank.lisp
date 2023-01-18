(in-package :junker)

(ql:quickload :swank)

(defcommand swank-enable () ()
  (swank-loader:init)
  (swank:create-server :port 4004
                       :style swank:*communication-style*
                       :dont-close t)
  )
