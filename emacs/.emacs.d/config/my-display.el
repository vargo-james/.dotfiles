;; Display
(set-frame-font "Inconsolata 14" nil t)
;; Disable the menu bar
(menu-bar-mode -1)
;; Maximize frame on startup.
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; Hide toolbar
(tool-bar-mode -1)
;; No scrollbars
(set-scroll-bar-mode nil)
;; Make the fringe clear
(set-face-attribute 'fringe nil
                    :foreground (face-foreground 'default)
                    :background (face-background 'default))

(use-package powerline
  :config
  (powerline-center-evil-theme))

;; Hide startup messages
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)

;; Line numbering
(add-hook 'prog-mode-hook #'linum-mode)
(use-package linum-relative
  :commands linum-relative-toggle
  :init
  (general-define-key :states 'normal
                      "R" #'linum-relative-toggle))

(show-paren-mode 1)

(setq default-fill-column 79)
(use-package fill-column-indicator
  :config
  (add-hook 'prog-mode-hook #'turn-on-fci-mode)
  (add-hook 'text-mode-hook #'turn-on-fci-mode)
  (add-hook 'org-mode-hook #'turn-off-fci-mode 'append))

;; Tabs
(setq-default indent-tabs-mode nil
              default_tab_width 2)

(global-visual-line-mode)

;; Color scheme
(use-package color-theme-sanityinc-tomorrow
  :config
  (load-theme 'sanityinc-tomorrow-bright t))

(provide 'my-display)
