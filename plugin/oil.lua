vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

local oil = require("oil")

-- Configura o Oil para ser o explorador padrão e mostrar arquivos ocultos (.config, .env)
oil.setup({
	default_file_explorer = true,
	view_options = { show_hidden = true },
})

-- Atalho: Aperte Espaço + o (letra O) para abrir as pastas
vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Abrir pastas" })
