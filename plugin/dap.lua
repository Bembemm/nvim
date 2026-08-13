local dap = require("dap")
local dap_view = require("dap-view")
local executable = require("core.executable")

dap_view.setup({
    auto_toggle = true,
    winbar = { controls = { enabled = true, position = "right" } },
    virtual_text = { enabled = true, position = "inline" },
})

local function resolve_lldb_dap()
    return executable.find({
        names = { "lldb-dap", "lldb-vscode" },
        env = "LLDB_DAP_PATH",
        extra_paths = {
            "/opt/homebrew/opt/llvm/bin/lldb-dap",
            "/usr/local/opt/llvm/bin/lldb-dap",
        },
        notify = "lldb-dap não encontrado. Instale LLDB ou defina LLDB_DAP_PATH.",
        title = "DAP C++",
    })
end

dap.adapters.lldb = function(callback)
    callback({ type = "executable", command = resolve_lldb_dap(), name = "lldb" })
end

dap.configurations.cpp = {
    {
        name = "Executar programa C++",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Executável: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = true,
    },
    {
        name = "Anexar a processo C++",
        type = "lldb",
        request = "attach",
        pid = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
    },
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticInfo", linehl = "Visual" })

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Alternar breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Condição do breakpoint: "))
end, { desc = "Breakpoint condicional" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continuar / iniciar" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Repetir última sessão" })
vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Alternar REPL" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Encerrar debug" })
vim.keymap.set("n", "<leader>du", dap_view.toggle, { desc = "Alternar DAP View" })
vim.keymap.set({ "n", "v" }, "<leader>de", function()
    dap_view.hover()
end, { desc = "Avaliar expressão" })

vim.schedule(function()
    local ok, wk = pcall(require, "which-key")
    if ok then
        wk.add({ { "<leader>d", group = "Debug" } })
    end
end)
