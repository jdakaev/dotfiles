;;; post-init.el --- DESCRIPTION -*- no-byte-compile: t; lexical-binding: t; -*-
;;; -- My Emacs Config
(setq default-directory "~/notes/")
;;; --- Elisp
(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)
(use-package elisp-autofmt :defer t)
;;; --- Appearance
(mapc #'disable-theme custom-enabled-themes) ; Disable all active themes
(load-theme 'modus-vivendi t)
(setq modus-themes-variable-pitch-ui t)
;;; --- Font Faces
(set-face-attribute 'default nil
                    :height 120
                    :weight 'normal
                    :family "Input Mono Narrow")
(set-face-attribute 'variable-pitch nil
                    :height 120
                    :weight 'normal
                    :family "Input Sans Compressed")
;;; --- Native Compilation
(use-package
 compile-angel
 :diminish compile-angel-on-load-mode
 :ensure t
 :custom (compile-angel-verbose t)
 :config
 ;; The following directive prevents compile-angel from compiling your init
 ;; files. If you choose to remove this push to `compile-angel-excluded-files'
 ;; and compile your pre/post-init files, ensure you understand the
 ;; implications and thoroughly test your code. For example, if you're using
 ;; the `use-package' macro, you'll need to explicitly add:
 ;; (eval-when-compile (require 'use-package))
 ;; at the top of your init file.
 (push "/init.el" compile-angel-excluded-files)
 (push "/early-init.el" compile-angel-excluded-files)
 (push "/pre-init.el" compile-angel-excluded-files)
 (push "/post-init.el" compile-angel-excluded-files)
 (push "/pre-early-init.el" compile-angel-excluded-files)
 (push "/post-early-init.el" compile-angel-excluded-files)

 ;; A local mode that compiles .el files whenever the user saves them.
 ;; (add-hook 'emacs-lisp-mode-hook #'compile-angel-on-save-local-mode)

 ;; A global mode that compiles .el files prior to loading them via `load' or
 ;; `require'. Additionally, it compiles all packages that were loaded before
 ;; the mode `compile-angel-on-load-mode' was activated.
 (compile-angel-on-load-mode 1))


;;; --- Consult
;; Vertico provides a vertical completion interface, making it easier to
;; navigate and select from completion candidates (e.g., when `M-x` is pressed).
(use-package
 vertico
 ;; (Note: It is recommended to also enable the savehist package.)
 :ensure t
 :config (vertico-mode))

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
;;; --- Org
(use-package
 org
 :load-path "~/.emacs.d/var/elpa/org-mode/lisp/"
 :config (setq org-special-ctrl-a/e t)

 (setq org-archive-location "~/notes/archive.org::")
 ;;;; Footnotes
 (setq org-footnote-section nil)
 ;;;; Telega links
 ;; Requires the load path
 ;; (load "ol-telega.el")
 ;;;; External Apps Filetypes
 (setq org-file-apps
       '((auto-mode . emacs)
         ;; ("\\.x?html?\\'" . "firefox %s")
         ("\\.pdf\\'" . "zathura \"%s\"")))
 ;;;; My/Jump to after drawers
 (defun my/org-jump-skipping-drawer ()
   (interactive)
   (org-fold-show-entry)
   (org-end-of-meta-data t)
   (if (org-at-heading-p)
       (progn
         (insert "\n")
         (move-point-visually -1))))
 (keymap-set org-mode-map "C-c n" 'my/org-jump-skipping-drawer)
 ;;;; Auto cleanup whitespace
 (defun my/org-cleanup-whitespace ()
   (interactive)
   (if (equal major-mode 'org-mode)
       (whitespace-cleanup)))
 (add-hook 'before-save-hook 'my/org-cleanup-whitespace)
 ;;;; Disable fringes
 ; Source - https://stackoverflow.com/a/22320638
 ; Posted by Lindydancer
 (add-hook 'org-mode-hook (lambda () (set-fringe-style 0)))
 ;;;; Org Mode Faces
 (add-hook 'org-mode-hook 'variable-pitch-mode)
 (set-face-attribute 'org-document-title nil
                     :font "Input Sans"
                     :weight 'bold
                     :height 1.8)
 (set-face-attribute 'org-document-title nil :height 1.1)
 (set-face-attribute 'org-todo nil :family "Input Mono" :weight 'bold)
 (set-face-attribute 'org-scheduled-today nil
                     :family "Input Sans"
                     :weight 'bold
                     :height 1.0
                     :foreground "#FFEE8C")
 (set-face-attribute 'org-agenda-structure nil
                     :family "Input Mono"
                     :weight 'bold
                     :height 1.3)
 ;; https://sophiebos.io/posts/beautifying-emacs-org-mode/
 (dolist (face
          '((org-level-1 . 1.35)
            (org-level-2 . 1.3)
            (org-level-3 . 1.2)
            (org-level-4 . 1.1)
            (org-level-5 . 1.1)
            (org-level-6 . 1.1)
            (org-level-7 . 1.1)
            (org-level-8 . 1.1)))
   (set-face-attribute (car face) nil
                       :font "Input Sans"
                       :weight 'bold
                       :height (cdr face)))

 ;; Org indent tweak
 (require 'org-indent)
 (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
 ;; Disable variable pitch for some things
 (set-face-attribute 'org-block nil
                     :foreground nil
                     :inherit 'fixed-pitch
                     :height 0.85)
 (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch) :height 0.85)
 (set-face-attribute 'org-indent nil
                     :inherit '(org-hide fixed-pitch)
                     :height 0.85)
 (set-face-attribute 'org-verbatim nil
                     :inherit '(shadow fixed-pitch)
                     :height 0.85)
 (set-face-attribute 'org-special-keyword nil
                     :inherit '(font-lock-comment-face fixed-pitch))
 (set-face-attribute 'org-meta-line nil
                     :inherit '(font-lock-comment-face fixed-pitch))
 (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
 (setq
  org-adapt-indentation t
  org-hide-leading-stars t
  org-hide-emphasis-markers t
  org-pretty-entities t
  org-ellipsis "  ·")
 (use-package olivetti :hook (org-mode . olivetti-mode) :defer t)
 (setq org-indent-indentation-per-level 1)
 (setq org-pretty-entities t)
 (setq org-hide-emphasis-markers t)
 (setq org-insert-heading-respect-content t)
 ;;;; Images
 (setq org-image-actual-width 'nil) ;; (/ (display-pixel-width) 10))
 (setq org-startup-with-inline-images t)

 ;;;; Org Modern
 (use-package
  org-modern
  :hook (org-mode . global-org-modern-mode)
  :config
  (setq
   org-modern-tag nil
   org-modern-priority nil
   org-modern-todo nil
   org-modern-table nil))

 ;;;; Babel
 (org-babel-do-load-languages
  'org-babel-load-languages
  (append org-babel-load-languages '((shell . t) (shell . t))))

 ;;;; Latex
 (setq org-startup-with-latex-preview t)
 (setq org-latex-preview-mode-display-live t)
 (setq org-preview-latex-image-directory
       (expand-file-name "ltximg/" user-emacs-directory))
 (setq org-format-latex-options (plist-put org-format-latex-options :zoom 1.5))
 (setq org-preview-latex-default-process 'dvisvgm)
 (setq org-latex-preview-mode-generate 'live)
 (setq org-latex-default-packages-alist
       '((#1= "" "amsmath" t ("lualatex" "xetex"))
         (#1# "fontspec" nil ("lualatex" "xetex"))
         ("AUTO" "inputenc" t ("pdflatex"))
         ("T1" "fontenc" nil ("pdflatex"))
         (#1# "amsmath" t ("pdflatex"))
         (#1# "amssymb" t ("pdflatex"))
         (#1# "capt-of" nil)
         (#1# "hyperref" nil)))
 (setq org-latex-classes '(("article" "
\\documentclass[11pt]{article}
\\usepackage{fontspec}
\\setmainfont{Input Sans}
\\pagestyle{empty}
[DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]
")))

 ;;;; Hide drawers by default

 (setq org-cycle-hide-drawer-startup nil)

 ;;;; Capture
 (defun my/org-choose-heading (&optional prompt)
   "Prompt for a location in an org file and jump to it.
This is for promping for refile targets when doing captures."
   (let ()
     (org-refile t nil nil prompt)))
 ;; Stop org-capture from creating IDs when doing a capture
 (setq org-id-link-to-org-use-id 'create-if-interactive)

 (setq org-datetree-add-timestamp nil)
 (setq org-capture-bookmark nil)

 (setq org-capture-templates
       '(("t" "Todo" entry (file "~/notes/inbox.org") "* TODO %?\n  \n ")
         ("s"
          "School todo"
          entry
          (file+function "~/notes/schodo.org" my/org-choose-heading)
          "* TODO %?\n  %i\n ")
         ("j"
          "Journal"
          entry
          (file+datetree "~/notes/journal.org")
          "* %?"
          :tree-type week)
         ("c" "Current clocking task notes" entry (clock) "* %i")))
 ;;;; Hooks
 :hook
 (org-mode . org-indent-mode)
 (org-mode . yas-minor-mode)
 (org-mode . auto-revert-mode)
 (org-mode . visual-line-mode)
 (org-mode . org-latex-preview-mode)
 (org-mode . org-cdlatex-mode)
 (org-mode . (lambda () (setq-local tab-width 8)))
 ;;;; Keybinds
 :bind
 ("C-c a" . org-agenda)
 ("C-c 1" . org-cycle-list-bullet)
 ("C-c p" . org-capture)
 ("C-c c" . org-clock-goto)
 ("C-c s" . org-store-link)
 ("C-c l" . org-insert-last-stored-link))
;;;; Org-yt
(use-package
 org-yt
 ;; :defer
 :vc (:url "https://github.com/TobiasZawada/org-yt"))
;;;; Agenda
(setq org-todo-keywords
      '((type "PROJ(p)" "TODO(t)" "NEXT(n)" "|" "DONE(d!)" "CANC(c%)")))
(setq org-agenda-files
      (list
       "~/notes/todo.org"
       "~/notes/daily.org"
       "~/notes/schodo.org"
       "~/notes/journal.org"))
(setq org-stuck-projects '("TODO=\"PROJ\"" ("NEXT") ("stalled" "someday") ""))
(setq org-agenda-sorting-strategy '((todo priority-down effort-up)))

(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-sticky t)


;;;; Agenda style
(setq
 org-agenda-tags-column 0
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed)
   (530 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 2000)
   " ┄┄┄┄┄ "
   "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string "⭠ now ─────────────────────────────────────────────────")
(setq org-agenda-overriding-header "")
(setq org-agenda-prefix-format '((todo . "  %-6e ") (agenda . " %i %?-12t% s")))
(setq org-agenda-remove-tags t)
(setq org-agenda-todo-keyword-format "")
(setq org-agenda-block-separator nil)
(setq org-agenda-span 'day)
(setq org-agenda-window-setup 'current-window)
;; Org log
(setq org-log-done 'time)
(setq org-log-into-drawer t)
(setq org-agenda-show-all-dates nil)
;;;; Org Clock Settings
(org-clock-persistence-insinuate)
(setq org-clock-history-length 20)
(setq org-clock-in-resume t)
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-clock-persist t)


;; Hide duplicate items
(setq org-agenda-show-future-repeats nil)
(setq org-agenda-start-with-log-mode '(state clock))
;;;; super-agenda
(use-package
 org-super-agenda
 :config (org-super-agenda-mode 1)
 ;;;;; Agenda definition
 (setq org-agenda-custom-commands
       '(("p" "Planning"
          ((stuck ())
           (todo
            "NEXT"
            ((org-super-agenda-groups
              '((:name "Scheduled" :scheduled t :order 48)
                (:name "Pinned" :tag "today" :order 1)
                (:name "" :discard t :tag "stalled")
                (:name "Waiting" :tag "waiting" :order 10)
                (:name "" :auto-tags t :order 3)
                (:name "Untagged" :anything t :order 2)))
             ;; (org-agenda-todo-ignore-scheduled 'all)
             ;; (org-agenda-todo-ignore-deadlines 'all)
             ))
           (agenda
            ""
            ((org-agenda-span 14)
             (org-agenda-start-with-log-mode nil)
             (org-agenda-include-deadlines t)))))
         ("w" "Day view"
          ((agenda
            ""
            (
             ;; (org-agenda-todo-ignore-scheduled 'future)
             ;; (org-agenda-tags-todo-honor-ignore-options t)
             ;; (org-agenda-include-deadlines nil)
             ))

           (tags-todo
            "today/NEXT"
            ((org-agenda-todo-ignore-scheduled 'future)
             (org-agenda-todo-ignore-deadlines 'future)
             (org-super-agenda-groups
              '((:name "Waiting:" :tag "waiting" :order 3)
                (:name "Accomplish today" :tag "today" :order 1)
                (:anything t :discard t))))))))))

;;;; Org Node
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
;;;; Org Inline Anki
(setq inline-anki-use-math-jax t)
(use-package
 inline-anki
 :vc (:url "https://github.com/meedstrom/inline-anki")
 :config (setq inline-anki-note-type "Cloze"))
(with-eval-after-load 'org
  (add-to-list 'org-structure-template-alist '("f" . "flashcard")))
(defface my-cloze '((t . (:box "pink" :background "#220135")))
  "Cloze face for Inline-Anki")
(setq org-emphasis-alist
      '(("*" bold)
        ("/" italic)
        ("_" my-cloze) ;; new
        ("=" org-verbatim verbatim)
        ("~" org-code verbatim)
        ("+" (:strike-through t))))

(setq debug-on-message nil)


;;;; Org Krita & Inkscape
(use-package
 org-krita
 ;; :defer
 :ensure t
 :vc (:url "https://github.com/lepisma/org-krita")
 :hook (org-mode . org-krita-mode))
(use-package ink :vc (:url "https://github.com/jdakaev/ink.git"))
;;; --- Markdown mode
(use-package markdown-mode :hook (markdown-mode . visual-line-mode) :defer t)
;;; --- Telegram
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
 ;; (telega-chat-mode . telega-squash-message-mode)
 :defer t)
;;; --- Company
(use-package company :defer t)
;;; --- Latex
(use-package cdlatex :defer t)
(use-package auctex :defer t)
;;; --- GPTel
(use-package
 gptel
 :hook (gptel-post-stream-hook . gptel-auto-scroll)
 :bind
 ("C-c g m" . gptel-menu)
 ("C-c g r" . gptel-rewrite)
 ("C-c g s" . gptel-send)
 :defer t)
(setq
 gptel-model 'test
 gptel-backend
 (gptel-make-openai
  "llama-cpp"
  :stream t
  :protocol "http"
  :host "10.0.0.64:1234"
  :models '("qwen3.5-9b")))
;;; --- Navigation
(repeat-mode)
(keymap-global-set "M-o" 'other-window)
;;; --- Recentf
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;; --- Snippets
(use-package
 yasnippet
 :config (setq yas/root-directory (list "~/.my-emacs/snippets/"))
 :defer t)
;;; --- Org Capture Maximized Window
;; https://fuco1.github.io/2017-09-02-Maximize-the-org-capture-buffer.html
(defvar my-org-capture-before-config nil
  "Window configuration before `org-capture'.")

(defadvice org-capture (before save-config activate)
  "Save the window configuration before `org-capture'."
  (setq my-org-capture-before-config (current-window-configuration)))

(add-hook 'org-capture-mode-hook 'delete-other-windows)
(defun my-org-capture-cleanup ()
  "Clean up the frame created while capturing via org-protocol."
  ;; In case we run capture from emacs itself and not an external app,
  ;; we want to restore the old window config
  (when my-org-capture-before-config
    (set-window-configuration my-org-capture-before-config))
  (-when-let
   ((&alist 'name name) (frame-parameters))
   (when (equal name "org-protocol-capture")
     (delete-frame))))

(add-hook 'org-capture-after-finalize-hook 'my-org-capture-cleanup)

;;; --- Outline Mode
(add-hook
 'outline-minor-mode-hook
 (lambda ()
   (define-key outline-minor-mode-map [backtab] 'outline-cycle-buffer)
   (define-key
    outline-minor-mode-map (kbd "C-c C-n") 'outline-next-visible-heading)
   (define-key
    outline-minor-mode-map (kbd "C-c C-p") 'outline-previous-visible-heading)
   (define-key
    outline-minor-mode-map (kbd "C-c C-f") 'outline-forward-same-level)
   (define-key
    outline-minor-mode-map (kbd "C-c C-b") 'outline-backward-same-level)
   (define-key outline-minor-mode-map (kbd "C-c C-u") 'outline-up-heading)
   (define-key outline-minor-mode-map (kbd "C-c C-a") 'outline-show-all)
   (define-key
    outline-minor-mode-map (kbd "C-c ?") 'bh/outline-show-heading-path)
   (define-key outline-minor-mode-map (kbd "C-c C-c C-a") 'outline-show-all)
   (define-key outline-minor-mode-map (kbd "<f1>") 'outline-toggle-children)

   (setq-local outline-minor-mode-use-buttons 'in-margins)
   (setq-local outline-minor-mode-highlight 'append)
   (setq-local outline-minor-mode-cycle t)))
;;; --- Auto Dark Mode
;; I stole this from
;; https://github.com/LionyxML/auto-dark-emacs/blob/master/auto-dark.el
(setq my/themes '(modus-operandi modus-vivendi))
(defun my/set-auto-theme (value)
  "Set the theme according to the D-Bus theme argument"
  (pcase value
    (2 (load-theme (car my/themes))) ;; Light theme
    (1 (load-theme (cadr my/themes))) ;; Dark theme
    ))

(defun my/get-current-system-theme ()
  "Use Emacs built-in D-Bus function to determine if dark theme is enabled."
  (caar
   (dbus-ignore-errors
    (dbus-call-method
     :session
     "org.freedesktop.portal.Desktop"
     "/org/freedesktop/portal/desktop"
     "org.freedesktop.portal.Settings"
     "Read"
     "org.freedesktop.appearance"
     "color-scheme"))))
(my/set-auto-theme (my/get-current-system-theme))
(defun auto-dark--register-dbus-listener ()
  "Register a callback function with D-Bus.
Ask D-Bus to send us a signal on theme change and add a callback
to change the theme."
  (dbus-register-signal
   :session
   "org.freedesktop.portal.Desktop"
   "/org/freedesktop/portal/desktop"
   "org.freedesktop.portal.Settings"
   "SettingChanged"
   (lambda (path var val)
     (when (and (string= path "org.freedesktop.appearance")
                (string= var "color-scheme"))
       (message "System theme changed")
       (my/set-auto-theme (caar val))))))
(auto-dark--register-dbus-listener)
