;; Check out hydra, ace-window, other abo-abo projects
;; Learn dired, mail client, see about controlling Firefox
;; Check out Semantic

(add-to-list 'load-path (concat user-emacs-directory "config"))
;; Package managment
;; Secure package downloads
(setq tls-checktrust t)
(let ((trustfile
       (replace-regexp-in-string
        "\\\\" "/"
        (replace-regexp-in-string
         "\n" ""
         (shell-command-to-string "python -m certifi")))))
  (setq tls-program
        (list
         (format "gnutls-cli%s --x509cafile %s -p %%p %%h"
                 (if (eq window-system 'w32) ".exe" "") trustfile))))
(if (boundp 'gnutls-verify-error) (setq gnutls-verify-error t))
(if (boundp 'gnutls-trustfiles) (setq gnutls-trustfiles (list trustfile)))

;; Garbage collection tuning
(setq gc-cons-threshold 20000000)

;; The package managing package
(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")
        ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/"))

      package-archive-priorities
      '(("melpa-stable" . 10)
        ("gnu"     . 5)
        ("melpa"        . 0))) 

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)

(eval-when-compile
  (require 'use-package))

;; Shell Commands
(setq shell-command-switch "-ic")

;; Display
;; Maximize frame on startup.
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; Color scheme
(load-theme 'manoj-dark)
;; Hide toolbar
(tool-bar-mode -1)
;; Hide startup messages
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)

;; Tabs
(setq-default indent-tabs-mode nil
	      tabs-width 8)
(visual-line-mode 1)
(setq require-final-newline t)

;; Key binding packages
;; Easy evil state key bindings
(use-package general
  :config
  (general-evil-setup)
  )
;; Key chords
(use-package key-chord
  :config
  (key-chord-mode 1)
  )

;; A minor mode for improved elisp editing and information
(use-package elisp-slime-nav
  :init
  (defun my-lisp-hook ()
    "Activates elisp-slime-nav-mode and turns on the docs"
    (elisp-slime-nav-mode)
    (eldoc-mode)
    )
  :config
  (add-hook 'emacs-lisp-mode-hook 'my-lisp-hook)
  (general-nmap "K" 'elisp-slime-nav-describe-elisp-thing-at-point)
  )

;; A rad feature.
(use-package expand-region
  :bind ("C-=" . er/expand-region)
  )

(general-nmap "C-u" 'evil-scroll-up)

(use-package evil
  :init
  ;; Overriding/intercept maps override the evil key bindings.
  ;; I don't want that.
  ;; (setq evil-overriding-maps nil
  ;;       evil-intercept-maps nil)
  (setq evil-shift-width 2)
  :config
  ;; {count}gcc or gc{motion} comments out range.
  (use-package evil-commentary
    :config
    (evil-commentary-mode))

  ;; gx{motion} gx{motion} to exchange text regions. gX cancels.
  (use-package evil-exchange
    :config
    (evil-exchange-install))

  ;; Extends the functionality of % motion.
  (use-package evil-matchit
    :config
    (global-evil-matchit-mode 1))

  ;; y[sS]{text-object}{trigger-char} -- adds corresponding tags.
  ;; g?S{text-object}{trigger}  -- same, visual state
  ;; If trigger-char = f, you can enter a function name and make the text a function call.
  ;; cs{text-object}{new-trigger} -- changes surround.
  ;; ds{text-object} -- deletes surround
  (use-package evil-surround
    :config
    (global-evil-surround-mode)
    (add-hook 'cpp-mode-hook (lambda ()
                               (push '(?< . ("< " . " >")) evil-surround-pairs-alist)
                               (push '(?> . ("<" . ">")) evil-surround-pairs-alist)
                               )
              )
    )
  ;; vii, vai, viI, vaI, viJ, vaJ
  (use-package evil-indent-plus
    :config
    (evil-indent-plus-default-bindings))

  ;; In case we do get in emacs state, we can get back with escape.
  (define-key evil-emacs-state-map [escape] 'evil-normal-state)
  (general-define-key :keymaps 'evil-insert-state-map
                      (general-chord "jk") 'evil-normal-state
                      (general-chord "kj") 'evil-normal-state)

  ;; We want the normal state to be the default all the time.
  ;; (setq evil-emacs-state-modes nil)
  ;; (setq evil-motion-state-modes nil)

  ;; Vim style searching
  (evil-select-search-module 'evil-search-module 'evil-search)
  (setq evil-ex-search-case 'sensitive)

  ;; This flips the on switch.
  (evil-mode t)
  )

;; Line numbering
(add-hook 'prog-mode-hook 'linum-mode)
(use-package linum-relative
  :config
  (general-nmap "R" 'linum-relative-toggle)
  )
  
;; Keybindings
;; Elisp evaluation
(general-nmap :prefix "SPC"
              "el" 'eval-last-sexp
              "ed" 'eval-defun
              "er" 'eval-region)
;; Window navigation
(general-nmap "C-h" 'evil-window-left
              "C-j" 'evil-window-down
              "C-k" 'evil-window-up
              "C-l" 'evil-window-right)

;; Hide highlights. I never liked using Z commands to quit.
(general-nmap "Z" 'evil-ex-nohighlight)

(evil-ex-define-cmd "ls" 'helm-mini)
(evil-ex-define-cmd "buffers" 'helm-mini)

;; Some helm key bindings
(general-nmap :prefix "SPC"
              "ls" 'helm-mini
              "ff" 'helm-find-files
              "gg" 'helm-google-suggest
              "sr" 'helm-surfraw)

(use-package magit
  :config
  (evil-set-initial-state 'magit-mode 'normal)
  (evil-set-initial-state 'magit-status-mode 'normal)
  (evil-set-initial-state 'magit-diff-mode 'normal)
  (evil-set-initial-state 'magit-log-mode 'normal)
  (evil-define-key 'normal magit-mode-map
    "j" 'magit-goto-next-section
    "k" 'magit-goto-previous-section)
  (evil-define-key 'normal magit-log-mode-map
    "j" 'magit-goto-next-section
    "k" 'magit-goto-previous-section)
  (evil-define-key 'normal magit-diff-mode-map
    "j" 'magit-goto-next-section
    "k" 'magit-goto-previous-section))

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode t)


(semantic-mode t)

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package helm
  :config
  (require 'helm-config)
  (helm-mode 1)
  (setq helm-split-window-in-side-p t
        helm-move-to-line-cycle-in-source t
        helm-scroll-amount 8
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t
        helm-M-x-fuzzy-match t
        helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match t)
  
  (helm-autoresize-mode)
  (setq helm-autoresize-max-height 50
        helm-autoresize-min-height 20)
  ;; helm key bindings
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "C-x C-b") 'helm-mini)
  (global-set-key (kbd "C-c h g g") 'helm-google-suggest)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)

  (add-to-list 'browse-url-firefox-arguments "-private-window")
  ;; semantic key bindings
  
  (use-package helm-flx
    :init
    (use-package flx)
    :config
    (helm-flx-mode +1)
    (setq helm-flx-for-helm-find-files t
          helm-flx-for-helm-locate t))

  (require 'helm-eshell)
  (add-hook 'eshell-mode-hook
            #'(lambda ()
                (define-key eshell-mode-map (kbd "C-c C-l")  'helm-eshell-history)))

  (use-package projectile
    :config
    (projectile-mode t)
    (setq projectile-completion-system 'helm))

  (use-package helm-projectile
    :config
    (helm-projectile-on)
    (setq projectile-switch-project-action 'helm-projectile
          projectile-enable-caching t))
    (general-nmap :prefix "SPC"
                  "pp" 'helm-projectile-switch-project
                  "pb" 'helm-projectile-switch-to-buffer
                  "pf" 'helm-projectile-find-file)
  )


(setq helm-gtags-ignore-case t
      helm-gtags-auto-update t
      helm-gtags-use-input-at-cursor t
      helm-gtags-pulse-at-cursor t
      helm-gtags-prefix-key "\C-cg"
      helm-gtags-suggested-key-mapping t)

(use-package helm-gtags
  :config
  ;; Enable helm-gtags-mode
  (add-hook 'dired-mode-hook 'helm-gtags-mode)
  (add-hook 'eshell-mode-hook 'helm-gtags-mode)
  (add-hook 'c-mode-hook 'helm-gtags-mode)
  (add-hook 'c++-mode-hook 'helm-gtags-mode)
  (add-hook 'asm-mode-hook 'helm-gtags-mode)

  (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
  (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
  
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
  (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history))


(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

(put 'downcase-region 'disabled nil)
