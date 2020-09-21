(require 'iso-transl)
;; (use-package dash)
;; (use-package paredit-mode)

(global-set-key (kbd "C-§") 'other-frame)
(global-set-key [remap other-window] 'other-window)
(global-set-key (kbd "C-'") 'ace-window) ;  key change windows
(global-set-key (kbd "C-x o") 'other-window)
(global-set-key (kbd "C-x C-b") 'ibuffer)


(delete-selection-mode t) ; Delete selection when pressing [delete] key
(global-set-key (kbd "<C-dead-circumflex>") 'crux-top-join-line)
(global-set-key (kbd "<M-dead-circumflex>") 'join-line)
;; In order to avoid to hit SPC everytime

;; Should be default but sometimes are overwritten
(global-set-key [M-a] 'backward-sentence)
(global-set-key [M-e] 'forward-sentence)
(global-set-key [M-d] 'kill-sentence)

;; Rebind altgr + key to the correct default behavior
;; To get the same alt as the american keyboard
(let* ((km '(("«" "M-y") ("»" "M-x") ("¢" "M-c") ("“" "M-v") ("”" "M-b")
             ("æ" "M-a") ("ß" "M-s") ("ð" "M-d") ("đ" "M-f") ("ŋ" "M-g")
             ("ł" "M-w") ("€" "M-e") ("¶" "M-r") ("ŧ" "M-t")))
       (kmc (mapcar (lambda(y) (--map (concat "C-" it) y)) km)) ; C- variant
       (key-mapper (lambda (it) (define-key key-translation-map
                                  (kbd (car it)) (kbd (car (cdr it)))))))
  (mapc key-mapper km)
  (mapc key-mapper kmc))

;; Emacs-live rewrite
(global-set-key (kbd "C-h") 'help-command)
;; (define-key org-mode-map (kbd "C-h") 'help-command)

;; Make C-é delete backward
(global-set-key (kbd "C-é") 'delete-backward-char)
(global-set-key (kbd "<C-backspace>") 'delete-backward-char)
;; (global-set-key [(control ?h)] 'delete-backward-char) ;; in terminals
(global-set-key (kbd "M-n")  'back-to-indentation)
;; (define-key paredit-mode-map (kbd "C-é") 'paredit-backward-delete)

;;allow the deletion of words:
;;backward kill word (forward kill word is M-d)
(global-set-key (kbd "M-é") 'backward-kill-word)
;; (define-key ido-file-completion-map (kbd "M-é") 'backward-kill-word)
;; (define-key paredit-mode-map (kbd "M-é") 'paredit-backward-kill-word)

;; C-z is undo-tree-undo as I never use suspendend frame
;; (global-set-key (kbd "C-z") 'undo-tree-undo)

;; Should write for console C-c C-y instead of C-c C-z
(define-key key-translation-map (kbd "C-c C-y") (kbd "C-c C-z"))

(define-key key-translation-map (kbd "M-[") (kbd "M-{"))
(define-key key-translation-map (kbd "M-]") (kbd "M-}"))
(define-key key-translation-map (kbd "Ŧ") (kbd "M-T"))
(global-set-key (kbd "M-T")  'sp-transpose-sexp)
