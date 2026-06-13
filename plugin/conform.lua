-- ~/.config/nvim/plugin/07-conform.lua

vim.schedule(function()
	vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

	local ok, conform = pcall(require, "conform")
	if not ok then
		return
	end

	conform.setup({
		-- Avisa quais programas usar para cada linguagem
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
		},
		-- O grande segredo: Formata sozinho toda vez que você salvar o arquivo!
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	})
end)
