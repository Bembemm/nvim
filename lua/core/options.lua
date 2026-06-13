local opt = vim.opt

-- Fonte (Neovide/GUI)
vim.opt.guifont = "Iosevka Nerd Font:h14"

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
opt.signcolumn = "yes" -- evita o texto "pular" quando sinais aparecem
opt.numberwidth = 2
opt.winborder = "rounded" -- bordas arredondadas em todas as floats (0.11+)
opt.scrolloff = 8 -- mantém 8 linhas acima/abaixo do cursor

-- Busca
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "nosplit" -- preview ao vivo de :s/old/new

-- Arquivos
opt.swapfile = false
opt.undofile = true -- persiste o histórico de undo entre sessões

-- Performance
opt.updatetime = 50 -- reduz latência do LSP e gitsigns

-- Clipboard
opt.clipboard = "unnamedplus"

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Caracteres invisíveis (útil para debug de formatação)
opt.listchars = "tab:→ ,trail:·,eol:↵"
opt.list = true

-- Tempo limite para sequências de teclas
opt.timeoutlen = 1000
