(require 'org)
(require 'ob-tangle)
(org-babel-load-file (expand-file-name "~/bedrock/config.org"))
(load (expand-file-name "~/bedrock/config.el"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("dcb1cc804b9adca583e4e65755895ba0a66ef82d29464cf89a78b88ddac6ca53" default))
 '(package-selected-packages
   '(dracula-theme company use-package use-package-chords key-chord evil which-key))
 '(ring-bell-function 'ignore)
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#282a36" :foreground "#f8f8f2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 140 :width normal :foundry "nil" :family "Menlo"))))
 '(company-tooltip-annotation ((t (:foreground "dark gray"))))
 '(match ((t (:background "plum1" :foreground "#282a36"))))
 '(region ((t (:extend nil :background "gray45")))))
