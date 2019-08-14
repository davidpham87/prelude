;; Python configure


;; for emacs-ipython over ssh
(setq request-curl-options '("--insecure"))

(setq dired-guess-shell-alist-user
      '(("\\.pdf$" "evince") ("\\.html$" "google-chrome")))

(setq ein:console-args
      '((8000 . '("--ssh" "aws-jupyter" "--simple-prompt"))
        (8888 . '("--ssh" "aws-jupyter" "--simple-prompt"))
        (default . "--simple-prompt"))
      ein:console-security-dir "~/jupyter_security"
      python-shell-prompt-regexp "In \\[[0-9]+\\]: "
      python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
      ;; python-shell-completion-setup-code
      ;; "from IPython.core.completerlib import module_completion"
      ;; python-shell-completion-string-code
      ;; "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
      python-shell-completion-native-disabled-interpreters
      '("ipython3" "ipython" "jupyter")
      python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      )
