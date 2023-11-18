(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(setq straight-use-package-by-default t)
(setq straight-check-for-modifications nil)

(use-package gcmh)
(setq gcmh-idle-delay 'auto
      gcmh-auto-idle-delay-factor 10
      gcmh-high-cons-threshold (* 16 1024 1024))

(use-package nerd-icons)
(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package vertico
  :custom
  (vertico-cycle t)
  :init (vertico-mode))

(use-package consult
  :bind (("C-s" . consult-line)))

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

(defun do/org-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org
  :straight (:type built-in)
  :hook
  ((org-mode . do/org-setup)
   (org-agenda-mode . org-agenda-entry-text-mode))
  :config
  (setq org-todo-keywords
        '((sequence "TODO" "DOING" "HOLD" "|" "CANCELLED" "DONE")))
  (setq org-agenda-files (directory-files-recursively "~/knowledge/" "\\.org$"))
  (setq org-agenda-span 14))

(with-eval-after-load 'org
  (setq org-babel-python-command "python3")
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (shell . t)
     (ditaa . t))))

(with-eval-after-load 'org
  (setq org-latex-logfiles-extensions
        (quote ("aux" "bbl" "blg" "fdb_latexmk" "fls" "out" "toc" "lof" "tex"))))

(use-package org-ref
  :disabled
  :after org)

(use-package toc-org
  :hook (org-mode . toc-org-mode))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package clojure-mode
  :mode "\\.clj\\'")
(use-package cider
  :after clojure-mode)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-c-i-jump nil)
  :config (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init)
  :custom
  (evil-collection-setup-minibuffer t))
