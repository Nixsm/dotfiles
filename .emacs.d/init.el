;; package manager

(if (eq system-type 'darwin)
	(require 'cask "/usr/local/share/emacs/site-lisp/cask.el")
	(require 'cask "/home/ephexeve/.cask/cask.el"))

(cask-initialize)

;; keep Cask file in sync with packages installed from M-x list-packages
; (require 'pallet)

;; source custom file

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)

		(t "~/.emacs.d/")))
(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(load-user-file "custom.el")
(load-user-file "plugs.el")
