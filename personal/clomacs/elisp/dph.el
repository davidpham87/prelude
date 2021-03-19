(require 'cider)
(require 'nrepl-client)
(require 'cl-lib)
(require 'clomacs)
(require 'parseedn)
(require 's)

(bbmacs-init)

(clomacs-defun
 dph/clj-jetdotter-convert
 convert
 :namespace jetdotter.core
 :doc "Convert string from one format to the other")

(clomacs-defun
 dph/clj-jetdotter-keywordize-keys
 keywordize-keys
 :namespace jetdotter.core
 :doc "Convert string from one format to the other")

(clomacs-defun
 dph/clj-lein->deps
 lein->deps
 :namespace utils
 :doc "Convert lein deps into deps.edn")

;; (defun dph/nrepl-callback (response)
;;   (let ((f (nrepl-make-response-handler
;;             (current-buffer)
;;             (lambda (_buffer value) (concat "val:" value))
;;             (lambda (_buffer out) (cider-repl-emit-interactive-stdout out))
;;             (lambda (_buffer err) (cider-handle-compilation-errors err (current-buffer))) '())))
;;     (funcall f response)))

;; (clomacs-defun
;;  dph/test-async
;;  main
;;  :call-type :async
;;  :callback (lambda (r) (dph/nrepl-callback r))
;;  :namespace hello
;;  :doc "Main test")

;; (clomacs-defun
;;  dph/test-sync
;;  main
;;  :namespace hello
;;  :doc "Main test")

(defun dph/default-args (s default)
  (if (or (and (char-or-string-p s) (s-blank? s))
          (null s))
      default s))

(defun dph/data-from->to (&optional source-format target-format)
  "Convert between different format :transit, :edn, :json, :yml."
  (interactive
   (let ((read-symbol (lambda (s) (thread-first s read-string parseedn-read-str))))
     (list
      (dph/default-args (funcall read-symbol "Source format [default :json]: ") :json)
      (dph/default-args (funcall read-symbol "Target format [default :edn]: ") :edn))))
  (save-excursion
    (let ((s (dph/clj-jetdotter-convert
              (buffer-substring-no-properties (region-beginning) (region-end))
              source-format
              target-format)))
      (delete-region (region-beginning) (region-end))
      (insert s))))

;; the most used conversion

(defun dph/data-json->edn ()
  "Convert region from json to edn"
  (interactive)
  (dph/data-from->to :json :edn))

(defun dph/data-edn->json ()
  "Convert region from edn to json"
  (interactive)
  (dph/data-from->to :edn :json))

(defun dph/data-edn->yaml ()
  "Convert region from edn to yaml"
  (interactive)
  (dph/data-from->to :edn :yaml))

(defun dph/data-yaml->edn ()
  "Convert region from yaml to edn"
  (interactive)
  (dph/data-from->to :yaml :edn))

(defun dph/data-js->edn ()
  "Hack function to transform pure data objects defined in javascript into pure data edn."
  (interactive)
  (let ((s (thread-first
               (s-replace-all '((":" . "") ("'" . "\""))
                              (buffer-substring-no-properties
                               (region-beginning) (region-end)))
             dph/clj-jetdotter-keywordize-keys)))
    (delete-region (region-beginning) (region-end))
    (insert s)))

(defun dph/lein->deps ()
  "Hack function to transform pure data objects defined in javascript into pure data edn."
  (interactive)
  (let ((s (thread-first
               (buffer-substring-no-properties
                (region-beginning) (region-end))
             dph/clj-lein->deps)))
    (delete-region (region-beginning) (region-end))
    (insert s)))

;; (parseedn-read-str (clj-rand-int 10))
;; (dph-clj-jetdotter-convert "{:api {:a 3 :b 2 :c [1 2 34]}}" :edn :json)
;; (bbmacs-bb-process)
;; (bbemacs-test "Hello world!")
;; (bbemacs-test '(:a 3 :b 3))
;; (bbemacs-test '(:a 3 :b 3 :c [1 2 3 4]))
;; (bbemacs-test)

;; {:api {:a 3, :b 2, :c [1 2 34]}}
;; {:api {:a 3, :b 2, :c [1 2 34]}}


;; (dph/clj-jetdotter-keywordize-keys "{a 3, b 2, c [1 2 34]}")
;; (dph/test-async)
;; ;; (dph/test-sync)
;; (dph/clj-jetdotter-keywordize-keys-async "{a 3, b 2, c [1 2 34]}")

;; lang-clojure.el ends here
