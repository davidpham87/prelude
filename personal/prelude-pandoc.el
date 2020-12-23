;;; prelude-ess.el --- Emacs Prelude: ess.el configuration.
;;
;; Copyright © 2019 David Pham

;; Author: David Pham <davidpham87@gmail.com>
;; URL: https://github.com/bbatsov/prelude
;; Version: 1.0.0
;; Keywords: R, ESS

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
;; (prelude-require-package 'pandoc-mode)

(with-eval-after-load 'pandoc-mode
  (add-hook 'markdown-mode-hook 'pandoc-mode)
  (add-hook 'pandoc-mode-hook 'pandoc-load-default-settings))

(provide 'prelude-pandoc)
