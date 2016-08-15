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