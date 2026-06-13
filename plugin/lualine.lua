vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
})

local lualine = require("lualine")

-- Liga a barra de status lá embaixo. O 'theme = auto' faz ela puxar
-- automaticamente as cores daquele tema Gruvbox que configuramos!
lualine.setup({
	options = {
		theme = "auto",
		icons_enabled = true,
	},
})
