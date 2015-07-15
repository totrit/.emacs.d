(require 'cl)
(defvar emacs-root (if (or (eq system-type 'darwin)
			 (eq system-type 'gnu/linux)
			 (eq system-type 'linux))
		 "/Users/maruilin/" 		 "e:/home/totrit/")
  "My home directory — the root of my personal emacs load-path.")
(defvar org-directory (if (or (eq system-type 'darwin)
			 (eq system-type 'gnu/linux)
			 (eq system-type 'linux))
		 "/Users/maruilin/BaiduYun/org/" 		 "e:/BaiduYun/org/")
  "My home directory — the root of my personal emacs load-path.")

(labels ((add-path (p)
	 (add-to-list 'load-path
			(concat emacs-root p))))
(add-path ".emacs.d")
(add-path ".emacs.d/emacs24-starter-kit")
(add-path ".emacs.d/emacs24-starter-kit/elpa/popup-20140207.1702")
(add-path ".emacs.d/emacs24-starter-kit/elpa/auto-complete-20140208.653")
(add-path ".emacs.d/emacs24-starter-kit/elpa/auto-complete-clang-async-20130526.814")
(add-path ".emacs.d/emacs24-starter-kit/elpa/gtags-3.3")
(add-path ".emacs.d/emacs24-starter-kit/elpa/google-c-style-20130412.1415")
(add-path ".emacs.d/emacs24-starter-kit/elpa/cmake-mode-20140217.659")
(add-path ".emacs.d/emacs24-starter-kit/elpa/org-20150223")
)
; For Starter kit
(load-file (concat emacs-root ".emacs.d/emacs24-starter-kit/init.el"))
; END

; For auto-complete
;;(require 'auto-complete-clang-async)
;;(defun ac-cc-mode-setup ()
;;  (setq ac-clang-complete-executable "~/.emacs.d/emacs24-starter-kit/elpa/auto-complete-clang-async-20130526.814/clang-complete")
;;  (setq ac-sources '(ac-source-clang-async))
;;  (ac-clang-launch-completion-process)
;;)
;;(defun my-ac-config ()
;;  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;;  (global-auto-complete-mode t))
;;  (local-set-key (kbd "C-x c") 'ac-clang-syntax-check)

;;(my-ac-config)
; END

; For gtags
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
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
; END

; For Android-Mode
;;(add-to-list 'load-path "~/.emacs.d/emacs24-starter-kit/elpa/android-mode-20131104.748")
;;(require 'android-mode)
;;(custom-set-variables
;; '(android-mode-sdk-dir "~/work/tools/adt-bundle-linux-x86_64-20130522/sdk"))
; END

; For cmake mode
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))
;END
; For org mode
;; org directory
(setq org-mobile-directory (concat org-directory "mobileorg/"))
(setq org-mobile-inbox-for-pull (concat org-directory "from-mobile.org"))
(when (string-equal system-type "windows-nt")
	(setq org-mobile-checksum-binary "c:/Windows/System32/sha1sum.exe")
)
(setq org-startup-indented t)
(setq org-todo-keywords
	'((sequence "TODO(t)" "PENDING(p@/!)" "|" "DONE(d!)" "DELEGATED(@/!)" "CANCELED(c@/!)")))
;; org agenda files
(setq org-agenda-files (list (concat org-directory "/work.org")
                             (concat org-directory "/personal.org")
			     (concat org-directory "/from-mobile.org")))
;; Capture
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
;; Clock sound
(setq org-clock-sound t)
;; Let Emacs shell load .bashrc
(setq shell-command-switch "-ic")
;; org publish
(load-library "my-org-publish")
(setq org-html-postamble nil)
;; uml
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)))
(setq org-plantuml-jar-path
      (expand-file-name (concat emacs-root ".emacs.d/executables/plantuml.8020.jar")))
(load-library "ob-plantuml")
; END

; For totrit's personal preferences
;; CODE FORMAT
(defun my-c-mode-common-hook ()
;;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
(c-set-offset 'substatement-open 0)
;; clipboard
(setq x-select-enable-clipboard t)
;; startup with no tool bar
(tool-bar-mode -1)
(scroll-bar-mode -1)
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
(global-set-key (kbd "C-c C-x k") 'windmove-up)
(global-set-key (kbd "C-c C-x j") 'windmove-down)
(global-set-key (kbd "C-c C-x l") 'windmove-right)
(global-set-key (kbd "C-c C-x h") 'windmove-left)
(global-set-key (kbd "C-c C-x p") 'previous-buffer)
(global-set-key (kbd "C-c C-x n") 'next-buffer)
(global-set-key (kbd "C-x e") 'kill-this-buffer)
(global-set-key (kbd "C-<RET>") 'set-mark-command)
; END

;; graph dot
(load-file (concat emacs-root ".emacs.d/emacs24-starter-kit/elpa/graphviz-dot/graphviz-dot-mode.el"))
;; 解决ido乱码问题
(setq ido-save-directory-list-file nil)

