local function mode_colors()
    local colors = require("onedark.colors")

    return {
        normal = colors.cyan,
        insert = colors.green,
        visual = colors.purple,
        replace = colors.red,
        command = colors.orange,
        terminal = colors.yellow,
        gutter = colors.bg_d,
    }
end

local function color_for_mode(mode)
    local colors = mode_colors()
    local first = mode:sub(1, 1)

    if first == "i" then
        return colors.insert
    end

    if first == "v" or first == "V" or first == "\22" or first == "s" or first == "S" or first == "\19" then
        return colors.visual
    end

    if first == "R" then
        return colors.replace
    end

    if first == "c" then
        return colors.command
    end

    if first == "t" then
        return colors.terminal
    end

    return colors.normal
end

local function update_line_numbers()
    local colors = mode_colors()
    local color = color_for_mode(vim.api.nvim_get_mode().mode)

    vim.api.nvim_set_hl(0, "LineNr", { fg = color, bg = colors.gutter })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = color, bg = colors.gutter, bold = true })
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = color, bg = colors.gutter })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = color, bg = colors.gutter })
end

local group = vim.api.nvim_create_augroup("ModeLineNumbers", { clear = true })

vim.api.nvim_create_autocmd({ "ModeChanged", "WinEnter", "BufEnter" }, {
    group = group,
    callback = update_line_numbers,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    pattern = "onedark",
    callback = function()
        vim.schedule(update_line_numbers)
    end,
})

vim.schedule(update_line_numbers)
