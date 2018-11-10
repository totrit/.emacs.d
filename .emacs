;(package-initialize)

(require 'cl)

(defvar emacs-root (if (or (eq system-type 'darwin)
		(eq system-type 'gnu/linux)
		(eq system-type 'linux))
		 "/Users/maruilin/" 		 "e:/home/totrit/")
  "My home directory — the root of my personal emacs load-path.")

; Personal info
(setq user-full-name "Alvin Ma")
(setq user-mail-address "alvin.ruilin.ma@gmail.com")

; Env (For executing external tools like proselint by Flycheck)
(setenv "PATH" (concat "/usr/local/bin:/opt/local/bin:/usr/bin:/bin:/home/abedra/.cabal/bin" (getenv "PATH")))
(setq exec-path (append exec-path '("/usr/local/bin")))
(require 'cl)

; Package Management
(load "package")
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-archive-enable-alist '(("melpa" magit f)))

; Default packages
(defvar alvin/packages '(auto-complete
                          flycheck
                          autopair
                          graphviz-dot-mode
                          org
                          plantuml-mode
                          ledger-mode
                          htmlize
                          smex
                          solarized-theme
                          writegood-mode)
  "Default packages")

; Install default packages on boot
(defun alvin/packages-installed-p ()
  (loop for pkg in alvin/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (alvin/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg alvin/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

; Disable unncessary bars
(scroll-bar-mode -1)
(tool-bar-mode -1)

; Indentation
(setq tab-width 4
      indent-tabs-mode nil)

; No Backup file
(setq make-backup-files nil)

; Key bindings
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-c C-x k") 'windmove-up)
(global-set-key (kbd "C-c C-x j") 'windmove-down)
(global-set-key (kbd "C-c C-x l") 'windmove-right)
(global-set-key (kbd "C-c C-x h") 'windmove-left)
(global-set-key (kbd "C-c C-x p") 'previous-buffer)
(global-set-key (kbd "C-c C-x n") 'next-buffer)
(global-set-key (kbd "C-x e") 'kill-this-buffer)
(global-set-key (kbd "C-<RET>") 'set-mark-command)
(global-set-key "\M-/" 'auto-complete)

; Org mode
(require 'org)
(setq org-startup-indented t)
(defvar org-directory (if (or (eq system-type 'darwin)
			 (eq system-type 'gnu/linux)
			 (eq system-type 'linux))
		 "/Users/maruilin/Sync/org/" 		 "e:/Sync/org")
  "My home directory — the root of my personal emacs load-path.")
(setq org-todo-keywords
	'((sequence "TODO(t)" "PENDING(p@/!)" "|" "DONE(d!)" "DELEGATED(@/!)" "CANCELED(c@/!)")))
(add-hook 'org-mode-hook
          (lambda ()
            (flyspell-mode)))
(add-hook 'org-mode-hook
          (lambda ()
            (writegood-mode)))
;; Agenda
;; org agenda files
(setq org-agenda-files (list (concat org-directory "/work.org")
                             (concat org-directory "/personal.org")
                             (concat org-directory "/journal.org")))
;; Clock sound
(setq org-clock-sound t)
;; org publish
(setq org-html-postamble nil)
;; UML
(setq plantuml-jar-path
      (expand-file-name (concat emacs-root ".emacs.d/vendor/plantuml.jar")))
(add-to-list
    'org-src-lang-modes '("plantuml" . plantuml))
;; Org babel
(require 'ob)
(setq org-plantuml-jar-path
      (expand-file-name (concat emacs-root ".emacs.d/vendor/plantuml.jar")))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t)
   (dot . t)))
(add-to-list 'org-src-lang-modes (quote ("dot". graphviz-dot)))
(setq org-src-fontify-natively t
      org-confirm-babel-evaluate nil)
(add-hook 'org-babel-after-execute-hook (lambda ()
                                          (condition-case nil
                                              (org-display-inline-images)
                                            (error nil)))
          'append)

;; Publish
(require 'ox-publish)
(setq org-publish-project-alist
  '(
        ("org-notes"               ;Used to export .org file
         :base-directory "~/work/org/publish/"  ;directory holds .org files 
         :base-extension "org"     ;process .org file only    
         :publishing-directory "~/work/www/"    ;export destination
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4               ; Just the default for this project.
         :auto-preamble t
	 :makeindex t
	 :index-filename "index.org"
	 :index-title "Main Page"
         :auto-sitemap t                  ; Generate sitemap.org automagically...
         :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "Site Map"         ; ... with title 'Sitemap'.
         :export-creator-info nil    ; Disable the inclusion of "Created by Org" in the postamble.
         :export-author-info t     ; Disable the inclusion of "Author: Your Name" in the postamble.
         :auto-postamble nil         ; Disable auto postamble 
         :table-of-contents t        ; Set this to "t" if you want a table of contents, set to "nil" disables TOC.
         ;:section-numbers nil        ; Set this to "t" if you want headings to have numbers.
         :html-postamble "<br><br><a rel=\"license\" href=\"http://creativecommons.org/licenses/by/4.0/\"><img alt=\"Creative Commons License\" style=\"border-width:0\" src=\"https://i.creativecommons.org/l/by/4.0/88x31.png\" /></a><br />This work is licensed under a <a rel=\"license\" href=\"http://creativecommons.org/licenses/by/4.0/\">Creative Commons Attribution 4.0 International License</a><div><a href=\"mailto:totrit@gmail.com\">给作者发Email</a></div>" ; your personal postamble
         :style-include-default nil  ;Disable the default css style
        )
        ("org-static"                ;Used to publish static files
         :base-directory "~/work/org/publish/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/work/www/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("org" :components ("org-notes" "org-static")) ;combine "org-static" and "org-static" into one function call
))
(defadvice org-html-paragraph (before fsh-org-html-paragraph-advice 
                                      (paragraph contents info) activate) 
  "Join consecutive Chinese lines into a single long line without 
unwanted space when exporting org-mode to html." 
  (let ((fixed-contents) 
        (orig-contents (ad-get-arg 1)) 
        (reg-han "[[:multibyte:]]")) 
    (setq fixed-contents (replace-regexp-in-string 
                          (concat "\\(" reg-han
                                  "\\) *\n *\\(" reg-han "\\)") 
                          "\\1\\2" orig-contents)) 
    (ad-set-arg 1 fixed-contents)))

; Auto complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'plantuml-mode)
(setq ac-auto-start 4)

; Auto pair
(require 'autopair)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(package-selected-packages
   (quote
    (autopair writegood-mode solarized-theme smex plantuml-mode graphviz-dot-mode flycheck auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; Flyspell
(setq flyspell-issue-welcome-flag nil)
(if (eq system-type 'darwin)
    (setq-default ispell-program-name "/usr/local/bin/aspell")
  (setq-default ispell-program-name "/usr/bin/aspell"))
(setq-default ispell-list-command "list")

; Flycheck for English
(require 'flycheck)
(flycheck-define-checker proselint
  "A linter for prose."
  :command ("proselint" source-inplace)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ": "
        (id (one-or-more (not (any " "))))
        (message) line-end))
  :modes (text-mode markdown-mode gfm-mode org-mode))
(add-to-list 'flycheck-checkers 'proselint)
