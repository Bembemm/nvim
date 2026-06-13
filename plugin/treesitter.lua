-- Coloca todo o bloco na "fila de espera" para rodar só depois que a tela do Neovim aparecer (deixa a abertura instantânea)
vim.schedule(function()
	-- Baixa o motor de highlight avançado
	vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

	-- Tenta carregar o plugin. Se ele ainda estiver sendo baixado, o 'ok' será falso,
	-- e o 'return' cancela o código, evitando aquele erro vermelho na tela.
	local ok, configs = pcall(require, "nvim-treesitter.configs")
	if not ok then
		return
	end

	-- Se carregou, liga as cores (highlight) e a indentação inteligente do treesitter.
	configs.setup({
		ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown" },
		highlight = { enable = true },
		indent = { enable = true },
	})
end)
