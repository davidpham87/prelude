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

(defun bb-nrepl (port)
  (interactive "sPort: ")
  (make-process
   :name "bb-nrepl"
   :buffer (concat "*bbmacs-nrepl (" port ")" "*")
   :command `("bb" "--nrepl-server" ,port)))
