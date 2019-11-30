(defun next-rest (rest)
  (cond
   ((string-equal rest ".h") "_inline.h")
   ((string-equal rest "_inline.h") ".cpp")
   ((string-equal rest ".cpp") ".h")))

(defun next-filename (filename)
  (let ((basename (file-name-base
                   (nth 0 (split-string filename "_inline"))))
        (rest (next-rest
               (if (string-suffix-p "_inline.h" filename)
                   "_inline.h"
                 (file-name-extension filename 1)))))
    (concat (file-name-directory filename) basename rest)))

(defun next-open-file (filename)
  (when (file-readable-p filename)
    (switch-to-buffer (find-file filename))
    (return-from next-open-file t))
  nil)

(defun next-cpp-file ()
  (interactive)
  (let ((filename buffer-file-name))
    (when (file-readable-p filename)
      (let ((nextFilename (next-filename filename)))
        (unless (next-open-file nextFilename)
          (next-open-file (next-filename nextFilename)))))))
