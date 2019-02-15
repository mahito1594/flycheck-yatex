;;; flycheck-yatex --- syntax checker for yatex-mode
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
