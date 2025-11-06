;;; themes.el --- Theme configurations -*- lexical-binding: t; -*-

;; Doom themes
(use-package doom-themes
  :disabled t
  :ensure t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (load-theme 'doom-dracula t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; or for treemacs users
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; Dracula theme
(use-package dracula-theme
  :ensure t
  :disabled t
  :init
  (load-theme 'dracula t))

;; Modus themes
;; Can try and mess around with these if I want
(use-package modus-themes
  :ensure t
  ;; :disabled t
  :custom
  ;; Reload the theme after we change some of the options
  (modus-themes-custom-auto-reload t)
  ;; Use more bold (keywords) and italic constructs
  (modus-themes-bold-constructs nil)
  (modus-themes-italic-constructs t)
  ;; Try out this example and see what it looks like -- might work
  ;; Affects the completion framework
  (modus-themes-completions
   '((matches . (extrabold underline))))
  :config
  ;; dracula inspired colore scheme
  (setq modus-themes-common-palette-overrides
	'((type "#FF79C6")
	  (builtin "#FF79C6")
	  (constant "#FF79C6")
	  (variable "#66aaf2")
	  (keyword "#50FA7B")
	  (string "#FFB86C")
	  (rx-construct "#39b859")
	  (rx-backslash "#ba7a36")
	  (property "magenta")
	  (comment "#6272A4")
	  (preprocessor red)
	  (fnname "#BD93F9")))
  ;; (setq modus-themes-common-palette-overrides
  ;;     `(
  ;;       ;; From the section "Make the mode line borderless"
  ;;       (border-mode-line-active unspecified)
  ;;       (border-mode-line-inactive unspecified)

  ;;       ;; From the section "Make matching parenthesis more or less intense"
  ;;       (bg-paren-match bg-magenta-intense)
  ;;       (underline-paren-match fg-main)

  ;;       ;; And expand the preset here.  Note that the ,@ works because
  ;;       ;; we use the backtick for this list, instead of a straight
  ;;       ;; quote.
  ;;       ,@modus-themes-preset-overrides-intense))
  ;;       ;; ))

  ;; (load-theme 'modus-vivendi-tinted :no-confirm)
  )

(defun my-modus-overrides ()
  (custom-set-faces
   '(font-lock-constant-face ((t (:slant italic :weight bold))))
   ;; make the `type' face italic
   '(font-lock-type-face ((t (:slant italic :weight normal))))))

;; (add-hook 'modus-themes-after-load-theme-hook #'my-modus-overrides)

;; CUSTOM THEMES (Thanks Claude)
(add-to-list 'custom-theme-load-path "~/emacs/bedrock-config/themes")
;; Available themes:
;; 'modus-mcm-retro
(load-theme 'modus-mcm-retro t)

;; ef themes
;; Also by prot, these are little sexier
;; https://protesilaos.com/emacs/ef-themes
(use-package ef-themes
  :ensure t
  :disabled t
  :config
  ;; disable other themes
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'ef-owl t))

(provide 'themes)
;;; themes.el ends here
