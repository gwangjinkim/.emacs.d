(setq inhibit-startup-message t)
(tool-bar-mode -1)

;; maximize window
(global-set-key (kbd "C-c M") 'toggle-frame-maximized)

(defun enlarge-my-window (&optional height-increase-lines width-increase-columns)
  "Resize the current window. Default: height by 10 lines and width by 20 columns.
               You can specify custom values for both height and width."
  (interactive
   (list
    (read-number "Increase height by (lines): " 10)  ;; Default is 10
    (read-number "Increase width by (columns): " 20)))  ;; Default is 20
  ;; Apply height and width increases
  (enlarge-window height-increase-lines)
  ;; (enlarge-window-horizontally width-increase-columns)
  (enlarge-window width-increase-columns t))

(global-set-key (kbd "C-c w") 'enlarge-my-window)


(use-package sweet-theme
  :ensure t
  :config
  (load-theme 'sweet t))

;; Icons backend (doom-modeline uses nerd-icons now)
(use-package nerd-icons
  :ensure t
  :if (display-graphic-p))

(use-package doom-modeline
  :ensure t
  :after nerd-icons
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-height 28)        ;; adjust bar height
  :config
  (let ((font "Symbols Nerd Font Mono"))
    (if (and (display-graphic-p)
             (fboundp 'font-family-list)
             (member font (font-family-list)))
        (progn
          ;; Font is available → enable icons
          (setq doom-modeline-icon t
                doom-modeline-major-mode-icon t
                nerd-icons-font-family font)
          (set-fontset-font t 'symbol (font-spec :family font) nil 'prepend)
          (set-fontset-font t '(#xE000 . #xF8FF)
                            (font-spec :family font) nil 'prepend)
          (message "doom-modeline: using Nerd Font icons (%s)" font))
      ;; Font missing → disable icons to avoid ugly glyphs
      (setq doom-modeline-icon nil
            doom-modeline-major-mode-icon nil)
      (message "doom-modeline: Nerd Font not found, icons disabled."))))

;; sly RET in mrepl fix
(defun my/sly-mrepl-ret-override ()
  "Make RET evaluate the expression in SLY MREPL, even with paredit-mode active."
  (define-key paredit-mode-map (kbd "RET") nil)
  (local-set-key (kbd "RET") #'sly-mrepl-return)
  (local-set-key (kbd "C-j") #'sly-mrepl-return)) ;; optional fallback

(add-hook 'sly-mrepl-mode-hook #'my/sly-mrepl-ret-override)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (setq which-key-separator " → " )
  (setq which-key-prefix-prefix "+"))

;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)

(defalias 'list-buffers 'ibuffer) ; make ibuffer default
(defalias 'list-buffers 'ibuffer-other-window) ; make ibuffer default open in another window

(use-package tabbar
  :ensure t
  :config
  (tabbar-mode 1))

(use-package eshell-vterm
  :ensure t
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000)) ;; optional: increase scrollback

;; (windmove-default-keybindings)

;; (winner-mode 1)

(use-package ace-window
  :ensure t
  :bind (("M-o" . ace-window))
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))))

(use-package counsel
  :ensure t)

(use-package swiper
  :ensure try
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-load-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :custom
  (projectile-project-search-path '("~/projects/")) ;; optional
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

;; js itself is natively recognized



;; we add typescript


;; ;; Define ts-mode for editing TypeScript src blocks in Org mode
;; (define-derived-mode ts-mode typescript-mode "ts"
;;   "Major mode for editing TypeScript src blocks in Org mode.")

;; ;; TypeScript Mode
;; (use-package typescript-mode
;;   :ensure t  ;; Install `typescript-mode` if not already installed
;;   :mode ("\\.ts\\'" . typescript-mode)  ;; Automatically associate `.ts` files with `typescript-mode`
;;   :init
;;   ;; Optional initialization if needed
;;   (setq typescript-indent-level 2)  ;; Set indentation level to 2 spaces
;;   )

;; ;; DAP Mode for Debugging
;; (use-package dap-mode
;;   :ensure t  ;; Install `dap-mode` if not already installed
;;   :config
;;   ;; Configure dap-mode as needed
;;   )

;; ;; LSP Mode for Language Server Protocol
;; (use-package lsp-mode
;;   :ensure t  ;; Install `lsp-mode` if not already installed
;;   :commands lsp  ;; Initialize lsp-mode when needed
;;   :hook
;;   ((typescript-mode . lsp)
;;    (javascript-mode . lsp))
;;   :custom
;;   (lsp-enable-file-watchers nil)  ;; Disable file watchers for better performance
;;   )

;; ;; Include Org Babel TypeScript Execution Configuration
;; ;; Reference: https://www.reddit.com/r/emacs/comments/b7rsxu/behold_orgbabelexecutetypescript/
;; (use-package ob-typescript
;;   :after org
;;   :config
;;   (add-to-list 'org-babel-load-languages '(typescript . t))
;;   (setq org-babel-default-header-args:typescript
;;         '((:results . "output")
;;           (:exports . "both")
;;           (:shebang . "#!/usr/bin/env ts-node")
;;           (:eval . "typescript")))
;;   )

;; ;; Optional: Add tree-sitter and tree-sitter-langs configuration if needed
;; ;; (use-package tree-sitter
;; ;;   :ensure t
;; ;;   :config
;; ;;   (require 'tree-sitter-langs)
;; ;;   (global-tree-sitter-mode)




(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  :config
  ;; Optional additional configuration can go here
  :init
  (setq typescript-indent-level 2)  ;; Set indentation level to 2 spaces
  )

;; and add org support
(use-package ob-typescript
  :ensure t
  :config
  ;; Set the command for TypeScript execution
  (setq org-babel-command:typescript "npx ts-node"))

(use-package yaml-mode
  :ensure t)

;; (add-to-list 'load-path (expand-file-name "~/src/lisp") t)
;; (add-to-list 'load-path (expand-file-name "~/path/to/orgdir/contrib/lisp") t)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-adapt-indentation t) ;; align text to header's start
  )

;; (require 'org)
;; (require 'ob)

;; (require 'ob-clojure)
;; (setq org-babel-clojure-backend 'cider)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (R . t)
   (julia . t)
   (lisp . t)
   (clojure . t)
   (js . t)
   (typescript . t)
   
   ))

;; stop emacs asking for confirmation
(setq org-confirm-babel-evaluate nil)

(use-package ox-reveal
  :ensure ox-reveal)

(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
(setq org-reveal-mathjax t)

(use-package htmlize
  :ensure t)

;; (add-to-list 'package-archives
;;              (cons "gnu-devel" "https://elpa.gnu.org/devel/")
;;              t)

;; (use-package org-roam
;;  :ensure t)

;; (use-package org-roam
;;   :ensure t
;;   :custom
;;   (org-roam-directory "~/RoamNotes")
;;   (org-roam-completion-everywhere t)
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;;          ("C-c n f" . org-roam-node-find)
;;          ("C-c n i" . org-roam-node-insert)
;;          :map org-mode-map
;;          ("C-M-i"   . completion-at-point))
;;   :config (org-roam-setup))

(defun just-one-space-on-line ()
    "Replace multiple spaces/tabs with single spaces on the current line."
    (interactive)
    (save-excursion
      (let ((start (line-beginning-position))
            (end (line-end-position)))
        (goto-char start)
        (while (re-search-forward "[ \t]+" end t)
          (replace-match " ")))))

  (defun just-one-space-on-region (start end)
    "Replace multiple whitespace characters with a single space in the selected region."
    (interactive "r")
    (save-excursion
      (goto-char start)
      (while (re-search-forward "[ \t]+" end t)
        (replace-match " "))))

;; Bind keys with C-c prefix:
(global-set-key (kbd "C-c l") 'just-one-space-on-line)
(global-set-key (kbd "C-c r") 'just-one-space-on-region)

;; (defun yank-and-just-one-space-on-lines ()
;;   "Yank the most recent kill and apply `just-one-space-on-line` to each inserted line."
;;   (interactive)
;;   (let ((start (point))) ;; remember where yank started
;;     (yank) ;; paste text from kill ring
;;     (let ((end (point))) ;; end point after paste
;;       (goto-char start)
;;       (while (< (point) end)
;;         (just-one-space-on-line)
;;         (forward-line 1)))))

;; (defun yank-fill-lines-and-collapse-spaces ()
;;   "Yank text, apply `fill-paragraph` (M-q) on each line, then collapse whitespaces in the pasted block."
;;   (interactive)
;;   (let ((start (point)))
;;     (yank)  ;; Paste text from kill ring (clipboard)
;;     (let ((end (point)))
;;       (goto-char start)
;;       (while (<= (point) end)
;;         (beginning-of-line)  ;; Move to beginning of line to ensure fill-paragraph works correctly
;;         (fill-paragraph)     ;; Apply M-q equivalent on current paragraph/line
;;         (forward-line 1))
;;       ;; Finally, collapse multiple spaces and tabs into a single space in entire pasted region
;;       (goto-char start)
;;       (while (re-search-forward "[ \t]+" end t)
;;         (replace-match " ")))))


(defun my-cleanup-region-with-blocks (start end)
  "Process text between START and END in blocks.
Bullet point blocks are processed separately from non-bullet blocks.
Existing blank lines are preserved; multiple spaces reduced to one.
Each paragraph gets `fill-paragraph` applied."
  (interactive "r")
  (save-excursion
    (goto-char start)
    (while (< (point) end)
      ;; Find the start of the next block (skip empty lines)
      (skip-chars-forward "\n" end)
      (let ((block-start (point)))
        ;; Find end of the block (stop on one or more blank lines or buffer end)
        (if (re-search-forward "\n[ \t]*\n" end 'move)
            (progn
              (goto-char (match-beginning 0))
              (let ((block-end (point)))
                (my-process-block block-start block-end)))
          ;; Last block till end
          (my-process-block block-start end)
          (goto-char end))))))

(defun my-process-block (block-start block-end)
  "Process a single block from BLOCK-START to BLOCK-END.
Detects if block is bullet list or regular text and processes accordingly."
  (save-restriction
    (narrow-to-region block-start block-end)
    (goto-char (point-min))
    (let ((is-bullet-block
           (save-excursion
             (beginning-of-line)
             (looking-at-p "^[ \t]*[-+*0-9]\\.?[\t ]"))))
      ;; Reduce multiple spaces/tabs to single space on every line
      (goto-char (point-min))
      (while (< (point) (point-max))
        (beginning-of-line)
        (when (re-search-forward "[ \t]+" (line-end-position) t)
          (replace-match " "))
        (forward-line 1))
      ;; Apply fill-paragraph to each paragraph in block
      (goto-char (point-min))
      (while (< (point) (point-max))
        (fill-paragraph)
        (forward-paragraph 1)))))

(defun my-yank-or-cleanup-region ()
  "If no region is active, yank text.
If region is active, clean it up by:
- treating bullet blocks and text blocks separately,
- preserving existing empty lines,
- reducing multiple spaces to single spaces,
- applying fill-paragraph (M-q) to each paragraph."
  (interactive)
  (if (use-region-p)
      (my-cleanup-region-with-blocks (region-beginning) (region-end))
    ;; no region active, yank and clean up newly yanked text
    (let ((start (point)))
      (yank)
      (my-cleanup-region-with-blocks start (point)))))

;; (global-set-key (kbd "C-c v") 'yank-fill-lines-and-collapse-spaces)
;; (global-set-key (kbd "C-c v") 'my-cleanup-region-with-blocks)
(global-set-key (kbd "C-c v") 'my-yank-or-cleanup-region)

;; add .bin/local to PATH variable the current
;; this is because I start emacs with
;; env HOME=$HOME/somefolder

(defun joindirs (root &rest dirs)
  "Joins a series of directories together,
     like Python's os.path.join
     (joindirs \"/a\" \"b\" \"c\") => /a/b/c"
  (if (not dirs)
      root
    (apply 'joindirs
           (expand-file-name (car dirs) root)
           (cdr dirs))))

(setenv "PATH" (concat (getenv "PATH") ":"
                       (joindirs (getenv "HOME") ".bin" "local")))

;; get conda environment
(require 'json)

(defun get-conda-envs-dir ()
  "Get the primary directory where Conda environments are stored."
  (let* ((output (process-lines "conda" "info" "--json"))
         (json-object-type 'hash-table)
         (json-array-type 'list)
         (json-key-type 'string)
         (info (json-read-from-string (mapconcat 'identity output "\n")))
         (envs-dirs (gethash "envs_dirs" info)))
    (if envs-dirs
        (car envs-dirs)
      (error "Could not determine Conda environments directory"))))

;; set conda env as workon
(defun set-conda-envs-dir-as-workon ()
  "Set the Conda environments directory as the WORKON environment variable."
  (let ((conda-envs-dir (get-conda-envs-dir)))
    (setenv "WORKON_HOME" conda-envs-dir)
    (message "WORKON_HOME set to %s" conda-envs-dir)))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

;; (use-package flycheck
;;   :ensure t
;;   :init
;;   (global-flycheck-mode t))

;; (use-package jedi                       
;;   :ensure t
;;   :init
;;   (add-hook 'python-mode-hook 'jedi:setup)
;;   (add-hook 'python-mode-hook 'jedi:ac-setup))

;; (use-package elpy
;;   :ensure t
;;   :config
;;   (elpy-enable)
;;   (set-conda-envs-dir-as-workon))

;; manually add two dependencies

(use-package spinner
  :ensure t)

(use-package compat
  :ensure t)

(use-package highlight-indentation
  :ensure t)

;; to then set elpy
(use-package elpy
  :ensure t
  :config
  (elpy-enable)
  ;; (setq elpy-rpc-virtualenv-path 'current) ;; otherwise error
  ;; do: sudo apt install virtualenv
  ;;     sudo apt install python3-pip
  (setq elpy-rpc-python-command "python3")
  ;; otherwise error on M-x elpy-config
  ;; 'Neither easy_install nor pip found
  ;;  use ipython
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i --simple-prompt")
  ;; to be able to use pyvenv-workon, one has to set $WORKON_HOME var
  (set-conda-envs-dir-as-workon))

(use-package dape
  :ensure t
  :defer t
  :init
  ;; Window arrangement and working directory setup
  (setq dape-buffer-window-arrangement 'right
        dape-cwd-fn 'projectile-project-root)
  ;; To use window configuration like gud (gdb-mi)
  ;; (setq dape-buffer-window-arrangement 'gud)

  :hook
  ((kill-emacs . dape-breakpoint-save) ;; save breakpoints on quit
   (after-init . dape-breakpoint-load) ;; load breakpoints on startup
   (dape-stopped-hook . dape-info)
   (dape-start-hook . (lambda () (save-some-buffers t t)))
   (dape-mode . my/setup-dape-bindings))

  :bind (
         ;; Global bindings
         ("<f5>" . my/dape-python)
         ("<f6>" . my/dape-project-debug)
         ;; Local bindings inside dape-mode
         ;; (:map dape-mode-map
         ;;      ("C-c w a" . dape-watch-add)
         ;;      ("C-c w r" . dape-watch-remove)
         ;;      ("C-c w w" . dape-watch))
         )

  :config
  ;; Enable global breakpoint toggling
  (dape-breakpoint-global-mode)

  ;; Extend default dape configs with a Python example
  (setq dape-configs
        (append
         '((python
            :name "Python :: Launch file"
            :type "python"
            :request "launch"
            :program nil ;; Use buffer-file-name by default
            :cwd nil     ;; Use `default-directory' by default
            :env nil
            :args nil
            :console "integratedTerminal"))
         dape-configs))

  ;; Function to start dape for current Python buffer
  (defun my/dape-python ()
    "Start dape debug session for current Python file."
    (interactive)
    (let ((dape-config
           `(:type "python"
                   :name "Python :: current file"
                   :request "launch"
                   :program ,(buffer-file-name)
                   :cwd ,(projectile-project-root)
                   :console "integratedTerminal")))
      (dape-debug dape-config)))

  ;; Local bindings in dape-mode
  (defun my/setup-dape-bindings ()
    (when (boundp 'dape-mode-map)
      (define-key dape-mode-map (kbd "C-c w a") #'dape-watch-add)
      (define-key dape-mode-map (kbd "C-c w r") #'dape-watch-remove)
      (define-key dape-mode-map (kbd "C-c w w") #'dape-watch)
      (define-key dape-mode-map (kbd "C-c C-c") #'dape-continue)))

  ;; Automatically add a watch expression when DAPE starts (optional!)
  ;; You might prefer doing this manually, or define your own helper instead.
  ;; (add-hook 'dape-start-hook (lambda () (dape-watch-add "my_variable")))


  ;; Pulse source line (performance hit)
  ;; (add-hook 'dape-display-source-hook 'pulse-momentary-highlight-one-line)

  ;; To not display info and/or buffers on startup
  ;; (remove-hook 'dape-start-hook 'dape-info)
  ;; (remove-hook 'dape-start-hook 'dape-repl)

  ;; To display info and/or repl buffers on stopped
  ;; (add-hook 'dape-stopped-hook 'dape-info)
  ;; (add-hook 'dape-stopped-hook 'dape-repl)

  ;; Kill compile buffer on build success
  ;; (add-hook 'dape-compile-hook 'kill-buffer)

  ;; Save buffers on startup, useful for interpreted languages
  ;; (add-hook 'dape-start-hook (lambda () (save-some-buffers t t)))

  )

;; Enable undo-tree globally
(use-package undo-tree
  :ensure t
  ;; :init ;; only for early setting slike variables
  :custom
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))) ; optional: persistent history
  (setq undo-tree-auto-save-history t)
  :config ;; run after package is loaded
  (global-undo-tree-mode))

;; Git integration for emacs
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; ;; Replace "sbcl" with the path to your implementation
;; (setq inferior-lisp-program "/usr/bin/sbcl")

;; for slime

;; (with-eval-after-load 'sly-mrepl
;;   (define-key sly-mrepl-mode-map (kbd "RET") #'sly-mrepl-return))

;; (with-eval-after-load 'sly-mrepl
;;  (define-key sly-mrepl-mode-map (kbd "S-RET") #'sly-mrepl-return))
(defun string-trim (str)
  "Trim leading and trailing whitespace from STR."
  (replace-regexp-in-string "\\`[ \t\n\r]+" "" (replace-regexp-in-string "[ \t\n\r]+\\'" "" str)))

(defun system-ram-size-in-mb ()
  "Return the system RAM size in megabytes, platform-independent."
  (interactive)
  (let ((ram-size-command
         (cond
          ((eq system-type 'darwin) "sysctl -n hw.memsize")
          ((eq system-type 'gnu/linux) "grep MemTotal /proc/meminfo | awk '{print $2 * 1024}'")
          ((eq system-type 'windows-nt) "wmic computersystem get TotalPhysicalMemory /Value | findstr TotalPhysicalMemory="))))
    (let ((output (shell-command-to-string ram-size-command)))
      (if output
          (let* ((output (split-string output "="))
                 (output (or (cadr output) (car output)))
                 (output (string-to-number (string-trim output))))
            (/ output (* 1024 1024)))
        (error "Failed to get system RAM size")))))




;; ;; set memory of sbcl to your machine's RAM size for sbcl and clisp
;; ;; (but for others - I didn't used them yet)
;; (defun unix-system-ram-size ()
;;   (let ((bytes (string-to-number (shell-command-to-string "sysctl hw.memsize | awk '{print $2}'"))))
;;     (/ bytes (* 1024 1024)))) ;; this works also for macos
;; ;; previously  "free --mega | awk 'FNR == 2 {print $2}'"
;; ;; (linux-system-ram-size)


;; ;; Define functions to manually switch between SLIME and SLY
;; (defun use-sly ()
;;   "Switch to using SLY for this session."
;;   (interactive)
;;   (remove-hook 'lisp-mode-hook 'slime-lisp-mode-hook)
;;   (require 'sly)
;;   (sly))

;; (defun use-slime ()
;;   "Switch to using SLIME for this session."
;;   (interactive)
;;   (remove-hook 'lisp-mode-hook 'sly-editing-mode)
;;   (require 'slime)
;;   (slime))

 (use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode lisp-mode sly-mode sly-mrepl-mode racket-mode racket-repl-mode) . paredit-mode)
  
  :bind
  (("C-c <right>" . paredit-forward-slurp-sexp)
   ("C-c <left>" . paredit-backward-slurp-sexp)
   ("C-c <up>" . paredit-forward-barf-sexp)
   ("C-c <down>" . paredit-backward-barf-sexp))) ;; use C-c instead of just C-right etc because of MacOS


;; long time my slime setting
(use-package slime
  :ensure t
  :hook ((lisp-mode .slime-mode))
  :config
  ;; roswell is not available for windows.
  (cond
   ((eq system-type 'darwin) (load (expand-file-name "~/.roswell/helper.el")))
   ((eq system-type 'gnu/linux) (load (expand-file-name "~/.roswell/helper.el")))
   ((eq system-type 'windows-nt) (load (concat (getenv "USERPROFILE") "\\quicklisp\\slime-helper.el"))
    (setq inferior-lisp-program (concat "sbcl --dynamic-space-size "
                                        (number-to-string (system-ram-size-in-mb)))))
   (t
    (error "Failed to load helper.el")))

  ;; $ ros config
  ;; $ ros use sbcl dynamic-space-size=3905
  ;; query with: (/ (- sb-vm:dynamic-space-end sb-vm:dynamic-space-start) (expt 1024 2))
  (cond
   ((or (eq system-type 'darwin) (eq system-type 'gnu/linux))
    (setq inferior-lisp-program (concat "ros -Q dynamic-space-size=" (number-to-string (system-ram-size-in-mb)) " run"))))

  ;; and for fancier look I personally add:
  (setq slime-contribs '(slime-fancy slime-cl-indent))

  ;; ;; ensure correct indentation e.g. of `loop` form
  (add-to-list 'slime-contribs 'slime-cl-indent)

  ;; don't use tabs
  (setq-default indent-tabs-mode nil)

  ;; actually for sly repl
  (with-eval-after-load 'sly-mrepl
    (define-key sly-mrepl-mode-map (kbd "RET") #'sly-mrepl-return))

  )





;; (setq slime-lisp-implementations `(("sbcl" ("ros use sbcl && ros run --" "--dynamic-space-size"
;;                                             ,(number-to-string (linux-system-ram-size))))
;;                                    ("clisp" ("ros use clisp && ros run --" "-m"
;;                                              ,(number-to-string (linux-system-ram-size))
;;                                              "MB"))
;;                                    ("ecl" ("ros use ecl && ros run --"))
;;                                    ("cmucl" ("ros use cmucl && ros run --"))))

;; ;; doesn't work as expected!! ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Debugger display values
;; (defun my-slime-step-display-value (n)
;;   "Step N times through the code and display the return value."
;;   (interactive "p")
;;   (slime-eval `(swank:stepper-step ,n))
;;   (let ((last-result (slime-eval '(swank:inspector-call-nth-function 0))))
;;     (message "Return value: %s" last-result)))

;; (define-key slime-mode-map (kbd "C-c C-s") 'my-slime-step-display-value)

;; (defun my-sly-step-display-value (n)
;;   "Step N times through the code and display the return value."
;;   (interactive "p")
;;   (sly-db-step n)
;;   (let ((last-result (sly-eval '(slynk:call-with-last-step-result))))
;;     (message "Return value: %s" last-result)))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (define-key sly-db-mode-map (kbd "C-c C-s") 'my-sly-step-display-value)


;; sly

;; (use-package sly
;;   :ensure t
;;   :hook ((lisp-mode .sly-editing-mode))
;;   :config
;;   ;; Roswell is not available for Windows.
;;   (cond
;;    ((eq system-type 'darwin) (load (expand-file-name "~/.roswell/helper.el")))
;;    ((eq system-type 'gnu/linux) (load (expand-file-name "~/.roswell/helper.el")))
;;    ((eq system-type 'windows-nt) (load (concat (getenv "USERPROFILE") "\\quicklisp\\sly-helper.el"))
;;     (setq inferior-lisp-program (concat "sbcl --dynamic-space-size "
;;                                         (number-to-string (system-ram-size-in-mb)))))
;;    (t
;;     (error "Failed to load helper.el")))

;;   ;; Set dynamic-space-size for SBCL with Roswell for macOS and Linux
;;   (cond
;;    ((or (eq system-type 'darwin) (eq system-type 'gnu/linux))
;;     (setq inferior-lisp-program (concat "ros -Q dynamic-space-size=" (number-to-string (system-ram-size-in-mb)) " run"))))

;;   ;; Enable SLY contribs for a fancier experience
;;   (setq sly-contribs '(sly-fancy slynk-mrepl sly-mrepl sly-cl-indent)) ;; slynk-mrepl is necessary contrib!

;;   ;; Don't use tabs for indentation
;;   (setq-default indent-tabs-mode nil)
;;   )

;; ;; Change keybindings for SLIME or SLY if necessary to avoid conflicts
;; (with-eval-after-load 'sly
;;   (define-key sly-mode-map (kbd "C-c C-s") 'sly-selector))

;; (with-eval-after-load 'slime
;;   (define-key slime-mode-map (kbd "C-c C-s") 'slime-selector))

;; make results visible inline
(use-package lispy
  :ensure t
  :hook ((lisp-mode emacs-lisp-mode) . lispy-mode)
  :config
  ;; Define `C-,` as a prefix key
  (define-prefix-command 'lispy-prefix)
  (global-set-key (kbd "C-l") 'lispy-prefix)

  ;; bind `C-, e` to lispy-eval-and-insert
  (define-key lispy-prefix (kbd "e") 'lispy-eval-and-insert)
  ;; Optionally, you can also configure other keys or customize lispy behavior here.
  )

(use-package racket-mode
  :ensure t
  :hook (racket-mode . racket-xp-mode))

(use-package company
  :ensure t
  :config
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 0.1)
  (setq company-tooltip-align-annotations t)
  :hook
  ((racket-mode . company-mode)
   (racket-repl-mode . company-mode)))

(use-package rainbow-delimiters
  :ensure t
  :hook
  ((racket-mode . rainbow-delimiters-mode)
   (racket-repl-mode . rainbow-delimiters-mode)))

;; (use-package ess
;;   :ensure t
;;   :init 
;;   (require 'ess-site)
;;   (setq ess-use-flymake nil)
;;   (setq ess-eval-visibly-p nil)
;;   (setq ess-use-eldoc nil))

(use-package ess
  :ensure t
  :mode (("\\.R\\'" . R-mode)
         ("\\.Rmd\\'" . R-markdown-mode)
         ("\\.Rnw\\'" . R-noweb-mode)
         ("\\.jl\\'" . ess-julia-mode))
  :init
  (require 'ess-site)
  (setq ess-eval-visibly 'nowait)
  (setq ess-ask-for-ess-directory nil)
  :config
  (setq ess-toggle-underscore nil)
  (setq ess-default-style 'DEFAULT)
  (setq ess-indent-with-fancy-comments nil)
  (setq ess-fancy-comments nil)
  (setq ess-history-file nil)
  (setq ess-use-flymake nil)
  (setq ess-R-font-lock-keywords
        '((ess-R-fl-keyword:fun-calls . t)
          (ess-R-fl-keyword:keywords . t)
          (ess-R-fl-keyword:assign-ops . t)
          (ess-R-fl-keyword:constants . t)
          (ess-R-fl-keyword:messages . t)
          (ess-R-fl-keyword:modifiers . t)
          (ess-R-fl-keyword:fun-defs . t)
          (ess-R-fl-keyword:numbers . t)
          (ess-R-fl-keyword:operators . t)
          (ess-R-fl-keyword:delimiters . t)
          (ess-R-fl-keyword:= . t)
          (ess-R-fl-keyword:+ . t)
          (ess-R-fl-keyword:- . t)
          (ess-R-fl-keyword:* . t)
          (ess-R-fl-keyword:/ . t)
          (ess-R-fl-keyword:^ . t)
          (ess-R-fl-keyword:< . t)
          (ess-R-fl-keyword:> . t)
          (ess-R-fl-keyword:! . t)
          (ess-R-fl-keyword:% . t)
          (ess-R-fl-keyword:%op% . t)
          (ess-R-fl-keyword:%!in% . t)
          (ess-R-fl-keyword:%notin% . t)))
   ;; to be able to use pyvenv-workon, one has to set $WORKON_HOME var
  (set-conda-envs-dir-as-workon) ;; conda env need python!
  :bind
  (:map ess-mode-map
        ("C-c C-j" . ess-eval-line-and-step)
        ("C-c C-l" . ess-eval-region-or-function-or-paragraph-and-step)
        ("C-c C-r" . ess-eval-region)
        ("C-c C-p" . ess-eval-buffer)
        ("C-c C-o" . ess-eval-chunk))
  )

;; Enable Org-mode and Org-roam
(use-package org
  :ensure t
  :bind
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture)
  ("C-c o" . org-open-at-point)
  ("C-c r" . org-refile)
  ("C-c A" . org-archive-subtree)
  ("C-c t" . org-todo)
  ("C-c i" . org-clock-in)
  ("C-c o" . org-clock-out)
  ("C-c d" . org-deadline)
  ("C-c s" . org-schedule)
  ("C-c l" . org-store-link)
  :config
  ;; Basic Org-mode settings
  (setq org-agenda-files '("~/org/tasks.org" "~/org/projects.org"))

  (setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$")) ;; all files in org folder in org agenda
  (setq org-log-done 'time)  ;; Log when tasks are marked as DONE
  (setq org-use-tag-inheritance t)  ;; Enable tag inheritance


  ;; Custom TODO keywords
  (setq org-todo-keywords
        '((sequence "TODO(t)" "IN-PROGRESS(i)" "WAITING(w)" "BLOCKED(b)" "|" "DONE(d)" "CANCELED(c)")))

  ;; Define available tags globally
  (setq org-tag-alist '((:startgroup)
                        ("@work" . ?w)
                        ("@home" . ?h)
                        (:endgroup)
                        ("urgent" . ?u)
                        ("important" . ?i)
                        ("lowpriority" . ?l)
                        ("reading" . ?r)
                        ("project" . ?p))
        org-fast-tag-selection-include-custom t) ;; allow on-the-fly generation

  ;; Custom agenda views for Eisenhower Matrix, PARA, etc.
  (setq org-agenda-custom-commands
        '(("e" "Eisenhower Matrix"
           ((tags-todo "+urgent+important"
                       ((org-agenda-overriding-header "Quadrant I: Urgent and Important")))
            (tags-todo "+important-urgent"
                       ((org-agenda-overriding-header "Quadrant II: Not Urgent but Important")))
            (tags-todo "+urgent-important"
                       ((org-agenda-overriding-header "Quadrant III: Urgent but Not Important")))
            (tags-todo "+low"
                       ((org-agenda-overriding-header "Quadrant IV: Not Urgent and Not Important")))))
          ("p" "PARA View"
           ((tags-todo "+project"
                       ((org-agenda-overriding-header "Projects")))
            (tags-todo "+area"
                       ((org-agenda-overriding-header "Areas of Responsibility")))
            (tags-todo "+resource"
                       ((org-agenda-overriding-header "Resources")))
            (tags-todo "+archive"
                       ((org-agenda-overriding-header "Archives")))))))

  ;; Enable time tracking and log idle time
  (setq org-clock-idle-time 10)  ;; Auto-pause after 10 mins idle
  )

;; Enable Org-roam for Zettelkasten-like note-taking
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/org/roam/")  ;; Directory for Org-roam notes
  :config
  ;; Keybindings for Org-roam
  (setq org-roam-v2-ack t)
  (org-roam-db-autosync-mode)

  ;; Keybindings for Org-roam
  (global-set-key (kbd "C-c n f") 'org-roam-node-find)
  (global-set-key (kbd "C-c n i") 'org-roam-node-insert)
  (global-set-key (kbd "C-c n l") 'org-roam-buffer-toggle)
  (global-set-key (kbd "C-c n t") 'org-roam-dailies-capture-today)

  ;; Org-oram dailies configuration
  (setq org-roam-dailies-directory "~/org/roam/daily/")
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %<%H:%M> - %?"
           :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

  ;; Add tags to Org-roam notes
  (setq org-roam-tag-sources '(prop all-directories))
  )

;; Enable Pomodoro Technique in Org-mode with org-pomodoro
(use-package org-pomodoro
  :ensure t
  :bind (:map org-mode-map
              ("C-c p" . org-pomodoro))  ;; Start Pomodoro timer
  :config
  ;; Customize sounds and settings for Pomodoro
  (setq org-pomodoro-length 25)
  (setq org-pomodoro-short-break-length 5)
  (setq org-pomodoro-long-break-length 15)
  (setq org-pomodoro-finished-sound "~/.emacs.d/mixkit-achievement-bell-600.wav")
  ;; got it from: https://mixkit.co/free-sound-effects/bell/ it is free! You can search there for other bells.
  )

;; Optional: Enable org-ql for advanced queries in Org-mode
(use-package org-ql
  :ensure t
  :config
  (setq org-ql-search-headline-sorting-functions '(org-ql--sort-by-date org-ql--sort-by-todo))
  )

;; Org-capture templates for GTD and PARA
(setq org-capture-templates
      '(("t" "Todo" entry (file "~/org/inbox.org")
         "* TODO %?\n  %u\n")
        ("p" "Project" entry (file "~/org/projects.org")
         "* PROJECT %?\n  %u\n")
        ("n" "Note" entry (file "~/org/notes.org")
         "* %u %?\n")))

(when (eq system-type 'darwin)
  (setq mac-option-key-is-meta t)
  (setq mac-command-key-is-meta nil)
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta))

(use-package dockerfile-mode
  :ensure t
  :mode "Dockerfile\\'")

(use-package yaml-mode
  :ensure t
  :mode "\\.ya?ml\\'"
  :hook (yaml-mode . (lambda ()
                       (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

;;; --- Tree-sitter core (built-in on Emacs 29+) ---
(use-package treesit
  :ensure nil                  ;; built-in
  :demand t
  :init
  (setq treesit-language-source-alist
        '((rust "https://github.com/tree-sitter/tree-sitter-rust")))
  :config
  ;; Make sure the core is really loaded so its C symbols exist.
  (require 'treesit)
  ;; Install grammar if missing, invalid, or ABI-mismatched.
  (when (and (fboundp 'treesit-install-language-grammar)
             (fboundp 'treesit-abi-version)
             (fboundp 'treesit-language-abi-version)
             (or (not (treesit-language-available-p 'rust))
                 (not (ignore-errors (treesit-language-abi-version 'rust)))
                 (not (equal (treesit-language-abi-version 'rust)
                             (treesit-abi-version)))))
    (message "[Tree-sitter] Installing or updating Rust grammar (ABI %s)..."
             (treesit-abi-version))
    (ignore-errors (treesit-install-language-grammar 'rust))))

;;; --- Rust major mode (Tree-sitter first, auto-fallback to classic) ---
(use-package rust-ts-mode
  :ensure nil                  ;; built-in on Emacs 29+
  :mode "\\.rs\\'"
  :init
  ;; Prefer ts-mode whenever available
  (when (and (featurep 'treesit)
             (fboundp 'treesit-language-available-p)
             (treesit-language-available-p 'rust))
    (add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode)))
  :hook
  ;; Start LSP automatically (deferred) when in ts-mode
  (rust-ts-mode . lsp-deferred)
  :config
  (setq rust-ts-mode-indent-offset 4))

;; Fallback if Tree-sitter not available
(use-package rust-mode
  :if (not (and (featurep 'treesit)
                (fboundp 'treesit-language-available-p)
                (treesit-language-available-p 'rust)))
  :ensure t
  :mode "\\.rs\\'"
  :hook (rust-mode . lsp-deferred))

;;; --- LSP for Rust ---
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . lsp-enable-which-key-integration)
  :custom
  (lsp-rust-analyzer-server-command '("rust-analyzer"))
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-rust-analyzer-proc-macro-enable t)
  (lsp-inlay-hint-enable t))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode))

(use-package toml-mode
  :ensure t)
