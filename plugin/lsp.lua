local function notify_missing(message)
    vim.schedule(function()
        vim.notify_once(message, vim.log.levels.WARN, { title = "Dependência ausente" })
    end)
end

if vim.fn.executable("lua-language-server") == 1 then
    vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                    library = { vim.env.VIMRUNTIME },
                    checkThirdParty = false,
                },
                format = { enable = false },
            },
        },
    })

    vim.lsp.enable("lua_ls")
else
    notify_missing("lua-language-server não encontrado; o LSP para Lua foi desativado.")
end

if vim.fn.executable("clangd") == 1 then
    vim.lsp.config("clangd", {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
        },
        filetypes = { "c", "cpp" },
        root_markers = {
            ".clangd",
            "compile_commands.json",
            "compile_flags.txt",
            "CMakeLists.txt",
            "meson.build",
            ".git",
        },
    })

    vim.lsp.enable("clangd")
else
    notify_missing("clangd não encontrado; o LSP para C/C++ foi desativado.")
end

vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        source = "if_many",
        spacing = 2,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        source = "if_many",
        border = "rounded",
        header = "",
        prefix = "",
        focusable = false,
    },
})

local function switch_source_header(client, bufnr)
    client:request("textDocument/switchSourceHeader", { uri = vim.uri_from_bufnr(bufnr) }, function(err, result)
        if err then
            vim.schedule(function()
                vim.notify(err.message or tostring(err), vim.log.levels.ERROR, { title = "clangd" })
            end)
            return
        end

        if not result or result == "" then
            vim.schedule(function()
                vim.notify("Arquivo correspondente não encontrado", vim.log.levels.INFO, { title = "clangd" })
            end)
            return
        end

        vim.schedule(function()
            local path = vim.fn.fnameescape(vim.uri_to_fname(result))
            vim.cmd.edit(path)
        end)
    end, bufnr)
end

local notified_clients = {}
local lsp_names = {
    clangd = "C/C++ · clangd",
    lua_ls = "Lua · LuaLS",
}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local buf = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local opts = function(desc)
            return { buffer = buf, desc = desc }
        end

        if client and not notified_clients[client.id] then
            notified_clients[client.id] = true
            local name = lsp_names[client.name] or client.name
            vim.schedule(function()
                vim.notify(("󰒋  %s carregado"):format(name), vim.log.levels.INFO, {
                    title = "LSP Ready",
                    icon = "󰒋 ",
                })
            end)
        end

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Ir para definição"))
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Ir para declaração"))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Documentação"))
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts("Code action"))
        vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts("Diagnóstico da linha"))
        vim.keymap.set("n", "<leader>lr", function()
            require("live-rename").rename({ insert = true, cursorpos = -1 })
        end, opts("Renomear símbolo ao vivo"))
        vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts("Assinatura da função"))

        if client and client:supports_method("textDocument/inlayHint", buf) then
            if client.name == "clangd" then
                vim.lsp.inlay_hint.enable(true, { bufnr = buf })
            end

            vim.keymap.set("n", "<leader>li", function()
                local filter = { bufnr = buf }
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
            end, opts("Alternar inlay hints"))
        end

        if client and client.name == "clangd" then
            vim.keymap.set("n", "<leader>lh", function()
                switch_source_header(client, buf)
            end, opts("Alternar source/header"))
        end
    end,
})
