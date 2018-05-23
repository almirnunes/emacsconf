;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    material-theme
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(scroll-bar-mode -1) ;; hide scroll bar
(setq visible-bell 1) ;; turn off sound warnings

;; Themes
;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 
(load-theme 'misterioso t) ;; load material theme
;(load-theme 'birds-of-paradise-plus t)
;;(require 'color-theme-sanityinc-tomorrow)
;;(color-theme-sanityinc-tomorrow--define-theme blue)


(global-linum-mode t) ;; enable line numbers globally
;(require 'ido) ;; Easiar navegability
;(ido-mode t)

(electric-pair-mode 1) ;; auto close bracket insertion. New in emacs 24
(setq electric-pair-pairs '(
                            (?\" . ?\")
                            (?\{ . ?\})
                            ) )


;;(desktop-save-mode 1) ;;save session
(tool-bar-mode -1)


;; HELM CONFIGURATION
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; Registers
(set-register ?e (cons 'file "~/.emacs.d/init.el"))
(set-register ?g (cons 'file "~/Dropbox/Aplicativos/MobileOrg/gtd2018.org"))
(set-register ?p (cons 'file "~/gdrive/Org/PaperStatus.org"))
(set-register ?m (cons 'file "~/gdrive/Phd/Inlet/Modeling/Complete/main.py"))

;; PROJECTILE
;(projectile-global-mode)
;(setq projectile-indexing-method 'alien)


;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
(setq exec-path (append exec-path '("~/anaconda3/bin")))
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; Avoid elpy from executing the code from the root folder (I haad problems importing modules)
(setq elpy-shell-use-project-root nil)

;; Evil
(require 'evil)
(evil-mode 1)

;; Origami
;(require 'origami)

;(define-key origami-mode-map (kbd "C-c f a") 'origami-toggle-all-nodes)
;; http://stackoverflow.com/questions/916797/emacs-global-set-key-to-c-tab
;(define-key origami-mode-map (kbd "<C-tab>") 'origami-recursively-toggle-node)

;(global-origami-mode 1)

;;kill python
;; Just use  C-c C-k


;; ORG MODE Config
;; -*- mode:elisp -*-
;;-----------------------------------------
;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org-mode configuration
;; Load
(add-to-list 'load-path "~/src/org/lisp")
(add-to-list 'load-path "~/src/org/contrib/lisp" t)
;;Enable select
(setq org-support-shift-select 1)
;; Enable org-mode
(require 'org)
;; Make org-mode work with files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; TODO Status
(setq org-todo-keyword-faces
      '(
        ("IN PROGRESS" . (:foreground "yellow" :weight bold))
        ("WAITING" . (:foreground "black" :weight bold))
        ;;("" . (:foreground "purple" :weight bold))
        ))

(setq org-todo-keywords
      '((sequence "TODO" "|" "IN PROGRESS" "WAITING" "|" "DONE")))

;;Org-Capture
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
   '(("j" "Journal" entry (file+datetree "D:/Org/journal.org")
          "* %?\nEntered on %U\n  %i\n  %a")))

;; MAGIT CONFIG
(global-set-key (kbd "C-x g") 'magit-status)


;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#ffffff" "#f36c60" "#8bc34a" "#fff59d" "#4dd0e1" "#b39ddb" "#81d4fa" "#263238"))
 ;'(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 ;'(custom-safe-themes
 ;  (quote
 ;   ("a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" default)))
 '(elpy-project-root-finder-functions nil)
 '(fci-rule-color "#37474f")
 '(hl-sexp-background-color "#1c1f26")
 '(package-selected-packages
   (quote
    (pt origami color-theme-sanityinc-tomorrow magit helm-projectile helm projectile evil py-autopep8 material-theme flycheck elpy ein better-defaults)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
