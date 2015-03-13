(load-file "/Users/maruilin/.emacs.d//emacs24-starter-kit/elpa/git-rebase-mode-20150122.1114/git-rebase-mode.el")
(load-file "/Users/maruilin/.emacs.d//emacs24-starter-kit/elpa/git-commit-mode-20140125.1553/git-commit-mode.el")
(load-file "/Users/maruilin/.emacs.d//emacs24-starter-kit/elpa/magit-20150124.930/magit.el")
(setq org-mode-blog-publishing-directory "~/work/www/")
(setq org-publish-project-alist
      '(("blog"
         :components ("blog-content" "blog-static"))
        ("blog-content"
         :base-directory "~/work/org/publish/"
         :base-extension "org"
         :publishing-directory org-mode-blog-publishing-directory
         :recursive t
         :publishing-function org-html-publish-to-html
         :preparation-function org-mode-blog-prepare
         :export-with-tags nil
         :headline-levels 4
         :auto-sitemap nil
         :sitemap-title "Sitemap"
         :section-numbers nil
         :with-toc nil
         :with-author nil
         :with-creator nil
         :html-doctype "html5"
         :html-preamble org-mode-blog-preamble
         :html-postamble "<hr><div id='comments'></div>"
         :html-head  "<link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\"/>\n"
         :html-head-extra "<script async=\"true\" src=\"/js/juvia.js\"></script>
         <link rel=\"shortcut icon\" href=\"/img/totrit.ico\">
         <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1\" />"
         :html-html5-fancy t
         :html-head-include-default-style nil
         )
        ("blog-static"
         :base-directory "~/work/org/publish/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|ico"
         :publishing-directory org-mode-blog-publishing-directory
         :recursive t
         :publishing-function org-publish-attachment)
        ("blog-rss"
         :base-directory "~/work/org/publish/"
         :base-extension "org"
         :rss-image-url "http://www.totrit.com/img/totrit.png"
         :publishing-directory org-mode-blog-publishing-directory
         :publishing-function (org-rss-publish-to-rss)
         :html-link-home "http://www.totrit.com/"
         :html-link-use-abs-url t
         :with-toc nil
         :exclude ".*"
         :include ("index.org"))))

(defun org-mode-blog-preamble (options)
  "The function that creates the preamble (sidebar) for the blog.
OPTIONS contains the property list from the org-mode export."
  (let ((base-directory (plist-get options :base-directory)))
    (org-babel-with-temp-filebuffer (expand-file-name "html/preamble.html" base-directory) (buffer-string))))

(defun org-mode-blog-prepare ()
  "`index.org' should always be exported so touch the file before publishing."
  (let* ((base-directory (plist-get project-plist :base-directory))
         (buffer (find-file-noselect (expand-file-name "index.org" base-directory) t)))
    (with-current-buffer buffer
      (set-buffer-modified-p t)
      (save-buffer 0))
    (kill-buffer buffer)))
