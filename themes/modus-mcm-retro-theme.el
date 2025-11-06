;;; modus-mcm-retro-theme.el --- MCM Retro theme based on Modus Vivendi -*- lexical-binding: t -*-

;; Copyright (C) 2025

;; Author: Your Name
;; URL: https://example.com
;; Version: 1.0.0
;; Package-Requires: ((emacs "27.1") (modus-themes "4.0.0"))
;; Keywords: faces, theme, accessibility

;;; Commentary:
;; A 60s/70s Mid-Century Modern inspired theme that extends Modus Vivendi.

;;; Code:

(require 'modus-themes)

;; Load the base theme first
(load-theme 'modus-vivendi t)

(deftheme modus-mcm-retro
  "A 60s/70s Mid-Century Modern inspired color theme based on Modus Vivendi."
  :background-mode 'dark
  :kind 'color-scheme
  :family 'modus)

(let ((class '((class color) (min-colors 256))))
  (custom-theme-set-faces
   'modus-mcm-retro
   
   ;; Basic colors - slightly lighter background, brighter foreground
   `(default ((,class (:foreground "#f5e5c8" :background "#2e3240"))))
   `(cursor ((,class (:background "#f5e5c8"))))
   `(region ((,class (:background "#556080"))))
   `(fringe ((,class (:background "#2e3240"))))
   `(highlight ((,class (:background "#556080"))))
   
   ;; Mode line - brighter
   `(mode-line ((,class (:foreground "#f5e5c8" :background "#242735" :box (:line-width 1 :color "#556080")))))
   `(mode-line-inactive ((,class (:foreground "#8a92a8" :background "#2a2d3a" :box (:line-width 1 :color "#454a5f")))))
   
   ;; Font lock (syntax highlighting) - more vibrant colors
   `(font-lock-comment-face ((,class (:foreground "#8a92a8" :slant italic))))
   `(font-lock-string-face ((,class (:foreground "#a5d68a"))))
   `(font-lock-keyword-face ((,class (:foreground "#e8adb8" :weight bold))))
   `(font-lock-builtin-face ((,class (:foreground "#7dd4cf"))))
   `(font-lock-function-name-face ((,class (:foreground "#6fbee0"))))
   `(font-lock-variable-name-face ((,class (:foreground "#dab896"))))  ; Changed: more muted tan/beige
   `(font-lock-type-face ((,class (:foreground "#bfa5dc"))))
   `(font-lock-constant-face ((,class (:foreground "#f5ad75"))))
   `(font-lock-warning-face ((,class (:foreground "#f5a294" :weight bold))))
   `(font-lock-preprocessor-face ((,class (:foreground "#7dd4cf"))))
   `(font-lock-doc-face ((,class (:foreground "#9fbf98"))))
   
   ;; Line numbers
   `(line-number ((,class (:foreground "#8a92a8" :background "#292c38"))))
   `(line-number-current-line ((,class (:foreground "#f5d670" :background "#2e3240" :weight bold))))
   
   ;; Search - brighter highlights
   `(isearch ((,class (:foreground "#2e3240" :background "#f5d670" :weight bold))))
   `(lazy-highlight ((,class (:foreground "#2e3240" :background "#f5ad75"))))
   
   ;; Links - more vivid
   `(link ((,class (:foreground "#8fe8e3" :underline t))))
   `(link-visited ((,class (:foreground "#d4b8f0" :underline t))))
   
   ;; Org mode headings - punchier colors
   `(org-level-1 ((,class (:foreground "#e8adb8" :weight bold :height 1.3))))
   `(org-level-2 ((,class (:foreground "#6fbee0" :weight bold :height 1.2))))
   `(org-level-3 ((,class (:foreground "#bfa5dc" :weight bold :height 1.1))))
   `(org-level-4 ((,class (:foreground "#7dd4cf" :weight bold))))
   `(org-level-5 ((,class (:foreground "#a5d68a" :weight bold))))
   `(org-level-6 ((,class (:foreground "#f5ad75" :weight bold))))
   `(org-level-7 ((,class (:foreground "#f5d670" :weight bold))))
   `(org-level-8 ((,class (:foreground "#dac5a8" :weight bold))))
   
   ;; Dired
   `(dired-directory ((,class (:foreground "#6fbee0" :weight bold))))
   `(dired-symlink ((,class (:foreground "#7dd4cf"))))
   
   ;; Minibuffer
   `(minibuffer-prompt ((,class (:foreground "#6fbee0" :weight bold))))
   
   ;; Error/Warning/Success - more saturated
   `(error ((,class (:foreground "#e88b7f" :weight bold))))
   `(warning ((,class (:foreground "#f5d670" :weight bold))))
   `(success ((,class (:foreground "#a5d68a" :weight bold))))
   
   ;; Diff mode - brighter diffs
   `(diff-added ((,class (:foreground "#b8e0a0" :background "#455742"))))
   `(diff-removed ((,class (:foreground "#f5a294" :background "#654540"))))
   `(diff-changed ((,class (:foreground "#ffe595" :background "#665a40"))))
   `(diff-refine-added ((,class (:background "#526e4f"))))
   `(diff-refine-removed ((,class (:background "#755550"))))
   
   ;; Company/completion
   `(company-tooltip ((,class (:foreground "#f5e5c8" :background "#454a5f"))))
   `(company-tooltip-selection ((,class (:background "#556080"))))
   `(company-tooltip-common ((,class (:foreground "#6fbee0" :weight bold))))
   
   ;; Show-paren - more visible
   `(show-paren-match ((,class (:foreground "#ffe595" :background "#665a40" :weight bold))))
   `(show-paren-mismatch ((,class (:foreground "#f5a294" :background "#654540" :weight bold))))))

(provide-theme 'modus-mcm-retro)

;;; modus-mcm-retro-theme.el ends here
