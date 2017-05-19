
(use-package helm
  :diminish helm-mode
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
        helm-imenu-fuzzy-match t
        helm-findutils-search-full-path t
        helm-lisp-fuzzy-completion t)

  (helm-autoresize-mode)
  (setq helm-autoresize-max-height 50
        helm-autoresize-min-height 20)
  ;; helm key bindings
  (global-unset-key (kbd "C-x c"))
  (my-generic-define-key "H" #'helm-command-prefix)
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-h SPC") #'helm-all-mark-rings)

  (define-key helm-map (kbd "M-SPC") nil)
  (define-key helm-map (kbd "C-i") #'helm-previous-source)
  (define-key helm-map [tab] #'helm-select-action)
  (general-define-key :prefix "M-SPC"
                      :keymaps 'helm-map
                      "s" #'helm-buffer-save-persistent)

  (general-define-key :keymaps 'shell-mode-map
                      "M-SPC l" 'helm-comint-input-ring)
  (define-key shell-mode-map (kbd "C-c C-l") 'helm-comint-input-ring)
  (define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)
  (general-define-key :prefix "M-SPC"
                      :keymaps 'minibuffer-local-map
                      "l" #'helm-minibuffer-histor)

  (evil-ex-define-cmd "ls" #'helm-mini)
  (evil-ex-define-cmd "buffers" #'helm-mini)

  (my-generic-define-key :infix "h"
                         "TAB" #'helm-resume
                         "b" #'helm-mini
                         "f" #'helm-find-files
                         "g" #'helm-google-suggest
                         "x" #'helm-M-x
                         ":" #'helm-eval-expression
                         ";" #'helm-eval-expression-with-eldoc
                         "y" #'helm-show-kill-ring
                         "s" #'helm-surfraw)

  (add-to-list 'browse-url-firefox-arguments "-private-window")

  (require 'helm-descbinds)
  (helm-descbinds-mode)

  (use-package
    helm-flx
    :init (use-package flx)
    :config
    (helm-flx-mode 1)
    (setq helm-flx-for-helm-find-files t
          helm-flx-for-helm-locate t))

  (use-package helm-swoop
    :commands (helm-swoop
               helm-swoop-back-to-last-point
               helm-multi-swoop
               helm-multi-swoop-all
               helm-swoop-from-isearch
               helm-multi-swoop-all-from-helm-swoop
               helm-multi-swoop-current-mode-from-helm-swoop)

    :init
    (setq helm-swoop-use-line-number-face t)
    (my-generic-define-key :infix "i"
                           "s" #'helm-swoop
                           "b" #'helm-swoop-back-to-last-point
                           "m" #'helm-multi-swoop
                           "a" #'helm-multi-swoop-all)

    (define-key isearch-mode-map (kbd "M-i") #'helm-swoop-from-isearch)
    (define-key evil-motion-state-map (kbd "M-i") #'helm-swoop-from-evil-search)

    (general-define-key :keymaps 'helm-swoop-map
                        "M-i" #'helm-multi-swoop-all-from-helm-swoop
                        "M-m" #'helm-multi-swoop-current-mode-from-helm-swoop
                        "C-r" #'helm-previous-line
                        "C-s" #'helm-next-line)

    (general-define-key :keymaps 'helm-multi-swoop-map
                        "C-r" #'helm-previous-line
                        "C-s" #'helm-next-line))


  (require 'helm-eshell)

  (add-hook 'eshell-mode-hook
            #'(lambda ()
                (general-define-key :keymaps 'eshell-mode-map
                                    :prefix "M-SPC"
                                    "l" #'helm-eshell-history))))

  (provide 'my-helm)
