local pairs = require("mini.pairs")
local jump2d = require("mini.jump2d")

pairs.setup({
    modes = { insert = true, command = false, terminal = false },
})

jump2d.setup({
    labels = "asdfghjklqwertyuiopzxcvbnm",
    view = {
        dim = false,
        n_steps_ahead = 1,
    },
    allowed_windows = {
        current = true,
        not_current = true,
    },
    mappings = {
        start_jumping = "",
    },
})

local modes = { "n", "x", "o" }

vim.keymap.set(
    modes,
    "<leader>jj",
    "<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<CR>",
    { silent = true, desc = "Jump2d início de palavra" }
)

vim.keymap.set(
    modes,
    "<leader>jl",
    "<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.line_start)<CR>",
    { silent = true, desc = "Jump2d início de linha" }
)

vim.keymap.set(
    modes,
    "<leader>jc",
    "<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
    { silent = true, desc = "Jump2d caractere" }
)
