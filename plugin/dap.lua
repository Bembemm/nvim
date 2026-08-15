local dap = require("dap")
local dap_view = require("dap-view")

dap_view.setup({
    auto_toggle = true,
    winbar = { controls = { enabled = true, position = "right" } },
    virtual_text = { enabled = true, position = "inline" },
})

local lldb_dap_cmd = vim.fn.exepath("lldb-dap")
if lldb_dap_cmd == "" then
    lldb_dap_cmd = vim.fn.exepath("lldb-vscode")
end

if lldb_dap_cmd ~= "" then
    dap.adapters.lldb = {
        type = "executable",
        command = lldb_dap_cmd,
        name = "lldb",
    }

    dap.configurations.cpp = {
        {
            name = "Build e depurar C++",
            type = "lldb",
            request = "launch",
            preLaunchTask = "C++ Build",
            program = "${fileDirname}/${fileBasenameNoExtension}",
            cwd = "${fileDirname}",
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
else
    vim.schedule(function()
        vim.notify_once(
            "lldb-dap/lldb-vscode não encontrado; o debug C++ foi desativado.",
            vim.log.levels.WARN,
            { title = "Dependência ausente" }
        )
    end)
end

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticInfo", linehl = "Visual" })

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Alternar breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Condição do breakpoint: "))
end, { desc = "Breakpoint condicional" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continuar / build e debug" })
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
