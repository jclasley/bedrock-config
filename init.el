(require 'org)
(require 'ob-tangle)
(org-babel-load-file (expand-file-name "~/emacs/bedrock-config/config.org"))
(load (expand-file-name "~/emacs/bedrock-config/config.el"))

;; macro to input the branch name at the top of the commit message
(defalias 'start\ commit\ msg
  (kmacro "j j j j j e e e w E y [ b g p"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("~/org/projects.org" "/Users/jonlasley/.org-jira/GRAPH.org"
     "/Users/jonlasley/org/todo.org" "/Users/jonlasley/org/habits.org"
     "/Users/jonlasley/org/game_dev_log.org"))
 '(org-fold-core-style 'overlays)
 '(package-selected-packages
   '(claude-code dracula-theme evil key-chord use-package
		 use-package-chords which-key))
 '(package-vc-selected-packages
   '((claude-code :url "https://github.com/stevemolitor/claude-code.el")
     (ultra-scroll :vc-backend Git :url
		   "https://github.com/jdtsmith/ultra-scroll"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#282a36" :foreground "#f8f8f2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 140 :width normal :foundry "nil" :family "DroidSansM Nerd Font"))))
 '(corfu-current ((t (:extend t :background "gray30" :foreground "#f8f8f2"))))
 '(vertical-border ((t (:background "#242530" :foreground "gray40")))))
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
