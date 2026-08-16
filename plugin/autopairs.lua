local autopairs = require("nvim-autopairs")

autopairs.setup({
    disable_filetype = {
        "TelescopePrompt",
        "spectre_panel",
        "snacks_picker_input",
        "snacks_input",
        "snacks_dashboard",
        "noice",
        "dap-repl",
    },
    disable_in_macro = true,
    disable_in_visualblock = false,
    disable_in_replace_mode = true,
    enable_moveright = true,
    enable_afterquote = true,
    enable_check_bracket_line = true,
    enable_bracket_in_quote = true,
    break_undo = true,
    check_ts = true,
    map_cr = true,
    map_bs = true,
    map_c_h = true,
    map_c_w = true,
    fast_wrap = {},
})

vim.keymap.set("n", "<leader>pa", function()
    autopairs.toggle()
end, { desc = "Alternar autopairs" })
