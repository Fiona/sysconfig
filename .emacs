(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "~/elisp/mmm-mode")
(add-to-list 'load-path "~/elisp/icicles")
(add-to-list 'load-path "~/elisp/erc")
(add-to-list 'load-path "~/elisp/flycheck")
(add-to-list 'load-path "~/elisp/seq")

; MELPA and packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

; Compatability with newer versions of emacs
(defalias 'apropos-macrop 'macrop)

; ------------------------------------------------------------------------------------
; ---------------------- FACES AND COLOURS -------------------------------------------
; ------------------------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(c-default-style "bsd")
 '(cua-mode t nil (cua-base))
 '(delete-active-region nil)
 '(frame-background-mode (quote dark))
 '(imenu-auto-rescan t)
 '(package-selected-packages
   (quote
    (csharp-mode sass-mode omnisharp neotree flycheck-color-mode-line company-jedi)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 99 :width normal :family "schumacher-clean"))))
 '(diredp-date-time ((t (:foreground "gray60"))))
 '(diredp-dir-heading ((t (:background "#1e1e1e" :foreground "white" :bold t :weight bold))))
 '(diredp-dir-priv ((t (:background "#1e1e1e" :foreground "gray60" :bold t :weight bold))))
 '(diredp-exec-priv ((t (:background "#1e1e1e" :foreground "Yellow"))))
 '(diredp-file-name ((t (:foreground "white"))))
 '(diredp-file-suffix ((t (:foreground "gray80"))))
 '(diredp-flag-mark-line ((t (:foreground "#fcc" :bold t :weight bold))))
 '(diredp-no-priv ((t (:background "#1e1e1e" :foreground "White"))))
 '(diredp-read-priv ((t (:background "#1e1e1e" :foreground "Green"))))
 '(diredp-write-priv ((t (:background "#1e1e1e" :foreground "Red"))))
 '(icicle-complete-input ((((background dark)) :background "black")))
 '(icicle-completing-mustmatch-prompt-prefix ((((type x w32 mac graphic) (class color)) (:foreground "Cyan"))))
 '(icicle-completing-prompt-prefix ((((type x w32 mac graphic) (class color)) (:foreground "Red"))))
 '(icicle-current-candidate-highlight ((((background dark)) (:background "gray20"))))
 '(icicle-historical-candidate ((((background dark)) (:foreground "White"))))
 '(icicle-prompt-suffix ((((type x w32 mac graphic) (class color) (background dark)) (:foreground "LightSlateBlue"))))
 '(icicle-search-context-level-1 ((((background dark)) (:background "gray20" :weight bold))))
 '(icicle-search-context-level-2 ((((background dark)) (:background "gray15" :weight bold))))
 '(icicle-search-context-level-3 ((((background dark)) (:background "gray10" :weight bold))))
 '(icicle-search-context-level-4 ((((background dark)) (:weight bold))))
 '(icicle-search-context-level-5 ((((background dark)) (:weight bold))))
 '(icicle-search-context-level-6 ((((background dark)) (:weight bold))))
 '(icicle-search-context-level-7 ((((background dark)) (:weight bold))))
 '(icicle-search-context-level-8 ((((background dark)) (:weight bold))))
 '(icicle-search-current-input ((t (:foreground "green"))))
 '(icicle-search-main-regexp-others ((((background dark)) (:foreground "SeaGreen"))))
 '(icicle-special-candidate ((((background dark)) (:foreground "yellow"))))
 '(icicle-whitespace-highlight ((t (:background "#300"))))
 '(org-column ((t (:background "grey20" :strike-through nil :underline nil :slant normal :weight normal :height 99 :width normal :family "schumacher-clean")))))

; -------------
; Colour scheme
; -------------
(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-tango)

; -------------
; Add MELPA to package management
; -------------
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

; ------------------------------------------------------------------------------------
; ---------------------- MODE CONFIGURATION ------------------------------------------
; ------------------------------------------------------------------------------------
; ------------
; Company mode autocomplete
; ------------
(require 'company)
(add-to-list 'company-backends 'company-omnisharp)
(add-to-list 'company-backends 'company-jedi)

; ------------
; PHP mode
; ------------
(require 'php-mode)

; Drupal file types
(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.engine$" . php-mode))

; ------------
; Python mode
; ------------
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\SConstruct\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(add-hook 'python-mode-hook
           '(lambda () (interactive)
             (company-mode)
             (jedi:setup)
             (setq indent-tabs-mode nil)
             (setq tab-width 4)
             (setq python-indent 4)
             (set (make-variable-buffer-local 'beginning-of-defun-function)
                  'py-beginning-of-def-or-class)
             (setq outline-regexp "def\\|class ")))

(setq jedi:complete-on-dot t)

; ------------
; Javascript mode
; ------------
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)

; ------------
; CSS mode
; ------------
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons '("\\.css\\'" . css-mode) auto-mode-alist))

; ------------
; TADS3 mode
; ------------
;(require 'tads3)
;(autoload 'tads3-mode "tads3-mode" "TADS 2 editing mode." t)
;(setq auto-mode-alist

; ------------
; C# Mode
; ------------
(require 'omnisharp)
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(add-hook 'csharp-mode-hook '(lambda () (interactive)
                               (omnisharp-mode)
                               (company-mode)
                               (flycheck-mode)
                               (local-set-key (kbd "M-.") 'omnisharp-go-to-definition)
                               ))

;; ------------------------------------------------------------------------------------
;; ---------------------- MISCELANIOUS SETTINGS ---------------------------------------
;; ------------------------------------------------------------------------------------
;; -----
;; Org mode
;; -----
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-agenda-files (file-expand-wildcards "~/org/*.org"))
(setq org-log-done t)

;; -----
;; Do not want start up screen, scrollbars, menus or the active region deletion behaviour
;; -----
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq delete-active-region nil)

;; -----
;; Tabs are four characters wide plz
;; -----
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)

;; -----
;; Make switch/cases indent correctly
;; -----
(c-set-offset 'case-label '+)

;; -----
;; disable backup
;; -----
(setq backup-inhibited t)

;; -----
;;disable auto save
;; -----
(setq auto-save-default nil)

;; -----
;; Linum mode adds line numbers in the gutter
;; -----
(require 'linum)
(global-linum-mode)

;; -----
;; Allows us to switch windows by number
;; -----
(require 'window-number)
(window-number-meta-mode)

;; -----
;; Change 'yes' or 'no' to y/n
;; -----
(fset 'yes-or-no-p 'y-or-n-p)

;; -----
;; I've decided I want case insensitive searching
;; -----
(setq case-fold-search t)

;; -----
;; File browser
;; -----
(require 'nav)
(require 'dired+)

;; -----
;; Magit is Git integration
;; -----
(require 'magit)

;; -----
;; We can browse the keyring with this
;; -----
(require 'browse-kill-ring)

;; -----
;; Make a window permanent when hitting pause
;; -----
(defun toggle-current-window-dedication ()
  (interactive)
  (let* ((window    (selected-window))
		 (dedicated (window-dedicated-p window)))
	(set-window-dedicated-p window (not dedicated))
	(message "Window %sdedicated to %s"
			 (if dedicated "no longer " "")
			 (buffer-name))))

(global-set-key [pause] 'toggle-current-window-dedication)

;; -----
;; Uniqify will make buffers with the same name more meaning ful
;; (file|dir) rather than file<2>
;; -----
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
; Don't rename special buffers
(setq uniquify-ignore-buffers-re "^\*")

;; -----
;; Reconfigure keys
;; -----
(define-key global-map [f12] 'kill-buffer)

(global-set-key (kbd "C-c a") 'org-agenda)
(define-key global-map [f5] 'revert-buffer)

(define-key global-map [f10] 'org-clock-in)
(define-key global-map [f11] 'org-clock-out)

(global-set-key [f8] 'neotree-toggle)

;; -----
;; Delete all trailing whitespace
;; -----
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; ------------------------------------------------------------------------------------
;; ---------------------------- SESSION RESTORE ---------------------------------------
;; ------------------------------------------------------------------------------------
;; -----
;; Restore frame layout and open buffers
;; -----
(require 'windows)
(require 'revive)
(win:startup-with-window)

(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe Emacs" t)

; This is needed to avoid that the save-history buffer is revived as well
(setq revive:ignore-buffer-pattern "^\\( \\*\\)\\|\\(\\.emacs-histories\\)")

; Save on exit
(add-hook 'kill-emacs-hook 'save-current-configuration)

; When loaded, see if the config file exists and restores the session
(add-hook 'after-init-hook
  (if (file-exists-p revive:configuration-file)
      (let ()
        (resume)
        (add-hook 'kill-emacs-hook 'save-current-configuration)
		)
	)
)
