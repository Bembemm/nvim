-- Cria um "apelido" curto para não precisar escrever "vim.opt" toda hora
local opt = vim.opt

vim.opt.guifont = "Iosevka Nerd Font:h14"
opt.number = true -- Mostra o número da linha atual na margem esquerda
opt.relativenumber = true -- Mostra a distância das outras linhas em relação à sua (ajuda a pular linhas)
opt.tabstop = 4 -- Define que um "TAB" visualmente ocupa o espaço de 4 letras
opt.shiftwidth = 4 -- Define que, ao apertar TAB, ele vai empurrar o texto 4 espaços pra frente
opt.expandtab = true -- Transforma o seu TAB em espaços reais (padrão no Python)
opt.smartindent = true -- Quando você der Enter numa função, ele já indenta a próxima linha sozinho
opt.wrap = false -- Impede que uma linha muito longa quebre e vá para a linha de baixo visualmente
opt.termguicolors = true -- Permite que o Neovim renderize as milhares de cores dos temas modernos
opt.clipboard = "unnamedplus" -- Faz o Neovim dividir a mesma "área de transferência" (Ctrl+C/Ctrl+V) do Windows/Linux
