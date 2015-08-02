;; disable touchpad when on emacs
 
(defun turn-off-mouse (&optional frame)
  (interactive)
  (shell-command "xinput --disable bcm5974"))

(defun turn-on-mouse (&optional frame)
  (interactive)
  (shell-command "xinput --enable bcm5974"))

(add-hook 'focus-in-hook #'turn-off-mouse)
(add-hook 'focus-out-hook #'turn-on-mouse)
(add-hook 'delete-frame-functions #'turn-on-mouse)

(provide 'setup-xinput)
