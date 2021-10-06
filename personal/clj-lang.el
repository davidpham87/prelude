(prelude-require-package 'use-package)

;; (use-package flycheck-clj-kondo
;;   ;; :after (lsp)
;;   :hook clojure-mode
;;   :ensure t)

;; (require 'flycheck-clj-kondo)

(use-package clomacs
  :after (lsp)
  :ensure t)

(use-package cider
  :after (lsp)
  :ensure t
  :config
  (global-set-key (kbd "C-è") 'cider-find-dwim))

(use-package clj-refactor
  :after (cider)
  :ensure t
  :config
  (defun clj-refactor-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    ;; This choice of keybinding leaves cider-macroexpand-1 unbound
    (cljr-add-keybindings-with-prefix "C-c m"))
  (add-hook 'clojure-mode-hook #'clj-refactor-mode-hook))

(defun bb-nrepl (port)
  (interactive "sPort: ")
  (make-process
   :name "bb-nrepl"
   :buffer (concat "*bbmacs-nrepl (" port ")" "*")
   :command `("bb" "--nrepl-server" ,port)))
