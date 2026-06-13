local harpoon_path = vim.fn.stdpath("data") .. "/site/pack/harpoon/start/harpoon"

-- Se o harpoon2 ainda não está no disco, clona o branch correto
if not vim.uv.fs_stat(harpoon_path) then
	vim.notify("Harpoon2: instalando...", vim.log.levels.INFO)
	local out = vim.fn.system({
		"git",
		"clone",
		"--branch",
		"harpoon2",
		"--depth",
		"1",
		"https://github.com/ThePrimeagen/harpoon",
		harpoon_path,
	})
	if vim.v.shell_error ~= 0 then
		vim.notify("Harpoon2: falha ao instalar:\n" .. out, vim.log.levels.ERROR)
		return
	end
	vim.opt.runtimepath:append(harpoon_path)
	vim.notify("Harpoon2: instalado! Reinicie o Neovim.", vim.log.levels.INFO)
	return
end

-- Garante que o path está no runtimepath (para quando já está instalado)
vim.opt.runtimepath:append(harpoon_path)

vim.schedule(function()
	-- plenary é dependência do harpoon2
	vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })

	local ok, harpoon = pcall(require, "harpoon")
	if not ok then
		vim.notify(
			"Harpoon2: não carregou. Delete ~/.local/share/nvim/site/pack/core/opt/harpoon e reinicie.",
			vim.log.levels.WARN
		)
		return
	end

	harpoon:setup({
		settings = {
			save_on_toggle = true,
			sync_on_ui_close = true,
		},
	})

	-- Extend: abre em split vertical/horizontal e tab direto do menu
	harpoon:extend({
		UI_CREATE = function(cx)
			vim.keymap.set("n", "<C-v>", function()
				harpoon.ui:select_menu_item({ vsplit = true })
			end, { buffer = cx.bufnr })
			vim.keymap.set("n", "<C-x>", function()
				harpoon.ui:select_menu_item({ split = true })
			end, { buffer = cx.bufnr })
		end,
	})

	local list = function()
		return harpoon:list()
	end

	-- Adicionar arquivo atual à lista
	vim.keymap.set("n", "<leader>a", function()
		list():add()
	end, { desc = "Harpoon: Adicionar arquivo" })

	-- Abrir o menu rápido
	vim.keymap.set("n", "<C-e>", function()
		harpoon.ui:toggle_quick_menu(list())
	end, { desc = "Harpoon: Menu rápido" })

	-- Navegar direto para os arquivos 1-4
	for i = 1, 4 do
		vim.keymap.set("n", "<C-" .. i .. ">", function()
			list():select(i)
		end, { desc = "Harpoon: Ir para arquivo " .. i })
	end

	-- Navegar para próximo/anterior da lista
	vim.keymap.set("n", "<leader>hn", function()
		list():next()
	end, { desc = "Harpoon: Próximo" })
	vim.keymap.set("n", "<leader>hp", function()
		list():prev()
	end, { desc = "Harpoon: Anterior" })
end)
