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

local function os_info()
    local os_release = read_file("/etc/os-release") or ""
    local pretty = os_release:match('PRETTY_NAME="([^"]+)"')
        or os_release:match("PRETTY_NAME=([^\n]+)")
        or vim.uv.os_uname().sysname
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
        os.date("󰃭 %d/%m/%Y  󰥔 %H:%M"),
    }, "\n")
end

return M
