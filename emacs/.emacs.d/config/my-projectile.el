(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode t)
  (setq projectile-completion-system 'helm)

  (use-package helm-projectile
    :config
    (helm-projectile-on)
    (setq projectile-switch-project-action 'helm-projectile
          projectile-enable-caching t))
  (my-generic-define-key :infix "p"
                         "p" #'helm-projectile-switch-project
                         "b" #'helm-projectile-switch-to-buffer
                         "f" #'helm-projectile-find-file
                         "g" #'helm-projectile-find-file-dwim
                         "s" #'helm-projectile-file-other-file))

(provide 'my-projectile)
