vim.pack.add({
	"https://github.com/nyoom-engineering/oxocarbon.nvim",
})

-- O Oxocarbon é um tema Dark, então voltamos para o background dark
vim.o.background = "dark"

vim.cmd("colorscheme oxocarbon")
