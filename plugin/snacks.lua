local snacks = require("snacks")

local function graph(percent, width)
    percent = math.max(0, math.min(tonumber(percent) or 0, 100))
    width = width or 20

    local start_empty, start_filled = "", ""
    local mid_empty, mid_filled = "", ""
    local end_empty, end_filled = "", ""
    local filled = math.floor((percent / 100) * width)

    if filled <= 0 then
        return start_empty .. string.rep(mid_empty, width - 2) .. end_empty
    end
    if filled >= width then
        return start_filled .. string.rep(mid_filled, width - 2) .. end_filled
    end
    return start_filled .. string.rep(mid_filled, filled - 1) .. string.rep(mid_empty, width - filled - 1) .. end_empty
end

local function gib(bytes)
    return math.floor((bytes or 0) / 1024 ^ 3 * 10) / 10
end

local function percentage(used, total)
    return total and total > 0 and used / total * 100 or 0
end

local function system_header()
    local load = select(1, vim.uv.loadavg()) or 0
    local cpus = vim.uv.available_parallelism and vim.uv.available_parallelism() or 1
    local cpu = math.floor(math.min(100, load / math.max(cpus, 1) * 100) + 0.5)

    local ram_total_bytes = vim.uv.get_total_memory and vim.uv.get_total_memory() or 0
    local ram_free_bytes = vim.uv.get_free_memory and vim.uv.get_free_memory() or 0
    local ram_total = gib(ram_total_bytes)
    local ram_used = gib(math.max(0, ram_total_bytes - ram_free_bytes))

    local disk_used, disk_total = 0, 0
    local ok, stat = pcall(vim.uv.fs_statfs, "/")
    if ok and stat then
        local block = stat.bsize or stat.frsize or 1
        local total = (stat.blocks or 0) * block
        local free = (stat.bavail or stat.bfree or 0) * block
        disk_total = gib(total)
        disk_used = gib(math.max(0, total - free))
    end

    local uptime = vim.uv.uptime and vim.uv.uptime() or 0
    local boot = os.date("%Y-%m-%d %H:%M:%S", os.time() - math.floor(uptime))
    local version = vim.version()
    local user = vim.env.USER or "user"

    local info = {
        "╭────────┬─────────────────────────────────────────╮",
        string.format("│ CPU    │ %-16s %s │", cpu .. "%", " " .. graph(cpu)),
        string.format("│ RAM    │ %-16s %s │", ram_used .. "/" .. ram_total .. "GB", " " .. graph(percentage(ram_used, ram_total))),
        string.format("│ SWAP   │ %-16s %s │", "0/0GB", "󰯍 " .. graph(0)),
        string.format("│ DISK   │ %-16s %s │", disk_used .. "/" .. disk_total .. "GB", " " .. graph(percentage(disk_used, disk_total))),
        string.format("│ UPTIME │ %-21s %3d%% %s %s │", boot, 0, "󰂎", graph(0, 10)),
        string.format("│  │ %-15s %8s %21s │", "1  " .. user, " nvim", "󰩠 local"),
        "╰────────┴─────────────────────────────────────────╯",
    }

    local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]

    return logo
        .. "\n\n Fedora Linux |  "
        .. version.major
        .. "."
        .. version.minor
        .. "."
        .. version.patch
        .. "\n"
        .. table.concat(info, "\n")
        .. "\n"
        .. os.date()
end

local function startup_item()
    local packs = vim.pack and vim.pack.get and vim.pack.get() or {}
    local elapsed = vim.g.nvim_start_time and (vim.uv.hrtime() - vim.g.nvim_start_time) / 1e6 or 0

    return {
        pane = 1,
        align = "center",
        text = {
            { "⚡ Neovim loaded ", hl = "footer" },
            { tostring(#packs) .. "/" .. tostring(#packs), hl = "special" },
            { " plugins in ", hl = "footer" },
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

snacks.setup({
    dashboard = {
        enabled = true,
        width = 60,
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
                return { header = system_header(), padding = 1, pane = 1 }
            end,
            {
                pane = 1,
                section = "terminal",
                cmd = "curl -s --max-time 3 'https://wttr.in/?0FQ' | sed 's/^/               /' || true",
                height = 6,
                ttl = 15 * 60,
            },
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
                title = "GIT STATUS",
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
    notifier = {
        enabled = true,
        timeout = 2500,
        style = "fancy",
    },
    image = {
        enabled = true,
        force = true,
        doc = { enabled = true, inline = true, float = true },
    },
})

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
