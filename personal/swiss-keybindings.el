(require 'iso-transl)
(use-package paredit)

(global-set-key (kbd "C-§") 'other-frame)
(global-set-key [remap other-window] 'other-window)
(global-set-key (kbd "C-'") 'ace-window) ;  key change windows
(global-set-key (kbd "C-x o") 'other-window)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(delete-selection-mode t) ; Delete selection when pressing [delete] key
(global-set-key (kbd "<C-dead-circumflex>") 'crux-top-join-line)
(global-set-key (kbd "<M-dead-circumflex>") 'join-line)
;; (global-set-key (kbd "M-j") 'join-line)
;; In order to avoid to hit SPC everytime

;; Should be default but sometimes are overwritten
(global-set-key [M-a] 'backward-sentence)
(global-set-key [M-e] 'forward-sentence)
(global-set-key [M-d] 'kill-sentence)

(let* ((km (cond
            ((eq system-type 'darwin)
             '(("¥" "M-y") ("≈" "M-x") ("©" "M-c") ("√" "M-v") ("∫" "M-b")
               ("å" "M-a") ("ß" "M-s") ("∂" "M-d") ("ƒ" "M-f")
               ("∑" "M-w") ("®" "M-r") ("†" "M-t")))
            ((eq system-type 'gnu/linux)
             '(("«" "M-y") ("»" "M-x") ("¢" "M-c") ("“" "M-v") ("”" "M-b")
               ("æ" "M-a") ("ß" "M-s") ("ð" "M-d") ("đ" "M-f") ("ŋ" "M-g")
               ("ł" "M-w") ("€" "M-e") ("¶" "M-r") ("ŧ" "M-t")))))
       (kmc (mapcar (lambda(y) (--map (concat "C-" it) y)) km)) ; C- variant
       (key-mapper (lambda (it) (define-key key-translation-map
                                            (kbd (car it)) (kbd (car (cdr it)))))))
  (mapc key-mapper km)
  (mapc key-mapper kmc))

;; Mac settings to have the same feeling as pc keyboard
(when (eq system-type 'darwin)
  ;; ;; This is to make mac friendly
  (setq mac-command-modifier 'meta
        mac-option-modifier 'none)

  (global-set-key (kbd "æ") '"{")
  (global-set-key (kbd "¶") '"}")
  (global-set-key (kbd "§") '"[")
  (global-set-key (kbd "‘") '"]")
  (global-set-key (kbd "C-<") '"\\")
  (define-key key-translation-map (kbd "M-æ") (kbd "M-{"))
  (define-key key-translation-map (kbd "M-¶") (kbd "M-}")))

;; Emacs-live rewrite
(global-set-key (kbd "C-h") 'help-command)

;; Make C-é delete backward
(global-set-key (kbd "C-é") 'delete-backward-char)
(global-set-key (kbd "<C-backspace>") 'delete-backward-char)
(global-set-key (kbd "M-n")  'back-to-indentation)

;;allow the deletion of words:
;;backward kill word (forward kill word is M-d)
(global-set-key (kbd "M-é") 'backward-kill-word)

;; Should write for console C-c C-y instead of C-c C-z
(define-key key-translation-map (kbd "C-c C-y") (kbd "C-c C-z"))

(define-key key-translation-map (kbd "M-[") (kbd "M-{"))
(define-key key-translation-map (kbd "M-]") (kbd "M-}"))

(define-key key-translation-map (kbd "Ŧ") (kbd "M-T"))
(global-set-key (kbd "M-T")  'sp-transpose-sexp)

(global-set-key (kbd "C-x C-b") 'ibuffer)
