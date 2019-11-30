;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; With my buffer macro

(defmacro with-my-buffer (name &rest body)
  `(let ((*$myBuffer* ,(get-buffer-create name)))
     (with-current-buffer *$myBuffer*
       (goto-char 0)
       (erase-buffer)
       ,@body)
     (switch-to-buffer *$myBuffer*)
     (buffer-name *$myBuffer*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; With current directory

;; (defmacro with-my-current-dir (dirName &rest body)
;;   `(let ((*$myCurDir* ,default-directory))
;;      (setq default-directory ,dirName)
;;      ,@body
;;      (setq default-directory *$myCurDir*)))
