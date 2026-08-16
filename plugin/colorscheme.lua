local onedark = require("onedark")

onedark.setup({
    style = "deep",
    transparent = false,
    term_colors = true,
    ending_tildes = false,
    cmp_itemkind_reverse = false,
    toggle_style_key = nil,
    code_style = {
        comments = "italic",
        keywords = "italic",
        functions = "none",
        strings = "none",
        variables = "none",
    },
    lualine = {
        transparent = false,
    },
    diagnostics = {
        darker = true,
        undercurl = true,
        background = true,
    },
})

local function apply_custom_highlights()
    local colors = require("onedark.colors")

    local indent_colors = {
        SnacksIndentRed = colors.red,
        SnacksIndentOrange = colors.orange,
        SnacksIndentYellow = colors.yellow,
        SnacksIndentGreen = colors.green,
        SnacksIndentCyan = colors.cyan,
        SnacksIndentPurple = colors.purple,
    }

    for group, color in pairs(indent_colors) do
        vim.api.nvim_set_hl(0, group, { fg = color })
    end

    vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = colors.cyan })
    vim.api.nvim_set_hl(0, "SnacksIndentChunk", { fg = colors.purple, bold = true })

    -- Keep the gutter visually separated from the code surface.
    vim.api.nvim_set_hl(0, "SignColumn", { bg = colors.bg_d })
    vim.api.nvim_set_hl(0, "CursorLineSign", { bg = colors.bg_d })
    vim.api.nvim_set_hl(0, "FoldColumn", { fg = colors.grey, bg = colors.bg_d })
    vim.api.nvim_set_hl(0, "CursorLineFold", { fg = colors.light_grey, bg = colors.bg_d })

    -- Subtle but clear boundaries between splits and sidebars.
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.bg2, bg = colors.bg0 })
end

onedark.load()
apply_custom_highlights()

local group = vim.api.nvim_create_augroup("OneDarkCustomHighlights", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    pattern = "onedark",
    callback = function()
        vim.schedule(apply_custom_highlights)
    end,
})
