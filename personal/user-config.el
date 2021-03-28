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

(prelude-require-package 'pandoc-mode)

(add-hook 'markdown-mode-hook 'pandoc-mode)
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)

(use-package pdf-tools
  :ensure t
  :config
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))

(defun init-exwm ()
  (interactive)
  (use-package exwm
    :ensure t
    :config

    (setq exwm-workspace-number 5)

    (setq exwm-input-prefix-keys
          '(?\C-x
            ?\C-u
            ?\C-h
            ?\M-x
            ?\M-1
            ?\M-2
            ?\M-&
            ?\M-:
            ?\C-'
            ?\s-'
            ?\C-§))

    (define-key global-map [?\s-a] 'counsel-linux-app)
    (define-key global-map [?\s-'] 'exwm-workspace-switch)
    (define-key global-map [s-left] 'windmove-left)
    (define-key global-map [s-right] 'windmove-right)

    (mapcar
     (lambda (i)
       (define-key global-map (kbd (format "s-%d" i))
         (lambda () (intera ctive) (exwm-workspace-switch ,i))))
     (number-sequence 0 9))


    (exwm-enable)))

(defun dph.windows/make (n)
  (interactive "nNumber of split: ")
  (delete-other-windows)
  (dotimes (i (- n 1))
    (split-window-right))
  (balance-windows))

(defun dph.windows/balance+x+y (x y)
  (interactive "nNumber of window on left: \nnNumber of window on right:" )
  (select-window (frame-first-window))
  (when (<= (+ x y) (length (window-list)))
    (let* ((w (frame-width))
           (w-left (/ w 2 x))
           (w-right (/ w 2 y))
           (wins (window-list))
           (wins-left (seq-take wins x))
           (wins-right (seq-drop wins x)))

      (mapcar (lambda (win)
                (window-resize win (- w-left (window-width win) 1) t))
              wins-left)

      (mapcar (lambda (win)
                (window-resize win (- w-right (window-width win) 1) t))
              wins-right))))

(defun dph.windows/make-3+1 ()
  (interactive)
  (dph.windows/make 4)
  (dph.windows/balance+x+y 3 1))

(defun dph.windows/make-3+2 ()
  (interactive)
  (dph.windows/make 5)
  (dph.windows/balance+x+y 3 2))
