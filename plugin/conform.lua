vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black", "isort" },
		sql = { "sqlfmt" },
		-- LaTeX: latexindent se disponível, senão cai pro LSP
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = {
		timeout_ms = 500,
		quiet = true,
	},
})
