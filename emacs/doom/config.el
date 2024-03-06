;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jonas Trantina"
      user-mail-address "trantina.jonas@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq evil-escape-key-sequence "fd")
;; using mm height seems backwards but it works for my current setups, it should
;; use resolution or DPI but I couldn't make that work
(setq doom-font (font-spec :family "FiraCode Nerd Font Ret" :size 15))

(setq evil-snipe-scope 'buffer)

(setq-default show-trailing-whitespace t)
(setq imenu-max-item-length 120)
(setq-default fill-column 100)

;; delete other window via ace
(map! :leader
      :desc "ace-delete-window"
      "w D" #'ace-delete-window)

;; switch windows with SPC-number
(map! :after winum :leader
      :n "0" #'treemacs-select-window
      :n "1" #'winum-select-window-1
      :n "2" #'winum-select-window-2
      :n "3" #'winum-select-window-3
      :n "4" #'winum-select-window-4
      :n "5" #'winum-select-window-5
      :n "6" #'winum-select-window-6
      :n "7" #'winum-select-window-7
      :n "8" #'winum-select-window-8
      :n "9" #'winum-select-window-9)

(map! :after projectile :leader
      :desc "toggle impl and test"
      "f t" #'projectile-toggle-between-implementation-and-test)
(defun run-credo-checker ()
  (interactive)
  ;;; Place your code below this line, but inside the bracket.
  (flycheck-compile 'elixir-credo)
  )

(map! :after elixir-mode :map elixir-mode-map :desc "credo" :localleader "C" #'run-credo-checker)
(map! :map flycheck :desc "Show all flychecks" :leader "cX" #'flycheck-list-errors)

;; Add missing helm mapping to open stuff in other window
(map! :map helm-map :desc "Open thing in other window" "C-c o" #'helm-ff-run-switch-other-window)
(map! :map helm-map :desc "Open thing in other window" "C-c C-o" #'helm-ff-run-switch-other-window)
;; And open in split to the right
(setq helm-split-window-default-side 'right)
(setq helm-split-window-other-side-when-one-window 'right)
(setq helm-window-prefer-horizontal-split t)

;; LSP and elixir stuff
(setq lsp-elixir-mix-env "dev")
(setq lsp-elixir-dialyzer-enabled nil)
;; (setq lsp-enable-file-watchers nil)
;; (add-hook 'lsp-after-initialize-hook
;;           (lambda ()
;;             (flycheck-add-next-checker 'lsp 'elixir-credo)))
;; (add-hook 'elixir-mode-hook
;;           (lambda ()
;;             (setq-local flycheck-check-syntax-automatically '(mode-enabled save))
;;             (setq lsp-flycheck-live-reporting nil)))


;; Set custom JS formatting rules
(setq lsp-javascript-format-insert-space-before-function-parenthesis t)
(setq lsp-javascript-format-insert-space-after-opening-and-before-closing-nonempty-braces t)
(setq lsp-javascript-format-insert-space-after-opening-and-before-closing-nonempty-parenthesis nil)
(setq lsp-javascript-format-insert-space-after-opening-and-before-closing-jsx-expression-braces t)

;; Enable auto-formatting only for the modes where it doesn' cause any issues, e.g.:
;; - Elixir
;; - JS - we now use ts-ls formatter
;; Since (format +onsave) doesn't work well now (it uses non-lsp formatter) this should od the same
;; (setq +format-on-save-enabled-modes '(elixir-mode rjsx-mode))
(add-hook! elixir-mode (add-hook 'before-save-hook 'lsp-format-buffer nil t))
(add-hook! rjsx-mode (add-hook 'before-save-hook 'lsp-format-buffer nil t))

;; Magit sort branches by last commit date
(setq magit-list-refs-sortby "-committerdate")

;; Add our Gitlab server
(with-eval-after-load 'forge
  (add-to-list 'forge-alist '("gitlab.dev.altworx.com" "gitlab.dev.altworx.com/api/v4" "gitlab.dev.altworx.com" forge-gitlab-repository))
  (add-to-list 'forge-alist '("gitlab.altworx" "gitlab.dev.altworx.com/api/v4" "gitlab.altworx" forge-gitlab-repository)))
(with-eval-after-load 'browse-at-remote
  (add-to-list 'browse-at-remote-remote-type-regexps '(:host "^gitlab\\.dev\\.altworx\\.com$" :type "gitlab"))
  (add-to-list 'browse-at-remote-remote-type-regexps '(:host "^gitlab\\.altworx$" :type "gitlab" :actual-host "gitlab.dev.altworx.com")))
(setq-default eglot-workspace-configuration
              '((:elixirLS :mixEnv "dev" :dialyzerEnabled :json-false)))

;; Enable flyspell everywhere!
(add-hook 'text-mode-hook
          (lambda () (flyspell-mode 1)))

(add-to-list 'doom-detect-indentation-excluded-modes 'elixir-mode)

;; Enable company numbers
(setq company-show-numbers 'left)

;; Exclude _ from word separators in Elixir
;; change to 'after-change-major-mode ti set it everywhere
(add-hook 'elixir-mode-hook (lambda ()
                              (modify-syntax-entry ?_ "w")))
;; And add dabbrev company - doesn't work, the variable keeps getting edited by someone else
;; (add-hook 'elixir-mode-hook
;;           (lambda () (add-hook 'company-mode-hook
;;                                (lambda ()
;;                                  (setq-local company-backends '((:separate company-capf company-yasnippet company-dabbrev)))))))
(use-package! xclip
  :config
  (setq xclip-program "wl-copy")
  (setq xclip-select-enable-clipboard t)
  (setq xclip-mode t)
  (setq xclip-method (quote wl-copy)))
