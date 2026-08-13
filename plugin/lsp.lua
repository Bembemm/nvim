local executable = require("core.executable")

local lua_ls_cmd = executable.find({
    names = "lua-language-server",
    env = "LUA_LS_PATH",
    notify = "lua-language-server não encontrado. Instale-o ou defina LUA_LS_PATH.",
    title = "LSP Lua",
})

local clangd_cmd = executable.find({
    names = "clangd",
    env = "CLANGD_PATH",
    extra_paths = {
        "/opt/homebrew/opt/llvm/bin/clangd",
        "/usr/local/opt/llvm/bin/clangd",
    },
    notify = "clangd não encontrado. Instale LLVM/clangd ou defina CLANGD_PATH.",
    title = "LSP C++",
})

if executable.available(lua_ls_cmd) then
    vim.lsp.config("lua_ls", {
        cmd = { lua_ls_cmd },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                format = { enable = false },
            },
        },
    })

    vim.lsp.enable("lua_ls")
end

if executable.available(clangd_cmd) then
    vim.lsp.config("clangd", {
        cmd = {
            clangd_cmd,
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
        },
        filetypes = { "cpp" },
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

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local buf = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local opts = function(desc)
            return { buffer = buf, desc = desc }
        end

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Ir para definição"))
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Ir para declaração"))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Documentação"))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Ir para implementação"))
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Referências"))
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts("Code action"))
        vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts("Diagnóstico da linha"))
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts("Renomear símbolo"))
        vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts("Assinatura da função"))

        if client and client:supports_method("textDocument/inlayHint") then
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
