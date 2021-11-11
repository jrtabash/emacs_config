;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Grep and grep path and command
(defvar my-use-specials t)

(defun my-grep-path () (get-srcDirectory))

(defun set-use-specials () (interactive) (setq my-use-specials t))
(defun unset-use-specials () (interactive) (setq my-use-specials nil))

(defun my-grep-specials () (if my-use-specials "--exclude-dir=.svn --include=*.* -I " ""))
(defun my-grep-command () (format "grep %s-n -r %s* -e " (my-grep-specials) (my-grep-path)))

(setq grep-command (my-grep-command))

(defun my-grep ()
  (interactive)
  (let ((pattern (read-string (my-grep-command))))
    (unless (word-empty-p pattern)
      (grep (concat (my-grep-command) "\"" pattern "\"")))))

(defun my-find ()
  (interactive)
  (let* ((pattern (grab-word))
         (grep-command (format "grep %s-n -r %s* -e \"%s\"" (my-grep-specials) (my-grep-path) pattern)))
    (unless (word-empty-p pattern)
      (grep grep-command))))

(defun my-find-curDir ()
  (interactive)
  (let* ((pattern (grab-word))
         (bufDir (file-name-directory (buffer-file-name (current-buffer))))
         (grep-command (format "grep %s-n %s* -e \"%s\"" (my-grep-specials) bufDir pattern)))
    (unless (word-empty-p pattern)
      (grep grep-command))))

(defun my-find-curFile ()
  (interactive)
  (let* ((pattern (grab-word))
         (filename (buffer-file-name (current-buffer)))
         (grep-command (format "grep %s-n %s -e \"%s\"" (my-grep-specials) filename pattern)))
    (unless (word-empty-p pattern)
      (grep grep-command))))

(defun find-cppType ()
  (interactive)
  (let* ((pattern (grab-word))
         (grep-command (format "grep %s-n -r %s* -e \"class \\+%s\\|struct \\+%s\\|namespace \\+%s\\|using \\+%s\\|typedef.\\+%s\"" 
                               (my-grep-specials) (my-grep-path) pattern pattern pattern pattern pattern)))
    (unless (word-empty-p pattern)
      (grep grep-command))))

(defun find-TODOJT ()
  (interactive)
  (let ((grep-command (format "grep %s-n -r %s* -e \"TODO:JT\"" (my-grep-specials) (my-grep-path))))
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
