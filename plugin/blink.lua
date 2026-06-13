-- ~/.config/nvim/plugin/03-blink.lua

vim.schedule(function()
	-- Baixa o LSP, o novo motor (blink.lib) e a interface (blink.cmp)
	vim.pack.add({
		"https://github.com/neovim/nvim-lspconfig",
		"https://github.com/saghen/blink.lib",
		"https://github.com/saghen/blink.cmp",
	})

	-- Só tenta carregar a interface se ela já estiver baixada
	local ok, blink = pcall(require, "blink.cmp")
	if not ok then
		return
	end

	-- Configuração do motor
	blink.setup({
		-- Tab para navegar, Enter para confirmar
		keymap = { preset = "default" },

		appearance = {
			nerd_font_variant = "mono",
		},

		-- Usa o motor de snippets nativo do próprio Neovim
		snippets = { preset = "default" },

		-- Onde ele vai buscar as palavras
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- Mostra os parâmetros da função enquanto você digita
		signature = { enabled = true },
	})

	-- Avisa aos LSPs para usarem a velocidade do Blink
	local capabilities = blink.get_lsp_capabilities()
	vim.lsp.config("*", { capabilities = capabilities })

	-- Configuração dos servidores
	vim.lsp.config("pyright", {})
	vim.lsp.config("lua_ls", {
		settings = { Lua = { diagnostics = { globals = { "vim" } } } },
	})

	-- Liga tudo
	vim.lsp.enable("pyright")
	vim.lsp.enable("lua_ls")
end)
