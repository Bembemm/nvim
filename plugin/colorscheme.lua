local monokai = require("monokai-pro")
local blend = require("monokai-pro.colors.blend")

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
    local gutter_bg = blend.blend(palette.dimmed5, 0.32, palette.background)
    local separator = blend.blend(palette.dimmed3, 0.48, palette.background)

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

    -- Give the editor gutter its own visual surface instead of blending into code.
    vim.api.nvim_set_hl(0, "SignColumn", { bg = gutter_bg })
    vim.api.nvim_set_hl(0, "CursorLineSign", { bg = gutter_bg })
    vim.api.nvim_set_hl(0, "FoldColumn", { fg = palette.dimmed3, bg = gutter_bg })
    vim.api.nvim_set_hl(0, "CursorLineFold", { fg = palette.dimmed2, bg = gutter_bg })

    -- Keep split/sidebar boundaries visible without turning them into bright borders.
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = separator, bg = palette.background })
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
