local lualine = require("lualine")
local colors = require("monokai").classic

local bar_bg = colors.base2
local surface = colors.base3
local foreground = colors.base8
local muted = colors.base5

local theme = {}
for mode, accent in pairs({
    normal = colors.aqua,
    insert = colors.green,
    visual = colors.purple,
    replace = colors.red,
    command = colors.orange,
    terminal = colors.yellow,
    inactive = muted,
}) do
    theme[mode] = {
        a = { fg = bar_bg, bg = accent, gui = "bold" },
        b = { fg = foreground, bg = surface },
        c = { fg = foreground, bg = bar_bg },
        x = { fg = foreground, bg = bar_bg },
        y = { fg = foreground, bg = surface },
        z = { fg = bar_bg, bg = accent, gui = "bold" },
    }
end

local function short_task_name(name)
    name = name:gsub("^C%+%+%s*", "")
    name = name:gsub("%s*·%s*", " ")

    if #name > 24 then
        return name:sub(1, 21) .. "…"
    end

    return name
end

local function overseer_state()
    local ok, overseer = pcall(require, "overseer")
    if not ok then
        return nil
    end

    local tasks = overseer.list_tasks({ recent_first = true })

    for _, task in ipairs(tasks) do
        if task:is_running() then
            return {
                status = overseer.STATUS.RUNNING,
                name = short_task_name(task.name),
            }
        end
    end

    local task = tasks[1]
    if not task or not task.time_end or os.time() - task.time_end > 4 then
        return nil
    end

    if
        task.status == overseer.STATUS.SUCCESS
        or task.status == overseer.STATUS.FAILURE
        or task.status == overseer.STATUS.CANCELED
    then
        return {
            status = task.status,
            name = short_task_name(task.name),
        }
    end
end

local overseer_icons = {
    RUNNING = "󰑮",
    SUCCESS = "󰄬",
    FAILURE = "󰅖",
    CANCELED = "󰜺",
}

local overseer_colors = {
    RUNNING = colors.yellow,
    SUCCESS = colors.green,
    FAILURE = colors.red,
    CANCELED = muted,
}

local overseer_component = {
    function()
        local state = overseer_state()
        if not state then
            return ""
        end

        return string.format("%s %s", overseer_icons[state.status] or "󰑮", state.name)
    end,
    cond = function()
        return overseer_state() ~= nil
    end,
    color = function()
        local state = overseer_state()
        return {
            fg = state and overseer_colors[state.status] or muted,
            gui = "bold",
        }
    end,
}

local function dap_active()
    local ok, dap = pcall(require, "dap")
    return ok and dap.session() ~= nil
end

local dap_component = {
    function()
        local dap = require("dap")
        local status = dap.status()

        if status ~= "" then
            return "󰃤 " .. status
        end

        return "󰃤 Debug"
    end,
    cond = dap_active,
    color = { fg = colors.purple, gui = "bold" },
}

local macro_component = {
    function()
        local register = vim.fn.reg_recording()
        return register ~= "" and (" @" .. register) or ""
    end,
    cond = function()
        return vim.fn.reg_recording() ~= ""
    end,
    color = { fg = colors.red, gui = "bold" },
}

local filename = {
    "filename",
    path = 1,
    shorting_target = 40,
    symbols = {
        modified = " ●",
        readonly = " ",
        unnamed = "[Sem nome]",
        newfile = "[Novo]",
    },
    color = function()
        return {
            fg = vim.bo.modified and colors.yellow or foreground,
            gui = "bold",
        }
    end,
}

local branch = {
    "branch",
    icon = "",
    color = { fg = colors.green, gui = "bold" },
}

local diff = {
    "diff",
    symbols = {
        added = "+",
        modified = "~",
        removed = "-",
    },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow },
        removed = { fg = colors.red },
    },
}

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = {
        error = " ",
        warn = " ",
        info = " ",
        hint = "󰌵 ",
    },
    diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.aqua },
        hint = { fg = colors.purple },
    },
}

local lsp_status = {
    "lsp_status",
    icon = "",
    color = { fg = colors.aqua },
}

local filetype = {
    "filetype",
    color = { fg = colors.purple, gui = "bold" },
}

lualine.setup({
    options = {
        disabled_filetypes = {
            statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
        },
        icons_enabled = true,
        theme = theme,
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { branch, diff },
        lualine_c = { filename },
        lualine_x = {
            macro_component,
            dap_component,
            overseer_component,
            diagnostics,
            lsp_status,
        },
        lualine_y = {
            filetype,
            "progress",
        },
        lualine_z = { "location" },
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
