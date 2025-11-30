(require 'use-package)
(require 'vterm)

;; 2. Bootstrap Quelpa (The Magic)
(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

(unless (package-installed-p 'quelpa-use-package)
  (package-refresh-contents)
  (package-install 'quelpa-use-package))

(require 'quelpa-use-package)
(setq quelpa-update-melpa-p nil)


(use-package gemini-cli-mode
  ;; The magic line:
  :quelpa (gemini-cli-mode :fetcher github :repo "davidpham87/gemini-cli-mode"))


(global-set-key (kbd "C-x M-m") 'vterm)
