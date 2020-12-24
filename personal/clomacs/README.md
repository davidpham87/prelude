# Emacs + Clojure = Babasha+Clomacs

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

This repository provides shows how you can set up clomacs and babashka to start
hacking

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

Parseedn allows to parse the resulting edn into elisp format as well.

## Location of the library

The reason to put the library in the suggested location is to avoid conflicting
with your other Clojure repls as clomacs will look for `clomacs` cider repl by
default.

# Performance

Don't forget that your making call to the nrepl at each evaluation of clomacs
function, so make sure to balance between composability and perfromance.
