local monokai = require("monokai-pro")

monokai.setup({
    transparent_background = false,
    terminal_colors = true,
    devicons = true,
    filter = "classic",
    day_night = {
        enable = false,
        day_filter = "classic",
        night_filter = "spectrum",
    },
    inc_search = "background",
    styles = {
        comment = { italic = true },
        keyword = { italic = true },
        type = { italic = true },
        storageclass = { italic = true },
        structure = { italic = true },
        parameter = { italic = true },
        annotation = { italic = true },
        tag_attribute = { italic = true },
    },
})

local function apply_custom_highlights()
    local palette = monokai.get_palette()

    local indent_colors = {
        SnacksIndentRed = palette.accent1,
        SnacksIndentOrange = palette.accent2,
        SnacksIndentYellow = palette.accent3,
        SnacksIndentGreen = palette.accent4,
        SnacksIndentCyan = palette.accent5,
        SnacksIndentPurple = palette.accent6,
    }

    for group, color in pairs(indent_colors) do
        vim.api.nvim_set_hl(0, group, { fg = color })
    end

    vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = palette.accent5 })
    vim.api.nvim_set_hl(0, "SnacksIndentChunk", { fg = palette.accent6, bold = true })
end

vim.cmd.colorscheme("monokai-pro")
apply_custom_highlights()

local group = vim.api.nvim_create_augroup("MonokaiProCustomHighlights", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    pattern = "monokai-pro",
    callback = function()
        vim.schedule(apply_custom_highlights)
    end,
})

vim.keymap.set("n", "<leader>cm", function()
    vim.cmd("MonokaiPro")
end, { desc = "Escolher filtro Monokai Pro" })
