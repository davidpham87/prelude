(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((python-mode . lsp)
         (clojure-mode . lsp)
         (clojurec-mode . lsp)
         (clojurescript-mode . lsp))
  :custom
  (lsp-auto-guess-root t)
  (lsp-file-watch-threshold 1500)  ; pyright has more than 1000

  :custom-face
  (lsp-face-highlight-read ((t (:underline t :background nil :foreground nil))))
  (lsp-face-highlight-write ((t (:underline t :background nil :foreground nil))))
  (lsp-face-highlight-textual ((t (:underline t :background nil :foreground nil))))
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-enable-indentation nil)
  (setq lsp-enable-xref nil)
  (add-to-list 'lsp-language-id-configuration '(clojure-mode . "clojure-mode"))
  (add-to-list 'lsp-language-id-configuration '(clojurec-mode . "clojurec-mode"))
  (add-to-list 'lsp-language-id-configuration '(clojurescript-mode . "clojurescript-mode"))
  (setq lsp-file-watch-ignored-directories
        (append lsp-file-watch-ignored-directories
                '("[/\\\\]\\.shadow-cljs\\'"
                  "[/\\\\]\\.clj-kondo\\'"
                  "[/\\\\]\\.cpcache\\'"
                  "[/\\\\]\\.lsp\\'"
                  "[/\\\\]public\\'"
                  "[/\\\\]output\\'"
                  "[/\\\\]elpa\\'"))))

(use-package lsp-ui
  :after lsp-mode
  :custom
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-sideline-delay 5.0)
  (lsp-ui-doc-delay 5.0)
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-always-show t)
  (lsp-ui-peek-fontify 'always)
  :custom-face
  (lsp-ui-peek-highlight
   ((t (:inherit nil :background nil :foreground nil :weight semi-bold
                 :box (:line-width -1))))))

;; (setq lsp-ui-doc-position 'at-point)
;; (setq lsp-ui-doc-delay 10.0)
;; (setq lsp-ui-sideline-delay 10.0)
