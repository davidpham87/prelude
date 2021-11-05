;;; bbmacs.el -- babashka and clomacs setup
;;
;; Copyright © 2020 David Pham
;;
;; Author: David Pham

;; This file is not part of GNU Emacs.

;;; Commentary:

;; babashka and clomacs setup

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
(require 'cl-lib)
(require 'cider)

(defvar bbmacs-clomacs-dir "~/.emacs.d/personal/clomacs/")
(defvar bbmacs-port 1659)

(defun bbmacs-connect ()
  "Start an babashka nREPL server for the current project and connect to it."
  (interactive)
  (let* ((process-filter
          (lambda (proc string)
            "Run cider-connect once babashka nrepl server is ready."
            (when (string-match "Started nREPL server at .+:\\([0-9]+\\)" string)
              (cider-connect-clj (list :host "localhost"
                                       :port (match-string 1 string)
                                       :project-dir bbmacs-clomacs-dir)))
            ;; Default behavior: write to process buffer
            (internal-default-process-filter proc string))))
    (set-process-filter
     (start-file-process "babashka" "*babashka*" "bb" "--nrepl-server" (number-to-string bbmacs-port))
     process-filter)))

(cl-defun bbmacs-bb-process
    (&optional (dir bbmacs-clomacs-dir) (port bbmacs-port))
  (let ((default-directory dir)
        (port (number-to-string port)))
    (make-process
     :name "bbmacs-nrepl"
     :buffer (concat "*bbmacs-nrepl (" port ")" "*")
     :command `("bb" "-f" "init.clj" ,port))))

(cl-defun bbmacs-bb-process-kill
    (&optional (dir bbmacs-clomacs-dir) (port bbmacs-port))
  (let* ((default-directory dir)
        (port (number-to-string port))
        (buffer (concat "*bbmacs-nrepl (" port ")" "*"))
        (process (get-buffer-process buffer)))
    (kill-process process)))

(defun bbmacs-init ()
  (interactive)
  (bbmacs-connect))

(defun bbmacs-reset ()
  (interactive)
  (bbmacs-bb-process-kill)
  (bbmacs-init))

(provide 'bbmacs)
;;; bbmacs.el ends here
