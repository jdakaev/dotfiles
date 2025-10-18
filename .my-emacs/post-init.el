;;; post-init.el --- DESCRIPTION -*- no-byte-compile: t; lexical-binding: t; -*-

(mapc #'disable-theme custom-enabled-themes)  ; Disable all active themes
(load-theme 'modus-operandi-tinted t)  ; Load the built-in theme

;; Set the default font to DejaVu Sans Mono with specific size and weight
(set-face-attribute 'default nil
                    :height 130 :weight 'normal :family "Hack")

;; Native compilation enhances Emacs performance by converting Elisp code into
;; native machine code, resulting in faster execution and improved
;; responsiveness.
;;
;; Ensure adding the following compile-angel code at the very beginning
;; of your `~/.emacs.d/post-init.el` file, before all other packages.
(use-package compile-angel
  :diminish compile-angel-on-load-mode
  :ensure t
  :custom
  ;; Set `compile-angel-verbose` to nil to suppress output from compile-angel.
  ;; Drawback: The minibuffer will not display compile-angel's actions.
  (compile-angel-verbose t)

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
;; Vertico provides a vertical completion interface, making it easier to
;; navigate and select from completion candidates (e.g., when `M-x` is pressed).
(use-package vertico
  ;; (Note: It is recommended to also enable the savehist package.)
  :ensure t
  :config
  (vertico-mode))

;; Vertico leverages Orderless' flexible matching capabilities, allowing users
;; to input multiple patterns separated by spaces, which Orderless then
;; matches in any order against the candidates.
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Marginalia allows Embark to offer you preconfigured actions in more contexts.
;; In addition to that, Marginalia also enhances Vertico by adding rich
;; annotations to the completion candidates displayed in Vertico's interface.
(use-package marginalia
  :ensure t
  :commands (marginalia-mode marginalia-cycle)
  :hook (after-init . marginalia-mode))

;; Embark integrates with Consult and Vertico to provide context-sensitive
;; actions and quick access to commands based on the current selection, further
;; improving user efficiency and workflow within Emacs. Together, they create a
;; cohesive and powerful environment for managing completions and interactions.
(use-package embark
  ;; Embark is an Emacs package that acts like a context menu, allowing
  ;; users to perform context-sensitive actions on selected items
  ;; directly from the completion interface.
  :ensure t
  :commands (embark-act
             embark-dwim
             embark-export
             embark-collect
             embark-bindings
             embark-prefix-help-command)
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Consult offers a suite of commands for efficient searching, previewing, and
;; interacting with buffers, file contents, and more, improving various tasks.
(use-package consult
  :ensure t
  :bind (;; C-c bindings in `mode-specific-map'
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
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))

  ;; Enable automatic preview at point in the *Completions* buffer.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  :init
  ;; Optionally configure the register formatting. This improves the register
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
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
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"))
(defun my/org-jump-skipping-drawer ()
               (interactive)
               (org-fold-show-entry)
               (org-end-of-meta-data t)
               (if (org-at-heading-p)
                   (progn (insert "\n") (move-point-visually -1)))
               )
(defun my/refile-to-tasks ()
  (interactive)
  (if
      (org-at-heading-p)
      nil
    (display-warning :warning "Not at org heading"
    ())))

(use-package org
  :config
  (setq org-cycle-hide-drawer-startup nil)
  (setq org-refile-targets '((my/org-refile-helper . (:maxlevel . 1))))
  (setq org-special-ctrl-a/e t)
  (setq org-todo-keywords '((type "TODO" "|" "DONE")))
  (setq org-agenda-files (list "~/notes/todo.org" "~/notes/daily.org" "~/notes/school.org" "~/notes/inbox.org"))
  (setq org-agenda-prefix-format '(
                                   (todo . " ")
                                   (agenda . " %i %-12:c%?-12t% s")))
  (setq org-agenda-show-all-dates nil)
  (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-agenda-show-future-repeats nil)
  ;; https://github.com/rougier/emacs-gtd
  (setq org-agenda-custom-commands
        '(("g" "GTD"
           ((todo "TODO"
                 ((org-agenda-skip-function
                   '(org-agenda-skip-entry-if 'deadline))
                  (org-agenda-prefix-format "[%e] ")
                  (org-agenda-overriding-header "Tasks")
                  (org-agenda-max-todos 10)))
           (agenda ""
                    ((org-agenda-skip-function
                      '(org-agenda-skip-entry-if 'deadline))
                     (org-deadline-warning-days 0)))
            (tags-todo "CATEGORY=\"school\""
                       ((org-agenda-skip-function
                         '(org-agenda-skip-entry-if 'deadline))
                        (org-agenda-prefix-format "[%e] ")
                        (org-agenda-overriding-header "School")
                        (org-agenda-max-todos 10)))
            ;; Deadline display?
            (tags-todo "CATEGORY=\"inbox\""
                       ((org-agenda-prefix-format "  %?-12t% s")
                        (org-agenda-overriding-header "Inbox")))
            (tags "CLOSED>=\"<today>\""
                  ((org-agenda-overriding-header "Completed today"))
                  )))
          ("n" "Not Home"
           ((agenda "")
            (tags-todo "@home")
            (tags "garden")))

          ("h" "Not Home"
           (todo "TODO"))

          ("s" "School"
           ((agenda "")
            (tags-todo "@home")
            (tags "garden")))
          ))
      (setq org-capture-templates
           '(("t" "Todo" entry (file "~/notes/inbox.org")
              "* TODO %?\n  %i\n ")
             ("j" "Journal" entry (file+datetree "~/notes/journal.org")
              "* %?\nEntered on %U\n  %i\n  %a")
             ("c" "Current clocking task notes" entry (clock)
              "* %i")))
  :hook
  (org-mode . org-indent-mode)
  (org-mode . visual-line-mode)
  (org-mode . (lambda ()
                (setq-local tab-width 8)))
;;   (org-mode . #(setq-local tab-width 8))
  :bind ("C-c a" . org-agenda)
  ("C-c 1" . org-cycle-list-bullet)
  ("C-c p" . org-capture)
  ("C-c c" . org-clock-goto)
  ("C-c s" . org-store-link)
  ("C-c l" . org-insert-last-stored-link)
  ("C-c n" . my/org-jump-skipping-drawer)
  )

(use-package org-krita
  :ensure t
  :vc (:url "https://github.com/lepisma/org-krita")
  :hook
  (org-mode . org-krita-mode))

(use-package org-mem
  :defer
  :config
  ;; At least one of these two is needed
  (setq org-mem-do-sync-with-org-id t)
  (setq org-mem-watch-dirs
        (list "~/notes")) ;; Configure me
  (org-mem-updater-mode))

(use-package org-node
  :init
  ;; Optional key bindings
  ;; Tip: Try changing these to just "M-o"!
  (keymap-global-set "M-p" org-node-global-prefix-map)
  (with-eval-after-load 'org
    (keymap-set org-mode-map "M-p" org-node-org-prefix-map))
  :config
  (org-node-cache-mode))

(use-package olivetti
  :defer t
  :hook org-mode)

(use-package markdown-mode
  :hook (markdown-mode . visual-line-mode)
  :defer t)

;; trying to figure out how to change default file open options
(defun my-open-file (file)
  (interactive)
  (
   (message "foo")
   (message "bar")
  ))

(use-package telega
  :config
  (setq telega-server-libs-prefix "/usr")
  (setq telega-emoji-use-images nil)
  (setq telega-file-open-function 'org-open-file)
  (setq org-id-link-to-org-use-id t)
  :bind-keymap
  ("C-c t" . telega-prefix-map)
  :hook
  (telega-root-mode . visual-line-mode)
  (telega-chat-mode . company-mode)
  (telega-chat-mode . telega-squash-message-mode)
  :defer t)
(use-package company
  :defer t)


(use-package gptel
  :bind ("C-c g m" . gptel-menu)
  ("C-c g r" . gptel-rewrite )
  ("C-c g s" . gptel-send ))

;; from karthinks on window management
(repeat-mode)
(keymap-global-set "M-o" 'other-window)

;; recentf stuff
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
