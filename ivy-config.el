  (use-package ivy
    :diminish
    :init
    (use-package amx :defer t)
    (use-package counsel :diminish :config (counsel-mode 1))
    (use-package swiper :defer t)
    (ivy-mode 1)
    (ivy-prescient-mode 1)
    :bind
    (("C-s"     . swiper-isearch)
     ("M-x"     . counsel-M-x)
     ("C-x C-f" . counsel-find-file)
     ("<f1> f"  . counsel-describe-function)
     ("<f1> v"  . counsel-describe-variable)
     ("<f1> o"  . counsel-describe-symbol)
     ("<f1> l"  . counsel-find-library)
     ("<f2> i"  . counsel-info-lookup-symbol)
     ("<f2> u"  . counsel-unicode-char)
     ("C-c g"   . counsel-git)
     ("C-c o"   . ivy-omni-org)
     ("C-c j"   . counsel-git-grep)
     (:map ivy-minibuffer-map
           ("C-r" . ivy-previous-line-or-history)
           ("M-RET" . ivy-immediate-done))
     (:map counsel-find-file-map
           ("C-~" . counsel-goto-local-home)))
    :custom
    (ivy-use-virtual-buffers t)
    (ivy-height 10)
    (ivy-on-del-error-function nil)
    (ivy-magic-slash-non-match-action 'ivy-magic-slash-non-match-create)
    (ivy-count-format "[%d/%d] ")
    (ivy-wrap t)
    :config
    (defun counsel-goto-local-home ()
        "Go to the $HOME of the local machine."
        (interactive)
      (ivy--cd "~/")))
