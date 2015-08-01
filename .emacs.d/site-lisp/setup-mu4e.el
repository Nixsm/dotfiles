;; Mu4e

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
 
 ;; attachment dir
 mu4e-attachment-dir  "~/Documents/"
 ;; insert sign
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

(provide 'setup-mu4e)
