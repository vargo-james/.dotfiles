;; Enable org-mode
(use-package org
  :init
  (defun my-org-hook ()
    "Sets up the org mode environment."
    (transient-mark-mode 1)
    (diminish 'transient-mark-mode)
    (setq org-catch-invisible-edits 1)
    (org-bullets-mode 1))
  :config
  (progn
    (use-package org-bullets)
    (add-hook 'org-mode-hook #'my-org-hook)))
;; (add-hook 'org-mode-hook (lambda() (transient-mark-mode 1)))
;; (diminish 'transient-mark-mode)
;; (setq org-catch-invisible-edits 1)
;; (use-package org-beautify-theme
;;   :config
;;   (add-hook 'org-mode-hook (lambda () (load-theme 'org-beautify-theme))))
;; (use-package org-bullets
;;   :config
;;   (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))))

(provide 'my-org)
