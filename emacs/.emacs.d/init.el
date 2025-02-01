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

(use-package doom-themes
  :straight t
  :config
  (load-theme 'doom-dracula t)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package nerd-icons)
(use-package doom-modeline
  :init (doom-modeline-mode 1))

(make-directory "~/.emacs.d/autosaves/" t)
(setq backup-directory-alist '((".*" . "~/.emacs.d/autosaves")))

(use-package vertico
  :custom (vertico-cycle t)
  :init (vertico-mode))

(use-package consult
  :bind (("C-s" . consult-line)))

(use-package marginalia
  :after vertico
  :init (marginalia-mode))

(use-package corfu
  :after orderless
  :init (global-corfu-mode)
  :custom (corfu-auto t))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package all-the-icons)
(use-package dirvish
  :after evil
  :init (dirvish-override-dired-mode)
  :config (evil-define-key 'normal dirvish-mode-map (kbd "TAB") 'dirvish-subtree-toggle))

(defun do/org-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org
  :straight (:type built-in)
  :bind (("C-c c" . org-capture))
  :hook
  ((org-mode . do/org-setup)
   (org-agenda-mode . org-agenda-entry-text-mode))
  :config
  (setq org-capture-templates
       	'(
	  ("w" "Work journal" entry (file+datetree "~/org/work-journal.org")
       	   "* %?\nEntered on %U\n" :empty-lines 1)
	  ("a" "Work accomplishments" entry (file+datetree "~/org/work-accomplishments.org")
       	   "* %?\n" :empty-lines 1 :tree-type month)
	  ))
  (setq org-todo-keywords
        '((sequence "TODO" "DOING" "HOLD" "|" "CANCELLED" "DONE")))
  (setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))
  (setq org-agenda-span 14))

(use-package org-bullets
  :after org
  :hook
  (org-mode . (lambda () (org-bullets-mode 1))))

(use-package ob
  :straight (:type built-in)
  :after org
  :init
  (setq org-babel-python-command "python3")
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (shell . t)
     (dot . t))))

(with-eval-after-load 'org
  (setq org-latex-logfiles-extensions
        (quote ("aux" "bbl" "blg" "fdb_latexmk" "fls" "out" "toc" "lof" "tex"))))

(use-package org-ref
  :disabled
  :after org)

(use-package toc-org
  :hook (org-mode . toc-org-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 1))

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

(use-package magit)

(use-package rust-ts-mode
  :mode "\\.rs\\'"
  :hook (rust-ts-mode . eglot-ensure))

(use-package project
  :straight (:type built-in)
  :init
  (setq project-vc-extra-root-markers '("Cargo.toml")))

(use-package treemacs)
(use-package treemacs-evil
  :after treemacs)
