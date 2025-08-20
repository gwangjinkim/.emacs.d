(require 'package)

(setq package-enable-at-startup nil)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
	("elpa" . "https://elpa.gnu.org/packages/")
	;; ("marmalade" . "http://marmalade-repo.org/packages/")
	))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;; load myinit.org
(org-babel-load-file (expand-file-name "myinit.org" user-emacs-directory))



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; slime for common-lisp
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; (setq inferior-lisp-program (expand-file-name "~/miniconda3/envs/cl/bin/sbcl"))
;; (add-to-list 'slime-contribs 'slime-cl-indent) ;; correct indentation

;; ;; don't use tabs
;; (setq-default indent-tabs-mode nil)

;; ;; memory of sbcl
;; (defun linux-system-ram-size ()
;;   (string-to-number (shell-command-to-string "free --mega | awk 'FNR == 2 {print $2}'")))

;; (setq slime-lisp-implementations `(("sbcl" ("sbcl" "--dynamic-space-size"
;;                                             ,(number-to-string (linux-system-ram-size))))
;; 				   ("clisp" ("clisp" "-m"
;;                                              ,(number-to-string (linux-system-ram-size))
;;                                              "MB"))
;; 				   ("ecl" ("ecl"))
;; 				   ("cmucl" ("cmucl"))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eldoc-documentation-functions nil t nil "Customized with use-package lsp-mode")
 '(ns-alternate-modifier 'meta)
 '(org-agenda-files
   '("~/org/org-mode.org" "/Users/josephus/org/roam/daily/2024-09-10.org"
     "/Users/josephus/org/business-idea-api.org"
     "/Users/josephus/org/chatgpt-fiction.org"
     "/Users/josephus/org/code-inspections.org"
     "/Users/josephus/org/common-lisp-questions.org"
     "/Users/josephus/org/common-lisp.org"
     "/Users/josephus/org/ebook-generation.org"
     "/Users/josephus/org/inbox.org"
     "/Users/josephus/org/jim-simons.org"
     "/Users/josephus/org/julia-emacs.org"
     "/Users/josephus/org/learning-google-cloud.org"
     "/Users/josephus/org/magit.org" "/Users/josephus/org/medium.org"
     "/Users/josephus/org/meta.org" "/Users/josephus/org/neo4j.org"
     "/Users/josephus/org/org-roam-tutorial.org"
     "/Users/josephus/org/python-debugging.org"
     "/Users/josephus/org/python-medium-ideas.org"
     "/Users/josephus/org/r-medium.org"
     "/Users/josephus/org/r-metaprogramming.org"
     "/Users/josephus/org/racket-debugging.org"
     "/Users/josephus/org/tax-calculation.org"))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))


(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
