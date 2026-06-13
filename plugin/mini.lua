vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })

local pairs = require("mini.pairs")

pairs.setup({
	modes = { insert = true, command = false, terminal = false },
})
