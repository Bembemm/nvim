local M = {}

local function cpp_sources(dir)
    local sources = {}

    for name, kind in vim.fs.dir(dir) do
        if kind == "file" and name:match("%.cpp$") then
            sources[#sources + 1] = vim.fs.joinpath(dir, name)
        end
    end

    table.sort(sources)
    return sources
end

local function contains_main(path)
    local ok, lines = pcall(vim.fn.readfile, path)
    if not ok then
        return false
    end

    for _, line in ipairs(lines) do
        local code = line:gsub("//.*$", "")
        if code:match("%f[%w_]main%s*%(") then
            return true
        end
    end

    return false
end

function M.context(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    if vim.bo[bufnr].filetype ~= "cpp" then
        return nil, "Build disponível apenas para arquivos C++."
    end

    local source = vim.api.nvim_buf_get_name(bufnr)
    if source == "" then
        return nil, "Salve o arquivo .cpp antes de compilar."
    end

    if not source:match("%.cpp$") then
        return nil, "Abra um arquivo .cpp para compilar o programa."
    end

    local dir = vim.fs.dirname(source)
    local sources = cpp_sources(dir)
    local entrypoints = {}

    for _, path in ipairs(sources) do
        if contains_main(path) then
            entrypoints[#entrypoints + 1] = path
        end
    end

    if #entrypoints > 1 then
        return nil,
            "Mais de um main() foi encontrado nesta pasta. Mantenha um programa/exercício C++ por pasta para usar o build automático."
    end

    local entrypoint = entrypoints[1] or source

    if #entrypoints == 0 then
        sources = { source }
    end

    local stem = vim.fn.fnamemodify(entrypoint, ":t:r")
    local executable_suffix = vim.fn.has("win32") == 1 and ".exe" or ""

    return {
        source = source,
        sources = sources,
        dir = dir,
        entrypoint = entrypoint,
        stem = stem,
        output = vim.fs.joinpath(dir, stem .. executable_suffix),
        multi_file = #sources > 1,
    }
end

return M
