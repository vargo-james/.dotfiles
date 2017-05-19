

;; This call is done in the my-package.el file.  It remains here as a comment
;; so that it will not be automatically added by Package.el.
;; (package-initialize)


;; Path of files to load
(add-to-list 'load-path (concat user-emacs-directory "config"))
(require 'my-package)
;; Configures what happens on save and how backups are managed.
(require 'my-backup-management)
;; M-SPC will be used as a global leader key.
(require 'my-generic-keybindings)
(require 'my-display)
(require 'my-evil)
(require 'my-startup)
(require 'my-org)
(require 'my-autocompletion)
(use-package undo-tree
  :diminish undo-tree-mode)
(diminish 'auto-revert-mode)
(setq shell-command-switch "-c")
(setq browse-url-browser-function #'browse-url-generic
      browse-url-generic-program "firefox-esr")
(use-package haskell-mode)
(require 'my-avys)
(require 'my-lisp)
;; A rad feature.
(use-package expand-region
  :bind ("C-=" . er/expand-region))

(autoload #'my-insert-vertical-space "my-edits" nil t)
(autoload #'my-insert-inverted-vertical-space "my-edits" nil t)
(global-set-key (kbd "C-c o") #'my-insert-vertical-space)
(global-set-key (kbd "C-c O") #'my-insert-inverted-vertical-space)
(require 'my-garbage-collection)
(require 'my-magit)
(require 'my-aggressive-indent)
;; This puts .h files in c++ mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode t)

(require 'my-helm)
(require 'my-projectile)

(use-package flycheck
  :config
  (global-flycheck-mode)
  (global-set-key (kbd "M-SPC q") #'flycheck)
  (my-generic-define-key :infix "q"
                         "n" #'flycheck-next-error
                         "p" #'flycheck-previous-error
                         "l" #'flycheck-list-errors
                         "v" #'flycheck-verify-setup
                         "C" #'flycheck-clear))


(use-package helm-gtags
  :init
  (setq helm-gtags-ignore-case t
        helm-gtags-auto-update t
        helm-gtags-use-input-at-cursor t
        helm-gtags-pulse-at-cursor t
        helm-gtags-prefix-key "\C-cg"
        helm-gtags-suggested-key-mapping t)

  :config
  ;; Enable helm-gtags-mode
  (add-hook 'dired-mode-hook #'helm-gtags-mode)
  (add-hook 'eshell-mode-hook #'helm-gtags-mode)
  (add-hook 'c-mode-hook #'helm-gtags-mode)
  (add-hook 'c++-mode-hook #'helm-gtags-mode)
  (add-hook 'asm-mode-hook #'helm-gtags-mode)

  (define-key helm-gtags-mode-map (kbd "C-c g a")
    #'helm-gtags-tags-in-this-function)
  (define-key helm-gtags-mode-map (kbd "C-j") #'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "M-.") #'helm-gtags-dwim)

  (define-key helm-gtags-mode-map (kbd "M-,") #'helm-gtags-pop-stack)
  (define-key helm-gtags-mode-map (kbd "C-c <") #'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") #'helm-gtags-next-history))

(require 'my-screensaver)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

(put 'downcase-region 'disabled nil)
