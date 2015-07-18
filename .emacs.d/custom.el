; disable menu bar
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq-default cursor-type 'bar)

(setq backup-directory-alist
      `((".*" . "~/.emacs.d/saves/")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/saves/" t)))

; stuff
(setq-default inhibit-startup-screen t
			  column-number-mode t
			  line-number-mode t
			  fill-column 80
			  savehist-file "~/.emacs.d/saves/savehist"
			  use-dialog-box nil)

;; Debugging
; (setq debug-on-error t)
; (setq stack-trace-on-error t)
; (setq el-get-verbose t)

; tabs to space
(setq-default indent-tabs-mode nil)
(setq-default standard-indent 4)
(setq default-tab-width 4)
(setq-default c-basic-offset 4)

(require 'gnutls)
(add-to-list 'gnutls-trustfiles (expand-file-name "~/.emacs.d/certs/relay.cert"))

; show matching parenthesis
(show-paren-mode 1)

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

(setq comint-prompt-read-only t)

; add homebrew's path
(add-to-list 'exec-path "/usr/local/bin")

(set-frame-font "Inconsolata-9")

;; disable OSX touchpad on Emacs.
(defun turn-off-mouse (&optional frame)
    (interactive)
	  (shell-command "xinput --disable 19"))

(defun turn-on-mouse (&optional frame)
    (interactive)
	  (shell-command "xinput --enable 19"))

(add-hook 'focus-in-hook #'turn-off-mouse)
(add-hook 'focus-out-hook #'turn-on-mouse)
(add-hook 'delete-frame-functions #'turn-on-mouse)

; Emacs customs
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file (expand-file-name "~/.emacs.d/bookmarks"))
 '(session-use-package t nil (session)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(header-line ((((type tty)) :foreground "black" :background "color-245") (default :background "#839496" :foreground "#073642"))))

