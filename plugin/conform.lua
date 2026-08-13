local conform = require("conform")

local formatters = {}
local stylua = vim.fn.exepath("stylua")
local clang_format = vim.fn.exepath("clang-format")

if stylua ~= "" then
    formatters.stylua = { command = stylua }
end

if clang_format ~= "" then
    formatters["clang-format"] = { command = clang_format }
end

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        cpp = { "clang-format" },
    },
    formatters = formatters,
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = {
        timeout_ms = 500,
        quiet = false,
    },
})
