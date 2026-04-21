(use-package
 vertico
 ;; (Note: It is recommended to also enable the savehist package.)
 :ensure t
 :config (vertico-mode))
(use-package
  vertico-posframe
  :config (vertico-posframe-mode 1))

;; Vertico leverages Orderless' flexible matching capabilities, allowing users
;; to input multiple patterns separated by spaces, which Orderless then
;; matches in any order against the candidates.
(use-package
 orderless
 :ensure t
 :custom
 (completion-styles '(orderless basic))
 (completion-category-defaults nil)
 (completion-category-overrides '((file (styles partial-completion)))))

;; Marginalia allows Embark to offer you preconfigured actions in more contexts.
;; In addition to that, Marginalia also enhances Vertico by adding rich
;; annotations to the completion candidates displayed in Vertico's interface.
(use-package
 marginalia
 :ensure t
 :commands (marginalia-mode marginalia-cycle)
 :hook (after-init . marginalia-mode))

;; Embark integrates with Consult and Vertico to provide context-sensitive
;; actions and quick access to commands based on the current selection, further
;; improving user efficiency and workflow within Emacs. Together, they create a
;; cohesive and powerful environment for managing completions and interactions.
(use-package
 embark
 ;; Embark is an Emacs package that acts like a context menu, allowing
 ;; users to perform context-sensitive actions on selected items
 ;; directly from the completion interface.
 :ensure t
 :commands
 (embark-act
  embark-dwim
  embark-export
  embark-collect
  embark-bindings
  embark-prefix-help-command)
 :bind
 (("C-." . embark-act) ;; pick some comfortable binding
  ("C-;" . embark-dwim) ;; good alternative: M-.
  ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

 :init (setq prefix-help-command #'embark-prefix-help-command)

 :config
 ;; Hide the mode line of the Embark live/completions buffers
 (add-to-list
  'display-buffer-alist
  '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
    nil
    (window-parameters (mode-line-format . none)))))

(use-package
 embark-consult
 :ensure t
 :hook (embark-collect-mode . consult-preview-at-point-mode))

;; Consult offers a suite of commands for efficient searching, previewing, and
;; interacting with buffers, file contents, and more, improving various tasks.
(use-package
 consult
 :ensure t
 :bind
 ( ;; C-c bindings in `mode-specific-map'
  ("C-c M-x" . consult-mode-command)
  ("C-c h" . consult-history)
  ("C-c k" . consult-kmacro)
  ("C-c m" . consult-man)
  ("C-c i" . consult-info)
  ([remap Info-search] . consult-info)
  ;; C-x bindings in `ctl-x-map'
  ("C-x M-:" . consult-complex-command)
  ("C-x b" . consult-buffer)
  ("C-x 4 b" . consult-buffer-other-window)
  ("C-x 5 b" . consult-buffer-other-frame)
  ("C-x t b" . consult-buffer-other-tab)
  ("C-x r b" . consult-bookmark)
  ("C-x p b" . consult-project-buffer)
  ;; Custom M-# bindings for fast register access
  ("M-#" . consult-register-load)
  ("M-'" . consult-register-store)
  ("C-M-#" . consult-register)
  ;; Other custom bindings
  ("M-y" . consult-yank-pop)
  ;; M-g bindings in `goto-map'
  ("M-g e" . consult-compile-error)
  ("M-g f" . consult-flymake)
  ("M-g g" . consult-goto-line)
  ("M-g M-g" . consult-goto-line)
  ("M-g o" . consult-outline)
  ("M-g m" . consult-mark)
  ("M-g k" . consult-global-mark)
  ("M-g i" . consult-imenu)
  ("M-g I" . consult-imenu-multi)
  ;; M-s bindings in `search-map'
  ("M-s d" . consult-find)
  ("M-s c" . consult-locate)
  ("M-s g" . consult-grep)
  ("M-s G" . consult-git-grep)
  ("M-s r" . consult-ripgrep)
  ("M-s l" . consult-line)
  ("M-s L" . consult-line-multi)
  ("M-s k" . consult-keep-lines)
  ("M-s u" . consult-focus-lines)
  ;; Isearch integration
  ("M-s e" . consult-isearch-history)
  :map
  isearch-mode-map
  ("M-e" . consult-isearch-history)
  ("M-s e" . consult-isearch-history)
  ("M-s l" . consult-line)
  ("M-s L" . consult-line-multi)
  ;; Minibuffer history
  :map
  minibuffer-local-map
  ("M-s" . consult-history)
  ("M-r" . consult-history))

 ;; Enable automatic preview at point in the *Completions* buffer.
 :hook (completion-list-mode . consult-preview-at-point-mode)

 :init
 ;; Optionally configure the register formatting. This improves the register
 (setq
  register-preview-delay 0.5
  register-preview-function #'consult-register-format)

 ;; Optionally tweak the register preview window.
 (advice-add #'register-preview :override #'consult-register-window)

 ;; Use Consult to select xref locations with preview
 (setq
  xref-show-xrefs-function #'consult-xref
  xref-show-definitions-function #'consult-xref)

 ;; Aggressive asynchronous that yield instantaneous results. (suitable for
 ;; high-performance systems.) Note: Minad, the author of Consult, does not
 ;; recommend aggressive values.
 ;; Read: https://github.com/minad/consult/discussions/951
 ;;
 ;; However, the author of minimal-emacs.d uses these parameters to achieve
 ;; immediate feedback from Consult.
 ;; (setq consult-async-input-debounce 0.02
 ;;       consult-async-input-throttle 0.05
 ;;       consult-async-refresh-delay 0.02)

 :config
 (consult-customize
  consult-theme
  :preview-key
  '(:debounce 0.2 any)
  consult-ripgrep
  consult-git-grep
  consult-grep
  consult-bookmark
  consult-recent-file
  consult-xref
  consult-source-bookmark
  consult-source-file-register
  consult-source-recent-file
  consult-source-project-recent-file
  ;; :preview-key "M-."
  :preview-key '(:debounce 0.4 any))
 (setq consult-narrow-key "<"))

(use-package
compile-angel
:ensure t
:custom (compile-angel-verbose t)
:config
(compile-angel-on-load-mode 1))

(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)
(use-package elisp-autofmt :defer t)

(mapc #'disable-theme custom-enabled-themes)
(load-theme 'modus-operandi-tinted t)
(global-set-key (kbd "C-c b t") #'modus-themes-toggle)

(defvar my/font-size 140
  "Default font size")
(defvar my/default-font "JetBrains Mono"
  "Default mixed width font to use")
(defvar my/default-font-mono "JetBrains Mono"
  "Default monospace font to use")
(load "~/.emacs.d/nix-vars.el")
(set-face-attribute 'default nil
                    :height my/font-size
                    :weight 'normal
                    :family my/default-font-mono)
(set-face-attribute 'variable-pitch nil
                    :height my/font-size
                    :weight 'normal
                    :family my/default-font)

(use-package doom-modeline
:config
(doom-modeline-mode 1))

(use-package autorevert
  :ensure nil
  :commands (auto-revert-mode global-auto-revert-mode)
  :hook
  (after-init . global-auto-revert-mode)
  :init
  ;; (setq auto-revert-verbose t)
  (setq auto-revert-interval 3)
  (setq auto-revert-remote-files nil)
  (setq auto-revert-use-notify t)
  (setq auto-revert-avoid-polling nil))

(use-package recentf
  :ensure nil
  :commands (recentf-mode recentf-cleanup)
  :hook
  (after-init . recentf-mode)

  :init
  (setq recentf-auto-cleanup (if (daemonp) 300 'never))
  (setq recentf-exclude
        (list "\\.tar$" "\\.tbz2$" "\\.tbz$" "\\.tgz$" "\\.bz2$"
              "\\.bz$" "\\.gz$" "\\.gzip$" "\\.xz$" "\\.zip$"
              "\\.7z$" "\\.rar$"
              "COMMIT_EDITMSG\\'"
              "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
              "-autoloads\\.el$" "autoload\\.el$"))

  :config
  ;; A cleanup depth of -90 ensures that `recentf-cleanup' runs before
  ;; `recentf-save-list', allowing stale entries to be removed before the list
  ;; is saved by `recentf-save-list', which is automatically added to
  ;; `kill-emacs-hook' by `recentf-mode'.
  (add-hook 'kill-emacs-hook #'recentf-cleanup -90))

;; Enable `auto-save-mode' to prevent data loss. Use `recover-file' or
;; `recover-session' to restore unsaved changes.
(setq auto-save-default t)

;; Trigger an auto-save after 300 keystrokes
(setq auto-save-interval 300)

;; Trigger an auto-save 30 seconds of idle time.
(setq auto-save-timeout 30)

(use-package savehist
  :ensure nil
  :commands (savehist-mode savehist-save)
  :hook
  (after-init . savehist-mode)
  :init
  (setq history-length 300)
  (setq savehist-autosave-interval 600))
;; save-place-mode enables Emacs to remember the last location within a file
;; upon reopening. This feature is particularly beneficial for resuming work at
;; the precise point where you previously left off.
(use-package saveplace
  :ensure nil
  :commands (save-place-mode save-place-local-mode)
  :hook
  (after-init . save-place-mode)
  :init
  (setq save-place-limit 400))

(repeat-mode)
(keymap-global-set "M-o" 'other-window)

(org-babel-do-load-languages
 'org-babel-load-languages
 (append org-babel-load-languages '((shell . t) (shell . t))))

(load "~/.emacs.d/org-mode-init.el")

(use-package
 org
 :config

(setq org-special-ctrl-a/e t
      org-use-speed-commands t)
;;

;; (use-package org-gtd
;; :ensure t
;; :after org
;; :demand t
;; :init
;; ;; Suppress upgrade warnings (must be set before package loads)
;; (setq org-gtd-update-ack "4.0.0")
;; ;; Where org-gtd will keep its files (defaults to ~/gtd/)
;; ;; (setq org-gtd-directory "~/my-gtd/")
;;
;; :custom
;; ;; Configure TODO keyword states (options like "TODO(t)" or "DONE(d!)" are fine)
;; (org-todo-keywords '((sequence "TODO" "NEXT" "WAIT" "|" "DONE" "CNCL")))
;;
;; ;; Map GTD semantic states to your keywords
;; (org-gtd-keyword-mapping '((todo . "TODO")
;;                            (next . "NEXT")
;;                            (wait . "WAIT")
;;                            (canceled . "CNCL")))
;;
;; :config
;; ;; REQUIRED: Enable org-edna for project dependencies
;; (org-edna-mode 1)
;;
;; ;; Add org-gtd files to your agenda (must be in :config so org-gtd-directory is defined)
;; (setq org-agenda-files (list org-gtd-directory))
;;
;; :bind
;; ;; Global keybindings (work anywhere in Emacs)
;; (("C-c d c" . org-gtd-capture)
;;  ("C-c d e" . org-gtd-engage)
;;  ("C-c d p" . org-gtd-process-inbox)
;;  ("C-c d n" . org-gtd-show-all-next)
;;  ("C-c d s" . org-gtd-reflect-stuck-projects)
;;
;;  ;; Keybinding for organizing items (only works in clarify buffers)
;;  :map org-gtd-clarify-mode-map
;;  ("C-c c" . org-gtd-organize)
;;
;;  ;; Quick actions on tasks in agenda views (optional but recommended)
;;  ;; :map org-agenda-mode-mapc
;;  ;; ("C-c ." . org-gtd-agenda-transient)
;;  ))

(setq
 org-id-link-to-org-use-id
 'create-if-interactive ;; Dont create IDs when capturing
 org-datetree-add-timestamp nil
 org-capture-bookmark nil)

(setq org-capture-templates
      '(("t"
         "Todo"
         entry
         (file+headline "~/notes/todo.org" "Inbox")
         "* TODO %?\n  \n ")
        ;; ("s"
        ;;  "School todo"
        ;;  entry
        ;;  (file+headline "~/notes/schodo.org" "Inbox")
        ;;  "* TODO %?\n  %i\n ")
        ("j"
         "Journal"
         entry
         (file+datetree "~/notes/journal.org")
         "* %?"
         :tree-type week)
        ("c" "Current clocking task notes" entry (clock) "* %i")))

(setq org-latex-compiler "xelatex")

 ;; Enable LaTeX preview
 (setq org-startup-with-latex-preview t)
 (setq org-latex-preview-mode-display-live t)
 (plist-put org-latex-preview-appearance-options :zoom 1.4)
 (setq org-cite-default-processor 'biblatex)
 (use-package cdlatex :defer t)
 (use-package auctex :defer t)

 (setq org-latex-packages-alist
       '(("" "amsmath" t)
         ("" "amssymb" t)
         ("" "fontspec" t ("xelatex" "lualatex"))))
 (setq org-latex-preview-preamble
       "\\documentclass{article}
     [DEFAULT-PACKAGES]
     [PACKAGES]
     \\usepackage{fontspec}
     \\setmainfont{Liberation Serif}
     \\usepackage{xcolor}")

(setq org-latex-classes
      '(("article"
         "\\documentclass[11pt, a4paper]{article}
         \\usepackage[margin=1in]{geometry}
  [DEFAULT-PACKAGES]
  [PACKAGES]
  [EXTRA]
  \\setmainfont{Liberation Serif}
  \\setsansfont{Liberation Sans}
  \\setmonofont{Liberation Mono}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ;; You can repeat this for "report" or "book" if you use them
        ))

(setq org-cycle-hide-drawer-startup nil)

(defun my/org-jump-skipping-drawer ()
  (interactive)
  (org-fold-show-entry)
  (org-end-of-meta-data t)
  (if (org-at-heading-p)
      (progn
        (insert "\n")
        (move-point-visually -1))))
(keymap-set org-mode-map "C-c n" 'my/org-jump-skipping-drawer)

(defun my/org-cleanup-whitespace ()
  (interactive)
  (if (equal major-mode 'org-mode)
      (whitespace-cleanup)))
(add-hook 'before-save-hook 'my/org-cleanup-whitespace)

(setq
       org-adapt-indentation t
       org-hide-leading-stars t
       org-hide-emphasis-markers t
       org-pretty-entities t
       org-ellipsis "  ·")
      (setq org-indent-indentation-per-level 1)
      (setq org-pretty-entities t)
      (setq org-hide-emphasis-markers t)
      (setq org-insert-heading-respect-content t)
       (use-package
org-modern
:hook (org-mode . global-org-modern-mode)
:config
(setq
 org-modern-tag nil
 org-modern-priority nil
 org-modern-todo nil
 org-modern-table nil))

    (set-face-attribute 'org-document-title nil
                        :font my/default-font
                        :weight 'bold
                        :height 1.8)
                        (set-face-attribute 'org-todo nil :family my/default-font-mono :weight 'bold)

(use-package
  org-super-agenda
  :config (org-super-agenda-mode 1)
  (setq org-agenda-custom-commands
        '(("p" "Planning"
           ((stuck ())
            (todo
             "NEXT"
             ((org-super-agenda-groups
               '((:name "Scheduled" :scheduled t :order 48)
                 (:name "Weekly focus" :tag "weekly" :order 1)
                 (:name "Monthly Focus" :tag "monthly" :order 2)
                 (:name "discard" :discard t :tag "stalled")
                 (:name "Waiting" :tag "waiting" :order 10)
                 (:name "Untagged" :anything t :order 2)))
              ))
            (agenda
             ""
             ((org-agenda-span 14)
              (org-agenda-start-with-log-mode nil)
              (org-agenda-include-deadlines t)))))
          ("w" "Day view"
           ((todo
             "NEXT"
             ((org-agenda-todo-ignore-scheduled 'all)
              (org-agenda-todo-ignore-deadlines 'all)
              (org-super-agenda-groups
               '((:name "Waiting:" :tag "waiting" :order 3)
                 (:name "Deep" :order 1 :tag "deep")
                 (:name "Light" :order 2 :tag "light")
                 (:anything t :discard t)))))

            (agenda
             ""
             (
              ;; (org-agenda-todo-ignore-scheduled 'future)
              ;; (org-agenda-tags-todo-honor-ignore-options t)
              ;; (org-agenda-include-deadlines nil)
              )))))))
(setq org-todo-keywords
      '((type "PROJ(p)" "TODO(t)" "NEXT(n)" "|" "DONE(d!)" "CANC(c%)")))
(setq org-agenda-files
      (list
       "~/notes/todo.org"
       ))
(setq org-stuck-projects '("TODO=\"PROJ\"" ("NEXT") ("stalled" "someday") ""))
(setq org-agenda-sorting-strategy '((tags priority-down effort-up)))
(setq org-agenda-skip-scheduled-if-done t)
;; (setq org-agenda-sticky t)

(setq
 org-agenda-tags-column 0
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed)
   (0530 2100)
   " ┄┄┄┄┄ "
   "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string "⭠ now ─────────────────────────────────────────────────")
(setq org-agenda-overriding-header "")
(setq org-agenda-prefix-format
      '((todo . " %-8c  %-3e %-8T") (agenda . " %i %?-12t% s")))
(setq org-agenda-remove-tags t)
(setq org-agenda-todo-keyword-format "")
(setq org-agenda-span 'day)
(setq org-agenda-window-setup 'current-window)

(setq org-log-done 'time)
(setq org-log-into-drawer t)
(setq org-agenda-show-all-dates nil)
(setq org-clock-persist-file "~/notes/clock.el")
(org-clock-persistence-insinuate)
(setq org-clock-history-length 20)
(setq org-clock-in-resume t)
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-clock-persist t)
(setq org-agenda-show-future-repeats nil)
;; (setq org-agenda-start-with-log-mode '(state clock))
(require 'org-indent)

(setq org-startup-with-inline-images t)
     (setq org-image-actual-width (/ (display-pixel-width) 10))
;;     (setq org-image-max-width 'fill-column)
     ;; (setq org-image-actual-width (list 300))

(setq org-archive-location "~/notes/archive.org::")

(setq org-footnote-section nil)

:hook
(org-mode . org-indent-mode)
(org-mode . yas-minor-mode)
(org-mode . auto-revert-mode)
(org-mode . visual-line-mode)
(org-mode . org-latex-preview-mode)
(org-mode . org-cdlatex-mode)
(org-mode . (lambda () (setq-local tab-width 8)))

:bind
("C-c a" . org-agenda)
("C-c f" . consult-org-heading)
("C-c 1" . org-cycle-list-bullet)
("C-c p" . org-capture)
("C-c c" . org-clock-goto)
("C-c s" . org-store-link)
("C-c l" . org-insert-last-stored-link))     ;; Closes the org-mode use-package bracket

(use-package
  org-mem
  :defer
  :config (setq org-mem-do-sync-with-org-id t)
  (setq org-mem-watch-dirs
        (list "~/notes")) ;; Configure me
  (org-mem-updater-mode))

(use-package
  org-node
  :init (keymap-global-set "M-p" org-node-global-prefix-map)
  (with-eval-after-load 'org
    (keymap-set org-mode-map "M-p" org-node-org-prefix-map))
  :config (org-node-cache-mode))

(defun my-org-node-find-custom-width (orig-fun &rest args)
  "Set a custom width for vertico-posframe during org-node-find."
  (let ((vertico-posframe-height 15) (vertico-posframe-width 40)) ; Change 70 to your preferred width
    (apply orig-fun args)))

(advice-add 'org-node-find :around #'my-org-node-find-custom-width)

(setq inline-anki-use-math-jax t)
(setq inline-anki-note-type "Cloze")
(use-package
  inline-anki
  ;; :init
 :vc (:url "https://github.com/meedstrom/inline-anki")
 ;; :config (setq inline-anki-note-type "Cloze")
 :defer t
 )
(with-eval-after-load 'org
  (add-to-list 'org-structure-template-alist '("f" . "flashcard")))
(defface my-cloze
  '((t (:box t)))
  "Face for inline-anki clozes.")

(provide 'my-cloze)
(setq org-emphasis-alist
      '(("*" bold)
        ("/" italic)
        ("_" my-cloze) ;; new
        ("=" org-verbatim verbatim)
        ("~" org-code verbatim)
        ("+" (:strike-through t))))

(setq org-file-apps
    '((auto-mode . emacs)
      ("\\.mm\\'" . default)
      ("\\.x?html?\\'" . default)
      ("\\.pdf\\'" . "zathura %s")))

(use-package
 markdown-mode
 :defer t
 :hook (markdown-mode . visual-line-mode)
 :config
 ;; Define keybindings for moving list items with Alt+Up and Alt+Down (Meta+Up/Down).
 (define-key markdown-mode-map (kbd "M-<up>") #'markdown-move-list-item-up)
 (define-key markdown-mode-map (kbd "M-<down>") #'markdown-move-list-item-down))

(use-package
  telega
  :config
  (setq telega-server-libs-prefix "/usr")
  (setq telega-emoji-use-images nil)
  (setq telega-file-open-function 'org-open-file)
  ;; (setq org-id-link-to-org-use-id t)
  (setq telega-chat-show-deleted-messages-for '(return t))
  :bind-keymap ("C-c t" . telega-prefix-map)
  :hook
  (telega-root-mode . visual-line-mode)
  (telega-chat-mode . company-mode)
  ;; (load "~/.emacs.d/telega.el")
  ;; (telega-chat-mode . telega-squash-message-mode)
  :defer t)
  (use-package company :defer t)
;;; --- Latex

(use-package
gptel
:hook (gptel-post-stream-hook . gptel-auto-scroll)
:bind
("C-c C-g m" . gptel-menu)
("C-c C-g r" . gptel-rewrite)
("C-c C-g s" . gptel-send)
("C-c C-g p" . gptel-beginning-of-response)
("C-c C-g n" . gptel-end-of-response)
:config
(setq
 gptel-model 'gpt-5-mini
 gptel-backend (gptel-make-gh-copilot "Copilot"))

(gptel-make-preset
 'explain
 :system "Explain what this concept means to a learner.")

(gptel-make-preset
 'Flashcard
 :system ""
 :rewrite-default-action 'accept
 :rewrite-message "Rewrite this text into a flashcard format"
 :context '("/home/mking/notes/prompts/flashcards.md")
 :use-context 'system)
(gptel-make-preset
 'diagram
 :system "Create a diagram based on the following material"
 :context '("/home/mking/notes/prompts/diagram.md")
 :use-context 'system)
 (gptel-make-preset
 'diagram-rewrite
 :system "Create a diagram based on the following material"
 :rewrite-default-action 'accept
 :context '("/home/mking/notes/prompts/diagram-rewrite.md")
 :rewrite-message "Fix the following issues in this diagram:"
 :use-context 'system))

;; (use-package vterm
;;     :ensure t)
