# flycheck-yatex

### Note
当パッケージではなく `flycheck-add-mode` 関数を使うべきでしょう．
使い方は

```elisp
(with-eval-after-load 'flycheck
  (flycheck-add-mode 'tex-chktex 'yatex-mode)
  (flycheck-add-mode 'tex-lacheck 'yatex-mode))
```

とします．

### Summary

[YaTeX](http://yatex.org/) のための [flycheck](https://www.flycheck.org/en/latest/) チェッカです．
flycheck のデフォルトで定義されている `tex-chktex` と `tex-lacheck` を yatex-mode でも使えるようにしたものです．

### Usage

ダウンロード後，ロードパスを追加し

```elisp
(require 'flycheck-yatex)

```

と `init.el` に記述します．
自動的に yatex-mode でチェッカが有効になります．
もし chktex を利用したくない場合は `M-x flycheck-disable-checker RET yatex-chktex` などで無効化してください．
lacheck についても同様です．
詳しくは [flycheck のマニュアル](http://www.flycheck.org/en/latest/user/syntax-checkers.html#disable-syntax-checkers)を参照してください．

#### With [use-package](https://github.com/jwiegley/use-package) + [straight](https://github.com/raxod502/straight.el)
straight.el を用いてパッケージ管理している場合は `init.el` に

```elisp
(straight-use-package
  '(flycheck-yatex :type git :host github :repo "mahito1594/flycheck-yatex"))
```

または use-package.el を利用している場合には

```elisp
(use-package flycheck-yatex
  :straight (:type git :host github :repo "mahito1594/flycheck-yatex"))
```

と書きます．

### Memo
ChkTeX の Warning 8 を無視するように設定しています．
また，LaTeX のインライン数式に `$...$` を用いる方はオプションに `"--nowarn=46"` を追加するのが良いかもしれません．
