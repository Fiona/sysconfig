(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "~/elisp/mmm-mode")
(add-to-list 'load-path "~/elisp/icicles")



; ------------------------------------------------------------------------------------
; ---------------------- FACES AND COLOURS -------------------------------------------
; ------------------------------------------------------------------------------------

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(c-default-style "gnu")
 '(c-syntactic-indentation nil)
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
 '(diredp-read-priv ((t (:background "#1e1e1e" :foreground "Red"))))
 '(diredp-write-priv ((t (:background "#1e1e1e" :foreground "Green"))))
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
        c-hanging-comment-ender-p nil
  	indent-tabs-mode
	(not
	 (and
	      (string-match "\.php$" (buffer-file-name))))))

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



; ------------------------------------------------------------------------------------
; ---------------------- EDITOR ADDITIONS --------------------------------------------
; ------------------------------------------------------------------------------------

; ------------
; YASnippet
; ------------
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/elisp/snippets/")


; -----------
; CUA and CUA-Rectangle mode
; -----------
(setq cua-enable-cua-keys nil)
(setq cua-highlight-region-shift-only t) ;; no transient mark mode
(setq cua-toggle-set-mark nil) ;; original set-mark behavior, i.e. no transient-mark-mode
(cua-mode t)



; ------------------------------------------------------------------------------------
; ---------------------- MISCELANIOUS SETTINGS RELATED -------------------------------
; ------------------------------------------------------------------------------------

; Do not want start up screen
(setq inhibit-startup-message t)
; Tabs are four characters wide plz
(setq default-tab-width 4)
;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)

; Linum mode adds line numbers in the gutter
(require 'linum)
(global-linum-mode)

; Enable desktop saving
(desktop-save-mode 1)
(setq history-length 250)
(add-to-list 'desktop-globals-to-save 'file-name-history)

; Magit is Git integration
(require 'magit)
(global-set-key (kbd "C-x C-g") 'magit-status)


(require 'icicles)
(icy-mode)

(require 'dired+)

