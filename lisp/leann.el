(defvar leann-cli "leann")
(defvar leann-index "org-notes")
(defvar leann-env
  '(("OPENAI_BASE_URL" . "http://localhost:11434/v1")
    ("OPENAI_API_KEY"  . "ollama")))

(defun leann--call (args &optional buf)
  (let* ((b (get-buffer-create (or buf "*leann*")))
         (process-environment
          (append (mapcar (lambda (kv) (format "%s=%s" (car kv) (cdr kv))) leann-env)
                  process-environment)))
    (with-current-buffer b (erase-buffer)
      (apply #'call-process leann-cli nil b nil args)
      (goto-char (point-min)))
    b))

(defun leann-search (query)
  "Search the LEANN index and show results."
  (interactive "sSearch query: ")
  (pop-to-buffer (leann--call (list "search" leann-index query) "*leann-search*")))

(defun leann-ask (question)
  "Ask the LLM with retrieval from LEANN and insert answer at point."
  (interactive "sAsk: ")
  (let ((tmp (leann--call (list "ask" leann-index question) "*leann-ask*")))
    (insert "\n#+BEGIN_QUOTE\n"
            (with-current-buffer tmp (buffer-string))
            "\n#+END_QUOTE\n")))

(defun leann-rebuild-index ()
  "Rebuild the LEANN index from ~/org."
  (interactive)
  (message "Rebuilding LEANN index…")
  (leann--call (list "build" leann-index "--docs" (expand-file-name "~/org")) "*leann-build*")
  (message "LEANN index rebuilt."))



;; Prefix keymap (change "C-c l" if you like)
(defvar leann-prefix-map
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "s") #'leann-search)
    (define-key m (kbd "a") #'leann-ask)
    (define-key m (kbd "b") #'leann-rebuild-index)
    m)
  "Keymap for commands after the LEANN prefix.")

(defvar leann-key-prefix "C-c l"
  "Key sequence used as the LEANN prefix (e.g., \"C-c l\" or \"C-c C-l\").")

(define-key global-map (kbd leann-key-prefix) leann-prefix-map)

(provide 'leann)
;;; leann.el ends here









;; --- instead of simple:
;; (global-set-key (kbd "C-c l s") #'leann-search)
;; (global-set-key (kbd "C-c l a") #'leann-ask)
;; (global-set-key (kbd "C-c l b") #'leann-rebuild-index)
