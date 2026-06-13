-- ~/.config/nvim/plugin/08-gitsigns.lua

vim.schedule(function()
    vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

    local ok, gitsigns = pcall(require, "gitsigns")
    if not ok then return end

    gitsigns.setup({
        -- Puxa o fundo transparente para casar com o seu vidro fosco (neovide)
        signcolumn = true,
        
        -- Configura um atalho extra que só funciona dentro de arquivos do Git
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            -- Atalho: Aperte Espaço + gp (Git Preview) para ver o que você apagou/mudou naquela linha
            vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = "Preview Git Hunk" })
        end
    })
end)
