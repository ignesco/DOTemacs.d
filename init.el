
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
(package-initialize)

(setq backup-directory-alist `(("." . "~/.emacs_saves")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; File name: ` ~/.emacs '
;;; ---------------------
;;;
;;; If you need your own personal ~/.emacs
;;; please make a copy of this file
;;; an placein your changes and/or extension.
;;;
;;; Copyright (c) 1997-2002 SuSE Gmbh Nuernberg, Germany.
;;;
;;; Author: Werner Fink, <feedback@suse.de> 1997,98,99,2002
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Test of Emacs derivates
;;; -----------------------
(if (string-match "XEmacs\\|Lucid" emacs-version)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; XEmacs
  ;;; ------
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (progn
     (if (file-readable-p "~/.xemacs/init.el")
        (load "~/.xemacs/init.el" nil t))
  )
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; GNU-Emacs
  ;;; ---------
  ;;; load ~/.gnu-emacs or, if not exists /etc/skel/.gnu-emacs
  ;;; For a description and the settings see /etc/skel/.gnu-emacs
  ;;;   ... for your private ~/.gnu-emacs your are on your one.
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (if (file-readable-p "~/.gnu-emacs")
      (load "~/.gnu-emacs" nil t)
    (if (file-readable-p "/etc/skel/.gnu-emacs")
	(load "/etc/skel/.gnu-emacs" nil t)))

  ;; Custom Settings
  ;; ===============
  ;; To avoid any trouble with the customization system of GNU emacs
  ;; we set the default file ~/.gnu-emacs-custom
  (setq custom-file "~/.gnu-emacs-custom")
  (load "~/.gnu-emacs-custom" t t)
;;;
)
;;;
(setq inhibit-startup-message t)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(setq-default fill-column 500)
(setq ring-bell-function 'ignore)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq standard-indent 2)
(global-set-key (kbd "TAB") 'tab-to-tab-stop);


;(menu-bar-mode -1) (tool-bar-mode -1) (scroll-bar-mode -1)
(setq initial-scratch-message "*************************\n***** Welcome Chime *****\n*************************\n")

(defun my-use-region-p ()
  "Return t if Transient Mark mode is enabled and the mark is active."
  (and transient-mark-mode mark-active))

(defun my-indent-region (N)
  (interactive "p")
  (if (my-use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N 4))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(defun my-unindent-region (N)
  (interactive "p")
  (if (my-use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N -4))
             (setq deactivate-mark nil))
    (self-insert-command N)))


(defun my-indent-region-with-space (N)
  (interactive "p")
  (if (my-use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N 1))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(defun my-unindent-region-with-space (N)
  (interactive "p")
  (if (my-use-region-p)
      (progn (indent-rigidly (region-beginning) (region-end) (* N -1))
             (setq deactivate-mark nil))
    (self-insert-command N)))

(global-set-key (kbd "C->") 'my-indent-region)
(global-set-key (kbd "C-<") 'my-unindent-region)

(global-set-key (kbd "C--") 'shrink-window)
(global-set-key (kbd "C-=") 'enlarge-window)

(global-set-key (kbd "C-M--") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-=") 'enlarge-window-horizontally)

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)

(add-to-list 'auto-mode-alist '("\\.procedure\\'" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.hdbprocedure\\'" . sql-mode))

(global-set-key "\C-x\C-b" 'buffer-menu)

(global-set-key "\C-\M-w" '(lambda (n) (interactive "p") 
        (delete-region (region-beginning) (region-end))
        (keyboard-quit)
    )
)

(add-to-list 'load-path "~/.emacs.d/lisp")
(load "zenburn-theme.el")

(load "haskell-mode-2.8.0/haskell-site-file")

(setq tab-stop-list (number-sequence 4 200 4))
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

; font size 12pt
(set-face-attribute 'default nil :height 140)

(defun scroll-up-one-line()
  (interactive)
  (scroll-up 1))

(defun scroll-down-one-line()
  (interactive)
  (scroll-down 1))

(global-set-key (kbd "C-,") 'scroll-up-one-line)
(global-set-key (kbd "C-.") 'scroll-down-one-line)
(setq column-number-mode t)
(global-unset-key (kbd "C-z"))

;jdb key bindings
(global-set-key (kbd "M-<f1>") '(lambda (n) (interactive "p") (insert "stepi") (comint-send-input) ))
(global-set-key (kbd "M-<f2>") '(lambda (n) (interactive "p") (insert "next") (comint-send-input)  ))
(global-set-key (kbd "M-<f3>") '(lambda (n) (interactive "p") (insert "read debug") (comint-send-input)  ))
