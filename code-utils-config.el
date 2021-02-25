(use-package lsp-mode
    :init
    (setq lsp-enable-snippet nil)
    ;; (setq lsp-completion-enable-additional-text-edit nil)
    ;; (setq lsp-eldoc-enable-hover nil)
    (setq lsp-signature-auto-activate nil) ;; you could manually request them via `lsp-signature-activate`
    (setq lsp-signature-render-documentation nil)
    ;; (setq lsp-diagnostics-provider :none) stop it from yelling at you
    (setq lsp-modeline-code-actions-enable nil)
    (setq lsp-completion-show-detail nil)
    (setq lsp-enable-symbol-highlighting nil)
    (setq lsp-headerline-breadcrumb-enable nil)
    (setq lsp-ui-sideline-enable nil)
    (setq lsp-eldoc-enable-hover nil)
    (setq lsp-enable-semantic-highlighting nil)
    (setq read-process-output-max (* 1024 1024)) ;; 1mb
    (setq lsp-idle-delay 0.500)
    (setq gc-cons-threshold 100000000)
    (setq lsp-clients-clangd-executable "/usr/bin/clangd")
    (setq lsp-clients-clangd-args '("-function-arg-placeholders=0"))
    :config
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-tramp-connection "jedi-language-server")
              :major-modes '(python-mode)
              :remote? t
              :server-id 'pyls-remote))
    :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
       (c++-mode . lsp)
       (c-mode . lsp)
       (html-mode . lsp)
       (css-mode . lsp)
       (python-mode . lsp)
       (rjsx-mode . lsp)
       (js-mode . lsp)
       (typescript-mode . lsp)
       ;; if you want which-key integration
       (lsp-mode . lsp-enable-which-key-integration))
    :commands lsp)

(use-package lsp-ui)
(setq lsp-enable-on-type-formatting nil)
(setq lsp-enable-indentation nil)
(use-package ccls
  :after projectile
  :custom
  (ccls-args nil)
  (ccls-executable (executable-find "ccls"))
  (projectile-project-root-files-top-down-recurring
   (append '("compile_commands.json" ".ccls")
           projectile-project-root-files-top-down-recurring))
  :config (push ".ccls-cache" projectile-globally-ignored-directories))

(use-package treemacs
  :config
  (setq treemacs-width 30))

(use-package company
      :ensure t
      :config
      (push '(company-capf :with company-yasnippet) company-backends)
      (setq company-idle-delay 0)
      (setq company-minimum-prefix-length 1)
      ;; Add yasnippet support for all company backends
      ;; https://github.com/syl20bnr/spacemacs/pull/179
      (defvar company-mode/enable-yas t "Enable yasnippet for all backends.")

      (defun company-mode/backend-with-yas (backend)
        (if (or (not company-mode/enable-yas) (and (listp backend)    (member 'company-yasnippet backend)))
            backend
          (append (if (consp backend) backend (list backend))
                  '(:with company-yasnippet))))

      (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends)))
