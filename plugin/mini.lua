-- plugin/mini.lua
-- mini.pairs: fecha automaticamente parênteses, colchetes, chaves e aspas

vim.schedule(function()
	vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })

	local ok, pairs = pcall(require, "mini.pairs")
	if not ok then
		return
	end

	pairs.setup({
		modes = { insert = true, command = false, terminal = false },
	})
end)
