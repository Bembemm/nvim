vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})
require("nvim-treesitter").install({
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"markdown",
	"css",
	"html",
	"javascript",
	"latex",
	"scss",
	"svelte",
	"tsx",
	"typst",
	"vue",
	"regex",
})

-- Highlighting
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"css",
		"html",
		"javascript",
		"latex",
		"scss",
		"svelte",
		"tsx",
		"typst",
		"vue",
		"regex",
	},
	callback = function()
		vim.treesitter.start()
	end,
})

-- Indentação (experimental)
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"css",
		"html",
		"javascript",
		"latex",
		"scss",
		"svelte",
		"tsx",
		"typst",
		"vue",
		"regex",
	},
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
