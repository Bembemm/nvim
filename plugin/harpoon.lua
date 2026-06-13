-- Harpoon2 precisa ser instalado via branch específico.
-- vim.pack.add não suporta branches, então usamos o método nativo do Neovim.
local harpoon_path = vim.fn.stdpath("data") .. "/site/pack/deps/start/harpoon"
local plenary_path = vim.fn.stdpath("data") .. "/site/pack/deps/start/plenary.nvim"

local function clone(url, path)
	if not vim.uv.fs_stat(path) then
		local out = vim.fn.system({
			"git",
			"clone",
			"--branch",
			"harpoon2",
			"--depth",
			"1",
			url,
			path,
		})
		if vim.v.shell_error ~= 0 then
			vim.notify("Harpoon2: falha ao instalar:\n" .. out, vim.log.levels.ERROR)
			return false
		end
		vim.notify("Harpoon2: instalado! Reinicie o Neovim.", vim.log.levels.INFO)
		return false -- pede reinício antes de continuar
	end
	return true
end

local function clone_plenary(url, path)
	if not vim.uv.fs_stat(path) then
		local out = vim.fn.system({ "git", "clone", "--depth", "1", url, path })
		if vim.v.shell_error ~= 0 then
			vim.notify("plenary.nvim: falha ao instalar:\n" .. out, vim.log.levels.ERROR)
			return false
		end
		return false
	end
	return true
end

local ok_p = clone_plenary("https://github.com/nvim-lua/plenary.nvim", plenary_path)
local ok_h = clone("https://github.com/ThePrimeagen/harpoon", harpoon_path)

if not (ok_p and ok_h) then
	return
end

local harpoon = require("harpoon")

harpoon:setup({
	settings = {
		save_on_toggle = true,
		sync_on_ui_close = true,
	},
})

-- Extend: abre em split vertical/horizontal direto do menu
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

vim.keymap.set("n", "<leader>a", function()
	list():add()
end, { desc = "Harpoon: Adicionar arquivo" })

vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(list())
end, { desc = "Harpoon: Menu rápido" })

for i = 1, 4 do
	vim.keymap.set("n", "<C-" .. i .. ">", function()
		list():select(i)
	end, { desc = "Harpoon: Ir para arquivo " .. i })
end

vim.keymap.set("n", "<leader>hn", function()
	list():next()
end, { desc = "Harpoon: Próximo" })

vim.keymap.set("n", "<leader>hp", function()
	list():prev()
end, { desc = "Harpoon: Anterior" })
