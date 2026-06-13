-- ~/.config/nvim/plugin/10-harpoon.lua

vim.schedule(function()
	vim.pack.add({ "https://github.com/ThePrimeagen/harpoon" })

	-- O Harpoon é dividido em dois motores: o de marcação (mark) e o de interface (ui)
	local ok_mark, mark = pcall(require, "harpoon.mark")
	local ok_ui, ui = pcall(require, "harpoon.ui")
	if not (ok_mark and ok_ui) then
		return
	end

	-- ==========================================
	-- ATALHOS NINJAS DE TELETRANSPORTE
	-- ==========================================

	-- 1. "Fisga" o arquivo atual e joga na sua lista (Espaço + a)
	vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: Adicionar arquivo" })

	-- 2. Abre o menu rápido de vidro fosco para ver seus arquivos marcados (Ctrl + e)
	vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon: Menu Rápido" })

	-- 3. Pula direto para os arquivos sem nem abrir o menu (Ctrl + 1, 2, 3, 4)
	vim.keymap.set("n", "<C-1>", function()
		ui.nav_file(1)
	end, { desc = "Harpoon: Ir para Arquivo 1" })
	vim.keymap.set("n", "<C-2>", function()
		ui.nav_file(2)
	end, { desc = "Harpoon: Ir para Arquivo 2" })
	vim.keymap.set("n", "<C-3>", function()
		ui.nav_file(3)
	end, { desc = "Harpoon: Ir para Arquivo 3" })
	vim.keymap.set("n", "<C-4>", function()
		ui.nav_file(4)
	end, { desc = "Harpoon: Ir para Arquivo 4" })
end)
