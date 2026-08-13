local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = {
        timeout_ms = 500,
        quiet = false,
    },
})
