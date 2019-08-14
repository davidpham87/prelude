;;; prelude-ess.el --- Emacs Prelude: ess.el configuration.
;;
;; Copyright © 2019 David Pham

;; Author: David Pham <davidpham87@gmail.com>
;; URL: https://github.com/bbatsov/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Some basic configuration for ess.el (the latest and greatest
;; R/S+ mode Emacs has to offer).

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
(prelude-require-package 'ess)

(when (boundp 'company-backends)
  (prelude-require-package 'company-quickhelp)
  (setq ess-use-auto-complete nil)
  (setq ess-use-company 'script-only)
  (add-to-list 'company-backends 'company-))

(require 'electric)
(require 'prelude-programming)

(defun prelude-ess-mode-defaults ()
  "Defaults for ess programming."
  (subword-mode +1)
  (ess-mode 1)
  (eldoc-mode 1)
  (setq ess-indent-level 2)

  ;; otherwise C-c C-r (eval region) takes forever
  (setq ess-eval-visibly-p nil)

  ;; otherwise you are prompted each time you start an interactive R session
  (setq ess-ask-for-ess-directory nil)

  (setq ess-local-process-name "R")
  (setq ansi-color-for-comint-mode 'filter)
  (setq comint-prompt-read-only t)
  (setq comint-scroll-to-bottom-on-input t)
  (setq comint-scroll-to-bottom-on-output t)
  (setq comint-move-point-for-output t)
  (local-set-key (kbd "<C-dead-circumflex>") 'my-ess-eval)
  (rainbow-mode t)
  (company-mode)
  (company-quickhelp-mode)
  (rainbow-delimiters-mode t)
  (ess-set-style 'OWN))

(setq prelude-ess-mode-hook 'prelude-ess-mode-defaults)

(add-hook 'ess-mode-hook (lambda ()
                           (run-hooks 'prelude-ess-mode-hook)))

(defun my-ess-start-R ()
  (interactive)
  (if (not (member "*R*" (mapcar (function buffer-name) (buffer-list))))
      (R)))

(defun my-ess-eval ()
  "Eval region faster"
  (interactive)
  (my-ess-start-R)
  (if (and transient-mark-mode mark-active)
      (call-interactively 'ess-eval-region)
    (call-interactively 'ess-eval-line-and-step)))

;; To clear the shell in R
(defun clear-shell ()
  (interactive)
  (let ((old-max comint-buffer-maximum-size))
    (setq comint-buffer-maximum-size 0)
    (comint-truncate-buffer)
    (setq comint-buffer-maximum-size old-max)))

(add-hook 'inferior-ess-mode-hook
          '(lambda ()
             (local-set-key [C-up] 'comint-previous-input)
             (local-set-key [C-down] 'comint-next-input)
             (rainbow-mode t)
             (company-mode)
             (company-quickhelp-mode)
             (rainbow-delimiters-mode t)))

(require 'ess-site)

;; To reset the size of the terminal in R in ESS use C-c w to reset
;; the size of the console
(defun my-ess-post-run-hook ()
  (ess-execute-screen-options)
  (local-set-key "\C-cw" 'ess-execute-screen-options))
(add-hook 'ess-post-run-hook 'my-ess-post-run-hook)

(provide 'prelude-ess)
