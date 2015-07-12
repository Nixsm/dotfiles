; plugins
(add-to-list 'load-path "~/.emacs.d/lisp") ; path to plugins
(load "linum-off")

; clipboard for osx (share clipboard)
(require 'pbcopy)
(turn-on-pbcopy)

; load solarized-theme
; https://github.com/sellout/emacs-color-theme-solarized
(if (display-graphic-p)
  (progn
        (scroll-bar-mode 0)
        (set-frame-parameter nil 'background-mode 'dark))
  (setq frame-background-mode 'dark))

(load-theme 'solarized t)

; org-mode
(require 'org)
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done t)
(setq org-agenda-files '("~/Documents/org"))
(setq org-src-fontify-natively t)

(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode t))
          t)

(setq org-default-notes-file (expand-file-name "~/Documents/org/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-todo-keywords
          '((sequence "TODO(t)" "|" "DONE(d)")
                (sequence "FEEDBACK(e)" "|" "VERIFY(v)")
                (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
                (sequence "|" "CANCELED(c)")))

; powerline
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'respectful)
(sml/setup)

; display time
(display-time-mode)
; display battery stats
(display-battery-mode 1)

; line number
(setq linum-format "%4d \u2502 ")
(global-linum-mode t)

; autopair
(require 'autopair)
(autopair-global-mode)

;; completion
(require 'ycmd)
(ycmd-setup)
(set-variable 'ycmd-server-command '("python" (expand-file-name "~/Workspace/git/ycmd/ycmd")))
(set-variable 'ycmd-global-config (expand-file-name "~/.ycm_extra_conf.py"))
(set-variable 'ycmd-request-message-level' -1)

(require 'company-ycmd)
(company-ycmd-setup)
;(add-hook 'after-init-hook 'global-company-mode)
(setq company-global-modes '(python-mode c-mode c++-mode ruby-mode))
(global-company-mode)

(require 'flycheck-ycmd)
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(mode-enabled save))

(when (not (display-graphic-p))
  (setq flycheck-indication-mode nil))

; bind company-select-next to tab
; (eval-after-load 'company
;   '(progn
;      (define-key company-active-map (kbd "TAB") 'company-select-next)
;      (define-key company-active-map [tab] 'company-select-next)))

; bind company-select-next to tab
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
     (define-key company-active-map [tab] 'company-complete-common-or-cycle)))
(setq company-selection t)
(setq company-idle-delay 0)

; disable company-mode for a few stuff
;(add-hook 'eshell-mode-hook (lambda () (company-mode -1)))
;(add-hook 'term-mode-hook (lambda () (company-mode -1)))
;(add-hook 'shell-mode-hook (lambda () (company-mode -1)))
;(add-hook 'inferior-python-mode (lambda () (company-mode -1)))

; git gutter+
(global-git-gutter-mode +1)

; magit
(setq magit-last-seen-setup-instructions "1.4.0")
(global-set-key (kbd "C-x g") 'magit-status)

; ace-jump-mode
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

; w3m
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(setq w3m-use-cookies t)
(setq w3m-coding-system 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-file-name-coding-system 'utf-8
      w3m-input-coding-system 'utf-8
      w3m-output-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8)

; virtualenvwrapper
(let ((workon-home (expand-file-name "~/.virtualenvs/")))
  (setenv "WORKON_HOME" workon-home)
  (setenv "VIRTUALENVWRAPPER_HOOK_DIR" workon-home))

; helm
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-autoresize-mode t)

(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(setq helm-buffers-fuzzy-matching t
          helm-recentf-fuzzy-match    t)

(setq helm-autoresize-max-height 25)
(helm-mode 1)

; projectile
(projectile-global-mode)

(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(require 'bookmark+)

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")

(require 'mu4e)
(require 'smtpmail)

;; default
(setq mu4e-maildir "~/.maildir")
(setq smtpmail-queue-mail t  ;; start in queuing mode)
          smtpmail-queue-dir   "~/.maildir/queue/cur")

(setq
  ;; general
  mu4e-get-mail-command "offlineimap"
  mu4e-update-interval 300

  ;; smtp
  message-send-mail-function 'smtpmail-send-it
  smtpmail-stream-type 'starttls

  ;; keybindings
  mu4e-maildir-shortcuts
      '(("/Personal/INBOX"               . ?k)
        ("/Personal/[Gmail].Trash"       . ?t)
        ("/Dev/INBOX"            		 . ?w)
        ("/Dev/Trash"                    . ?f)
		("/Univali/INBOX"                . ?u)
		("/Univali/Trash"                . ?j))

  ; attachment dir
  mu4e-attachment-dir  "~/Documents/"
  ; insert sign
  mu4e-compose-signature-auto-include 't)

(setq mu4e-html2text-command "w3m -T text/html")

(defvar my-mu4e-account-alist
  '(("personal"
     (mu4e-sent-folder "/personal/Saved Items")
     (mu4e-drafts-folder "/personal/Drafts")
     (user-mail-address "mezger.benjamin@gmail.com")
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-local-domain "personal")
     (smtpmail-smtp-user "mezger.benjamin@gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-stream-type starttls)
     (smtpmail-smtp-service 587))
    ("dev"
     (mu4e-sent-folder "/dev/Saved Items")
     (mu4e-drafts-folder "/dev/Drafts")
     (user-mail-address "ephexeve@gmail.com")
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-local-domain "dev")
     (smtpmail-smtp-user "ephexeve@gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-stream-type starttls)
     (smtpmail-smtp-service 587))
    ("univali"
     (mu4e-sent-folder "/univali/Saved Items")
     (mu4e-drafts-folder "/univali/Drafts")
     (user-mail-address "benmezger@edu.univali.br")
     (smtpmail-default-smtp-server "smtp.office365.com")
     (smtpmail-local-domain "univali")
     (smtpmail-smtp-user "benmezger@edu.univali.br")
     (smtpmail-smtp-server "smtp.office365.com")
     (smtpmail-stream-type starttls)
     (smtpmail-smtp-service 587))))

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var))
                                                my-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                             nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

;;(define-key 'mu4e-main-mode-map "C" 'mu4e-multi-compose-new)
;;(define-key 'mu4e-headers-mode-map "C" 'mu4e-multi-compose-new)
;;(define-key 'mu4e-view-mode-map "C" 'mu4e-multi-compose-new)

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
             ("marmalade" . "http://marmalade-repo.org/packages/")
             ("melpa" . "http://melpa.milkbox.net/packages/")))

(require 'session)

(setq session-save-file (expand-file-name "saves/.session" user-emacs-directory))
(add-hook 'after-init-hook 'session-initialize)

(setq save-place-file "~/.emacs.d/saves/saved-cursors")
(setq-default save-place t)
(require 'saveplace)

; exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GPG_AGENT_INFO"))

; osx-pseudo-daemon
(osx-pseudo-daemon-mode)

; elfeed
(require 'elfeed)

(global-set-key (kbd "C-x w") 'elfeed)

(setq elfeed-feeds
          '(("https://feeds.feedburner.com/justinlilly" blog computer-science)
                ("https://feeds.feedburner.com/tweakers/mixed" tweakers tech news)
                ("http://rss.cnn.com/rss/edition.rss" cnn top-stories news)
                ("http://rss.cnn.com/rss/edition_world.rss" cnn world news)
                ("http://rss.cnn.com/rss/edition_europe.rss" cnn europe news)
                ("http://www.cartacapital.com.br/atom.xml" carta-capital news)
                ("http://feeds.sciencedaily.com/sciencedaily" daily-science news science)
                ("http://export.arxiv.org/rss/cs" computer-science news arxiv)
        ("https://www.schneier.com/blog/atom.xml" computer-science security news)
                ))
(setf url-queue-timeout 30)

