;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; To load this file into emacs, add something like this to .emacs:
;;
;; (defvar *$my-emacs-config* "~/<where-your-config-elisp-files-are>/")
;; (let ((my-config-main (concat *$my-emacs-config* "main.el")))
;;   (when (file-readable-p my-config-main)
;;     (load my-config-main)))
;; 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load my emacs configuration files
(defvar *$my-emacs-config-files*
  '("packages"
    "macros"
    "look-and-feel"
    "helpers"
    "search"
    "compile"
    "misc"
    "next"
    "shortcuts"
    "custom"))

(dolist (name *$my-emacs-config-files*)
  (let ((file (concat *$my-emacs-config* name ".el")))
    (when (file-readable-p file)
      (load file))))

(let ((scratchFile (concat *$my-emacs-config* "scratch.el")))
  (when (file-readable-p scratchFile)
    (let* ((attr (file-attributes scratchFile 'integer))
           (size (nth 7 attr)))
      (when (> size 0)
        (with-my-buffer "*scratch*"
          (goto-char (point-max))
          (newline)
          (insert "========================")
          (newline)
          (insert "Running scratch.el file:")
          (newline)
          (load scratchFile))))))
