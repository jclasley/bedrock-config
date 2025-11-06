(message "Loaded in evil.el")

(defmacro evil-normal-key-map! (keys map)
  "Creates a new binding for a keymap, prefixed by <leader>."
  `(evil-define-key 'normal 'global (kbd ,(string-join (list "<leader>" keys) "")) ,map))

(use-package undo-fu
  :ensure t)

(use-package evil
  :requires undo-fu
  :ensure t
  :custom
  (evil-undo-system 'undo-fu)
  :init
  (evil-mode 1))

;; pretty annoying to not have
;; https://github.com/emacs-evil/evil-surround
(use-package evil-surround
  :requires evil
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; HELPERS
(defmacro general-create-prefix-keymap (name prefix states &rest bindings)
  "Create a new keymap, bind it to PREFIX, and define BINDINGS within it.

NAME is the symbol for the keymap variable.
PREFIX is the key sequence to bind the keymap to (e.g., \"b\" for SPC b).
STATES is a list of evil states (e.g., '(normal visual)).
BINDINGS is a plist of key definitions passed to `general-def`.

The plist can include :which-key to set the which-key label for the prefix.

Example:
  (general-create-prefix-keymap my/buffer-map \"b\" '(normal visual)
    :which-key \"buffers\"
    \"d\" 'kill-current-buffer
    \"q\" 'bury-buffer)"
  (declare (indent 3))
  (let* ((keymap-var name)
         (which-key-label (plist-get bindings :which-key))
         (bindings-without-which-key (cl-loop for (k v) on bindings by #'cddr
                                              unless (eq k :which-key)
                                              append (list k v))))
    `(progn
       ;; Create the keymap
       (defvar ,keymap-var (make-sparse-keymap)
         ,(format "Keymap for prefix %s" prefix))
       
       ;; Define bindings in the keymap
       ,@(when bindings-without-which-key
           `((general-def ,states ',keymap-var
               ,@bindings-without-which-key)))
       
       ;; Bind the keymap to the prefix key using my-leader-def
       (my-leader-def ,prefix '(:keymap ,keymap-var
					,@(when which-key-label
					    (list :which-key which-key-label)))))))


(general-evil-setup)

;; create the leader def
(general-create-definer my-leader-def
  :states '(normal visual)
  :prefix "SPC"
  :non-normal-prefix "M-SPC")

;; jk binding
(general-imap "j"
  (general-key-dispatch 'self-insert-command
    "k" 'evil-normal-state))

;; KEYBINDINGS
(general-define-key
 :keymaps '(normal insert visual global)
 "C-e" 'end-of-line
 "C-a" 'beginning-of-line-text)

(general-define-key
 :keymaps '(normal visual)
 "gc" '(comment-dwim :wk "comment")
 "gd" '(xref-find-definitions :wk "goto def")
 "gD" '(xref-find-references :wk "goto ref")
 "go" '(xref-find-definitions-other-window :wk "goto def (other)")
 "gt" '(lsp-goto-type-definition :wk "goto type")
 "s" '(evil-avy-goto-char-2 :wk "search"))

;; CORFU
(general-def 'insert
  "C-SPC" 'corfu-insert-separator)

;; TODO
;; (general-def 'insert corfu-map
;;   "ESC" (general-predicate-dispatch 'evil-normal-state
;; 	  ))

;; LEADER KEYS

(my-leader-def
  "SPC" 'execute-extended-command
  "r" 'rg-menu
  ";" 'eval-expression)

;; nested maps
(my-leader-def
  "s" '(:keymap my/consult-map :which-key "consult")
  "h" '(:keymap help-map :which-key "help")
  "p" '(:keymap project-prefix-map :which-key "project")
  "w" '(:keymap my/window-map :which-key "window")
  "g" '(:keymap my/goto-map :which-key "goto")
  "e" '(:keymap my/errors-map :which-key "errors")
  "TAB" '(:keymap eyebrowse-mode-prefix-map :which-key "eyebrowse"))

;; eyebrowse helper
(general-def eyebrowse-mode-prefix-map
  "TAB" 'eyebrowse-switch-to-window-config
  "d" 'eyebrowse-close-window-config
  "n" 'eyebrowse-create-window-config)

;; FILES
(my-leader-def
  "f" '(:ignore t :wk "files")
  "fs" '(save-buffer :wk "save")
  "ff" '(find-file :wk "find")
  "fF" '(find-file-other-window :wk "file other window")
  "fr" '(consult-recent-file :wk "recent")
  "fy" '(copy-filename :wk "copy path"))

;; BUFFERS
(setq my/buffer-map (make-sparse-keymap))
(general-def my/buffer-map
  ;; "b" 'toggle-between-buffers
  "d" '(kill-current-buffer :wk "kill")
  "q" '(bury-buffer :wk "bury")
  "b" '(consult-project-buffer :wk "consult"))
(my-leader-def
  "b" '(:keymap my/buffer-map :wk "buffers"))

;; PROJECT
(general-def project-prefix-map
  "d" '(project-dired :wk "dired")
  "t" 'neotree
  "F" '(projectile-find-file-other-window :wk "file other window"))

;; WINDOW
(general-def my/window-map
  "O" '(delete-other-windows :wk "only this")
  "=" '(balance-windows :wk "balance")
  "s" '(evil-window-vsplit :wk "below")
  "v" '(evil-window-split :wk "split"))

;; VTERM
(defun new-vterm-project ()
  (interactive)
  ;; check if vterm for this project exists -- if so, open it
  (let* ((proj (project-name (project-current)))
	 (vterm-name (format "*vterm %s*" proj))
	 (buf (get-buffer vterm-name)))
    (if buf
	(switch-to-buffer-other-window buf)
      (vterm-other-window vterm-name))))

(my-leader-def 
  "v" '(:ignore t :wk "vterm")
  "vv" 'new-vterm-project)

;; TODO MAGIT

;; INSERT
(my-leader-def
  "i" '(:ignore t :wk "insert")
  "in" 'yas-new-snippet
  "is" 'yas-insert-snippet
  "ir" 'consult-register
  "iy" 'consult-yank-from-kill-ring)

;; GOTO
(general-def my/goto-map
  "s" '(evil-avy-goto-char-timer :wk "search"))

;; ERRORS
(general-def my/errors-map
  "d" '(flycheck-explain-error-at-point :wk "describe"))
