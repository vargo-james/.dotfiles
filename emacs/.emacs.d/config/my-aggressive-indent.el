(use-package aggressive-indent
  :diminish aggressive-indent-mode
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  (add-to-list 'aggressive-indent-dont-indent-if
               '(and (derived-mode-p 'c++-mode)
                     (null
                      (string-match "\\([;{}]\\|\\b\\(if\\|for\\|while\\)\\b\\)"
                                    (thing-at-point 'line))))))

(provide 'my-aggressive-indent)
