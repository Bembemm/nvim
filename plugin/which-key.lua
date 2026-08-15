local wk = require("which-key")

wk.setup({
    preset = "modern",
    delay = 200,
    triggers = {
        { "<leader>", mode = "n" },
    },
    win = {
        border = "rounded",
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
    },
    icons = {
        mappings = true,
    },
})

wk.add({
    { "<leader>b", group = "Buffers" },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>h", group = "Harpoon" },
    { "<leader>l", group = "LSP" },
    { "<leader>p", group = "Plugins" },
    { "<leader>r", group = "Run" },
    { "<leader><Left>", desc = "Janela à esquerda" },
    { "<leader><Down>", desc = "Janela abaixo" },
    { "<leader><Up>", desc = "Janela acima" },
    { "<leader><Right>", desc = "Janela à direita" },
})

vim.keymap.set("n", "<leader>?", function()
    wk.show({ global = false })
end, { desc = "Keymaps do buffer" })
