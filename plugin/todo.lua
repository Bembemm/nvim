vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })

local todo = require("todo-comments")

todo.setup({
	signs = true,
})

-- Usa snacks.picker (já instalado) em vez de Telescope que não está na config
vim.keymap.set("n", "<leader>ft", function()
	require("snacks").picker.grep({ search = "TODO|FIXME|HACK|NOTE|PERF|WARN" })
end, { desc = "Buscar TODOs" })
