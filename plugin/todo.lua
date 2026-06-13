vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })
local todo = require("todo-comments")
todo.setup({
	signs = true,
})
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Buscar TODOs" })
