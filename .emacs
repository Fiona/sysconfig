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
 '(imenu-auto-rescan t)
 '(show-paren-mode t)
 '(frame-background-mode (quote dark))
 '(tool-bar-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(icicle-complete-input ((((background dark)) :background "black")))
 '(icicle-completing-mustmatch-prompt-prefix ((((type x w32 mac graphic) (class color)) (:foreground "Cyan"))))
 '(icicle-completing-prompt-prefix ((((type x w32 mac graphic) (class     color)) (:foreground "Red"))))
 '(icicle-current-candidate-highlight ((((background dark)) (:background "gray20"))))
 '(icicle-historical-candidate ((((background dark)) (:foreground "White"))))
 '(icicle-prompt-suffix ((((type x w32 mac graphic) (class color) (background dark)) (:foreground "LightSlateBlue"))))
 '(icicle-search-context-level-1 ((((background dark)) (:background     "gray20" :weight bold))))
 '(icicle-search-context-level-2 ((((background dark)) (:background     "gray15" :weight bold))))
 '(icicle-search-context-level-3 ((((background dark)) (:background     "gray10" :weight bold))))
 '(icicle-search-context-level-4 ((((background dark)) (:weight bold))))
 '(icicle-search-context-level-5 ((((background dark)) (:weight bold))))
 '(icicle-search-context-level-6 ((((background dark)) (:weight bold))))
 '(icicle-search-context-level-7 ((((background dark)) (:weight bold))))
 '(icicle-search-context-level-8 ((((background dark)) (:weight bold))))
 '(icicle-search-current-input ((t (:foreground "green"))))
 '(icicle-search-main-regexp-others ((((background dark)) (:foreground  "SeaGreen"))))
 '(icicle-special-candidate ((((background dark)) (:foreground "yellow"))))
 '(icicle-whitespace-highlight ((t (:background "#300"))))
 '(diredp-date-time ((t (:foreground "gray60"))))
 '(diredp-dir-heading ((t (:background "#1e1e1e" :foreground "white" :bold t :weight bold))))
 '(diredp-dir-priv ((t (:background "#1e1e1e" :foreground "gray60" :bold t :weight bold))))
 '(diredp-file-name ((t (:foreground "white"))))
 '(diredp-file-suffix ((t (:foreground "gray80"))))
 '(diredp-flag-mark-line ((t (:foreground "#fcc" :bold t :weight bold))))
 '(diredp-read-priv ((t (:background "#1e1e1e" :foreground "Green"))))
 '(diredp-write-priv ((t (:background "#1e1e1e" :foreground "Red"))))
 '(diredp-exec-priv ((t (:background "#1e1e1e" :foreground "Yellow"))))
 '(diredp-no-priv ((t (:background "#1e1e1e" :foreground "White"))))
 '(default ((t (:stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 99 :width normal :family "schumacher-clean")))))



; -------------
; Colour scheme
; -------------
(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-tango)



; ------------------------------------------------------------------------------------
; ---------------------- MODE CONFIGURATION ------------------------------------------
; ------------------------------------------------------------------------------------

; ------------
; PHP mode
; ------------
(require 'php-mode)

; stop indentation being a cock
(defun php-mode-hook ()
  (setq tab-width 4
        c-basic-offset 4
))

(add-hook 'php-mode-user-hook 
	  'php-mode-hook)


; Drupal file types
(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.engine$" . php-mode))


; ------------
; Multi mode
; ------------
(require 'mmm-mode)
(setq mmm-global-mode 'maybe)

; Set up PHP Heredocs to be HTML highlighted
(mmm-add-classes
 '((php-here-doc
  :front "<<<\\([a-zA-Z0-9_-]+\\)"
  :back "^~1[;]?$"
  :save-matches 1
  :submode html-mode
  :delimiter-mode nil)))

(add-to-list 'mmm-mode-ext-classes-alist '(php-mode nil php-here-doc))
(set-face-background 'mmm-default-submode-face nil)


; ------------
; Python mode
; ------------
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
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



;; ------------------------------------------------------------------------------------
;; ---------------------- FLYMAKE SETTINGS --------------------------------------------
;; ------------------------------------------------------------------------------------
(require 'flymake)

(defun auto-flymake-goto-next-error()
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-err-menu-for-current-line)
  )

(defun auto-flymake-goto-prev-error()
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-err-menu-for-current-line)
  )


;; For PHP
;; can't remember where it came from
(unless (fboundp 'flymake-php-init)
  (defun flymake-php-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "php" (list "-f" local-file "-l")))))

(let ((php-ext-re "\\.php[345]?\\'")
      (php-error-re
       "\\(?:Parse\\|Fatal\\) error: \\(.*\\) in \\(.*\\) on line \\([0-9]+\\)"))
  (unless (assoc php-ext-re flymake-allowed-file-name-masks)
    (add-to-list 'flymake-allowed-file-name-masks
                 (list php-ext-re
					   'flymake-php-init
					   'flymake-simple-cleanup
					   'flymake-get-real-file-name))
    (add-to-list 'compilation-error-regexp-alist-alist
                 (list 'compilation-php
					   php-error-re  2 3 nil nil))
    (add-to-list 'compilation-error-regexp-alist 'compilation-php)
    (add-to-list 'flymake-err-line-patterns
                 (list php-error-re 2 3 nil 1))))

(add-hook 'php-mode-hook (lambda () (flymake-mode t)))

(set-face-background 'flymake-errline "#ffa2a2")
(set-face-foreground 'flymake-errline "#ff0000")




;; ------------------------------------------------------------------------------------
;; ---------------------- EDITOR ADDITIONS --------------------------------------------
;; ------------------------------------------------------------------------------------

;; -----
;; YASnippet
;; -----
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/elisp/snippets/")


;; -----
; CUA and CUA-Rectangle mode
;; -----
(setq cua-enable-cua-keys nil)
(setq cua-highlight-region-shift-only t) ;; no transient mark mode
(setq cua-toggle-set-mark nil) ;; original set-mark behavior, i.e. no transient-mark-mode
(cua-mode t)



;; ------------------------------------------------------------------------------------
;; ---------------------- MISCELANIOUS SETTINGS ---------------------------------------
;; ------------------------------------------------------------------------------------

;; -----
;; Do not want start up screen
;; -----
(setq inhibit-startup-message t)

;; -----
;; Tabs are four characters wide plz
;; -----
(setq default-tab-width 4)


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
;; Magit is Git integration
;; -----
(require 'magit)


;; -----
;; Restore frame layout and open buffers
;; -----
(require 'windows)
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
(global-set-key (kbd "M-]") 'dabbrev-expand)
(define-key global-map [f12] 'kill-buffer)
(global-set-key (kbd "M-'") 'flymake-display-err-menu-for-current-line)
(global-set-key (kbd "M-a") 'auto-flymake-goto-prev-error)
(global-set-key (kbd "M-o") 'auto-flymake-goto-next-error)
(global-set-key (kbd "C-x C-g") 'magit-status)


(require 'icicles)
(icy-mode)

(require 'dired+)


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

(add-hook 'after-init-hook 'irc-maybe)

