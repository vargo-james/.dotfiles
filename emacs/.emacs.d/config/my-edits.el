
;; This cute little function inserts vertical space.
(defun my-insert-vertical-space (&optional n)
  "Insert N empty lines under point (or above point if N < 0).
In each new line, a 'left-margin' and the 'fill-prefix' will be inserted if
those are set. N defaults to 1."
  (interactive "*p")
  (or n (setq n 1))
  (let ((loc (point-marker))
        (do-fill-prefix (not (string= "" fill-prefix)))
        (do-left-margin (if (> (current-left-margin) 0) t nil))
        (abbrev-mode nil)
        (downward (> n 0)))
    (if downward (end-of-line) (beginning-of-line))
    (newline (if downward n (- n)))
    (if downward (forward-line (- (1- n))) (forward-line n))
    (if downward (setq n (- n)))
    (while (> n 0)
      (if do-left-margin (indent-to (current-left-margin)))
      (if do-fill-prefix (insert-and-inherit fill-prefix))
      (forward-line 1)
      (setq n (1- n)))
    (goto-char loc)))

(defun my-insert-inverted-vertical-space (&optional n)
  "Like 'my-insert-vertical-space', but the argument N is flipped."
  (interactive "*p")
  (my-insert-vertical-space (- n)))

(provide 'my-edits)
