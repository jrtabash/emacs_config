;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load my emacs configuration files
(defvar *$my-emacs-config* "~/.my-emacs-config/")
(let ((my-config-main (concat *$my-emacs-config* "main.el")))
  (when (file-readable-p my-config-main)
    (load my-config-main)))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#1C1B19" "#EF2F27" "#519F50" "#FBB829" "#2C78BF" "#E02C6D" "#0AAEB3" "#918175"])
 '(custom-safe-themes
   (quote
    ("05d1b0f079a493d98d02444fafc8d85ba5815b1e1d731a80291f063fd72ee0a9" default)))
 '(hl-paren-colors (quote ("#FCE8C3" "#519F50" "#2C78BF" "#918175")))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (haskell-mode helm-projectile projectile scala-mode magit fiplr ace-isearch rust-mode lua-mode go-mode clojure-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t (:foreground "Yellow"))))
 '(diff-changed ((t (:foreground "Red"))))
 '(diff-context ((t (:foreground "Grey"))))
 '(diff-file-header ((t (:foreground "Cyan"))))
 '(diff-header ((t (:foreground "Cyan"))))
 '(diff-hunk-header ((t (:foreground "Cyan"))))
 '(diff-index ((t (:foreground "Red"))))
 '(diff-nonexistent ((t (:foreground "DarkBlue"))))
 '(diff-removed ((t (:foreground "Green")))))
