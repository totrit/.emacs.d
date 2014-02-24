; For Starter kit
(load-file "~/.emacs.d/emacs24-starter-kit/init.el")
; END

; For auto-complete
(add-to-list 'load-path "~/.emacs.d/emacs24-starter-kit/elpa/popup-20140207.1702")
(add-to-list 'load-path "~/.emacs.d/emacs24-starter-kit/elpa/auto-complete-20140208.653")
(add-to-list 'load-path "~/.emacs.d/emacs24-starter-kit/elpa/auto-complete-clang-async-20130526.814")
(require 'auto-complete-clang-async)
(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/.emacs.d/emacs24-starter-kit/elpa/auto-complete-clang-async-20130526.814/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
)
(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (global-auto-complete-mode t))
  (local-set-key (kbd "C-x c") 'ac-clang-syntax-check)

(my-ac-config)
; END

; For gtags
(add-to-list 'load-path "~/.emacs.d/emacs24-starter-kit/elpa/gtags-3.3")
(autoload 'gtags-mode "gtags" "" t)
(add-hook 'gtags-select-mode-hook
  '(lambda ()
        (setq hl-line-face 'underline)
        (hl-line-mode 1)
))
(add-hook 'c-mode-hook
  '(lambda ()
        (gtags-mode 1)))
(setq gtags-suggested-key-mapping t)
(setq gtags-auto-update t)
; END

; For Google C code style
(add-to-list 'load-path "/home/totrit/.emacs.d/emacs24-starter-kit/elpa/google-c-style-20130412.1415")
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
; END

; For Android-Mode
(add-to-list 'load-path "~/.emacs.d/emacs24-starter-kit/elpa/android-mode-20131104.748")
(require 'android-mode)
(custom-set-variables
 '(android-mode-sdk-dir "~/work/tools/adt-bundle-linux-x86_64-20130522/sdk"))
; END

; For totrit's personal preferences
;; CODE FORMAT
(defun my-c-mode-common-hook ()
;;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
(c-set-offset 'substatement-open 0)
;;; other customizations can go here
(setq c++-tab-always-indent t)
(setq c-basic-offset 4) ;; Default is 2
(setq c-indent-level 4) ;; Default is 2
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
(setq tab-width 4)
(setq indent-tabs-mode nil) ; use spaces only if nil
)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; Personal key bindings
(global-set-key (kbd "C-x k") 'windmove-up)
(global-set-key (kbd "C-x j") 'windmove-down)
(global-set-key (kbd "C-x l") 'windmove-right)
(global-set-key (kbd "C-x h") 'windmove-left)
(global-set-key (kbd "C-x p") 'previous-buffer)
(global-set-key (kbd "C-x n") 'next-buffer)
(global-set-key (kbd "C-x e") 'kill-this-buffer)
; END

