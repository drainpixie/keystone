(local {: g : opt : colorscheme} (require :core))
(local indent-width 2)

;; indentation
(opt :expandtab true)
(opt :smartindent true)
(opt :tabstop indent-width)
(opt :shiftwidth indent-width)
(opt :softtabstop indent-width)

;; line number
(opt :number true)
(opt :relativenumber true)

;; swap
(opt :swapfile true)
(opt :backup false)
(opt :undofile true)

;; search
(opt :hlsearch true)
(opt :incsearch true)

;; style
(opt :bg :light)
(opt :wrap true)
(opt :linebreak true)
(colorscheme :default)

;; misc
(g :mapleader " ")
(opt :autoread true)
(opt :lazyredraw true)
(opt :clipboard :unnamedplus)
