;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Count matched
(defun my-countMatches ()
  (interactive)
  (let ((pattern (grab-word)))
    (when (word-empty-p pattern)
      (setq pattern (read-string "Enter pattern: ")))
    (unless (word-empty-p pattern)
      (message (format "count(%s): %d" pattern (count-matches pattern))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Copy
(defun my-copy ()
  (interactive)
  (apply-wordStartAndEndFunction #'copy-region-as-kill))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-forward-line ()
  (interactive)
  (forward-line 5))

(defun my-backward-line ()
  (interactive)
  (forward-line -5))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-enlarge-window ()
  (interactive)
  (enlarge-window 5))

(defun my-shrink-window ()
  (interactive)
  (shrink-window 5))

(defun my-enlarge-window-horizontally ()
  (interactive)
  (enlarge-window-horizontally 5))

(defun my-shrink-window-horizontally ()
  (interactive)
  (shrink-window-horizontally 5))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FIPLR find file in cpp
(defun fiplr-find-file-in-cpp ()
  (interactive)
  (fiplr-find-file-in-directory (get-cppDirectory) fiplr-ignored-globs))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO
(defun add-TODOJT ()
  (interactive)
  (insert-TODOJT (read-string "TODO Text: ")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun load-dotemacs ()
  (interactive)
  (let ((dotemacs "~/.emacs"))
    (load dotemacs)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun start-term ()
  (interactive)
  (term "/bin/bash"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun split-and-start-term ()
  (interactive)
  (split-window-vertically)
  (switch-to-buffer-other-window (buffer-name (current-buffer)))
  (start-term))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-compile ()
  (interactive)
  (compile (format "cd %sishlang/src/ && make" (get-cppDirectory))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-unit-tests ()
  (interactive)
  (let ((testOptions (read-string "Test Options: "))
        (build (format "%sishlang/src/build" (get-cppDirectory))))
    (async-shell-command
     (format "export LD_LIBRARY_PATH=%s; %s/ishlang_unit_test %s"
             build
             build
             testOptions))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun run-unit-test ()
  (interactive)
  (save-excursion
    (beginning-of-defun)
    (forward-word)
    (forward-word)
    (forward-char)
    (forward-char)
    ;; (down-list)
    (let ((testName (grab-word))
          (build (format "%sishlang/src/build" (get-cppDirectory))))
      (unless (word-empty-p testName)
        (shell-command
         (format "export LD_LIBRARY_PATH=%s; %s/ishlang_unit_test -v -n %s"
                 build
                 build
                 testName))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Close all open buffers (non-starred)

(defun close-all-open-buffers ()
  (interactive)
  (let ((killed 0)
        (notKilled 0))
    (mapcar (lambda (buf)
              (unless (is-special-buffer-p buf)
                (if (kill-buffer buf)
                    (setq killed (1+ killed))
                  (setq notKilled (1+ notKilled)))))
            (buffer-list))
    (with-my-buffer "*close-all-buffers-result*"
      (insert "Close All Buffers Summary")
      (newline)
      (insert (format "  Closed buffers: %d" killed))
      (newline)
      (insert (format "    Open buffers: %d" notKilled))
      (newline))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reload/revert all open buffers

(defun reload-all-open-buffers ()
  (interactive)
  (let ((found 0)
        (reverted 0))
    (mapcar (lambda (buf)
              (setq found (1+ found))
              (unless (is-special-buffer-p buf)
                (revert-buffer buf :noconfirm 1)
                (setq reverted (1+ reverted))))
            (buffer-list))
    (with-my-buffer "*reload-all-open-buffers*"
      (insert "Reload All Buffers Summary")
      (newline)
      (insert (format "     Found buffers: %d" found))
      (newline)
      (insert (format "  Reverted buffers: %d" reverted))
      (newline))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Highlight / unhighlight

(defvar *$my-highlight-regex* nil)
(defvar *$my-highlight-color* nil)

(defun my-highlight-color ()
  (cond
   ((eql *$my-highlight-color* 'hi-green)  (setq *$my-highlight-color* 'hi-blue))
   ((eql *$my-highlight-color* 'hi-blue)   (setq *$my-highlight-color* 'hi-pink))
   ((eql *$my-highlight-color* 'hi-pink)   (setq *$my-highlight-color* 'hi-yellow))
   ((eql *$my-highlight-color* 'hi-yellow) (setq *$my-highlight-color* 'highlight))
   ((eql *$my-highlight-color* 'highlight) (setq *$my-highlight-color* 'hi-green))
   (t                                      (setq *$my-highlight-color* 'hi-green))))

(defun my-highlight ()
  (interactive)
  (let ((pattern (grab-word-ask)))
    (setq *$my-highlight-regex*
          (cons pattern *$my-highlight-regex*))
    (highlight-regexp (car *$my-highlight-regex*) (my-highlight-color))))

(defun my-unhighlight ()
  (interactive)
  (unhighlight-regexp (car *$my-highlight-regex*))
  (setq *$my-highlight-regex* (cdr *$my-highlight-regex*)))
