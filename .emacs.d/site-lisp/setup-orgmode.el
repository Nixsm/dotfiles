;; Org mode package configuration
(require 'org)

(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on

;; keybindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-log-done t)

;; org-mode directory
(setq org-agenda-files '("~/Documents/org"))
(setq org-src-fontify-natively t)

(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode t))
          t)

; quick notes
(setq org-default-notes-file (expand-file-name "~/Documents/org/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

;; custom todo-keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)")
        (sequence "FEEDBACK(e)" "|" "VERIFY(v)")
        (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
        (sequence "|" "CANCELED(c)")))

(provide 'setup-orgmode)
