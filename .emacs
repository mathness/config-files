;; ~/.emacs - pedro jara

;;************************************************************
;; GENERAL
;;************************************************************
;; Load .emacs.d subdirectories
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/")
           (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))
;(toggle-scroll-bar -1)
;(menu-bar-mode t)
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(global-font-lock-mode t)
(transient-mark-mode t)
(column-number-mode t)
(line-number-mode t)
(show-paren-mode t)
(setq display-time-24hr-format t)
(display-time)
(server-start)
(mouse-wheel-mode t)
(global-hl-line-mode) ;; Highlight the current line
(setq font-lock-maximum-decoration t)
;(setq require-final-newline 1)
(setq next-line-add-newlines nil)
(setq default-major-mode 'text-mode)
(setq scroll-step 1)
;(set-default-font "lucidasans-bold-12")
(when window-system
  (set-default-font
   "-outline-Consolas-normal-normal-normal-mono-16-*-*-c-*-koi8-r"))
  ;extended compound-text coding for X clipboard
(setq backup-directory-alist
      `(("." . ,(expand-file-name "~/.emacs.d/backups"))))


;;************************************************************
;; Personal Info
;;************************************************************
(setq user-full-name "Pedro Damian Jara Palma"
      user-mail-address "mathness@gmail.com"
      user-company-name "Eclectic Brain"
      mail-host-address "mail")

;;************************************************************
;; ASIGNACIONES DE TECLADO
;;************************************************************
(global-set-key (kbd "C-z") 'undo)
;(global-set-key (kbd "C-<tab>") 'swbuff-switch-to-next-buffer)
;(global-set-key (kbd "M-<down>") 'windmove-down)
;(global-set-key (kbd "M-<up>") 'windmove-up)
;(global-set-key (kbd "C-x <right>") 'windmove-right)
;(global-set-key (kbd "C-x <left>") 'windmove-left)
;(global-set-key (kbd "C-<tab>") 'iswitchb-buffer)
(global-set-key (kbd "C-s") 'icicle-occur)
(global-set-key [f3] 'dabbrev-expand)
(define-key global-map (read-kbd-macro "M-RET") 'hippie-expand)
(global-set-key [(f4)] 'speedbar-get-focus)
(defalias 'cr 'comment-region)
(defalias 'ucr 'uncomment-region)
(defalias 'mf 'latex-make-region-fraction)
;(when (fboundp 'windmove-default-keybindings)
;  (windmove-default-keybindings))
(global-set-key [mouse-3] 'mouse-buffer-menu)

;;************************************************************
;; Printing
;;************************************************************
(when window-system
;  (setenv "GS_LIB" "C:/Program Files/gs/gs8.60/lib;e:/GSTools/gs8.14/fonts")
  (setq ps-printer-name "//192.168.1.120/Lexmark_C522")
  (setq ps-printer-name t)
  (setq ps-lpr-command "C:/Program Files/gs/gs8.60/bin/gswin32c.exe")
  (setq ps-lpr-switches '("-q" "-dNOPAUSE" "-dBATCH"
                          "-sDEVICE=mswinpr2"
                          "-sPAPERSIZE=letter")))

;;************************************************************
;; MISC
;;************************************************************
(fset 'yes-or-no-p 'y-or-n-p) ; write y instead of yes
(setq make-backup-files nil)  ; no backupfile
(setq delete-auto-save-files t) ; delete unnecessary autosave files
(setq delete-old-versions t)    ; delete oldversion files
(setq query-replace-highlight t)
(setq search-highlight t)
;(setq pop-up-windows nil) ;; forcing Emacs to reuse the same window
(add-hook 'before-save-hook 'time-stamp) ;add time stamps
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)
(setq initial-frame-alist '((top . 1) (height . 50)))
(recentf-mode 1)
(setq recentf-max-saved-items 10)
(setq recentf-save-file "~/.emacs.d/.recentf")
(add-hook 'find-file-hook (lambda () (linum-mode 1)))
;(swbuff-y-mode)

;;************************************************************
;; Color themes
;;************************************************************
; using emacs-color-theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-clarity)

;;************************************************************
;; Additional functionality
;;************************************************************
;(when window-system
  (load-file "~/.emacs.d/cedet-1.0pre4/common/cedet.el") ;)
(require 'smart-compile)
(require 'ecb-autoloads)
(require 'icicles)
(icicle-mode 1)
(setq x-select-enable-clipboard t)
(setq semanticdb-default-save-directory "~/.emacs.d/.semantic")
(setq-default abbrev-mode t)
(read-abbrev-file "~/.emacs.d/_abbrev_defs")
(setq save-abbrevs nil)
(require 'git-emacs)
(require 'cc-mode)
(require 'tex-site)
(require 'latex)
(require 'msf-abbrev)
(setq msf-abbrev-verbose t) ;; optional
(setq msf-abbrev-root "~/.emacs.d/mode-abbrevs")
(global-set-key (kbd "C-c l") 'msf-abbrev-goto-root)
(global-set-key (kbd "C-c a") 'msf-abbrev-define-new-abbrev-this-mode)
(msf-abbrev-load)
(setq msf-abbrev-mode-alias '((c++-mode . csharp-mode)))

;; (ido-mode t) ; use 'buffer rather than t to use only buffer switching
;; (setq ido-enable-flex-matching t)
;; (setq ido-use-filename-at-point t)
;; (setq ido-auto-merge-work-directories-length -1)
;; (defun steve-ido-choose-from-recentf ()
;;   "Use ido to select a recently opened file from the `recentf-list'"
;;   (interactive)
;;   (find-file (ido-completing-read "Open file: " recentf-list nil t)))

;;************************************************************
;; REFERENTE AL IDIOMA
;;************************************************************
(setq default-enable-multibyte-characters t)
(setq file-name-coding-system 'utf-8)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;(set-keyboard-coding-system 'latin-1)
(setq ispell-program-name "aspell"
        flyspell-default-dictionary "es.multi"
        flyspell-persistent-highlight nil
        ispell-local-dictionary "es.multi")

;;************************************************************
;; Autoinsert for skeletons
;;************************************************************
(require 'autoinsert)
(auto-insert-mode)  ;;; Adds hook to find-files-hook
(setq auto-insert-directory "~/.emacs.d/skeletons/")
(setq auto-insert-query nil) ;;; don't prompt before insertion
(define-auto-insert "\.xml" "xml-template.xml")
(define-auto-insert "\.php" "php-template.php")
(define-auto-insert "\.tex" "latex-template.tex")
(define-auto-insert "\.html" "xhtml-template.html")

;;************************************************************
;; LaTeX Mode
;;************************************************************
;(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq preview-scale-function 1.5)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-electric-escape t) ;; the TeX escape character will be bound
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(setq-default TeX-master nil) ;; Query for master file.
;(when (not window-system) (require 'tex-site))
(when window-system (require 'tex-mik))
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode) ;; Enable LaTeX-math-mode
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(setq reftex-plug-into-AUCTeX t)
(setq reftex-extra-bindings t)
(setq TeX-default-mode 'LaTeX-mode)
(setq LaTeX-force-default-mode t)
(setq LaTeX-section-hook
      '(LaTeX-section-heading ;;Query the name of the sectioning command
        LaTeX-section-title ;;Query the user for the title
        LaTeX-section-toc ;;Query the user for the toc entry
        LaTeX-section-section
        LaTeX-section-label))

;; Linking ESS with AucTex
(require 'ess-site)
(add-to-list 'auto-mode-alist '("\\.Rnw\\'" . Rnw-mode))
(add-to-list 'auto-mode-alist '("\\.Snw\\'" . Snw-mode))
(add-hook 'Rnw-mode-hook
          (lambda ()
            (add-to-list 'TeX-command-list
                         '("Sweave" "R CMD Sweave %s"
                           TeX-run-command nil t :help "Run Sweave") t)
            (add-to-list 'TeX-command-list
                         '("LatexSweave" "%l \"%(mode)\\input{%s}\""
                           TeX-run-TeX nil t :help "Run Latex after Sweave") t)
            (setq TeX-command-default "Sweave")))

;;************************************************************
;; C# Mode
;;************************************************************
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
(require 'vj-complete-elisp) ;; currently steals C-t (will be fixed)
(require 'vj-complete-csharp)
(setq vj-complete-csharp-filename
      "~/.emacs.d/vj-complete/assembly_tags")
(csharp-reload-tags)

;;C/C++/Java/C# Mode
(defun my-c-mode-common-hook ()
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'statement-cont 4)
  (c-set-offset 'topmost-intro-cont 0)
  (c-set-offset 'block-open 0)
  (c-set-offset 'arglist-intro 4)
  (c-set-offset 'arglist-cont-nonempty 4)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-csharp-mode-hook ()
  (progn
    (turn-on-font-lock)
    (auto-fill-mode)
    (setq tab-width 4)
    (define-key csharp-mode-map "\t" 'c-tab-indent-or-complete)))
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)

;;************************************************************
;; Ruby On Rails Mode
;;************************************************************
(autoload 'ruby-mode "ruby-mode"  "Mode for editing ruby files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))
(modify-coding-system-alist 'file "\\.rb$" 'utf-8)
(modify-coding-system-alist 'file "\\.rhtml$" 'utf-8)

(require 'rails)
(require 'rinari)
(setq rinari-tags-file-name "TAGS")

    ;;; nxml (HTML ERB template support)
(load "~/.emacs.d/nxhtml-1.47-080820/autostart.el")
(setq
 nxhtml-global-minor-mode t
 mumamo-chunk-coloring 'submode-colored
 nxhtml-skip-welcome t
 indent-region-mode t
 rng-nxml-auto-validate-flag nil
 nxml-degraded t)
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))


;;************************************************************
;; Python Mode
;;************************************************************
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python))
(add-to-list 'interpreter-mode-alist '("python" . python))
(add-hook 'python-mode-hook
          (lambda ()
            (set (make-variable-buffer-local 'beginning-of-defun-function)
                 'py-beginning-of-def-or-class)
            (setq outline-regexp "def\\|class ")))

;;************************************************************
;; SQL Editing Mode
;;************************************************************
(add-to-list 'same-window-buffer-names "*SQL*")
(autoload 'sql "sql" "SQL editing mode" t)
(setq auto-mode-alist
      (append '(("\\.sql$" . sql-mode)
                ("\\.tbl$" . sql-mode)
                ("\\.sp$"  . sql-mode))
              auto-mode-alist))
(eval-after-load "sql" '(load-library "sql-indent"))

;;************************************************************
; Mode for editing JavaScript
;;************************************************************
(autoload 'js2-mode "js2" "Javascript editing mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;************************************************************
;;JDE (Java Development)
;;************************************************************
(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
(require 'semantic-c) ; for C code integration
(require 'semantic-el) ; for Lisp integration
(require 'semantic-make) ; for Makefile integration
(require 'semantic-imenu) ; if you use imenu or wich-function
(add-hook 'speedbar-load-hook
          (lambda () (require 'semantic-sb)))
(autoload 'semantic-bnf-mode "semantic-bnf" "Mode for Bovine Normal Form." t)
(add-to-list 'auto-mode-alist'("\.bnf$" . semantic-bnf-mode))
(autoload 'semantic-minor-mode "semantic-mode"
  "Mode managing semantic parsing." t)
(require 'jde) ;; Requires elib

;;************************************************************
;; configure HTML editing
;;************************************************************
;(load "~/.emacs.d/nxhtml-1.29-080515/autostart.el")
(setq auto-mode-alist
      (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\|content\\)\\'" . nxml-mode)
            auto-mode-alist))
;; (eval-after-load 'nxhtml
;;   '(define-key nxhtml-mode-map [f2] 'nxml-complete))
(add-hook 'html-mode-hook 'flyspell-mode)

;;************************************************************
;; Matlab Mode (note this overrides objective-C mode)
;;************************************************************
(setenv "DISPLAY" ":0.0") ;gives matlab access to X11.
(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list 'auto-mode-alist '("\\.m$" . matlab-mode))
;(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(setq matlab-indent-function t)
(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)
(setq matlab-shell-command "/opt/matlab74/bin/matlab")
(setq matlab-shell-command-switches '("-nosplash" "-nodesktop"))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-gzip-setup (quote cons))
 '(ecb-options-version "2.32")
 '(ecb-tar-setup (quote cons))
 '(ecb-wget-setup (quote cons)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;require 'imenu)
;(setq imenu-sort-function (quote imenu--sort-by-name))

;(require 'msb)

 ;if (eq window-system 'w32)
;   (setq process-coding-system-alist
;         (cons '("bash" . raw-text-unix) process-coding-system-alist)))
