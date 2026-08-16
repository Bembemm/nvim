vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

-- Básicos
keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Salvar arquivo" })
keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Sair" })
keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Sair forçado" })
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Limpar busca" })

-- Janelas
keymap.set("n", "<leader><Left>", "<C-w>h", { desc = "Janela à esquerda" })
keymap.set("n", "<leader><Down>", "<C-w>j", { desc = "Janela abaixo" })
keymap.set("n", "<leader><Up>", "<C-w>k", { desc = "Janela acima" })
keymap.set("n", "<leader><Right>", "<C-w>l", { desc = "Janela à direita" })

-- Plugins
keymap.set("n", "<leader>pu", function()
    vim.pack.update()
end, { desc = "Atualizar plugins" })

-- Buffers
keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Fechar buffer" })
keymap.set("n", "<leader>bo", function()
    local current = vim.api.nvim_get_current_buf()

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
            pcall(vim.api.nvim_buf_delete, buf, { force = false })
        end
    end
end, { desc = "Fechar outros buffers" })

-- Visual
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover seleção para baixo" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover seleção para cima" })
keymap.set("v", "<", "<gv", { silent = true, desc = "Indentar para esquerda" })
keymap.set("v", ">", ">gv", { silent = true, desc = "Indentar para direita" })
keymap.set("v", "D", "yP", { desc = "Duplicar seleção" })

-- Terminal
keymap.set("t", "<Esc>", "<C-\\><C-N>", { desc = "Sair do modo terminal" })
