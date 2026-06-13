-- Define o espaço como tecla Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Impede que o espaço sozinho mova o cursor
vim.keymap.set({ "n", "v" }, "<space>", "<Nop>", { silent = true })

local keymap = vim.keymap

-- Básicos
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Salvar arquivo" })
keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Sair" })
keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Limpar highlight de busca" })
keymap.set("n", "<leader>p", "<cmd>lua vim.pack.update()<CR>", { desc = "Atualizar plugins" })

-- Diagnóstico
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Mostrar erro detalhado" })
keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Próximo diagnóstico" })
keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Diagnóstico anterior" })

-- Buffers
keymap.set("n", "<leader>fb", "<cmd>bd<CR>", { desc = "Fechar buffer" })
keymap.set("n", "<leader>fba", ":%bd|e#|bd#<CR>", { desc = "Fechar todos exceto atual" })

-- Modo visual: mover seleção
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover seleção para baixo" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover seleção para cima" })

-- Modo visual: indentar mantendo seleção
keymap.set("v", "<", "<gv", { noremap = true, silent = true, desc = "Indentar para esquerda" })
keymap.set("v", ">", ">gv", { noremap = true, silent = true, desc = "Indentar para direita" })

-- Modo visual: duplicar seleção
keymap.set("v", "D", "yP", { desc = "Duplicar seleção" })

-- Terminal: sair do modo insert com Esc
keymap.set("t", "<Esc>", "<C-\\><C-N>", { desc = "Sair do modo terminal" })
