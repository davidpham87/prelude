(setq prelude-minimalistic-ui t)
(setq enable-recursive-minibuffers t) ;; bug in helm + exwm

(with-eval-after-load 'package
  (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/")))
