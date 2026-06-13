vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

local gitsigns = require("gitsigns")

gitsigns.setup({
	-- Puxa o fundo transparente para casar com o seu vidro fosco (neovide)
	signcolumn = true,

	-- Configura um atalho extra que só funciona dentro de arquivos do Git
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		-- Atalho: Aperte Espaço + gp (Git Preview) para ver o que você apagou/mudou naquela linha
		vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr, desc = "Preview Git Hunk" })
	end,
})
