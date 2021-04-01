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

(defun dph.exwm.win/select-windows (n)
  (dotimes (i n)
    (other-window 1)
    (switch-to-buffer (other-buffer (current-buffer)))))

(defun dph.exwm.win/system-monitors ()
  (interactive)

  (tab-new 1)
  (tab-rename "System Monitors")

  (dph.windows/make 1)

  (start-process-shell-command "htop" nil "gnome-terminal -e htop")
  (start-process-shell-command "system-monitor" nil "gnome-system-monitor")

  (sit-for 3)
  (dph.windows/make 2)
  (select-window (frame-first-window))
  (other-window 1))

(defun dph.exwm.win/chats ()
  (interactive)
  (tab-new 1)
  (tab-rename "Chats")
  (dph.windows/make 4)

  (start-process-shell-command "signal" nil "signal-desktop")
  (start-process-shell-command "whatsapp" nil "google-chrome --new-window web.whatsapp.com")
  (start-process-shell-command "chats" nil "google-chrome --new-window
   https://app.slack.com/client/T03RZGPFR/C8NUSGWG6/thread/C0KL616MN-1599922108.113000
   https://discord.com/channels/808815302941868063/808815302941868065
   https://clojurians.zulipchat.com/#narrow")

  (sit-for 2)
  (dph.exwm.win/select-windows 3))

(defun dph.exwm.win/home ()
  (interactive)
  (tab-new 1)
  (tab-rename "Music+News")
  (dph.windows/make-2+1)

  (start-process-shell-command "music" nil "google-chrome --new-window
   https://music.youtube.com")
  (start-process-shell-command "Browse" nil "google-chrome")
  (start-process-shell-command "news" nil "google-chrome --new-window
   https://www.nytimes.com/
   https://www.pressreader.com/catalog
   https://www.newscientist.com/")

  (sit-for 1)
  (dph.exwm.win/select-windows 2))

;; (dph.exwm.win/system-monitors)
