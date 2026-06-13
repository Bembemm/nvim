vim.schedule(function()
    -- Baixa o 'plenary' (que é a base) e o 'telescope' (que é o buscador)
    vim.pack.add({
        "https://github.com/nvim-lua/plenary.nvim",
        "https://github.com/nvim-telescope/telescope.nvim",
    })

    local ok, telescope = pcall(require, "telescope")
    if not ok then return end

    -- Inicia o motor do Telescope
    telescope.setup()

    -- Cria o atalho Espaço + ff para buscar arquivos pelo nome
    -- e Espaço + fg para buscar uma palavra DENTRO dos arquivos do projeto
    local builtin = require("telescope.builtin")
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Buscar arquivos' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Buscar texto' })
end)
