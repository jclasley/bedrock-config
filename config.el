;;;  ________                                                _______                 __                            __
  ;;; /        |                                              /       \               /  |                          /  |
  ;;; $$$$$$$$/ _____  ____   ______   _______  _______       $$$$$$$  | ______   ____$$ | ______   ______   _______$$ |   __
  ;;; $$ |__   /     \/    \ /      \ /       |/       |      $$ |__$$ |/      \ /    $$ |/      \ /      \ /       $$ |  /  |
  ;;; $$    |  $$$$$$ $$$$  |$$$$$$  /$$$$$$$//$$$$$$$/       $$    $$</$$$$$$  /$$$$$$$ /$$$$$$  /$$$$$$  /$$$$$$$/$$ |_/$$/
  ;;; $$$$$/   $$ | $$ | $$ |/    $$ $$ |     $$      \       $$$$$$$  $$    $$ $$ |  $$ $$ |  $$/$$ |  $$ $$ |     $$   $$<
  ;;; $$ |_____$$ | $$ | $$ /$$$$$$$ $$ \_____ $$$$$$  |      $$ |__$$ $$$$$$$$/$$ \__$$ $$ |     $$ \__$$ $$ \_____$$$$$$  \
  ;;; $$       $$ | $$ | $$ $$    $$ $$       /     $$/       $$    $$/$$       $$    $$ $$ |     $$    $$/$$       $$ | $$  |
  ;;; $$$$$$$$/$$/  $$/  $$/ $$$$$$$/ $$$$$$$/$$$$$$$/        $$$$$$$/  $$$$$$$/ $$$$$$$/$$/       $$$$$$/  $$$$$$$/$$/   $$/

  ;;; Minimal init.el

  ;;; Contents:
  ;;;
  ;;;  - Basic settings
  ;;;  - Discovery aids
  ;;;  - Minibuffer/completion settings
  ;;;  - Interface enhancements/defaults
  ;;;  - Tab-bar configuration
  ;;;  - Theme
  ;;;  - Optional extras
  ;;;  - Built-in customization framework

  ;;; Guardrail

  (when (< emacs-major-version 29)
    (error (format "Emacs Bedrock only works with Emacs 29 and newer; you have version ~a" emacs-major-version)))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;in
  ;;;
  ;;;   Basic settings
  ;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Package initialization
  ;;
  ;; We'll stick to the built-in GNU and non-GNU ELPAs (Emacs Lisp Package
  ;; Archive) for the base install, but there are some other ELPAs you could look
  ;; at if you want more packages. MELPA in particular is very popular. See
  ;; instructions at:
  ;;
  ;;    https://melpa.org/#/getting-started
  ;;
  ;; You can simply uncomment the following if you'd like to get started with
  ;; MELPA packages quickly:
  ;;
  ;; (with-eval-after-load 'package
  ;;   (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

  ;; If you want to turn off the welcome screen, uncomment this
  ;(setopt inhibit-splash-screen t)

  (setopt initial-major-mode 'fundamental-mode)  ; default mode for the *scratch* buffer
  (setopt display-time-default-load-average nil) ; this information is useless for most

  ;; Automatically reread from disk if the underlying file changes
  (setopt auto-revert-avoid-polling t)
  ;; Some systems don't do file notifications well; see
  ;; https://todo.sr.ht/~ashton314/emacs-bedrock/11
  (setopt auto-revert-interval 5)
  (setopt auto-revert-check-vc-info t)
  (global-auto-revert-mode)

  ;; Save history of minibuffer
  (savehist-mode)


  ;; Fix archaic defaults
  (setopt sentence-end-double-space nil)

  ;; Make right-click do something sensible
  (when (display-graphic-p)
    (context-menu-mode))

  ;; Don't litter file system with *~ backup files; put them all inside
  ;; ~/.emacs.d/backup or wherever
  (defun bedrock--backup-file-name (fpath)
    "Return a new file path of a given file path.
  If the new path's directories does not exist, create them."
    (let* ((backupRootDir "~/.emacs.d/emacs-backup/")
           (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path
           (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") )))
      (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
      backupFilePath))
  (setopt make-backup-file-name-function 'bedrock--backup-file-name)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;
  ;;;   Discovery aids
  ;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Show the help buffer after startup

  ;; (add-hook 'after-init-hook 'help-quick)

  ;; which-key: shows a popup of available keybindings when typing a long key
  ;; sequence (e.g. C-x ...)
  (use-package which-key
    :ensure t
    :config
    (which-key-mode))


  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;
  ;;;   Minibuffer/completion settings
  ;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; For help, see: https://www.masteringemacs.org/article/understanding-minibuffer-completion

  ;; (setopt enable-recursive-minibuffers t)                ; Use the minibuffer whilst in the minibuffer
  ;; (setopt completion-cycle-threshold 1)                  ; TAB cycles candidates
  ;; (setopt completions-detailed t)                        ; Show annotations
  ;; (setopt tab-always-indent 'complete)                   ; When I hit TAB, try to complete, otherwise, indent
  ;; (setopt completion-styles '(basic initials substring)) ; Different styles to match input to candidates
;; 
  ;; (setopt completion-auto-help 'always)                  ; Open completion always; `lazy' another option
  ;; (setopt completions-max-height 20)                     ; This is arbitrary
  ;; (setopt completions-detailed t)
  ;; (setopt completions-format 'one-column)
  ;; (setopt completions-group t)
  ;;
(setopt completion-auto-select 'second-tab)            ; Much more eager
  ;(setopt completion-auto-select t)                     ; See `C-h v completion-auto-select' for more possible values

  (keymap-set minibuffer-mode-map "TAB" 'minibuffer-complete) ; TAB acts more like how it does in the shell

  ;; For a fancier built-in completion option, try ido-mode,
  ;; icomplete-vertical, or fido-mode. See also the file extras/base.el

  ;(icomplete-vertical-mode)
  ;(fido-vertical-mode)
  ;(setopt icomplete-delay-completions-threshold 4000)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;
  ;;;   Interface enhancements/defaults
  ;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Mode line information
  (setopt line-number-mode t)                        ; Show current line in modeline
  (setopt column-number-mode t)                      ; Show column as well

  (setopt x-underline-at-descent-line nil)           ; Prettier underlines
  (setopt switch-to-buffer-obey-display-actions t)   ; Make switching buffers more consistent

  (setopt show-trailing-whitespace nil)      ; By default, don't underline trailing spaces
  (setopt indicate-buffer-boundaries 'left)  ; Show buffer top and bottom in the margin

  ;; Enable horizontal scrolling
  (setopt mouse-wheel-tilt-scroll t)
  (setopt mouse-wheel-flip-direction t)

  ;; We won't set these, but they're good to know about
  ;;
  ;; (setopt indent-tabs-mode nil)
  ;; (setopt tab-width 4)

  ;; Misc. UI tweaks
  (blink-cursor-mode -1)                                ; Steady cursor
  (pixel-scroll-precision-mode)                         ; Smooth scrolling

  ;; Use common keystrokes by default
  (cua-mode)

  ;; Display line numbers in programming mode
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  (setopt display-line-numbers-width 3)           ; Set a minimum width

  ;; Nice line wrapping when working with text
  (add-hook 'text-mode-hook 'visual-line-mode)

  ;; Modes to highlight the current line with
  (let ((hl-line-hooks '(text-mode-hook prog-mode-hook)))
    (mapc (lambda (hook) (add-hook hook 'hl-line-mode)) hl-line-hooks))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;
  ;;;   Tab-bar configuration
  ;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Show the tab-bar as soon as tab-bar functions are invoked
  (setopt tab-bar-show 1)

  ;; Add the time to the tab-bar, if visible
  (add-to-list 'tab-bar-format 'tab-bar-format-align-right 'append)
  (add-to-list 'tab-bar-format 'tab-bar-format-global 'append)
  (setopt display-time-format "%a %F %T")
  (setopt display-time-interval 1)
  (display-time-mode)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;
  ;;;   Optional extras
  ;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Uncomment the (load-file …) lines or copy code from the extras/ elisp files
  ;; as desired

  ;; UI/UX enhancements mostly focused on minibuffer and autocompletion interfaces
  ;; These ones are *strongly* recommended!
  ;(load-file (expand-file-name "extras/base.el" user-emacs-directory))

  ;; Packages for software development
  ;(load-file (expand-file-name "extras/dev.el" user-emacs-directory))

  ;; Vim-bindings in Emacs (evil-mode configuration)
  ;(load-file (expand-file-name "extras/vim-like.el" user-emacs-directory))

  ;; Org-mode configuration
  ;; WARNING: need to customize things inside the elisp file before use! See
  ;; the file extras/org-intro.txt for help.
  ;(load-file (expand-file-name "extras/org.el" user-emacs-directory))

  ;; Email configuration in Emacs
  ;; WARNING: needs the `mu' program installed; see the elisp file for more
  ;; details.
  ;(load-file (expand-file-name "extras/email.el" user-emacs-directory))

  ;; Tools for academic researchers
  ;(load-file (expand-file-name "extras/researcher.el" user-emacs-directory))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;
  ;;;   Built-in customization framework
  ;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(package-selected-packages
     '(dracula-theme company use-package use-package-chords key-chord evil which-key)))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   )

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; My stuff
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq ring-bell-function nil)

(setopt tab-width 4)

(global-company-mode -1)

(use-package dash :ensure t)

(winner-mode 1)
(recentf-mode 1)

(eldoc-mode 1)
;; theme
(add-to-list 'custom-theme-load-path "~/bedrock/themes")
(use-package dracula-theme
  :init
  (load-theme 'dracula t))

(setq initial-buffer-choice "~/bedrock/config.org")

;; get use-package to behave
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

(use-package use-package-chords
  :ensure t
  :config (key-chord-mode 1))

(use-package rainbow-delimiters 
  :ensure t
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package doom-modeline
  :ensure t
  :config (doom-modeline-mode 1))

(use-package emacs
  :custom
  (tab-always-indent 'complete)
  ;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
  ;; mode.  Corfu commands are hidden, since they are not used via M-x. This
  ;; setting is useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p)
  (enable-recursive-minibuffers t)
  :init
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
            (replace-regexp-in-string
             "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
             crm-separator)
            (car args))
    (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator))

(use-package projectile
  :ensure t
  :config
  (setq projectile-switch-project-action 'projectile-dired)
  :bind
  (("s-p" . #'projectile-command-map))
  :init (projectile-mode +1))

(use-package origami
  :ensure t
  :init (global-origami-mode))

(use-package treemacs
  :ensure t
  :config
  (setq treemacs-follow-mode t))

(use-package eyebrowse
  :ensure t
  :init (eyebrowse-mode 1))

(setq org-tag-alist (append '((:startgroup . nil) ; at most one of the following
                            ("@home" . ?h)
                            ("@work" . ?w)
                            ("@out". ?o)
                            (:endgroup . nil)
                            ;; any of the following
                            ("project" . ?p)
                            ("learning" . ?l))
                          org-tag-alist-for-agenda))

(setq my/org-todo-keywords '(
                             ("TODO(t)" . org-todo)
                             ("NEXT(n)" .  (:foreground "#34ebd8" :weight bold :slant italic))
                             ("PROG(p!)" . (:foreground "green" :weight bold))
                             ("HOLD(h@)" . (:background "orange" :foreground "white")) ; in progress but held up
                             ("|")
                             ("DONE(d!)" . org-done)
                             ("WONT(w@/!)" . (:foreground "red" :weight bold))))

(use-package org
  :ensure t
  :config
  (setq org-agenda-files (list (expand-file-name "~/org")))
  ;; set faces
  (setq org-todo-keywords (list (append '(sequence)
                                      (seq-map #'(lambda (elt)
                                                   (if (listp elt)
                                                       (car elt)
                                                     elt))
                                               my/org-todo-keywords))))

(setq org-todo-keyword-faces (let ((f (lambda (elt)
                                       (if (listp elt)
                                           `(
                                            ,(seq-take-while #'(lambda (elt) (not (equal ?\( elt))) (car elt))
                                            .
                                            ,(cdr elt))
                                         elt)
                                       )))
                               (seq-map #'(lambda (elt) (funcall f elt)) my/org-todo-keywords)))
;; 
  ;; config files
  (setq +org-chores-file (expand-file-name "~/org/chores.org"))
  :bind
  (("C-c o a" . org-agenda)
   ("C-c o c" . org-capture))
  :init
  (add-hook 'org-mode-hook #'org-indent-mode))

(use-package org-super-agenda
  :ensure t
  :init (org-super-agenda-mode 1))

(setq org-agenda-custom-commands
    '(("c" "Super agenda"
       ((agenda "" ((org-agenda-overriding-header "")
                    (org-super-agenda-groups
                     '((:log t)
                       (:name "Overdue"
                        :deadline past)
                       (:name "Habits"
                        :habit t)
                       (:name "Today"
                        :time-grid t
                        :date today)
                       (:name "Important"
                        :priority "A"
                        :face (:weight ultra-bold :background "blue")
                        :order 1)
                       (:name "Unstarted"
                        :scheduled past)
                       ))))
        (alltodo "" ((org-agenda-overriding-header "")
                     (org-super-agenda-groups
                      `((:log t)
                        (:name "Important"
                         :priority "A"
                         :face (:weight ultra-bold :background "blue")
                         :order 0)
                        (:name "Next"
                         :todo "NEXT"
                         :order 2)
                       (:name "Coming up"
                              :scheduled future)
                        (:name "In progress"
                         :todo "PROG"
                         :order 1)
                        (:name "Daphne"
                         :tag "daphne")
                        (:name "Chores"
                         :file-path ,(expand-file-name +org-chores-file) ; back-quoted list allows evaluation with `,`
                         :face (:slant italic)
                         :order 2)
                        (:name "Can wait"
                         :priority "C")
                        (:name "If time"
                         :priority "B")
                        (:discard (:file-path ,(expand-file-name "~/org/bills.org")))
                        (:discard (:file-path ,(expand-file-name "~/org/habits.org")))))))))))

(setq org-capture-templates '(("a" "Agenda")
                              ("ad" "Deadline" entry
                               (file+olp+datetree +org-capture-agenda-file)
                               "* %?\nDEADLINE: %^{at}t")
                              ("t" "Todos")
                              ("tt" "project todo" entry
                               (file "~/org/projects.org")
                               "* TODO %?\n%i")
                              ("tn" "today" entry
                               (file+headline "~/org/todo.org" "Todos")
                               "* TODO %?\n%t")
                              ("td" "deadline" entry
                               (file+headline "~/org/todo.org" "Todos")
                               "* TODO %?\nDEADLINE: %^{at}t")
                              ("ts" "scheduled" entry
                               (file+headline "~/org/todo.org" "Todos")
                               "* TODO %?\nSCHEDULED: %^{at}t")
                              ("c" "chore" entry
                               (file +org-chores-file)
                               "* TODO %?\nDEADLINE: %t")))

(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))

(defun reload()
  (interactive)
  (org-babel-load-file (expand-file-name "~/bedrock/config.org"))
  (load (expand-file-name "~/bedrock/config.el")))

(use-package vertico
  :ensure t
  :custom
  (vertico-count 20) ;; Show more candidates
  (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :config ; evaluated after the pkg loads
  ;; (keymap-set vertico-map "TAB" #'vertico-next)
  ;; (keymap-set vertico-map "<backtab>" #'vertico-previous)
  :bind
  (("C-c '" . vertico-repeat))
  :init (vertico-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  :config
  (setq corfu-auto t
        corfu-auto-prefix 2)
  :bind
  (:map corfu-map
      ("TAB" . corfu-next)
      ([tab] . corfu-next)
      ("S-TAB" . corfu-previous)
      ([backtab] . corfu-previous))
  :init (global-corfu-mode 1))

(use-package consult
  :ensure t
  :bind
  ;; meow SPC x b
  (("C-c s b" . consult-buffer)
   ("C-c s l" . consult-line)
   ("C-c s o" . consult-outline)
   ("C-c s i" . consult-imenu)))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :ensure t
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))
;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package vterm
  :ensure t)

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-bexpand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))

(use-package meow
  :ensure t
  :config
  (meow-setup)
  (setq meow-use-clipboard t)
  :init
  (meow-global-mode 1))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(setq treesit-language-source-alist
      '(("gomod" . "https://github.com/camdencheek/tree-sitter-go-mod")
        ("go" . "https://github.com/tree-sitter/tree-sitter-go")))

(use-package lsp-mode
  :ensure t
  :hook
  ;; go
  ((go-ts-mode . lsp-deferred)))

(defun lsp-format-and-organize-imports ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))