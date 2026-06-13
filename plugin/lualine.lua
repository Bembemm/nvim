vim.schedule(function()
	-- Baixa o lualine e também os ícones bonitinhos para ele usar (devicons)
	vim.pack.add({
		"https://github.com/nvim-lualine/lualine.nvim",
	})

	local ok, lualine = pcall(require, "lualine")
	if not ok then
		return
	end

	-- Liga a barra de status lá embaixo. O 'theme = auto' faz ela puxar
	-- automaticamente as cores daquele tema Gruvbox que configuramos!
	lualine.setup({
		options = {
			theme = "auto",
			icons_enabled = true,
		},
	})
end)
