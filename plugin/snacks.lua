local snacks = require("snacks")
local dashboard = require("core.dashboard")

local indent_highlights = {
    "SnacksIndentRed",
    "SnacksIndentOrange",
    "SnacksIndentYellow",
    "SnacksIndentGreen",
    "SnacksIndentCyan",
    "SnacksIndentPurple",
}

local function startup_item()
    local packs = vim.pack and vim.pack.get and vim.pack.get() or {}
    local active = 0

    for _, pack in ipairs(packs) do
        if pack.active then
            active = active + 1
        end
    end

    local elapsed = vim.g.nvim_config_start_time and (vim.uv.hrtime() - vim.g.nvim_config_start_time) / 1e6 or 0

    return {
        pane = 1,
        align = "center",
        text = {
            { "⚡ Config loaded · ", hl = "footer" },
            { tostring(active) .. "/" .. tostring(#packs), hl = "special" },
            { " plugins · ", hl = "footer" },
            { string.format("%.2fms", elapsed), hl = "special" },
        },
    }
end

local function restore_session()
    local session = vim.fn.stdpath("state") .. "/session.vim"
    if vim.fn.filereadable(session) == 1 then
        vim.cmd.source(session)
    else
        vim.notify("Nenhuma sessão salva encontrada", vim.log.levels.INFO, { title = "Session" })
    end
end

local function git_branch()
    local root = snacks.git.get_root()
    if not root then
        return ""
    end

    local ok, lines = pcall(vim.fn.readfile, root .. "/.git/HEAD")
    if not ok or not lines[1] then
        return ""
    end

    return lines[1]:match("^ref: refs/heads/(.+)$") or lines[1]:sub(1, 7)
end

snacks.setup({
    dashboard = {
        enabled = true,
        width = 56,
        pane_gap = 4,
        preset = {
            keys = {
                { icon = " ", key = "n", desc = "New File", action = ":ene" },
                {
                    icon = "󰥨 ",
                    key = "f",
                    desc = "Find File",
                    action = function()
                        snacks.dashboard.pick("files", { cwd = "." })
                    end,
                },
                {
                    icon = "󰈞 ",
                    key = "g",
                    desc = "Find Text",
                    action = function()
                        snacks.dashboard.pick("live_grep")
                    end,
                },
                {
                    icon = " ",
                    key = "r",
                    desc = "Recent Files",
                    action = function()
                        snacks.dashboard.pick("oldfiles")
                    end,
                },
                {
                    icon = " ",
                    key = "c",
                    desc = "Config",
                    action = function()
                        snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") })
                    end,
                },
                {
                    icon = " ",
                    key = "p",
                    desc = "Plugins",
                    action = function()
                        snacks.picker.files({ cwd = vim.fn.stdpath("data") .. "/site/pack/core/opt" })
                    end,
                },
                { icon = " ", key = "s", desc = "Restore Session", action = restore_session },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
        },
        sections = {
            function()
                return { header = dashboard.header(), padding = 1, pane = 1 }
            end,
            startup_item,
            { pane = 2, section = "keys", padding = 1 },
            {
                pane = 2,
                icon = " ",
                title = "RECENT FILES",
                section = "recent_files",
                indent = 2,
                padding = 1,
            },
            { pane = 2, icon = "󰙅 ", title = "PROJECTS", section = "projects", indent = 2, padding = 1 },
            {
                pane = 2,
                icon = " ",
                title = "GIT STATUS [" .. git_branch() .. "]",
                section = "terminal",
                enabled = function()
                    return snacks.git.get_root() ~= nil
                end,
                cmd = "git --no-pager diff --stat -B -M -C && git status --short --renames",
                height = 5,
                padding = 1,
                ttl = 5 * 60,
                indent = 2,
            },
            {
                pane = 2,
                section = "terminal",
                enabled = function()
                    return snacks.git.get_root() == nil and vim.fn.executable("rmatrix") == 1
                end,
                cmd = "rmatrix -C red -b",
                height = 6,
                indent = 2,
                padding = 1,
            },
        },
    },
    picker = { enabled = true },
    input = { enabled = true },
    notifier = {
        enabled = true,
        timeout = 2500,
        style = "fancy",
    },
    indent = {
        enabled = true,
        indent = {
            enabled = true,
            char = "│",
            hl = indent_highlights,
            only_scope = false,
            only_current = false,
        },
        animate = {
            enabled = true,
            style = "out",
            easing = "linear",
            duration = {
                step = 20,
                total = 300,
            },
        },
        scope = {
            enabled = true,
            char = "│",
            underline = false,
            only_current = true,
            hl = "SnacksIndentScope",
        },
        chunk = {
            enabled = true,
            only_current = true,
            hl = "SnacksIndentChunk",
            char = {
                corner_top = "╭",
                corner_bottom = "╰",
                horizontal = "─",
                vertical = "│",
                arrow = ">",
            },
        },
    },
    image = {
        enabled = true,
        force = true,
        doc = { enabled = true, inline = true, float = true },
    },
})

vim.keymap.set("n", "<leader>.d", function()
    snacks.dashboard.open()
end, { desc = "Dashboard" })

vim.keymap.set("n", "<leader>ff", function()
    snacks.picker.files()
end, { desc = "Buscar arquivos" })

vim.keymap.set("n", "<leader>fg", function()
    snacks.picker.grep()
end, { desc = "Buscar texto" })

vim.keymap.set("n", "<leader>fr", function()
    snacks.picker.recent()
end, { desc = "Arquivos recentes" })

vim.keymap.set("n", "<leader>fc", function()
    snacks.picker.commands()
end, { desc = "Buscar comandos" })

vim.keymap.set("n", "<leader>fp", function()
    snacks.picker.pick()
end, { desc = "Todos os pickers" })

vim.keymap.set("n", "<leader>bb", function()
    snacks.picker.buffers()
end, { desc = "Listar buffers" })

vim.keymap.set("n", "<leader>i", function()
    snacks.image.hover()
end, { desc = "Visualizar imagem" })
