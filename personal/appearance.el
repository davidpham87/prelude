(when (member "Source Code Pro" (font-family-list))
  (add-to-list 'default-frame-alist '(font . "Source Code Pro-10")))

(add-to-list 'default-frame-alist '(height . 70))
(add-to-list 'default-frame-alist '(width . 81))
(setq-default fill-column 79)           ; Automatic width formatting with M-q

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)
(scroll-bar-mode -1)

(setq dired-listing-switches "-alh")

(setq aw-keys '(?a ?s ?d ?f ?j ?k ?l ?k ?é))
(setq aw-scope 'frame)

(defun set-frame-width-interactive (arg)
  "Interactively set frame width"
  (interactive "p")
  (set-frame-width (selected-frame) arg))
