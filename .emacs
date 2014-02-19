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
(my-ac-config)
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
(setq indent-tabs-mode t) ; use spaces only if nil
)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook) 
; END

