local dropbar = require("dropbar")
local dropbar_api = require("dropbar.api")

local buf_update_events = {
    "FileChangedShellPost",
    "TextChanged",
    "ModeChanged",
}

if vim.fn.exists("##BufModifiedSet") == 1 then
    table.insert(buf_update_events, 1, "BufModifiedSet")
end

dropbar.setup({
    bar = {
        update_events = {
            buf = buf_update_events,
        },
    },
})

vim.keymap.set("n", "<leader>;", dropbar_api.pick, {
    desc = "Dropbar escolher contexto",
})

vim.keymap.set("n", "[;", dropbar_api.goto_context_start, {
    desc = "Dropbar início do contexto",
})

vim.keymap.set("n", "];", dropbar_api.select_next_context, {
    desc = "Dropbar próximo contexto",
})
