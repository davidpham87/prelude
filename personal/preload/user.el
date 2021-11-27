(setq prelude-minimalistic-ui t)
(setq enable-recursive-minibuffers t) ;; bug in helm + exwm
(setq org-roam-v2-ack t)

(with-eval-after-load 'package
  (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/")))
