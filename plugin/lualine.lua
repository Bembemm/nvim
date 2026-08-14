local lualine = require("lualine")
local colors = require("monokai").classic

local bar_bg = colors.base2

local modecolor = {
    n = colors.aqua,
    i = colors.green,
    v = colors.purple,
    ["\22"] = colors.purple,
    V = colors.purple,
    c = colors.orange,
    no = colors.aqua,
    s = colors.yellow,
    S = colors.yellow,
    ic = colors.orange,
    R = colors.red,
    Rv = colors.purple,
    cv = colors.orange,
    ce = colors.orange,
    r = colors.aqua,
    rm = colors.aqua,
    ["r?"] = colors.aqua,
    ["!"] = colors.red,
    t = colors.yellow,
}

local theme = {}
for mode, accent in pairs({
    normal = colors.aqua,
    insert = colors.green,
    visual = colors.purple,
    replace = colors.red,
    command = colors.orange,
    terminal = colors.yellow,
    inactive = colors.base5,
}) do
    theme[mode] = {
        a = { fg = colors.base2, bg = accent },
        b = { fg = colors.base8, bg = bar_bg },
        c = { fg = colors.base8, bg = bar_bg },
        x = { fg = colors.base8, bg = bar_bg },
        y = { fg = colors.base8, bg = bar_bg },
        z = { fg = colors.base8, bg = bar_bg },
    }
end

local space = {
    function()
        return " "
    end,
    color = { bg = bar_bg },
}

local mode = {
    "mode",
    color = function()
        local current = vim.fn.mode(1)
        local bg = modecolor[current] or modecolor[current:sub(1, 1)] or colors.aqua
        return { bg = bg, fg = colors.base2, gui = "bold" }
    end,
    separator = { left = "", right = "" },
}

local branch = {
    "branch",
    icon = " ",
    color = { bg = colors.green, fg = colors.base2, gui = "bold" },
    separator = { left = "", right = "" },
}

local filename = {
    "filename",
    color = { bg = colors.aqua, fg = colors.base2, gui = "bold" },
    separator = { left = "", right = "" },
}

local diff = {
    "diff",
    color = { bg = colors.base3, fg = colors.base8, gui = "bold" },
    separator = { left = "", right = "" },
    symbols = { added = " ", modified = " ", removed = " " },
    colored = true,
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow },
        removed = { fg = colors.red },
    },
}

local location = {
    "location",
    color = { bg = colors.yellow, fg = colors.base2, gui = "bold" },
    separator = { left = "", right = "" },
}

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.aqua },
        hint = { fg = colors.purple },
    },
    color = { bg = colors.base3, fg = colors.base8, gui = "bold" },
    separator = { left = "", right = "" },
    always_visible = true,
}

local macro = {
    function()
        local register = vim.fn.reg_recording()
        return register ~= "" and (" @" .. register) or ""
    end,
    cond = function()
        return vim.fn.reg_recording() ~= ""
    end,
    color = { fg = colors.red, bg = bar_bg, gui = "italic,bold" },
}

lualine.setup({
    options = {
        disabled_filetypes = {
            statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
        },
        icons_enabled = true,
        theme = theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { space },
        lualine_c = { branch, space, filename },
        lualine_x = {},
        lualine_y = { macro },
        lualine_z = { diff, space, location, space, diagnostics },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
})

vim.o.laststatus = 3
