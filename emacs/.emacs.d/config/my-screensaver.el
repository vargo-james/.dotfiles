(require 'zone)
(require 'zone-nyan)
(setq zone-programs [zone-nyan])
(zone-when-idle (* 60 5))

(provide 'my-screensaver)
