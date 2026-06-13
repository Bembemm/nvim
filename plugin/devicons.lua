-- ~/.config/nvim/plugin/14-devicons.lua

vim.schedule(function()
	-- Adiciona o plugin ao pack do Neovim
	vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })

	local ok, devicons = pcall(require, "nvim-web-devicons")
	if not ok then
		return
	end

	-- Configuração do plugin com a variante dark obrigatória
	devicons.setup({
		default = true,
		variant = "dark", -- Garante o contraste para o tema Gruvbox
		color_icons = true,
		-- Adicionamos essa flag para garantir que ele sobrescreva
		-- qualquer ícone padrão que não esteja no tema dark
		strict = true,
	})
end)
