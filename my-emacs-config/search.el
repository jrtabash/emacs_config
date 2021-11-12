;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Grep and grep path and command

(defun my-grep-path () (get-srcDirectory))

;; grep
;; (defun my-grep-bin () "grep")
;; (defun my-grep-specials () "--exclude-dir=.svn --include=*.* -I ")
;; (defun my-grep-command-path (path) (format "%s %s-n -r %s* -e " (my-grep-bin) (my-grep-specials) path))
;; (defun cpp-type-expr () "%s \"class \\+%s\\|struct \\+%s\\|namespace \\+%s\\|using \\+%s\\|typedef.\\+%s\"")

;; ripgrep
(defun my-grep-bin () "rg")
(defun my-grep-specials () "-H --no-heading --color never ")
(defun my-grep-command-path (path) (format "%s %s-n %s -e " (my-grep-bin) (my-grep-specials) path))
(defun cpp-type-expr () "%s \"class +%s|struct +%s|namespace +%s|using +%s|typedef.+%s\"")

(defun my-grep-command () (my-grep-command-path (my-grep-path)))

(setq grep-command (my-grep-command))

(defun my-grep ()
  (interactive)
  (let ((pattern (read-string (my-grep-command))))
    (unless (word-empty-p pattern)
      (grep (concat (my-grep-command) "\"" pattern "\"")))))

(defun my-find ()
  (interactive)
  (let* ((pattern (grab-word))
         (grep-command (format "%s \"%s\"" (my-grep-command) pattern)))
    (unless (word-empty-p pattern)
      (grep grep-command))))

(defun my-find-curDir ()
  (interactive)
  (let* ((pattern (grab-word))
         (bufDir (file-name-directory (buffer-file-name (current-buffer))))
         (grep-command (format "%s \"%s\"" (my-grep-command-path bufDir) pattern)))
    (unless (word-empty-p pattern)
      (grep grep-command))))

(defun find-cppType ()
  (interactive)
  (let* ((pattern (grab-word))
         (grep-command (format (cpp-type-expr) (my-grep-command) pattern pattern pattern pattern pattern)))
    (unless (word-empty-p pattern)
      (grep grep-command))))

(defun find-TODOJT ()
  (interactive)
  (let ((grep-command (format "%s \"TODO.JT\"" (my-grep-command))))
    (grep grep-command)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TAGS
(defun my-tags-search ()
  (interactive)
  (let ((pattern (grab-word)))
    (unless (word-empty-p pattern)
      (tags-search pattern))))

(defun my-tags-apropos ()
  (interactive)
  (let ((pattern (grab-word)))
    (unless (word-empty-p pattern)
      (tags-apropos pattern))))
