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

-- Highlighting + indentação num único autocmd (sem duplicação de lista)
local ts_filetypes = {
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
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = ts_filetypes,
	callback = function()
		vim.treesitter.start()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
