vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
})

local lualine = require("lualine")

lualine.setup({
	options = {
		theme = "auto",
		icons_enabled = true,
	},
})
