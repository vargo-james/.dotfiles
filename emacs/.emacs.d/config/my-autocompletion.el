
(semantic-mode t)
(diminish 'semantic-mode)

(use-package company
  :diminish company-mode
  :config
  (advice-add 'company-call-frontends :before #'on-off-fci-before-company)
  (define-key evil-insert-state-map (kbd "M-n") #'company-complete)
  (add-hook 'emacs-startup-hook #'global-company-mode)
  (defun on-off-fci-before-company(command)
    (when (string= "show" command)
      (turn-off-fci-mode))
    (when (string= "hide" command)
      (turn-on-fci-mode))))

(provide 'my-autocompletion)
