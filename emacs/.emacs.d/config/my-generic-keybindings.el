
(global-unset-key (kbd "M-SPC"))
(global-set-key (kbd "M-SPC SPC") #'just-one-space)
(global-set-key (kbd "M-SPC M-SPC") #'keyboard-quit)

(general-create-definer my-generic-define-key
                        :states '(motion insert emacs)
                        :prefix "SPC"
                        :global-prefix "M-SPC")

;; Motion bindings
(defhydra hydra-motion nil "MOTION"
  ("h" evil-backward-char nil)
  ("l" evil-forward-char nil)
  ("j" evil-next-line nil)
  ("k" evil-previous-line nil)
  ("u" evil-backward-word-begin nil)
  ("U" evil-backward-WORD-begin nil)
  ("i" evil-forward-word-begin nil)
  ("I" evil-forward-WORD-begin nil)
  ("o" evil-backward-word-end nil)
  ("O" evil-backward-WORD-end nil)
  ("p" evil-forward-word-end nil)
  ("P" evil-forward-WORD-end nil)
  ("n" evil-first-non-blank nil)
  ("m" evil-last-non-blank nil)
  ("N" evil-beginning-of-line nil)
  ("M" evil-end-of-line nil)
  ("v" evil-scroll-down nil)
  ("c" evil-scroll-up nil)
  ("x" evil-goto-line nil)
  ("z" (evil-goto-line 1) nil)
  ("t" avy-goto-char-2 nil)
  ("/" evil-ex-search-forward nil)
  ("?" evil-ex-search-backward nil)
  ("." (evil-ex-search-next 1) nil)
  ("," (evil-ex-search-previous 1) nil)
  ("'" evil-ex-nohighlight nil)
  ("y" evilmi-jump-items nil)
  ("q" evil-jump-forward nil)
  ("w" evil-jump-backward nil)
  ("TAB" hydra-edit/body :color blue)
  ("SPC" keyboard-quit nil :color blue))

(defhydra hydra-edit nil "EDIT"
  ("TAB" hydra-motion/body :color blue)
  ("SPC" keyboard-quit nil :color blue))

(defun swap-buffers (count &optional all-frames)
  "Swap buffers with the window selected by (other-window COUNT ALL-FRAMES)."
  (interactive "p")
  (let* ((current-win (selected-window))
         (current-buffer (window-buffer))
         (swap-win (progn (other-window count all-frames)
                          (selected-window)))
         (swap-buffer (window-buffer)))
    (set-window-buffer swap-win current-buffer)
    (set-window-buffer current-win swap-buffer)
    (select-window current-win)))

(defhydra hydra-windows (:hint nil :color red)
  "
Window Management
Font Size:   _0_: default      _-_: shrink       _+_: enlarge
Window Size: _=_: balance      _u_: v-expand     _i_: v-retract
                             ^^_p_: h-expand     _o_: h_retract
Split:       _h_: horizontal   _v_: vertical
Switch:      _j_: next         _k_: prev
Swap:        _J_: next         _K_: prev
"
  ("=" balance-windows)
  ("p" enlarge-window-horizontally)
  ("o" shrink-window-horizontally)
  ("u" enlarge-window)
  ("i" shrink-window)
  ("0" (text-scale-adjust 0))
  ("+" (text-scale-adjust 1))
  ("-" (text-scale-adjust -1))
  ("j" other-window)
  ("k" (other-window -1))
  ("J" (swap-buffers 1))
  ("K" (swap-buffers -1))
  ("h" split-window-below)
  ("v" split-window-right)
  ("x" delete-window "Delete This")
  ("d" delete-other-windows "Delete Others" :color blue)
  ("TAB" hydra-motion/body "MOTION" :color blue)
  ("SPC" keyboard-quit "exit" :color blue))

(setq lpr-command "lp"
      printer-name "Brother_HL-2170W_series"
      lpr-printer-switch "-d"
      lpr-add-switches nil)

(my-generic-define-key :infix "0"
                       "r" #'print-region
                       "b" #'print-buffer)

(my-generic-define-key "g" #'hydra-motion/body
                       "x" #'hydra-edit/body
                       "w" #'hydra-windows/body)

(my-generic-define-key :infix "b"
                       "b" #'evil-switch-to-windows-last-buffer
                       "s" #'save-buffer
                       "k" #'(lambda () (interactive) (kill-buffer)))

(my-generic-define-key :infix "e"
                       "r" #'eval-region
                       "l" #'eval-last-sexp
                       "d" #'eval-defun)

(my-generic-define-key "qq" #'save-buffers-kill-terminal
                       "o" #'my-insert-vertical-space
                       "O" #'my-insert-inverted-vertical-space
                       "z" #'evil-ex-nohighlight)

(provide 'my-generic-keybindings)
