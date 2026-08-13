vim.pack.add({ "https://github.com/folke/which-key.nvim" })

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
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>h", group = "Harpoon" },
    { "<leader>l", group = "LSP" },
    { "<leader>p", group = "Plugins" },
})

vim.keymap.set("n", "<leader>?", function()
    wk.show({ global = false })
end, { desc = "Keymaps do buffer" })
