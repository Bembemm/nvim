-- ~/.config/nvim/plugin/09-todo.lua

vim.schedule(function()
	-- Ele precisa do plenary, que nós já instalamos lá atrás no Telescope!
	vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })

	local ok, todo = pcall(require, "todo-comments")
	if not ok then
		return
	end

	-- Liga o motor de cores e ícones
	todo.setup({
		signs = true, -- Coloca um ícone bonito lá na margem esquerda
	})

	-- Integração absurda com o Telescope:
	-- Aperte Espaço + ft (Find Todo) para listar todos os TODOs do seu projeto!
	vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Buscar TODOs" })
end)
