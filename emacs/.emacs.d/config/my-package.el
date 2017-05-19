;;; This file takes care of setting up the package management tools.

;; Secure package downloads. These variables don't seem to exist in my
;; current version of emacs.

;; (setq tls-checktrust t)
;; (let ((trustfile (replace-regexp-in-string
;;                   "\\\\" "/"
;;                   (replace-regexp-in-string
;;                    "\n" ""
;;                    (shell-command-to-string "python -m certifi")))))
;;   (setq tls-program
;;         (list
;;          (format "gnutls-cli%s --x509cafile %s -p %%p %%h"
;;                  (if (eq window-system 'w32) ".exe" "") trustfile)))
;;   (if (boundp 'gnutls-verify-error)
;;       (setq gnutls-verify-error t))
;;   (if (boundp 'gnutls-trustfiles)
;;       (setq gnutls-trustfiles (list trustfile))))


;; ;; Package managment
;; The package managing package
(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/"))

      package-archive-priorities
      '(("melpa-stable" . 9)
        ("gnu"     . 5)
        ("melpa"        . 0)))

(setq package-menu-hide-low-priority nil)

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)
;; Key binding packages
;; Easy evil state key bindings
;; Also makes it possible to create keybindings dependent upon keymaps
;; that do not yet exist (without eval-after-load)

(eval-when-compile
  (require 'use-package))

(use-package general
  :config
  (general-evil-setup))

;; Key chords
(use-package key-chord
  :diminish key-chord-mode
  :config
  (key-chord-mode 1))

(use-package use-package-chords)

(use-package hydra)

(provide 'my-package)

;;; my-package ends here
