vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    {
        src = "https://github.com/ThePrimeagen/harpoon",
        version = "harpoon2",
    },
})

local harpoon = require("harpoon")

harpoon:setup({
    settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
    },
})

harpoon:extend({
    UI_CREATE = function(cx)
        vim.keymap.set("n", "<C-v>", function()
            harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr, desc = "Abrir em split vertical" })

        vim.keymap.set("n", "<C-x>", function()
            harpoon.ui:select_menu_item({ split = true })
        end, { buffer = cx.bufnr, desc = "Abrir em split horizontal" })
    end,
})

local function list()
    return harpoon:list()
end

vim.keymap.set("n", "<leader>ha", function()
    list():add()
end, { desc = "Adicionar arquivo" })

local function open_menu()
    harpoon.ui:toggle_quick_menu(list())
end

vim.keymap.set("n", "<leader>hm", open_menu, { desc = "Abrir menu" })
vim.keymap.set("n", "<C-e>", open_menu, { desc = "Harpoon: Menu rápido" })

for i = 1, 4 do
    vim.keymap.set("n", "<C-" .. i .. ">", function()
        list():select(i)
    end, { desc = "Harpoon: Ir para arquivo " .. i })
end

vim.keymap.set("n", "<leader>hn", function()
    list():next()
end, { desc = "Próximo arquivo" })

vim.keymap.set("n", "<leader>hp", function()
    list():prev()
end, { desc = "Arquivo anterior" })
