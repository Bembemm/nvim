-- ~/.config/nvim/plugin/00-theme.lua

vim.pack.add({
    "https://github.com/sainnhe/gruvbox-material"
})

-- Opções de contraste do fundo: 'hard' (mais escuro), 'medium' (padrão), 'soft' (mais claro)
vim.g.gruvbox_material_background = 'hard'

-- Ativa fontes em itálico (ótimo para comentários e palavras-chave)
vim.g.gruvbox_material_enable_italic = 1

-- Desativa o carregamento de coisas desnecessárias para o tema carregar mais rápido
vim.g.gruvbox_material_better_performance = 1

-- Aplica o tema (Sintaxe blindada)
vim.cmd("colorscheme gruvbox-material")
