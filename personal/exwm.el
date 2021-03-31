(require 'dash)

(defun init-exwm ()
  (interactive)

  (use-package exwm
    :ensure t
    :config

    (defun exwm-rename-buffer ()
      (interactive)
      (exwm-workspace-rename-buffer
       (concat exwm-class-name ":"
               (if (<= (length exwm-title) 50) exwm-title
                 (concat (substring exwm-title 0 49) "...")))))

    (add-hook 'exwm-update-class-hook 'exwm-rename-buffer)
    (add-hook 'exwm-update-title-hook 'exwm-rename-buffer)

    (setq exwm-input-prefix-keys
          '(?\C-x
            ?\C-u
            ?\C-h
            ?\M-x
            ?\M-1
            ?\M-2
            ?\M-3
            ?\M-4
            ?\M-&
            ?\M-:
            ?\C-'
            ?\s-'
            ?\C-§
            ?\M-«
            ?\M-»
            ?\M-“
            ?\M-đ
            ?\M-ł))

    (setq exwm-input-simulation-keys
          '(;; movement
            ([?\C-b] . [left])
            ([?\M-b] . [C-left])
            ([?\C-f] . [right])
            ([?\M-f] . [C-right])
            ([?\M-đ] . [C-right])
            ([?\C-p] . [up])
            ([?\C-n] . [down])
            ([?\C-a] . [home])
            ([?\C-e] . [end])
            ([?\C-g] . [escape])
            ([?\M-v] . [prior])
            ([?\M-“] . [prior])
            ([?\C-v] . [next])
            ([?\C-d] . [delete])
            ([?\C-k] . [S-end delete])
            ([?\C-\_] . [?\C-z])
            ([?\C-0] . [C-w]) ;; close tabs

            ;; cut/paste.
            ([?\C-w] . [?\C-x])
            ([?\M-w] . [?\C-c])
            ([?\C-y] . [?\C-v])

            ;; search
            ([?\C-s] . [?\C-f])))

    (exwm-input--set-simulation-keys exwm-input-simulation-keys)

    (define-key global-map [?\s-a] 'counsel-linux-app)
    (define-key global-map [?\s-'] 'exwm-workspace-switch)
    (define-key global-map [s-left] 'windmove-left)
    (define-key global-map [s-right] 'windmove-right)

    (exwm-enable)))

(defun dph.exwm.win/system-monitors ()
  (interactive)
  ;; (tab-new 0)

  ;; you can only have a single gnome-system-monitor
  ;; (start-process-shell-command "system-monitor" nil "gnome-system-monitor -r")

  ;; (start-process-shell-command "firefox" nil "firefox")
  ;; (call-process "gtk-launch" nil 0 nil "htop")

  (dph.windows/make 1)
  (start-process-shell-command "htop" nil "gnome-terminal -e htop")
  (start-process-shell-command "system-monitor" nil "gnome-system-monitor")
  (sit-for 2)
  (dph.windows/make 4)
  (select-window (frame-first-window))
  (other-window 1)
  (switch-to-buffer "Gnome-system-monitor:System Monitor"))

;; (dph.exwm.win/system-monitors)
