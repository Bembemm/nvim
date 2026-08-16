require("satellite").setup({
    current_only = false,
    winblend = 35,
    zindex = 40,
    width = 1,
    excluded_filetypes = {
        "snacks_dashboard",
        "Trouble",
        "oil",
        "noice",
        "notify",
        "help",
        "qf",
    },
    handlers = {
        cursor = {
            enable = true,
        },
        search = {
            enable = true,
        },
        diagnostic = {
            enable = true,
            signs = { "-", "=", "≡" },
            min_severity = vim.diagnostic.severity.HINT,
        },
        gitsigns = {
            enable = true,
            signs = {
                add = "│",
                change = "│",
                delete = "-",
            },
        },
        marks = {
            enable = true,
            key = "m",
            show_builtins = false,
        },
        quickfix = {
            enable = true,
            signs = { "-", "=", "≡" },
        },
    },
})
