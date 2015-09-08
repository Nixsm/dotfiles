;; emacs configuration

;; disable menu bar and tool bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; set cursor type
(setq-default cursor-type 'bar)

;; disable startup screen, set column number, etc
(setq-default inhibit-startup-screen t
	      column-number-mode t
	      line-number-mode t
	      fill-column 80
	      use-dialog-box nil)

;; tabs to space
(setq-default indent-tabs-mode nil)
(setq-default standard-indent 4)
(setq default-tab-width 4)
(setq-default c-basic-offset 4)

;; display time
(display-time-mode)

;; display battery stats
(display-battery-mode 1)

;; line number
(setq linum-format "%4d \u2502 ")
(global-linum-mode t)

;; save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; highlight current line
(global-hl-line-mode t)

; start emacs with empty file
(setq inhibit-splash-screen t)
(switch-to-buffer "**")

; completion splits horizontally
(setq split-width-threshold nil)

; ido-mode
(require 'ido)
(ido-mode t)

; winner mode
(when (fboundp 'winner-mode)
  (winner-mode 1))

; windmove
(windmove-default-keybindings)

; CamelCase distinction
(global-subword-mode t)

; yes/no to y/n
(fset 'yes-or-no-p 'y-or-n-p)

; read only prompt
(setq comint-prompt-read-only t)

; add homebrew's path
(add-to-list 'exec-path "/usr/local/bin")

; show matching parenthesis
(show-paren-mode 1)

;; backup
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; set font
(set-frame-font "Inconsolata-14")

