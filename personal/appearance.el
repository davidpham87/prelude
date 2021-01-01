;; Sets a few personal decision about the look of emacs.

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

(setq split-width-threshold 120)
(setq split-height-threshold 160)

(setq history-delete-duplicates t)
(setq history-length 100)

;; worse case, but this in the custom-faces

;; (custom-theme-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(tab-bar ((t (:foreground "#3F3F3F" :background "#2B2B2B" :inherit variable-pitch :box (:line-width 1)))))
;;  '(tab-bar-tab ((t (:foreground "#DCDCCC" :background "#3F3F3F" :box (:line-width 1 :style pressed-button)))))
;;  '(tab-bar-tab-inactive ((t (:foreground "#989890" :background "#2B2B2B" :box (:line-width 1 :style release-button))))))
