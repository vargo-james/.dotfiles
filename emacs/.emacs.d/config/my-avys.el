
;; Jumping Around
(use-package avy
  :commands (avy-goto-char-2)
  :config
  (when (and (not (fboundp 'avy--with-avy-keys))
             (fboundp 'avy-with))
    (defalias 'avy--with-avy-keys 'avy-with)))

;; Link following
(use-package ace-link
  :config
  (ace-link-setup-default)
  (define-key org-mode-map (kbd "M-o") #'ace-link-org))

(provide 'my-avys)
