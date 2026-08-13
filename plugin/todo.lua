local todo = require("todo-comments")

todo.setup({
    signs = true,
})

vim.keymap.set("n", "<leader>ft", function()
    require("snacks").picker.todo_comments()
end, { desc = "Buscar TODOs" })
