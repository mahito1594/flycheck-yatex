;;; flycheck-yatex --- syntax checker for yatex-mode

;; Copyright (C) 2019 Mahito Tanno

;; Author: Mahito Tanno <pb94.mahito@gmail.com>
;; Package-Requires: ((flycheck "31"))
;; Keywords: Emacs, TeX/LaTeX, flycheck

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Includes `flycheck.el'
;; https://www.flycheck.org
;; Copyright (C) 2017-2018 Flycheck contributors
;; Copyright (C) 2012-2016 Sebastian Wiesner and Flycheck contributors
;; Copyright (C) 2013, 2014 Free Software Foundation, Inc.
;; Released under the GPL v3.0

;;; Commentary:

;; This package defines two syntax checkers for yatex-mode with flycheck.
;; 1. yatex-chktex
;; 2. yatex-lacheck
;;
;; This is done by simply adding `yatex-mode' to `:modes' in `tex-chktex' and
;; `tex-lacheck' which are defined in `flycheck.el'.

;;; Code:

(require 'flycheck)

(flycheck-define-checker yatex-chktex
  "A TeX and LaTeX syntax and style checker using chktex.
See URL `http://www.nongnu.org/chktex/'."
  :command ("chktex"
            (config-file "--localrc" flycheck-chktexrc)
            ;; Options:
            ;; - Compact error messages,
            ;; - no version information,
            ;; - ignore Warning 8, and
            ;; - execute `\input' statements.
            "--verbosity=0" "--quiet" "--nowarn=8" "--inputfiles")
  :standard-input t
  :error-patterns
  ((warning line-start "stdin:" line ":" column ":"
            (id (one-or-more digit)) ":" (message) line-end))
  :error-filter
  (lambda (errors)
    (flycheck-sanitize-errors (flycheck-increment-error-columns errors)))
  :modes yatex-mode)

(flycheck-define-checker yatex-lacheck
  "A LaTeX syntax and style checker using lacheck.
See URL `http://www.ctan.org/pkg/lacheck'."
  :command ("lacheck" source-inplace)
  :error-patterns
  ((warning line-start
            "\"" (file-name) "\", line " line ": " (message)
            line-end))
  :modes yatex-mode)

(provide 'flycheck-yatex)
;;; flycheck-yatex.el ends here
