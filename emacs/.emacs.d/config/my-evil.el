(use-package evil
  :init
  (setq evil-shift-width 2)
  :config
  ;; Vim style searching
  (evil-select-search-module 'evil-search-module #'evil-search)
  (setq evil-ex-search-case 'smart)

  ;; {count}gcc or gc{motion} comments out range.
  (use-package evil-commentary
    :diminish evil-commentary-mode
    :config
    (evil-commentary-mode))

  ;; gx{motion} gx{motion} to exchange text regions. gX cancels.
  (use-package evil-exchange
    :config
    (evil-exchange-install))

  ;; Extends the functionality of % motion.
  (use-package evil-matchit
    :diminish evil-matchit-mode
    :config
    (global-evil-matchit-mode 1))

  ;; y[sS]{text-object}{trigger-char} -- adds corresponding tags.
  ;; g?S{text-object}{trigger}  -- same, visual state
  ;; If trigger-char = f, you can enter a function name and
  ;; make the text a function call.
  ;; cs{text-object}{new-trigger} -- changes surround.
  ;; ds{text-object} -- deletes surround
  (use-package evil-surround
    :diminish evil-surround-mode
    :config
    (global-evil-surround-mode)
    (add-hook 'cpp-mode-hook
              #'(lambda ()
                  (push '(?< . ("< " . " >")) evil-surround-pairs-alist)
                  (push '(?> . ("<" . ">")) evil-surround-pairs-alist))))
  ;; vii, vai, viI, vaI, viJ, vaJ
  (use-package evil-indent-plus
    :config
    (evil-indent-plus-default-bindings))

  ;; In case we do get in emacs state, we can get back with escape.
  (define-key evil-emacs-state-map [escape] #'evil-normal-state)

  (dolist (kmap '(evil-emacs-state-map
                  evil-insert-state-map
                  evil-visual-state-map) nil)
    (key-chord-define (eval kmap) "jk" #'evil-normal-state))

  (add-hook 'minibuffer-setup-hook
            (lambda ()
              (key-chord-define-local "jk" #'abort-recursive-edit)))

  (define-key evil-normal-state-map (kbd "C-b") #'evil-visual-block)

  (defhydra hydra-scroll nil "Scroll"
    ("v" evil-scroll-down nil)
    ("c" evil-scroll-up nil))

  (general-nmap :prefix "SPC"
                "v" #'hydra-scroll/body)


  ;; ;; We use emacs scrolling bindings
  ;; (general-define-key :keymaps '(evil-motion-state-map evil-insert-state-map)
  ;;                     "C-v" #'scroll-up-command
  ;;                     "C-a" #'move-beginning-of-line
  ;;                     "C-e" #'move-end-of-line
  ;;                     "C-d" #'delete-char
  ;;                     "C-k" #'kill-line
  ;;                     "C-y" #'yank
  ;;                     "C-n" #'next-line
  ;;                     "C-p" #'previous-line)

  ;; This flips the on switch.
  (evil-mode t))

(provide 'my-evil)
