local M = {}

local function add(candidates, path)
    if path and path ~= "" then
        candidates[#candidates + 1] = vim.fn.expand(path)
    end
end

---@param opts { names: string|string[], env?: string, extra_paths?: string[], notify?: string, title?: string }
---@return string
function M.find(opts)
    local names = type(opts.names) == "table" and opts.names or { opts.names }

    if opts.env then
        local override = vim.env[opts.env]
        if override and override ~= "" then
            override = vim.fn.expand(override)
            if vim.fn.executable(override) == 1 then
                return override
            end
        end
    end

    for _, name in ipairs(names) do
        local from_path = vim.fn.exepath(name)
        if from_path ~= "" then
            return from_path
        end
    end

    local candidates = {}

    for _, prefix in ipairs({ vim.env.PREFIX or "", vim.env.TERMUX_PREFIX or "" }) do
        if prefix ~= "" then
            for _, name in ipairs(names) do
                add(candidates, vim.fs.joinpath(prefix, "bin", name))
            end
        end
    end

    for _, dir in ipairs({
        "~/.local/bin",
        "~/.nix-profile/bin",
        "/run/current-system/sw/bin",
        "/usr/local/bin",
        "/usr/bin",
        "/opt/homebrew/bin",
    }) do
        for _, name in ipairs(names) do
            add(candidates, vim.fs.joinpath(dir, name))
        end
    end

    for _, path in ipairs(opts.extra_paths or {}) do
        add(candidates, path)
    end

    for _, path in ipairs(candidates) do
        if vim.fn.executable(path) == 1 then
            return path
        end
    end

    if opts.notify then
        vim.schedule(function()
            vim.notify(opts.notify, vim.log.levels.WARN, { title = opts.title or "Executável" })
        end)
    end

    return names[1]
end

return M
