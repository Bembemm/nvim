local executable = require("core.executable")

vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        cpp = { "clang-format" },
    },
    formatters = {
        stylua = {
            command = function()
                return executable.find({
                    names = "stylua",
                    env = "STYLUA_PATH",
                })
            end,
        },
        ["clang-format"] = {
            command = function()
                return executable.find({
                    names = "clang-format",
                    env = "CLANG_FORMAT_PATH",
                    extra_paths = {
                        "/opt/homebrew/opt/llvm/bin/clang-format",
                        "/usr/local/opt/llvm/bin/clang-format",
                    },
                })
            end,
        },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = {
        timeout_ms = 500,
        quiet = false,
    },
})
