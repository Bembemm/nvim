local screenkey = require("screenkey")

screenkey.setup({
    win_opts = {
        row = vim.o.lines - vim.o.cmdheight - 1,
        col = vim.o.columns - 1,
        relative = "editor",
        anchor = "SE",
        width = 34,
        height = 1,
        border = "rounded",
        title = " Keys ",
        title_pos = "center",
        style = "minimal",
        focusable = false,
        noautocmd = true,
    },
    compress_after = 4,
    clear_after = 2,
    disable = {
        filetypes = {},
        buftypes = { "terminal" },
        events = true,
    },
    show_leader = true,
    group_mappings = true,
    filter = function(keys)
        local filtered = {}

        for _, key in ipairs(keys) do
            local plain_navigation = key.key == "h" or key.key == "j" or key.key == "k" or key.key == "l"
            if key.is_mapping or not plain_navigation then
                filtered[#filtered + 1] = key
            end
        end

        return filtered
    end,
})

vim.keymap.set("n", "<leader>ks", function()
    screenkey.toggle()
    vim.notify(screenkey.is_active() and "Screenkey ligado" or "Screenkey desligado", vim.log.levels.INFO, {
        title = "Screenkey",
    })
end, { desc = "Ligar/desligar Screenkey" })

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        if #vim.api.nvim_list_uis() == 0 or screenkey.is_active() then
            return
        end

        vim.schedule(screenkey.toggle)
    end,
})
