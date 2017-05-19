;;; This file defines the settings relevant to saving files and maintaining
;;; backup copies.

;; Backup File Management
(setq vc-make-backup-files t
      vc-follow-symlinks t
      backup-by-copying t
      backup-directory-alist '(("." . "~/.saves"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      require-final-newline t
      version-control t)

(defun force-backup-of-buffer ()
  "Tricks Emacs into backing up the file at every save."
  (setq buffer-backed-up nil))

(add-hook 'before-save-hook #'force-backup-of-buffer)
(add-hook 'before-save-hook #'delete-trailing-whitespace)

(provide 'my-backup-management)
