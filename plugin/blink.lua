vim.pack.add({
	"https://github.com/saghen/blink.lib",
	"https://github.com/saghen/blink.cmp",
})

local blink = require("blink.cmp")

blink.setup({
	keymap = { preset = "default" },

	appearance = {
		nerd_font_variant = "mono",
	},

	snippets = { preset = "default" },

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	signature = { enabled = true },

	completion = {
		documentation = {
			auto_show = true,
			window = { border = "rounded" },
		},
		menu = {
			draw = {
				treesitter = { "lsp" },
				columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
			},
		},
	},
})

local capabilities = blink.get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

-- Python
vim.lsp.config("pyright", {})
vim.lsp.enable("pyright")

-- LaTeX
vim.lsp.config("texlab", {})
vim.lsp.enable("texlab")

-- Lua (editar a própria config do Neovim)
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			format = { enable = false },
		},
	},
})
vim.lsp.enable("lua_ls")

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		source = "if_many",
		spacing = 2,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		source = "if_many",
		border = "rounded",
		header = "",
		prefix = "",
		focusable = false,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local buf = ev.buf
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Ir para definição" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buf, desc = "Ir para declaração" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "Documentação" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = buf, desc = "Ir para implementação" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = buf, desc = "Referências" })
		vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { buffer = buf, desc = "Assinatura da função" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buf, desc = "Renomear símbolo" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code action" })
	end,
})
