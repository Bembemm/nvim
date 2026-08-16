local monokai = require("monokai-pro")

local function mode_colors()
    local palette = monokai.get_palette()

    return {
        normal = palette.accent5,
        insert = palette.accent4,
        visual = palette.accent6,
        replace = palette.accent1,
        command = palette.accent2,
        terminal = palette.accent3,
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
    local color = color_for_mode(vim.api.nvim_get_mode().mode)

    vim.api.nvim_set_hl(0, "LineNr", { fg = color })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = color, bold = true })
end

local group = vim.api.nvim_create_augroup("ModeLineNumbers", { clear = true })

vim.api.nvim_create_autocmd({ "ModeChanged", "WinEnter", "BufEnter" }, {
    group = group,
    callback = update_line_numbers,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = function()
        vim.schedule(update_line_numbers)
    end,
})

vim.schedule(update_line_numbers)
