;;; smartparens-elixir.el --- Configuration for Elixir.  -*- lexical-binding: t; -*-

;; Copyright (C) 2017 Matúš Goljer

;; Author: Matúš Goljer <matus.goljer@gmail.com>
;; Maintainer: Matúš Goljer <matus.goljer@gmail.com>
;; Version: 0.0.1
;; Created: 15th January 2017
;; Keywords: languages

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'smartparens)

(--each '(elixir-mode)
  (add-to-list 'sp-sexp-suffix (list it 'regexp "")))

(defun keyword-do-p (a b c)
  (if (equal a "do")
      (looking-at "do:")))

(defun heredoc-p (a b c)
  (save-excursion
    (backward-char)
    (looking-at "\"\"\"")))

(sp-with-modes 'elixir-mode
  (sp-local-pair "\"" "\""
		 :skip-match 'heredoc-p)
  
  (sp-local-pair "\"\"\"" "\"\"\""
		 :when '(("RET" "<evil-ret>")))

  (sp-local-pair "do" "end"
                 :when '(("SPC" "RET" "<evil-ret>"))
                 :unless '(sp-in-comment-p sp-in-string-p)
		 :skip-match 'keyword-do-p)

  (sp-local-pair "fn" "end"
		 :when '(("SPC" "RET" "<evil-ret>"))
                 :unless '(sp-in-comment-p sp-in-string-p)))

(provide 'smartparens-elixir)
;;; smartparens-elixir.el ends here
