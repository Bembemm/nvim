vim.pack.add({ "https://github.com/folke/snacks.nvim" })

local snacks = require("snacks")

snacks.setup({
	-- Ativa o motor do Picker (substituto do Telescope)
	picker = { enabled = true },
	notifier = { enabled = true },
	-- 1. O motor de imagens
	image = {
		enabled = true,
		force = true,
		doc = { enabled = true, inline = true, float = true },
	},

	-- 2. A Dashboard Avançada de 2 colunas
	dashboard = {
		enabled = true,
		sections = {
			{ section = "header" },
			{
				pane = 2,
				section = "terminal",
				cmd = "/usr/sbin/colorscript -e square",
				height = 5,
				padding = 1,
			},
			{ section = "keys", gap = 1, padding = 1 },
			{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
			{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
			{
				pane = 2,
				icon = " ",
				title = "Git Status",
				section = "terminal",
				enabled = function()
					return snacks.git.get_root() ~= nil
				end,
				cmd = "git status --short --branch --renames",
				height = 5,
				padding = 1,
				ttl = 5 * 60,
				indent = 3,
			},
		},
		preset = {
			keys = {
				-- Usando funções diretas em vez de strings de comando
				{
					icon = " ",
					key = "f",
					desc = "Buscar Arquivo",
					action = function()
						require("snacks").picker.files()
					end,
				},
				{ icon = " ", key = "n", desc = "Novo Arquivo", action = ":ene | startinsert" },
				{
					icon = " ",
					key = "g",
					desc = "Buscar Texto",
					action = function()
						require("snacks").picker.grep()
					end,
				},
				{
					icon = " ",
					key = "r",
					desc = "Arquivos Recentes",
					action = function()
						require("snacks").picker.recent()
					end,
				},
				{
					icon = " ",
					key = "c",
					desc = "Configurações",
					action = function()
						require("snacks").picker.files({ cwd = "~/.config/nvim" })
					end,
				},
				{ icon = "󰒲 ", key = "q", desc = "Sair", action = ":qa" },
			},
		},
	},
})

-- KEYMAPS: Injetando require("snacks") direto na veia para evitar falha de variável global
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
