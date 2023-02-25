(setq inhibit-startup-message t)
(tool-bar-mode -1)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)

(defalias 'list-buffers 'ibuffer) ; make ibuffer default
(defalias 'list-buffers 'ibuffer-other-window) ; make ibuffer default open in another window

(use-package tabbar
  :ensure t
  :config
  (tabbar-mode 1))

;; (windmove-default-keybindings)

;; (winner-mode 1)

(use-package ace-window
  :ensure t
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
   (lisp . t)
   (clojure . t)))

;; stop emacs asking for confirmation
(setq org-confirm-babel-evaluate nil)

(use-package ox-reveal
  :ensure ox-reveal)

(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
(setq org-reveal-mathjax t)

(use-package htmlize
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; function to wrap blocks of text in org templates                       ;;
;; e.g. latex or src etc                                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun org-begin-template ()
  "Make a template at point."
  (interactive)
  (if (org-at-table-p)
      (call-interactively 'org-table-rotate-recalc-marks)
    (let* ((choices '(("s" . "SRC")
                      ("e" . "EXAMPLE")
                      ("q" . "QUOTE")
                      ("v" . "VERSE")
                      ("c" . "CENTER")
                      ("l" . "LaTeX")
                      ("h" . "HTML")
                      ("a" . "ASCII")))
           (key
            (key-description
             (vector
              (read-key
               (concat (propertize "Template type: " 'face 'minibuffer-prompt)
                       (mapconcat (lambda (choice)
                                    (concat (propertize (car choice) 'face 'font-lock-type-face)
                                            ": "
                                            (cdr choice)))
                                  choices
                                  ", ")))))))
      (let ((result (assoc key choices)))
        (when result
          (let ((choice (cdr result)))
            (cond
             ((region-active-p)
              (let ((start (region-beginning))
                    (end (region-end)))
                (goto-char end)
                (insert "#+END_" choice "\n")
                (goto-char start)
                (insert "#+BEGIN_" choice "\n")))
             (t
              (insert "#+BEGIN_" choice "\n")
              (save-excursion (insert "#+END_" choice))))))))))

;;bind to key
(define-key org-mode-map (kbd "C-<") 'org-begin-template)



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; function to wrap blocks of text in org templates                       ;;
;; ;; e.g. latex or src etc                                                  ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun org-begin-template ()
;;   "Make a template at point."
;;   (interactive)
;;   (if (org-at-table-p)
;;       (call-interactively 'org-table-rotate-recalc-marks)
;;     (let* ((choices '(("s" . "SRC")
;;                       ("e" . "EXAMPLE")
;;                       ("q" . "QUOTE")
;;                       ("v" . "VERSE")
;;                       ("c" . "CENTER")
;;                       ("l" . "LaTeX")
;;                       ("h" . "HTML")
;;                       ("a" . "ASCII")))
;;            (add-additionally '(("s" . "")
;;                                ("e" . "")
;;                                ("q" . "")
;;                                ("v" . "")
;;                                ("c" . "")
;;                                ("l" . "")
;;                                ("h" . "")
;;                                ("a" . ""))))
;;       (key
;;        (key-description
;;         (vector
;;          (read-key
;;           (concat (propertize "Template type: " 'face 'minibuffer-prompt)
;;                   (mapconcat (lambda (choice)
;;                                (concat (propertize (car choice) 'face 'font-lock-type-face)
;;                                        ": "
;;                                        (cdr choice)))
;;                              choices
;;                              ", ")))))))
;;     (let ((result (assoc key choices))
;;           (add-result (assoc key add-additionally)))
;;       (when result
;;         (let ((choice (cdr result))
;;               (adder  (cdr add-result)))
;;           (cond
;;            ((region-active-p)
;;             (let ((start (region-beginning))
;;                   (end (region-end)))
;;               (goto-char end)
;;               (insert "#+END_" choice "\n")
;;               (goto-char start)
;;               (insert "#+BEGIN_" choice adder "\n")))
;;            (t
;;             (insert "#+BEGIN_" choice adder "\n")
;;             (save-excursion (insert "#+END_" choice)))))))))

;; ;;bind to key
;; (define-key org-mode-map (kbd "C-<") 'org-begin-template)
;; ;;;;; this was my bad attempt which did not work - to allow multikeycombination
;; ;;;;; to have more choices in templates

;; (add-to-list 'package-archives
;;              (cons "gnu-devel" "https://elpa.gnu.org/devel/")
;;              t)

;; (use-package org-roam
;;  :ensure t)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/RoamNotes")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i"   . completion-at-point))
  :config (org-roam-setup))

;; (use-package undo-tree
;;   :ensure t
;;   :init
;;   (global-undo-tree-mode))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))

(use-package elpy
  :ensure t
  :config
  (elpy-enable))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

;; Git integration for emacs
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; ;; Replace "sbcl" with the path to your implementation
;; (setq inferior-lisp-program "/usr/bin/sbcl")

;; for slime

(use-package slime
  :ensure t
  :config
  (load (expand-file-name "~/.roswell/helper.el"))
  ;; $ ros config
  ;; $ ros use sbcl dynamic-space-size=3905
  ;; query with: (/ (- sb-vm:dynamic-space-end sb-vm:dynamic-space-start) (expt 1024 2))

  ;; set memory of sbcl to your machine's RAM size for sbcl and clisp
  ;; (but for others - I didn't used them yet)
  (defun linux-system-ram-size ()
    (string-to-number (shell-command-to-string "free --mega | awk 'FNR == 2 {print $2}'")))
  ;; (linux-system-ram-size)

  (setq inferior-lisp-program (concat "ros -Q dynamic-space-size=" (number-to-string (linux-system-ram-size)) " run"))

  ;; and for fancier look I personally add:
  (setq slime-contribs '(slime-fancy))

  ;; ensure correct indentation e.g. of `loop` form
  (add-to-list 'slime-contribs 'slime-cl-indent)

  ;; don't use tabs
  (setq-default indent-tabs-mode nil))

  ;; (setq slime-lisp-implementations `(("sbcl" ("ros use sbcl && ros run --" "--dynamic-space-size"
  ;;                                             ,(number-to-string (linux-system-ram-size))))
  ;;                                    ("clisp" ("ros use clisp && ros run --" "-m"
  ;;                                              ,(number-to-string (linux-system-ram-size))
  ;;                                              "MB"))
  ;;                                    ("ecl" ("ros use ecl && ros run --"))
  ;;                                    ("cmucl" ("ros use cmucl && ros run --"))))

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
         ("\\.Rnw\\'" . R-noweb-mode))
  :init
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
  :bind
  (:map ess-mode-map
        ("C-c C-j" . ess-eval-line-and-step)
        ("C-c C-l" . ess-eval-region-or-function-or-paragraph-and-step)
        ("C-c C-r" . ess-eval-region)
        ("C-c C-p" . ess-eval-buffer)
        ("C-c C-o" . ess-eval-chunk))
  )
