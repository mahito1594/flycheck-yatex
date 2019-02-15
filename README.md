# flycheck-yatex

### Summary

[YaTeX](http://yatex.org/) のための [flycheck](https://www.flycheck.org/en/latest/) チェッカです．
flycheck のデフォルトで定義されている `tex-chktex` と `tex-lacheck` を yatex-mode でも使えるようにしたものです．

### Usage

ダウンロード後，ロードパスを追加し

```elisp
(require 'flycheck-yatex)
(add-to-list 'flycheck-chekckers 'yatex-chktex) ; use chktex
;; (add-to-list 'flycheck-checkers 'yatex-lacheck) ; use lacheck
```

と `init.el` に記述します．

#### With [use-package](https://github.com/jwiegley/use-package) + [straight](https://github.com/raxod502/straight.el)
straight.el を用いてパッケージ管理している場合は `init.el` に

```elisp
(use-package flycheck-yatex
  :straight (:host github :repo "mahito1594/flycheck-yatex")
  :config
  (add-to-list 'flycheck-checkers 'yatex-chktex) ; use chktex
  ;; (add-to-list 'flycheck-checkers 'yatex-lacheck) ; use lacheck
  )
```

と書きます．

### Memo
ChkTeX の Warning ８を無視するように設定しています．
また，LaTeX のインライン数式に `$...$` を用いる方はオプションに `"--nowarn=46"` を追加するのが良いかもしれません．