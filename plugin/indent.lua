-- ~/.config/nvim/plugin/04-indent.lua

vim.schedule(function()
    vim.pack.add({
        "https://github.com/lukas-reineke/indent-blankline.nvim",
    })

    local ok, ibl = pcall(require, "ibl")
    if not ok then return end

    -- Lista com a ordem das cores que vão se repetir
    local highlight = {
        "RainbowRed",
        "RainbowOrange",
        "RainbowYellow",
        "RainbowGreen",
        "RainbowCyan",
        "RainbowBlue",
        "RainbowViolet",
    }
    
    local hooks = require("ibl.hooks")
    
    -- O Segredo: Em vez de códigos HEX, nós "linkamos" aos grupos nativos do tema!
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed",    { link = "DiagnosticError" }) -- Vermelho do tema
        vim.api.nvim_set_hl(0, "RainbowOrange", { link = "Number" })          -- Laranja do tema
        vim.api.nvim_set_hl(0, "RainbowYellow", { link = "Type" })            -- Amarelo do tema
        vim.api.nvim_set_hl(0, "RainbowGreen",  { link = "String" })          -- Verde do tema
        vim.api.nvim_set_hl(0, "RainbowCyan",   { link = "Special" })         -- Ciano/Aqua do tema
        vim.api.nvim_set_hl(0, "RainbowBlue",   { link = "Function" })        -- Azul do tema
        vim.api.nvim_set_hl(0, "RainbowViolet", { link = "Statement" })       -- Roxo/Rosa do tema
    end)

    -- Liga o plugin usando as cores dinâmicas
    ibl.setup({
        indent = { highlight = highlight, char = "│" },
        scope = { enabled = true, show_start = false, show_end = false },
    })
end)
