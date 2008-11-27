(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "~/elisp/mmm-mode")
(add-to-list 'load-path "~/elisp/icicles")

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
 '(tool-bar-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 99 :width normal :family "schumacher-clean")))))


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


; -----------
; Miscelanious settings
; -----------
(setq default-tab-width 4)
;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)
; Linum mode adds line numbers in the gutter
(require 'linum)
(global-linum-mode)

(desktop-save-mode 1)
;; Customization follows below
(setq history-length 250)
(add-to-list 'desktop-globals-to-save 'file-name-history)

(require 'magit)
(global-set-key (kbd "C-x C-g") 'magit-status)

(require 'icicles)
(icy-xfmode) 


; -------------
; Colour scheme
; -------------
(defconst color-scheme 'dark)
(defconst foreground-color "white")
(defconst background-color "black")
(defconst cursor-color "red")
(defconst pointer-color "white")

(if (featurep 'xemacs)
    (let ((frame (selected-frame)))
      (set-face-foreground 'default foreground-color)
      (set-face-background 'default background-color)
      (setq frame-background-mode color-scheme)
      color-scheme
      (set-frame-property frame
                          'custom-properties
                          (mapcar (lambda (symbol)
                                    (if (eql symbol 'light)
                                        'dark
                                      symbol))
                                  (frame-property frame
                                                  'custom-properties))))
  (progn 
     (add-to-list 'default-frame-alist '(foreground-color . "white"))
     (add-to-list 'default-frame-alist '(background-color . "black"))
     (add-to-list 'default-frame-alist '(cursor-color . "red"))
     (add-to-list 'default-frame-alist '(background-mode . dark))
     (set-cursor-color cursor-color)
     (set-mouse-color pointer-color))
)

