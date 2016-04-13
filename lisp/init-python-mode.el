(autoload 'doctest-mode "doctest-mode" "Python doctest editing mode." t)

(setq interpreter-mode-alist
      (cons '("python" . python-mode) interpreter-mode-alist))

(defun python-mode-hook-setup ()
  (unless (is-buffer-file-temp)
    ;; run command `pip install jedi flake8 importmagic` in shell,
    ;; or just check https://github.com/jorgenschaefer/elpy
    (elpy-mode 1)
    (company-mode -1)
    (define-key evil-normal-state-map (kbd "M-.") 'elpy-goto-definition)
    (define-key python-mode-map (kbd "M-,") 'pop-tag-mark)
    ;(add-to-list 'company-backends 'company-jedi)
    ;; http://emacs.stackexchange.com/questions/3322/python-auto-indent-problem/3338#3338
    ;; emacs 24.4 only
    (setq electric-indent-chars (delq ?: electric-indent-chars))
    ))

(add-hook 'python-mode-hook 'python-mode-hook-setup)

;(require 'elpy)
;(elpy-enable)
;(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
;(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
(add-hook 'python-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
;(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--max-line-length=120"))

;; Standard Jedi.el setting
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq jedi:tooltip-method '(pos-tip)) ;popup

(provide 'init-python-mode)
