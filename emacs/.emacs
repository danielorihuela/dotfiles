;; -*- mode: elisp -*-

;;;; EMACS CONFIGURATION
;; Disable the splash screen
(setq inhibit-splash-screen t)
;; Disable some ui
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
;; Add margin
(set-fringe-mode 10)
(global-display-line-numbers-mode t)
;; Make gui take all space
(setq frame-resize-pixelwise t)
;; Set font height to 18
(set-face-attribute 'default nil :height 180)

;; Set indent to 4
(setq-default tab-width 4)
(setq-default evil-shift-width tab-width)
(setq-default indent-tabs-mode nil)

;;;; CONFIGURE PACKAGES
;; Initialize package sources
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Create package list in fresh install
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


(use-package monokai-pro-theme
  :config
  (load-theme 'monokai-pro t))


(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :config
  (setq markdown-split-window-direction 'right))


(setq base_path "~/Desktop/emacs/")
(use-package org
  :hook
  (org-mode . (lambda()
               (org-indent-mode)
               (visual-line-mode 1)))
  :config
  (setq org-todo-keywords
        '(sequence "TODO" "NEXT" "WAITING" "|" "CANCELLED" "DONE"))
  (setq org-todo-keyword-faces
        '(("TODO" :foreground "#FF2C6D" :weight bold)
          ("NEXT" :foreground "#45A9F9" :weight bold)
          ("WAITING" :foreground "#FFB86C" :weight bold)
          ("CANCELED" :foreground "#19f9d8" :weight bold)
          ("DONE" :foreground "#19f9d8" :weight bold)))
  (setq org-agenda-files
        (directory-files-recursively base_path "\.org"))
  (plist-put org-format-latex-options :scale 2.0))

(use-package org-roam
  :hook
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory "~/Desktop/emacs/KnowledgeBase/")
  :bind
  (:map org-roam-mode-map
        (("C-c n l" . org-roam)
         ("C-c n f" . org-roam-find-file)
         ("C-c n g" . org-roam-graph))
        :map org-mode-map
        (("C-c n i" . org-roam-insert))
        (("C-c n I" . org-roam-insert-immediate))))


(use-package ivy
  :diminish (ivy-mode . "")
  :init (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 15)
  (setq ivy-count-format "(%d/%d) "))

(use-package ivy-rich
    :init
    (ivy-rich-mode 1))

(use-package counsel
  :bind*
  (("M-x"     . counsel-M-x)
   ("C-s"     . swiper)
   ("C-x C-f" . counsel-find-file)
   ("C-x C-r" . counsel-recentf)
   ("C-c g"   . counsel-git)    
   ("C-c j"   . counsel-git-grep)
   ("C-c /"   . counsel-ag)      
   ("C-x l"   . counsel-locate)
   ("<f1> f"  . counsel-describe-function)
   ("<f1> v"  . counsel-describe-variable)
   ("<f1> l"  . counsel-find-library)
   ("<f2> i"  . counsel-info-lookup-symbol)
   ("<f2> u"  . counsel-unicode-char)
   ("C-c C-r" . ivy-resume)))


(use-package magit)


(use-package clojure-mode)
(use-package cider)

(use-package julia-repl)
(use-package julia-mode
  :hook (julia-mode . julia-repl-mode))

;;;; MY OWN FUNCTIONS
;; Archive all TODO tasks in current file
(defun -archive-tasks (tag)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
   tag 'file))

(defun archived-finished-tasks ()
  (interactive)
  (-archive-tasks "/DONE")
  (-archive-tasks "/CANCELLED"))

;; Open Books in a kanban fashion
(setq books_read (concat base_path "books_read.org"))
(setq books_next (concat base_path "books_next.org"))
(setq books_backlog (concat base_path "books_backlog.org"))

(defun books ()
  (interactive)
  (let ((read (find-file-noselect books_read))
        (next (find-file-noselect books_next))
        (backlog (find-file-noselect books_backlog)))
    (delete-other-windows)
    (switch-to-buffer next)
    (window--display-buffer
     read (split-window (selected-window) nil 'left)
     'window  display-buffer-mark-dedicated)
    (window--display-buffer
     backlog (split-window (selected-window) nil 'right)
     'window  display-buffer-mark-dedicated))
  (command-execute 'balance-windows))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
        (quote
         (cider clojure-mode magit org-roam ivy-rich counsel julia-mode markdown-mode use-package monokai-pro-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
