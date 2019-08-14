(when (member "Source Code Pro" (font-family-list))
  (add-to-list 'default-frame-alist '(font . "Source Code Pro-11")))

(add-to-list 'default-frame-alist '(height . 70))
(add-to-list 'default-frame-alist '(width . 81))
(setq-default fill-column 79)           ; Automatic width formatting with M-q


(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

(setq dired-listing-switches "-alhX")

;; (mapc (function
;;        (lambda (x) (add-hook x 'rainbow-enable-in-mode)))
;;       '(text-mode-hook LaTeX-mode-hook emacs-lisp-mode python-mode-hook
;;                        R-mode))

(defun set-frame-width-interactive (arg)
  "Interactively set frame width"
  (interactive "p")
  (set-frame-width (selected-frame) arg))
