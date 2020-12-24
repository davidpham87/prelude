(prelude-require-package 'use-package)

(use-package flycheck-clj-kondo
  :hook clojure-mode
  :ensure t)

(use-package clomacs
  :ensure t)

(use-package cider
  :ensure t)

(require 'cl-lib)
(require 'clomacs)
(require 'cider)
(require 'parseedn)

(setq bbmacs-clomacs-dir "~/.emacs.d/personal/clomacs/")
(setq bbmacs-port 1659)

(defun bbmacs-connect ()
  (interactive)
  (cider-connect-clj
   (list :host "localhost"
         :port bbmacs-port
         :project-dir bbmacs-clomacs-dir)))

(cl-defun bbmacs-bb-process
    (&optional (dir bbmacs-clomacs-dir) (port bbmacs-port))
  (let ((default-directory dir)
        (port (number-to-string port)))
    (make-process
     :name "bbmacs-nrepl"
     :buffer (concat "*bbmacs-nrepl" port "*")
     :command `("bb" "-f" "init.clj" ,port))))

(defun bbmacs-init ()
  (interactive)
  (bbmacs-bb-process bbmacs-clomacs-dir bbmacs-port)
  (sleep-for 0 100)
  (bbmacs-connect))

(bbmacs-init)

;; (clomacs-defun
;;  bbemacs-test
;;  main
;;  :namespace hello
;;  :doc "Test clomacs")

;; (clomacs-defun
;;  bbemacs-test
;;  main
;;  :namespace hello
;;  :doc "Test clomacs")

;; (clomacs-defun
;;  clj-rand
;;  rand
;;  :call-type :sync
;;  :namespace clojure.core
;;  :doc "Clojure")

;; (clomacs-defun
;;  clj-rand-int
;;  rand-int
;;  :call-type :sync
;;  :namespace clojure.core
;;  :doc "Clojure")

;; (clomacs-defun
;;  clj-str-split
;;  split
;;  :call-type :sync
;;  :namespace clojure.string
;;  :doc "Clojure")

;; (clomacs-defun
;;  hello-split
;;  split
;;  :namespace hello
;;  :doc "Clojure")

;; (parseedn-read-str (clj-rand-int 10))
;; (bbmacs-bb-process)
;; (bbemacs-test "Hello world!")
;; (bbemacs-test '(:a 3 :b 3))
;; (bbemacs-test '(:a 3 :b 3 :c [1 2 3 4]))
;; (bbemacs-test)
