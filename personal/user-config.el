;; Python configure

(setq dired-guess-shell-alist-user
      '(("\\.pdf$" "evince") ("\\.html$" "google-chrome")))

(defun shadow-cljs-shells ()
  "Create some default eshell "
  (interactive)
  (eshell nil)
  (rename-buffer "*eshell*<git>")
  (eshell nil)
  (rename-buffer "*eshell*<flask>")
  (eshell nil)
  (rename-buffer "*eshell*<shadow-cljs-server>")
  (eshell nil)
  (rename-buffer "*eshell*<shadow-cljs>"))

;; (require 'exwm)
;; (require 'exwm-config)
;; (exwm-config-default)

(prelude-require-package 'pandoc-mode)

(add-hook 'markdown-mode-hook 'pandoc-mode)
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)
