;; Python configure
(require 'dash)

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

(use-package bufler
  :ensure t)

(defun dph.windows/make (n)
  "Create evenly n spread windows"
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

      (-map
       (lambda (win)
         (window-resize win (- w-left (window-width win) 1) t))
       wins-left)

      (-map
       (lambda (win)
         (window-resize win (- w-right (window-width win) 1) t))
       wins-right))))

(defun dph.windows/balance (s)
  (interactive "sNumber of window left x right (.e.g 3x1): ")
  (let* ((args (-map #'string-to-number (split-string s "[x ]")))
        (x (-first-item args))
        (y (-last-item args)))
    (dph.windows/balance+x+y x y)))

(defun dph.windows/make-2+1 ()
  "Split the frame in two, and the left half is spread into 3 equally spaced window"
  (interactive)
  (dph.windows/make 4)
  (select-window (frame-first-window))
  (let* ((wins (reverse (window-list))))
    (delete-window (-first-item wins))))

(defun dph.windows/make-3+1 ()
  "Split the frame in two, and the left half is spread into 3 equally spaced window"
  (interactive)
  (dph.windows/make 6)
  (select-window (frame-first-window))
  (let* ((wins (reverse (window-list))))
    (delete-window (-first-item wins))
    (delete-window (-second-item wins))))

(defun dph.windows/make-3+2 ()
  "Split the frame in two, the left half is spread into 3 equally spaced window, the right half into 2."
  (interactive)
  (dph.windows/make-3+1)
  (select-window (-last-item (window-list)))
  (split-window-right))
