(prelude-require-package 'use-package)
(require 's)

(use-package
  org-roam
  :ensure t
  ;; :hook org-mode
  :custom
  (org-roam-directory "~/Documents/org_files")
  (org-roam-index-file "decks/index.org")
  (org-roam-capture-templates
   (let ((s (s-join
             "\n"
             '("#+TITLE: ${title}\n#+OPTIONS: toc:nil"
               "#+ROAM_ALIAS: %(s-dashed-words \"${title}\")"
               "#+filetags: %(s-dashed-words \"${title}\")"
               "#+DATE: %<%Y-%m-%d>"
               ""
               "* ${title}"))))
     (list (list "d" "default" 'plain "%?"
                 :target (list 'file+head "cards/%<%Y%m%d%H%M%S>-${slug}" s)
                 :unnarrowed t))))
  :bind  (("C-c n l" . org-roam-buffer-toggle)
          ("C-c n f" . org-roam-node-find)
          ("C-c n g" . org-roam-graph)
          ("C-c n i" . org-roam-node-insert)
          ("C-c n c" . org-roam-capture)
          ;; Dailies
          ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode)
  (require 'org-roam-protocol))

;; (use-package
;;   org-roam-ui
;;   :ensure t
;;   :after org-roam
;;   ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;   ;;         a hookable mode anymore, you're advised to pick something yourself
;;   ;;         if you don't care about startup time, use
;;   ;;  :hook (after-init . org-roam-ui-mode)
;;   :config
;;   (setq org-roam-ui-sync-theme t
;;         org-roam-ui-follow t
;;         org-roam-ui-update-on-save t
;;         org-roam-ui-open-on-start t)
;;   :bind (:map
;;          org-roam-mode-map
;;          (("C-c n g" . org-roam-ui))))

(use-package
 deft
 :after org
 :bind ("C-c n d" . deft)
 :custom
 (deft-recursive t)
 (deft-use-filter-string-for-filename t)
 (deft-default-extension "org")
 (deft-directory org-roam-directory)
 (deft-ignore-file-regexp ".*docs-md.*"))


;; (setq
;;  org-roam-capture-templates
;;  (let ((s (s-join
;;            "\n"
;;            '("#+TITLE: ${title}\n#+OPTIONS: toc:nil"
;;              "#+ROAM_ALIAS: %(s-dashed-words \"${title}\")"
;;              "#+ROAM_TAGS: %(s-dashed-words \"${title}\")"
;;              "#+DATE: %<%Y-%m-%d>"
;;              ""
;;              "* ${title}"))))
;;    (list (list "d" "default" 'plain '(function org-roam-capture--get-point)
;;                "%?"
;;                :file-name "cards/%<%Y%m%d%H%M%S>-${slug}"
;;                :head s
;;                :unnarrowed t))))
