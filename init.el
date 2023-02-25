

(require 'package)
;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
;; 'failed load gnu archive' preventer
;; to put infront package-initialize ;; works!
(setq package-enable-at-startup nil)
(setq package-archives '())
(add-to-list 'package-archives '("elpa"      . "http://elpa.gnu.org/packages/") t) ;; beware "https://url-to-sth/" it has to end with '/'!
;; (add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives '("melpa"     . "http://melpa.org/packages/") t)
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; M-x package-refresh-contents
(package-initialize)
(package-refresh-contents)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; load myinit.org
(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))



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
 '(org-agenda-files '("~/Dropbox/cl/setting-up-lisp.org"))
 '(package-selected-packages
   '(org-roam magit slime-volleyball ob-clojurescript unicode-progress-reporter tabbar use-package which-key websocket try slime skewer-mode request-deferred projector ox-reveal org2blog org-email org-bullets org-blog org-babel-eval-in-repl material-theme jedi geiser flycheck exec-path-from-shell emojify elpy counsel clojure-snippets clojure-cheatsheet clj-mode cl-generic cider-spy cider-hydra cider-eval-sexp-fu cider-decompile better-defaults)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
