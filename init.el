(require 'org)
(require 'ob-tangle)
(org-babel-load-file (expand-file-name "~/bedrock/config.org"))
(load (expand-file-name "~/bedrock/config.el"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-fold-core-style 'overlays)
 '(package-selected-packages
   '(company dracula-theme evil key-chord paredit treesit use-package
	     use-package-chords which-key))
 '(package-vc-selected-packages
   '((ultra-scroll :url "https://github.com/jdtsmith/ultra-scroll")
     (claude-code :url
		  "https://github.com/stevemolitor/claude-code.el"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#282a36" :foreground "#f8f8f2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 140 :width normal :foundry "nil" :family "DroidSansMono Nerd Font"))))
 '(company-tooltip-annotation ((t (:foreground "dark gray"))))
 '(match ((t (:background "plum1" :foreground "#282a36"))))
 '(region ((t (:extend nil :background "gray45")))))
