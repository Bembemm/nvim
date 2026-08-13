vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })

local devicons = require("nvim-web-devicons")

devicons.setup({
	default = true,
	variant = "dark",
	color_icons = true,
	strict = true,
})
