;For Starter kit
(load-file "~/.emacs.d/emacs24-starter-kit/init.el")
;;;;;;;;;;;;;;;;;;;;;;;;;;;; For cedet
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: For Emacs >= 23.2, you must place this *before* any
;; CEDET component (including EIEIO) gets activated by another
;; package (Gnus, auth-source, ...).
(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")

;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode,
;;   imenu support, and the semantic navigator
(semantic-load-enable-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)

;; * This enables auto complete.
;;(semantic-ia-complete-symbol-menu)

;; * This enables even more coding tools such as intellisense mode,
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberant ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it. 
;; (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languages only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)
(global-set-key [(f4)] 'speedbar-get-focus)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ECB configurations
(add-to-list 'load-path "~/.emacs.d/ecb-2.40")
(add-to-list 'load-path "~/.emacs.d/cedet-1.1/eieio")
(add-to-list 'load-path "~/.emacs.d/cedet-1.1/semantic")
(add-to-list 'load-path "~/.emacs.d/cedet-1.1/speedbar")
(setq semantic-load-turn-everything-on t)
(setq ecb-auto-activate t
	       ecb-tip-of-the-day nil)
(require 'ecb)

; totrit's personal preferences
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

