;; common lisp features
(require 'cl)

;; turn off welcome screen & tool-bar
(setq inhibit-startup-message t)
(tool-bar-mode -1)

;; show column number
(setq column-number-mode t)

;; set up package archives
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; use-package - simplifies package management
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; try - try packages before you buy
(use-package try
	     :ensure t)

;; ido - interactive do
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; lorem-ipsum
(use-package lorem-ipsum
  :ensure t)

;; flycheck
(use-package flycheck
  :ensure t
  :init 
  (global-flycheck-mode t))

;; yasnippet 
(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t)

;; undo-tree
(use-package undo-tree
  :ensure t
  :init 
  (global-undo-tree-mode))

;; slime
(use-package slime
  :ensure t)

;; psvn
(use-package psvn
  :ensure t)


;; web-mode
(use-package web-mode
  :ensure t
  :config 
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-enable-auto-expanding t))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))


;; general setup stuff
;; this speeds up Tramp mode
(setq tramp-default-method "ssh")

;; allow narrowing
(put 'narrow-to-region 'disabled nil)


;; my functions
(defun c-get-declaration ()
  "extract the next C function declaration"
  (save-excursion
    (let ((start 0))
      (c-beginning-of-defun -1)
      (setq start (point))
      (c-end-of-statement)
      (buffer-substring start (point)))))

(defun forward-whitespace (n)
  "Move forward to the Nth next whitespace character"
  (interactive "p")
  (if (re-search-forward "[ \t\n]+" nil t n)
      (goto-char (match-beginning 0))))

(defun view-file-in-region (start end)
  "View the filename between START and END"
  (interactive "r")
  (let ((file-name (buffer-substring start end)))
    (if (file-exists-p file-name)
	(find-file-other-window file-name))))

;; Use C-n as a prefix for my commands
(define-prefix-command 'ntc-map)
(global-set-key "\C-n" 'ntc-map)
(global-set-key "\C-no" 'view-file-in-region)
(global-set-key "\C-nw" 'forward-whitespace)


