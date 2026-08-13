local gitsigns = require("gitsigns")

gitsigns.setup({
    signcolumn = true,
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set("n", "<leader>gp", gs.preview_hunk, {
            buffer = bufnr,
            desc = "Preview do hunk",
        })
    end,
})
