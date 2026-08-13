local M = {}

local function read_file(path)
    local file = io.open(path, "r")
    if not file then
        return nil
    end

    local content = file:read("*a")
    file:close()
    return content
end

local function command(command)
    local output = vim.fn.system(command)
    if vim.v.shell_error ~= 0 then
        return ""
    end
    return vim.trim(output)
end

local function clamp(value, min, max)
    return math.min(math.max(value, min), max)
end

local function graph(percent, width)
    percent = clamp(tonumber(percent) or 0, 0, 100)
    width = width or 18

    local filled = math.floor((percent / 100) * width + 0.5)
    return string.rep("━", filled) .. string.rep("─", width - filled)
end

local function format_bytes(bytes)
    bytes = tonumber(bytes) or 0

    if bytes >= 1024 ^ 3 then
        return string.format("%.1fG", bytes / 1024 ^ 3)
    end
    if bytes >= 1024 ^ 2 then
        return string.format("%.1fM", bytes / 1024 ^ 2)
    end
    if bytes >= 1024 then
        return string.format("%.1fK", bytes / 1024)
    end

    return string.format("%dB", bytes)
end

local function os_info()
    local os_release = read_file("/etc/os-release") or ""
    local pretty = os_release:match('PRETTY_NAME="([^"]+)"') or os_release:match("PRETTY_NAME=([^\n]+)") or "Linux"
    local id = (os_release:match("\nID=([^\n]+)") or os_release:match("^ID=([^\n]+)") or "linux"):gsub('"', "")

    local icons = {
        fedora = "",
        arch = "󰣇",
        ubuntu = "",
        debian = "",
        nixos = "",
    }

    return string.format("%s %s", icons[id] or "", pretty)
end

local function nvim_version()
    local version = vim.version()
    return string.format(" Neovim %d.%d.%d", version.major, version.minor, version.patch)
end

local function cpu_load()
    local loadavg = read_file("/proc/loadavg") or ""
    local load = tonumber(loadavg:match("^([%d%.]+)")) or 0
    local cpu_count = math.max(#vim.uv.cpu_info(), 1)
    return clamp((load / cpu_count) * 100, 0, 100)
end

local function memory_info()
    local meminfo = read_file("/proc/meminfo") or ""
    local values = {}

    for key, value in meminfo:gmatch("([%w_()]+):%s+(%d+)") do
        values[key] = tonumber(value) * 1024
    end

    local total = values.MemTotal or 0
    local available = values.MemAvailable or 0
    local used = math.max(total - available, 0)
    local swap_total = values.SwapTotal or 0
    local swap_free = values.SwapFree or 0
    local swap_used = math.max(swap_total - swap_free, 0)

    return used, total, swap_used, swap_total
end

local function disk_info()
    local line = command("df -B1 / | tail -1")
    local total, used = line:match("^%S+%s+(%d+)%s+(%d+)")
    return tonumber(used) or 0, tonumber(total) or 0
end

local function uptime()
    local value = tonumber((read_file("/proc/uptime") or ""):match("^([%d%.]+)")) or 0
    local days = math.floor(value / 86400)
    local hours = math.floor((value % 86400) / 3600)
    local minutes = math.floor((value % 3600) / 60)

    if days > 0 then
        return string.format("%dd %02dh %02dm", days, hours, minutes)
    end

    return string.format("%02dh %02dm", hours, minutes)
end

local function battery_info()
    local paths = vim.fn.glob("/sys/class/power_supply/BAT*", false, true)
    local path = paths[1]
    if not path then
        return nil
    end

    local capacity = tonumber(vim.trim(read_file(path .. "/capacity") or ""))
    local status = vim.trim(read_file(path .. "/status") or "")
    if not capacity then
        return nil
    end

    local icon = status == "Charging" and "󰂄" or "󰁹"
    return capacity, status, icon
end

local function process_count()
    return tonumber(command("ps -e --no-headers | wc -l")) or 0
end

local function local_ip()
    return command("hostname -I | awk '{print $1}'") ~= "" and command("hostname -I | awk '{print $1}'") or "offline"
end

local function system_info()
    local cpu = cpu_load()
    local ram_used, ram_total, swap_used, swap_total = memory_info()
    local disk_used, disk_total = disk_info()
    local ram_percent = ram_total > 0 and (ram_used / ram_total) * 100 or 0
    local swap_percent = swap_total > 0 and (swap_used / swap_total) * 100 or 0
    local disk_percent = disk_total > 0 and (disk_used / disk_total) * 100 or 0
    local battery = battery_info()

    local lines = {
        "╭─────────┬──────────────────────────────────────────────╮",
        string.format("│ CPU     │ %5.1f%%    %-18s │", cpu, graph(cpu)),
        string.format(
            "│ RAM     │ %11s    %-18s │",
            format_bytes(ram_used) .. "/" .. format_bytes(ram_total),
            graph(ram_percent)
        ),
    }

    if swap_total > 0 then
        table.insert(
            lines,
            string.format(
                "│ SWAP    │ %11s  󰯍  %-18s │",
                format_bytes(swap_used) .. "/" .. format_bytes(swap_total),
                graph(swap_percent)
            )
        )
    end

    table.insert(
        lines,
        string.format(
            "│ DISK    │ %11s    %-18s │",
            format_bytes(disk_used) .. "/" .. format_bytes(disk_total),
            graph(disk_percent)
        )
    )
    table.insert(lines, string.format("│ UPTIME  │ %-44s │", "󰅐 " .. uptime()))

    if battery then
        table.insert(
            lines,
            string.format(
                "│ BATTERY │ %-12s %3d%%  %-18s │",
                battery[3] .. " " .. battery[2],
                battery[1],
                graph(battery[1], 18)
            )
        )
    end

    table.insert(
        lines,
        string.format("│ SYSTEM  │ %-20s   %-5d  󰩠 %-12s │", vim.env.USER or "user", process_count(), local_ip())
    )
    table.insert(lines, "╰─────────┴──────────────────────────────────────────────╯")

    return lines
end

local header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]

function M.header()
    return table.concat({
        header,
        "",
        os_info() .. "  │  " .. nvim_version(),
        "",
        table.concat(system_info(), "\n"),
        "",
        os.date("󰃭 %d/%m/%Y  󰥔 %H:%M"),
    }, "\n")
end

return M
