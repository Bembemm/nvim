local opt = vim.opt

-- Fonte (Neovide/GUI)
opt.guifont = "Iosevka Nerd Font:h14"

-- Números de linha
opt.number = true
opt.relativenumber = true

-- Indentação
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.shiftround = true
opt.smartindent = true

-- Aparência
opt.wrap = false
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.numberwidth = 2
opt.winborder = "rounded"
opt.scrolloff = 8

-- Busca
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "nosplit"

-- Arquivos
opt.swapfile = false
opt.undofile = true

-- Responsividade
opt.updatetime = 200
opt.timeoutlen = 500

-- Clipboard
opt.clipboard = "unnamedplus"

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Caracteres invisíveis
opt.listchars = "tab:→ ,trail:·,eol:↵"
opt.list = true
