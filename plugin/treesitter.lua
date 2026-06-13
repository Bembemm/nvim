vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install({
	-- Neovim essencial
	"lua",
	"vim",
	"vimdoc",
	"query",
	-- Seu foco
	"python",
	"sql",
	"latex",
	"markdown",
	"regex",
})

local ts_filetypes = {
	"lua",
	"vim",
	"vimdoc",
	"query",
	"python",
	"sql",
	"latex",
	"markdown",
	"regex",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = ts_filetypes,
	callback = function()
		vim.treesitter.start()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
