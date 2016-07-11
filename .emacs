(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "~/elisp/mmm-mode")
(add-to-list 'load-path "~/elisp/icicles")
(add-to-list 'load-path "~/elisp/erc")



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
; PHP mode
; ------------
(require 'php-mode)


; Drupal file types
(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.engine$" . php-mode))


; ------------
; Multi mode
; ------------
;(require 'mmm-mode)
;(setq mmm-global-mode 'maybe)

; Set up PHP Heredocs to be HTML highlighted
;(mmm-add-classes
; '((php-here-doc
;  :front "<<<\\([a-zA-Z0-9_-]+\\)"
;  :back "^~1[;]?$"
;  :save-matches 1
;  :submode html-mode
;  :delimiter-mode nil)))

;(add-to-list 'mmm-mode-ext-classes-alist '(php-mode nil php-here-doc))
;(set-face-background 'mmm-default-submode-face nil)


; ------------
; Python mode
; ------------
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\SConstruct\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(add-hook 'python-mode-hook
           (lambda ()
             (set (make-variable-buffer-local 'beginning-of-defun-function)
                  'py-beginning-of-def-or-class)
             (setq outline-regexp "def\\|class ")))


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
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
;(setq auto-mode-alist
;      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
(add-hook 'csharp-mode-hook '(lambda () (interactive)
                               (omnisharp-mode)
                               (company-mode)
                               (flycheck-mode)
                               (local-set-key (kbd "M-.") 'omnisharp-go-to-definition)
                               ))
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-omnisharp))


;; ------------------------------------------------------------------------------------
;; ---------------------- FLYMAKE SETTINGS --------------------------------------------
;; ------------------------------------------------------------------------------------
;(require 'flymake)

;(defun auto-flymake-goto-next-error()
;  (interactive)
;  (flymake-goto-next-error)
;  (flymake-display-err-menu-for-current-line)
;  )

;(defun auto-flymake-goto-prev-error()
;  (interactive)
;  (flymake-goto-next-error)
;  (flymake-display-err-menu-for-current-line)
;  )


;; For PHP
;; can't remember where it came from
;(unless (fboundp 'flymake-php-init)
;  (defun flymake-php-init ()
;    (let* ((temp-file (flymake-init-create-temp-buffer-copy
;                       'flymake-create-temp-inplace))
;           (local-file (file-relative-name
;                        temp-file
;                        (file-name-directory buffer-file-name))))
;      (list "php" (list "-f" local-file "-l")))))

;(let ((php-ext-re "\\.php[345]?\\'")
;      (php-error-re
;       "\\(?:Parse\\|Fatal\\) error: \\(.*\\) in \\(.*\\) on line \\([0-9]+\\)"))
;  (unless (assoc php-ext-re flymake-allowed-file-name-masks)
;    (add-to-list 'flymake-allowed-file-name-masks
;                 (list php-ext-re
;					   'flymake-php-init
;					   'flymake-simple-cleanup
;					   'flymake-get-real-file-name))
;   (add-to-list 'compilation-error-regexp-alist-alist
;                 (list 'compilation-php
;					   php-error-re  2 3 nil nil))
;    (add-to-list 'compilation-error-regexp-alist 'compilation-php)
;    (add-to-list 'flymake-err-line-patterns
;                 (list php-error-re 2 3 nil 1))))

;(add-hook 'php-mode-hook (lambda () (flymake-mode t)))


;(set-face-background 'flymake-errline "#ffa2a2")
;(set-face-foreground 'flymake-errline "#ff0000")



;; ------------------------------------------------------------------------------------
;; ---------------------- EDITOR ADDITIONS --------------------------------------------
;; ------------------------------------------------------------------------------------

;; -----
;; YASnippet
;; -----
;(require 'yasnippet)
;(yas/initialize)
;(yas/load-directory "~/elisp/snippets/")

;; -----
;; Auto complete
;; -----
;(when (require 'auto-complete nil t)
;  (require 'auto-complete-yasnippet)
;  (global-auto-complete-mode t)
;
;  (set-face-background 'ac-candidate-face "lightgray")
;  (set-face-underline 'ac-candidate-face "darkgray")
;  (set-face-background 'ac-selection-face "steelblue")
;
;  (setq ac-dwim t)
;  (set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer))
;)


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

; sort out python specific crap
(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 4)
        (setq python-indent 4)))


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
;; Nearly murdered emacs for it's yes or no bullshit
;; -----
(fset 'yes-or-no-p 'y-or-n-p)

;; -----
;; File browser
;; -----
(require 'nav)

;; -----
;; Magit is Git integration
;; -----
(require 'magit)

;; -----
;; We can browse the keyring with this
;; -----
(require 'browse-kill-ring)

;; -----
;; Finally - a minimap for emacs!
;; -----
;(require 'minimap)


;; -----
;; How did I live without this? This will make certain windows permanent.
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
;(global-set-key (kbd "M-]") 'dabbrev-expand)
(define-key global-map [f12] 'kill-buffer)
;(global-set-key (kbd "f12") 'kill-buffer)
;(global-set-key (kbd "M-'") 'flymake-display-err-menu-for-current-line)
;(global-set-key (kbd "M-a") 'auto-flymake-goto-prev-error)
;(global-set-key (kbd "M-o") 'auto-flymake-goto-next-error)
;(global-set-key (kbd "C-x C-g") 'magit-status)

;(define-key global-map [f1] 'minimap-create)
;(define-key global-map [f2] 'minimap-kill)

(global-set-key (kbd "C-c a") 'org-agenda)
(define-key global-map [f5] 'revert-buffer)

(define-key global-map [f10] 'org-clock-in)
(define-key global-map [f11] 'org-clock-out)

; Resize window keys
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(require 'dired+)

;; -----
;; This enhances tags by searching up the current directory for a tags file so
;; the tags file searched in is generally the current project open.
;; -----
;(require 'etags-table)
;(setq etags-table-search-up-depth 7)


;; -----
;; Highlight lines longer than 80 characters
;; -----
;(font-lock-add-keywords
; 'php-mode
; '(("^[^\n]\\{80\\}\\(.*\\)$"
;	1 font-lock-warning-face prepend)))

;; -----
;; Neat tree view
;; ----
;(require 'neotree)
;(global-set-key [f8] 'neotree-toggle)


;; Standard Jedi.el setting
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Trailing whitespace is dumb so i'm not having any.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; ------------------------------------------------------------------------------------
; ---------------------- ERC IRC MODE ------------------------------------------------
; ------------------------------------------------------------------------------------
(require 'erc)

(setq erc-autojoin-channels-alist
	  '(("freenode.net" "#geekup")
	  ("blitzed.org" "#bilge")
	  ("localhost"))
)

(erc-timestamp-mode t)
(setq erc-timestamp-format "[%R-%m/%d]")

(setq erc-user-full-name "Fiona Burrows")
(setq erc-email-userid "fiona@myrmidonprocess.com")

(setq erc-keywords '("fiona"))

; thanks for this one emacs wiki
(setq erc-button-url-regexp
	  "\\([-a-zA-Z0-9_=!?#$@~`%&*+\\/:;,]+\\.\\)+[-a-zA-Z0-9_=!?#$@~`%&*+\\/:;,]*[-a-zA-Z0-9\\/]")

(defun irc-maybe ()
  "Connect to IRC."
  (interactive)
  (when (y-or-n-p "IRC? ")
	(erc :server "irc.freenode.net" :port 6667 :nick "Fiona")
	(erc :server "irc.blitzed.org" :port 6667 :nick "Fiona")
	; Bitlbee
	(erc :server "localhost" :port 6667 :nick "Fiona")
	)
  )

;(add-hook 'after-init-hook 'irc-maybe)

;; -----
;; Magic Jedi Python stuff
;; -----
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; -----
;; Cool file tree view
;; -----
(global-set-key [f8] 'neotree-toggle)

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
