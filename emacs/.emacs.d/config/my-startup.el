(defun my-initial-buffers ()
  "Puts the todo.org doc in main window with scratch and eshelg to the right."
  (split-window-right)
  (other-window 1)
  (split-window-below (- (+ (/ (window-total-height) 3) 3)))
  (other-window 1)
  (eshell)
  (other-window 1)
  (find-file "~/todo.org"))

(add-hook 'emacs-startup-hook #'my-initial-buffers)

(provide 'my-startup)
