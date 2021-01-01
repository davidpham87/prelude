(prelude-require-package 'conda)

;; for emacs-ipython over ssh
(setq request-curl-options '("--insecure"))

(use-package python
  :custom
  (ein:console-args
   '((8000 . '("--ssh" "aws-jupyter" "--simple-prompt"))
     (8888 . '("--ssh" "aws-jupyter" "--simple-prompt"))
     (default . "--simple-prompt")))
  (ein:console-security-dir "~/jupyter_security")
  (python-shell-prompt-regexp "In \\[[0-9]+\\]: ")
  (python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: ")
  ;; (python-shell-completion-setup-code
  ;; "from IPython.core.completerlib import module_completion")
  ;; (python-shell-completion-string-code
  ;;  "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
  (python-shell-completion-native-disabled-interpreters
   '("ipython3" "ipython" "jupyter"))
  ;; better command line experience
  (python-shell-interpreter "ipython3")
  (python-shell-interpreter-args "--simple-prompt -i")
  (pythonic-interpreter "python3")
  :hook
  (python-mode . flycheck-mode)
  (python-mode . lsp-deferred))

(use-package conda
  :custom
  (conda-anaconda-home "/usr/lib/miniconda3")
  (conda-env-home-directory "~/.conda/"))


;; install pyright
;; npm install -g pyright

(use-package lsp-pyright
  :ensure t
  :after lsp-mode
  :hook (python-mode . (lambda () (require 'lsp-pyright) (lsp-deferred)))
  :custom
  (lsp-pyright-auto-import-completions nil)
  (lsp-pyright-typechecking-mode "off"))
