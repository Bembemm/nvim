vim.g.nvim_start_time = vim.uv.hrtime()

-- 1. Otimizador de cache nativo (Liga o turbo)
vim.loader.enable()

-- 2. Carrega as opções e atalhos
require("core.options")
require("core.keymaps")

-- 3. Mantém os parsers do nvim-treesitter sincronizados após instalação ou atualização
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        if name ~= "nvim-treesitter" or (kind ~= "install" and kind ~= "update") then
            return
        end

        if kind == "install" or not ev.data.active then
            vim.cmd.packadd("nvim-treesitter")
        end

        vim.cmd("TSUpdate")
    end,
})

-- 4. Declara os plugins durante o init.lua para evitar carregamento recursivo no bootstrap
require("core.plugins")
