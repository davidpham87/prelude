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

(defun bb-nrepl ()
  "Start an babashka nREPL server for the current project and connect to it."
  (interactive)
  (let* ((default-directory (project-root (project-current t)))
         (process-filter (lambda (proc string)
                           "Run cider-connect once babashka nrepl server is ready."
                           (when (string-match "Started nREPL server at .+:\\([0-9]+\\)" string)
                             (cider-connect-clj (list :host "localhost"
                                                      :port (match-string 1 string)
                                                      :project-dir default-directory)))
                           ;; Default behavior: write to process buffer
                           (internal-default-process-filter proc string))))
    (set-process-filter
     (start-file-process "babashka" "*babashka*" "bb" "--nrepl-server" "0")
     process-filter)))
