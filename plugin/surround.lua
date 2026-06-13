-- plugin/surround.lua
-- nvim-surround: manipulação de pares ao redor de texto
--   ys<movimento><par>  → adiciona ao redor
--   ds<par>             → deleta ao redor
--   cs<par><novo>       → troca ao redor
--   S (visual)          → envolve seleção

vim.schedule(function()
	vim.pack.add({ "https://github.com/kylechui/nvim-surround" })

	local ok, surround = pcall(require, "nvim-surround")
	if not ok then
		return
	end

	surround.setup()
end)
