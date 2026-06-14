vim.pack.add({ "https://github.com/folke/snacks.nvim" })

local snacks = require("snacks")

snacks.setup({
	picker = { enabled = true },
	notifier = { enabled = true },
	image = {
		enabled = true,
		force = true,
		doc = { enabled = true, inline = true, float = true },
	},
	-- Dashboard removido
})

-- KEYMAPS
vim.keymap.set("n", "<leader>f", function()
	require("snacks").picker.files()
end, { desc = "Snacks: Buscar Arquivos" })
vim.keymap.set("n", "<leader>g", function()
	require("snacks").picker.grep()
end, { desc = "Snacks: Buscar Texto (Grep)" })
vim.keymap.set("n", "<leader>b", function()
	require("snacks").picker.buffers()
end, { desc = "Snacks: Listar Buffers" })
vim.keymap.set("n", "<leader>r", function()
	require("snacks").picker.recent()
end, { desc = "Snacks: Arquivos Recentes" })
vim.keymap.set("n", "<leader>c", function()
	require("snacks").picker.commands()
end, { desc = "Snacks: Comandos do Neovim" })
vim.keymap.set("n", "<leader><space>", function()
	require("snacks").picker.pick()
end, { desc = "Snacks: Abrir Menu Geral" })

vim.keymap.set("n", "<leader>i", function()
	require("snacks").image.hover()
end, { desc = "Snacks: Ver Imagem" })
