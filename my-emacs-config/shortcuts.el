;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set key shortcuts
(defvar my-shortcuts nil)
(unless (eql my-shortcuts nil)
  (setq my-shortcuts nil))

(defun add-a-shortcut (key command)
  (push (cons key command) my-shortcuts)
  (global-set-key (format "\M-s%s" key) command))

(defun show-my-shortcuts ()
  (interactive)
  (with-my-buffer "*my-shortcuts*"
    (insert "My Shortcuts, \"\\M-s\" followed by:")
    (newline)
    (mapcar (lambda (key.cmd)
              (insert (format "  %s ==> %s" (car key.cmd) (cdr key.cmd)))
              (newline))
            (reverse my-shortcuts))))

(add-a-shortcut "a" `find-cppType)            ;; Search for c++ class, struct or namespace definition (grabs current position to end of word)
;; A
(add-a-shortcut "b" `run-unit-test)           ;; Run unit test, grabbing current word as test name
(add-a-shortcut "B" `my-unit-tests)           ;; Run unit tests
(add-a-shortcut "c" `comment-region)          ;; Comment highlighted region
;; C
(add-a-shortcut "d" `add-TODOJT)              ;; Add a "TODO:JT" comment
;; D
(add-a-shortcut "e" `mark-sexp)               ;; Select sexp
(add-a-shortcut "E" `my-find-curFile)         ;; Search for text in current buffer/file (text = current position to end of word)
(add-a-shortcut "f" `my-find)                 ;; Search for text (text = current position to end of word)
(add-a-shortcut "F" `my-find-curDir)          ;; Search for text in current buffer directory (text = current position to end of word)
(add-a-shortcut "g" `my-grep)                 ;; Use my grep (cpp path)
(add-a-shortcut "G" `grep)                    ;; Use grep
(add-a-shortcut "h" `next-cpp-file)           ;; Switch between cpp/h files - (old function = ff-find-other-file)
(add-a-shortcut "H" `show-my-shortcuts)       ;; Show list of shortcuts
(add-a-shortcut "i" `indent-region)           ;; Indent highlighted region
;; I
(add-a-shortcut "j" `find-TODOJT)             ;; Find all "TODO:JT" comments
;; J
(add-a-shortcut "k" `close-all-open-buffers)  ;; Close/kill all open non-starred buffers
;; K
(add-a-shortcut "l" `goto-line)               ;; Goto line
(add-a-shortcut "L" `my-countMatches)         ;; Count pattern matches in current file, starting at current position
;; m
;; M
;; n
;; N
(add-a-shortcut "o" `my-compile)              ;; Compile C++ source
(add-a-shortcut "O" `kill-compilation)        ;; Kill compilation of C++ source
;; p
;; P
(add-a-shortcut "q" `my-tags-apropos)         ;; Query Tags (grab current position to end of word)
;; Q
(add-a-shortcut "r" `replace-string)          ;; Replace string
(add-a-shortcut "R" `replace-regexp)          ;; Replace regex
(add-a-shortcut "s" `tags-loop-continue)      ;; Tags loop continue
(add-a-shortcut "S" `search-forward-regexp)   ;; Search forward regular expression
(add-a-shortcut "t" `start-term)              ;; Start terminal
(add-a-shortcut "T" `shell)                   ;; Start shell
(add-a-shortcut "u" `uncomment-region)        ;; Uncomment highlighted region
;; U
;; v
;; V
(add-a-shortcut "w" `my-tags-search)          ;; Tags search (grab current position to end of word)
;; W
(add-a-shortcut "x" `eval-expression)         ;; Evaluate emacs lisp expression
;; X
(add-a-shortcut "y" `my-highlight)            ;; Highlight
(add-a-shortcut "Y" `my-unhighlight)          ;; Unhighlight
(add-a-shortcut "z" `my-copy)                 ;; Copy text from current position to end of word
;; Z
(add-a-shortcut "`" `magit-diff-working-tree) ;; Version control diff working tree
(add-a-shortcut "1" `vc-diff)                 ;; Version control diff current file/buffer
(add-a-shortcut "2" `vc-print-log)            ;; Version control log current file/buffer
(add-a-shortcut "3" `magit-blame)             ;; Version control blame current file/buffer
(add-a-shortcut "4" `magit-status)            ;; Version control status
;; 5
;; 6
;; 7
;; 8
(add-a-shortcut "9" `revert-buffer)           ;; Revert buffer
(add-a-shortcut "(" `reload-all-open-buffers) ;; Revert all open buffers
(add-a-shortcut "0" `load-dotemacs)           ;; Reload .emacs file
(add-a-shortcut "=" `calc)                    ;; Emacs Calculator

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Other shortcuts
(global-set-key (kbd "<C-tab>") #'other-window) ;; Switch to other window (alternate to 'Ctrl-x o'

(global-set-key "\M-n" #'my-forward-line)
(global-set-key "\M-p" #'my-backward-line)
(global-set-key "\M-2" #'isearch-cancel)
(global-set-key "\M-3" #'isearch-forward-symbol-at-point)

(global-set-key (kbd "C-x F") #'helm-projectile-find-file-dwim)
(global-set-key (kbd "C-x f") #'helm-projectile-find-file-dwim)
(global-set-key (kbd "C-x =") #'my-enlarge-window)
(global-set-key (kbd "C-x -") #'my-shrink-window)
(global-set-key (kbd "C-x ]") #'my-enlarge-window-horizontally)
(global-set-key (kbd "C-x [") #'my-shrink-window-horizontally)
(global-set-key (kbd "C-x q") #'helm-resume)
(global-set-key (kbd "C-x w") #'helm-swoop-back-to-last-point)

(global-set-key (kbd "<f3>") #'isearch-forward-symbol-at-point)
(global-set-key (kbd "<f12>") #'split-and-start-term)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ask for confirmation on exit
(global-set-key "\C-x\C-c"
		(lambda () (interactive)
		  (if (string-equal "y" (read-string "Exit Emacs (y/n)? "))
		      (save-buffers-kill-emacs))))
