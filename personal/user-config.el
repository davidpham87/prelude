;; Python configure
(require 'flycheck-clj-kondo)

;; for emacs-ipython over ssh
(setq request-curl-options '("--insecure"))

(setq dired-guess-shell-alist-user
      '(("\\.pdf$" "evince") ("\\.html$" "google-chrome")))


(prelude-require-package 'conda)

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

      ;; better command line experience
      python-shell-interpreter "ipython3"
      python-shell-interpreter-args "--simple-prompt -i"
      pythonic-interpreter "python3"

      ;; insure this is the correct path as conda will be used with ~conda-anaconda-home/bin/conda
      conda-anaconda-home "/usr/lib/miniconda3")

(defun conda-env-list-custom ()
  (let* ((conda-anaconda-home "/usr/lib/miniconda3"))
    (conda-env-list)))

;; (conda-env-list-custom)


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
