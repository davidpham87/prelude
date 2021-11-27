# Emacs + Clojure = Babashka + Clomacs

This project describe how you can interact emacs with clojure through babashka.

# Why?

I love Clojure and Emacs, but never managed to learn common-lisp or elisp for
big programs, so I tried to found a solution about how to be able to hack in
emacs. One of the downside of elisp is it does not support asynchronous code as
well.

Babahska is a cross platform battery included version Clojure built with
GraalVM with really fast startup time, includes nrepl server, offers a solution
for concurrency. It is extremely to install (just download the binary and put
it on your `$PATH`).

[Clomacs](https://github.com/clojure-emacs/clomacs) allows to communicate
between emacs and a nrepl server.

This repository shows how you can set up clomacs and babashka to start
hacking

# Example of usage

Let's define `utils` clojure `ns`

``` clojure
(ns utils
  (:require
   [clojure.edn :as edn]
   [clojure.pprint]
   [clojure.string :as str]))

(defn pretty-format [x]
  (with-out-str (clojure.pprint/pprint x)))

(defn lein->deps [s]
  (->>
   (for [[p v] (edn/read-string s)] [p {:mvn/version v}])
   (into {})
   pretty-format))

(defn sym->map [s]
  (let [xs (-> s
               (str/split #" ")
               sort)]
    (->
     (zipmap (map keyword xs) (map symbol xs))
     pretty-format)))
```
This is an elisp function that calls a clojure function that parse the lein
deps and return deps.edn map.

``` emacs-lisp
(clomacs-defun
 dph/clj-lein->deps
 lein->deps
 :namespace utils
 :doc "Convert lein deps into deps.edn")

(dph/clj-lein->deps
 "[[datascript/datascript \"1.10.0\"]
   [reagent/reagent \"1.10.0\"]]")

;; => "{datascript/datascript {:mvn/version \"1.10.0\"}
;;      reagent/reagent {:mvn/version \"1.10.0\"}}"

(clomacs-defun
 dph/clj-sym->map
 sym->map
 :namespace utils
 :doc "Convert a region of symbols into a clojure map")

(dph/clj-sym->map "foo bar opts")
;; "{:bar bar, :foo foo, :opts opts}"

```

Usually, you desire to mark a region and apply a function to its content. Let's
define this function and wrap the previous ones.

``` emacs-lisp
(defun dph/replace-region-with-result (f)
  (let ((s (funcall f
                    (buffer-substring-no-properties
                     (region-beginning) (region-end)))))3
                     (delete-region (region-beginning) (region-end))
                     (insert s)))

(defun dph/lein->deps ()
  "Hack function to transform pure data objects defined in javascript into pure data edn."
  (interactive)
  (dph/replace-region-with-result 'dph/clj-lein->deps))

(defun dph/sym->map ()
  (interactive)
  (dph/replace-region-with-result 'dph/clj-sym->map))
```

Now, if you mark the region with `foo bar opts` and call `M-x dph/sym->map` the region will be replaced with `{:bar bar, :foo foo, :opts opts}`.

So you can write your own content manipulation with clojure and all its
library, instead of the elisp. A more convoluted example could be that you want
to interact with the shell, or make API calls, which is much easier in
Clojure/Babashka.

# Installation


## Babashka

Install [babashka](https://github.com/borkdude/babashka) and have it on your
path.

## Clomacs

Clone this repository and make a link to `~/.emacs.d/personal/clomacs/` (or copy it
directly there).

Then save the following code in a file and import it.

``` emacs-lisp
(require 'cl-lib)
(require 'clomacs)
(require 'cider)
(require 'parseedn)

(setq bbmacs-clomacs-dir "~/.emacs.d/clomacs/")
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
```

Then somewhere in your `init.el` file call

``` emacs-lisp
(bbmacs-init) ;; calls babashka and download the deps.
```

Sometimes, the starting time of babashka will be too slow, and cider will fail
to connect. Call `(bbmacs-connect)` to connect to the repl.

Use the the elisp `clomacs-fun` to link your clojure code and emacs. You are
not forced to keep the `:lib-name` argument empty, but then pay attention to
conflict between repls.

## Parseedn

Parseedn allows to parse the resulting edn into elisp format..

## Location of the library

The reason to put the library in the suggested location is to avoid conflicting
with your other Clojure repls as clomacs will look for `clomacs` cider repl by
default.

# Performance

Don't forget that your making call to the nrepl at each evaluation of clomacs
function, so make sure to balance between composability and performance.
