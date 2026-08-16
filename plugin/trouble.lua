local trouble = require("trouble")

trouble.setup({})

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<cr>", {
    silent = true,
    desc = "Trouble diagnósticos",
})

vim.keymap.set("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>", {
    silent = true,
    desc = "Trouble diagnósticos do buffer",
})

vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=true<cr>", {
    silent = true,
    desc = "Trouble símbolos",
})

vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle focus=true<cr>", {
    silent = true,
    desc = "Trouble quickfix",
})
