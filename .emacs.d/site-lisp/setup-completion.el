;; completion
(require 'ycmd)
(ycmd-setup)
(set-variable 'ycmd-server-command '("python2" "/Users/nicholas/workspace/git/ycmd/ycmd"))
(set-variable 'ycmd-global-config "/Users/nicholas/.ycm_extra_conf.py")
(set-variable 'ycmd-request-message-level' -1)

(require 'company-ycmd)
(company-ycmd-setup)
;(add-hook 'after-init-hook 'global-company-mode)
(setq company-global-modes '(python-mode c-mode c++-mode ruby-mode cmake-mode glsl-mode))
(global-company-mode)

(require 'flycheck-ycmd)
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(mode-enabled save))

(when (not (display-graphic-p))
  (setq flycheck-indication-mode nil))

;; bind company-select-next to tab
;; (eval-after-load 'company
;;   '(progn
;;      (define-key company-active-map (kbd "TAB") 'company-select-next)
;;      (define-key company-active-map [tab] 'company-select-next)))

;; bind company-select-next to tab
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
     (define-key company-active-map [tab] 'company-complete-common-or-cycle)))
(setq company-selection t)
(setq company-idle-delay 0)

;; disable company-mode for a few stuff
;; (add-hook 'eshell-mode-hook (lambda () (company-mode -1)))
;; (add-hook 'term-mode-hook (lambda () (company-mode -1)))
;; (add-hook 'shell-mode-hook (lambda () (company-mode -1)))
;; (add-hook 'inferior-python-mode (lambda () (company-mode -1)))

(provide 'setup-completion)
