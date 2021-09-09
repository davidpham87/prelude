(prelude-require-package 'use-package)
(require 's)

(use-package
  org-roam
  :ensure t
  :hook org-mode
  :custom
  (org-roam-directory "~/Documents/org_files")
  (org-roam-index-file "decks/index.org")
  (org-roam-capture-templates
   (let ((s (s-join
             "\n"
             '("#+TITLE: ${title}\n#+OPTIONS: toc:nil"
               "#+ROAM_ALIAS: %(s-dashed-words \"${title}\")"
               "#+ROAM_TAGS: %(s-dashed-words \"${title}\")"
               "#+DATE: %<%Y-%m-%d>"
               ""
               "* ${title}"))))
     (list (list "d" "default" 'plain '(function org-roam-capture--get-point)
                 "%?"
                 :file-name "cards/%<%Y%m%d%H%M%S>-${slug}"
                 :head s
                 :unnarrowed t))))
  :bind (:map
         org-roam-mode-map
         (("C-c n l" . org-roam)
          ("C-c n f" . org-roam-find-file)
          ("C-c n b" . org-roam-switch-to-buffer)
          ("C-c n g" . org-roam-graph))
         :map org-mode-map
         (("C-c n i" . org-roam-insert))))

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
