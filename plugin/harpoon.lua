-- plugin/harpoon.lua
-- Harpoon 2 — branch harpoon2 (o branch main está deprecated)
-- API completamente diferente da v1: harpoon:list():add() em vez de mark.add_file()

vim.schedule(function()
	vim.pack.add({
		-- IMPORTANTE: aponta para o branch harpoon2, não o main
		{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
		"https://github.com/nvim-lua/plenary.nvim",
	})

	local ok, harpoon = pcall(require, "harpoon")
	if not ok then
		return
	end

	harpoon:setup({
		settings = {
			save_on_toggle = true,
			sync_on_ui_close = true,
		},
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
