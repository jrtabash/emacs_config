;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Customization

;; ------------------------------------------------------------------------
;; Color Theme
;; (if (< emacs-major-version 24)
;;     (color-theme-late-night2)
;;   (if (display-graphic-p)
;;       (load-theme 'wombat t)
;;     (load-theme 'wombat t)))
;;labburn grandshell flatui-dark kaolin alect-black-alt gotham tango-dark wombat adwaita

(load-theme 'srcery t)

;; (if (display-graphic-p)
;;     (progn
;;       (set-foreground-color "#FFFFFF")
;;       (set-background-color "#000000"))
;;   (load-theme 'wombat t))

;; (set-foreground-color "#FFFFFF")
;; (set-foreground-color "gray")
;; (set-background-color "#000000")

;; ------------------------------------------------------------------------
;; ANSI color compilation filter
(require 'ansi-color)

(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))

(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; ------------------------------------------------------------------------
;; Tabs and C formatting
(setq-default indent-tabs-mode nil)

(setq c-default-style "bsd"
      c-basic-offset 4)

(defun my-c++-mode-common-hook ()
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'arglist-intro 8)
  (c-set-offset 'arglist-close 4)
  (c-set-offset 'case-label 0)
  (c-set-offset 'inclass 4)
  (c-set-offset 'comment-intro 0)
  (c-set-offset 'topmost-intro-cont 0)
  (c-set-offset 'innamespace 0)
  (c-set-offset 'namespace-open 0)
  (c-set-offset 'namespace-close 0)
  (c-set-offset 'template-args-cont 4)
  (c-set-offset 'statement-case-open 0)
  (c-set-offset 'statement-case-intro 4)
  (c-set-offset 'member-init-intro 4)
  (c-set-offset 'member-init-cont -2)
  (c-set-offset 'inher-cont 0)
  (c-set-offset 'statement-cont 4)
  (c-set-offset 'brace-list-open 0)
  (c-set-offset 'brace-list-intro 4)
  (c-set-offset 'statement-case-open 0)
  (c-set-offset 'statement-block-intro 4)
  (c-set-offset 'defun-block-intro 4)
  (c-set-offset 'case-label 4)
  (c-set-offset 'access-label -4)
  (show-paren-mode t)
  (setq truncate-lines nil)
  ;; (auto-fill-mode)
  (setq fill-column 120))

(defun my-go-mode-hook ()
  (setq tab-width 4 indent-tabs-mode nil))

(add-hook 'c++-mode-common-hook 'my-c++-mode-common-hook)
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; ------------------------------------------------------------------------
;; Font
;;(set-default-font "-adobe-courier-medium-r-normal--12-120-75-75-m-70-iso8859-1")
;;(set-default-font "-adobe-courier-medium-r-normal--14-100-100-100-m-90-iso10646-1")
;;(set-default-font "-adobe-courier-medium-r-normal--14-140-75-75-m-90-iso8859-1")
;; (when (display-graphic-p)
;;   (set-default-font "-Adobe-Adobe Courier-normal-normal-normal-*-14-*-*-*-m-90-iso10646-1"))

(when (display-graphic-p)
  (set-frame-font "courier 14" nil t))

;; ------------------------------------------------------------------------
;; Backup
(defvar backup-dir 
  (concat "/home/" (user-login-name) "/.emacs.d/auto-save-list/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

;; ------------------------------------------------------------------------
;; Auto Modes
(setq auto-mode-alist (cons '("\\.h" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.inc" . c++-mode) auto-mode-alist))

(setq auto-mode-alist (cons '("wscript" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("wscript_build" . python-mode) auto-mode-alist))

(setq auto-mode-alist (cons '("\\.ish" . common-lisp-mode) auto-mode-alist))

;; ------------------------------------------------------------------------
;; Diff
(setq ediff-split-window-function 'split-window-horizontally)

(add-hook 'ediff-load-hook
  (lambda ()
    (let ((bgCurrent "DarkBlue")
          (fgCurrent "White")
          (bgFine "Brown")
          (fgFine "White"))
      (set-face-foreground ediff-current-diff-face-A fgCurrent)
      (set-face-background ediff-current-diff-face-A bgCurrent)
      (set-face-foreground ediff-fine-diff-face-A    fgFine)
      (set-face-background ediff-fine-diff-face-A    bgFine)
      (set-face-foreground ediff-current-diff-face-B fgCurrent)
      (set-face-background ediff-current-diff-face-B bgCurrent)
      (set-face-foreground ediff-fine-diff-face-B    fgFine)
      (set-face-background ediff-fine-diff-face-B    bgFine))))

(custom-set-faces
 '(diff-context     ((t (:foreground "Grey")))     'now)
 '(diff-file-header ((t (:foreground "Cyan")))     'now)
 '(diff-header      ((t (:foreground "Cyan")))     'now)
 '(diff-hunk-header ((t (:foreground "Cyan")))     'now)
 '(diff-index       ((t (:foreground "Red")))      'now)
 '(diff-added       ((t (:foreground "Yellow")))   'now)
 '(diff-removed     ((t (:foreground "Green")))    'now)
 '(diff-changed     ((t (:foreground "Red")))      'now)
 '(diff-nonexistent ((t (:foreground "DarkBlue"))) 'now))

;; disable vc-git
;; (setq vc-handled-backends ())

;; ------------------------------------------------------------------------
;; Editor
(setq-default truncate-lines 1)

;; ------------------------------------------------------------------------
;; Window
(when (functionp #'tool-bar-mode)
  (tool-bar-mode -1))

(when (functionp #'menu-bar-mode)
  (menu-bar-mode -1))

(when (functionp #'scroll-bar-mode)
  (scroll-bar-mode -1))

;; (when (functionp #'global-linum-mode)
;;   (global-linum-mode 1))

;; (when (functionp #'global-hl-line-mode)
;;   (global-hl-line-mode 1))
