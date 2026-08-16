local scrollview = require("scrollview")

if vim.fn.exists("+mousemoveevent") == 1 then
    vim.opt.mousemoveevent = true
end

scrollview.setup({
    current_only = false,
    excluded_filetypes = {
        "snacks_dashboard",
        "snacks_picker_input",
        "snacks_input",
        "Trouble",
        "oil",
        "noice",
        "notify",
        "help",
        "qf",
        "dropbar_menu",
        "dropbar_menu_fzf",
    },
    signs_on_startup = { "all" },
    diagnostics_severities = {
        vim.diagnostic.severity.ERROR,
        vim.diagnostic.severity.WARN,
        vim.diagnostic.severity.INFO,
        vim.diagnostic.severity.HINT,
    },
})

require("scrollview.contrib.gitsigns").setup({
    enabled = true,
    hide_full_add = true,
    only_first_line = false,
})

vim.keymap.set("n", "<leader>vt", "<cmd>ScrollViewToggle<cr>", {
    silent = true,
    desc = "Scrollview toggle",
})

vim.keymap.set("n", "<leader>vl", "<cmd>ScrollViewLegend<cr>", {
    silent = true,
    desc = "Scrollview legenda",
})

vim.keymap.set("n", "<leader>vj", "<cmd>ScrollViewNext<cr>", {
    silent = true,
    desc = "Scrollview próximo sinal",
})

vim.keymap.set("n", "<leader>vk", "<cmd>ScrollViewPrev<cr>", {
    silent = true,
    desc = "Scrollview sinal anterior",
})

vim.keymap.set("n", "<leader>vf", "<cmd>ScrollViewFirst<cr>", {
    silent = true,
    desc = "Scrollview primeiro sinal",
})

vim.keymap.set("n", "<leader>ve", "<cmd>ScrollViewLast<cr>", {
    silent = true,
    desc = "Scrollview último sinal",
})

vim.keymap.set("n", "<leader>vr", "<cmd>ScrollViewRefresh<cr>", {
    silent = true,
    desc = "Scrollview atualizar",
})
