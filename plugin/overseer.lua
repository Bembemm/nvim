local overseer = require("overseer")

overseer.setup({ dap = true })

local function cpp_context()
    local bufnr = vim.api.nvim_get_current_buf()

    if vim.bo[bufnr].filetype ~= "cpp" then
        vim.notify("Build disponível apenas para arquivos C++.", vim.log.levels.WARN, { title = "Overseer" })
        return nil
    end

    local source = vim.api.nvim_buf_get_name(bufnr)
    if source == "" then
        vim.notify("Salve o arquivo .cpp antes de compilar.", vim.log.levels.WARN, { title = "Overseer" })
        return nil
    end

    local compiler = vim.fn.exepath("clang++")
    if compiler == "" then
        vim.notify("clang++ não foi encontrado no PATH.", vim.log.levels.ERROR, { title = "Overseer" })
        return nil
    end

    if vim.bo[bufnr].modified then
        vim.cmd.update()
    end

    local dir = vim.fs.dirname(source)
    local stem = vim.fn.fnamemodify(source, ":t:r")

    return {
        compiler = compiler,
        source = source,
        dir = dir,
        stem = stem,
        output = vim.fs.joinpath(dir, stem),
    }
end

local function cpp_build_definition(ctx)
    return {
        name = "C++ Build · " .. ctx.stem,
        cmd = {
            ctx.compiler,
            "-std=c++20",
            "-Wall",
            "-Wextra",
            "-Wpedantic",
            "-g",
            "-O0",
            ctx.source,
            "-o",
            ctx.output,
        },
        cwd = ctx.dir,
        components = {
            { "on_output_quickfix", open_on_match = true, set_diagnostics = true },
            "on_result_diagnostics",
            "default",
        },
    }
end

local function failed_build_definition()
    return {
        name = "C++ Build",
        cmd = { "false" },
        components = { "default" },
    }
end

local function new_cpp_build_task(ctx)
    return overseer.new_task(cpp_build_definition(ctx))
end

overseer.register_template({
    name = "C++ Build",
    desc = "Compilar o arquivo C++ atual com clang++",
    tags = { overseer.TAG.BUILD },
    condition = { filetype = { "cpp" } },
    builder = function()
        local ctx = cpp_context()
        if not ctx then
            return failed_build_definition()
        end

        return cpp_build_definition(ctx)
    end,
})

local function build_cpp()
    local ctx = cpp_context()
    if not ctx then
        return
    end

    new_cpp_build_task(ctx):start()
end

local function build_and_run_cpp()
    local ctx = cpp_context()
    if not ctx then
        return
    end

    local build = new_cpp_build_task(ctx)

    build:subscribe("on_complete", function(_, status)
        if status ~= overseer.STATUS.SUCCESS then
            return
        end

        vim.schedule(function()
            local run = overseer.new_task({
                name = "C++ Run · " .. ctx.stem,
                cmd = { ctx.output },
                cwd = ctx.dir,
                components = { "default" },
            })

            run:start()

            vim.schedule(function()
                run:open_output("horizontal")
                vim.cmd("resize 12")
                vim.cmd("startinsert")
            end)
        end)
    end)

    build:start()
end

local function restart_last_task()
    local tasks = overseer.list_tasks({ recent_first = true })
    if vim.tbl_isempty(tasks) then
        vim.notify("Nenhuma tarefa do Overseer foi executada ainda.", vim.log.levels.WARN, { title = "Overseer" })
        return
    end

    overseer.run_action(tasks[1], "restart")
end

vim.keymap.set("n", "<leader>rb", build_cpp, { desc = "Build C++ atual" })
vim.keymap.set("n", "<leader>rr", build_and_run_cpp, { desc = "Build e executar C++" })
vim.keymap.set("n", "<leader>rt", "<cmd>OverseerRun<CR>", { desc = "Executar tarefa" })
vim.keymap.set("n", "<leader>ru", "<cmd>OverseerToggle<CR>", { desc = "Alternar tarefas" })
vim.keymap.set("n", "<leader>rl", restart_last_task, { desc = "Repetir última tarefa" })
