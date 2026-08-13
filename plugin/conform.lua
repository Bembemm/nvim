local executable = require("core.executable")

local conform = require("conform")

local formatters = {}

local stylua_cmd = executable.find({
    names = "stylua",
    env = "STYLUA_PATH",
})

if executable.available(stylua_cmd) then
    formatters.stylua = { command = stylua_cmd }
end

local clang_format_cmd = executable.find({
    names = "clang-format",
    env = "CLANG_FORMAT_PATH",
    extra_paths = {
        "/opt/homebrew/opt/llvm/bin/clang-format",
        "/usr/local/opt/llvm/bin/clang-format",
    },
})

if executable.available(clang_format_cmd) then
    formatters["clang-format"] = { command = clang_format_cmd }
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
