local snacks = require("snacks")

snacks.setup({
    picker = { enabled = true },
    notifier = { enabled = true },
    image = {
        enabled = true,
        force = true,
        doc = { enabled = true, inline = true, float = true },
    },
})

vim.keymap.set("n", "<leader>ff", function()
    snacks.picker.files()
end, { desc = "Buscar arquivos" })

vim.keymap.set("n", "<leader>fg", function()
    snacks.picker.grep()
end, { desc = "Buscar texto" })

vim.keymap.set("n", "<leader>fr", function()
    snacks.picker.recent()
end, { desc = "Arquivos recentes" })

vim.keymap.set("n", "<leader>fc", function()
    snacks.picker.commands()
end, { desc = "Buscar comandos" })

vim.keymap.set("n", "<leader>fp", function()
    snacks.picker.pick()
end, { desc = "Todos os pickers" })

vim.keymap.set("n", "<leader>bb", function()
    snacks.picker.buffers()
end, { desc = "Listar buffers" })

vim.keymap.set("n", "<leader>i", function()
    snacks.image.hover()
end, { desc = "Visualizar imagem" })
