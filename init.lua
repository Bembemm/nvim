-- 1. Otimizador de cache nativo (Liga o turbo)
vim.loader.enable()

-- 2. Carrega as opções e atalhos
require("core.options")
require("core.keymaps")

-- 3. Hook obrigatório para o Treesitter compilar sozinho na primeira instalação
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end
})
