;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Helper functions
(defun get-currentPosition ()
  (marker-position (point-marker)))

(defun get-endOfWordPosition (start)
  (let ((pos (- (re-search-forward "[ ;:=(){}\n\t\-\.<>]") 1)))
    (goto-char start)
    pos))

(defun apply-wordStartAndEndFunction (ftn)
  (let* ((start (get-currentPosition))
         (end (get-endOfWordPosition start)))
    (when (> end start)
      (funcall ftn start end))))

(defun grab-word ()
  ;; (thing-at-point)
  (let ((word (thing-at-point 'word)))
  ;; (let ((word (apply-wordStartAndEndFunction #'buffer-substring)))
    (if (stringp word)
        word
      (read-string "enter pattern: "))))

(defun grab-word-ask ()
  (let ((word (grab-word)))
    (cond
     ((stringp word)
      (let ((other (read-string (format "Enter pattern (%s): " word))))
        (if (string= other "")
            word
          other)))
     (t
      (read-string "Enter pattern: ")))))

(defun word-p (word) (stringp word))
(defun word-empty-p (word) (string= word ""))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Is special buffer?
(defun is-special-buffer-p (buf)
  (let ((first (substring (buffer-name buf) 0 1)))
    (or (string= first "*") (string= first " "))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Get cpp source directory
(defun get-cppDirectory ()
  ;; "~/Development/cpp/"
  "~/github/ishlang/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Insert TODO
(defun insert-TODOJT (todoText)
  (cond
   ((and (stringp todoText)
         (> (length todoText) 0))
    (setq todoText (format " - %s" todoText)))
   (t
    (setq todoText "")))
  
  (beginning-of-line nil)
  (insert (format "// TODO:JT%s" todoText))
  (newline))
