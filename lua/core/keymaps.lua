-- Define o espaço como tecla Leader
vim.g.mapleader = " "

local keymap = vim.keymap

-- Atalhos básicos
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Salvar arquivo" })
keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Sair" })
keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Limpar highlight de busca" })
-- Mostra a janela flutuante com o erro/diagnóstico da linha
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Mostrar erro detalhado" })
