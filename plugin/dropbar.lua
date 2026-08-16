local dropbar = require("dropbar")
local dropbar_api = require("dropbar.api")

dropbar.setup()

vim.keymap.set("n", "<leader>;", dropbar_api.pick, {
    desc = "Dropbar escolher contexto",
})

vim.keymap.set("n", "[;", dropbar_api.goto_context_start, {
    desc = "Dropbar início do contexto",
})

vim.keymap.set("n", "];", dropbar_api.select_next_context, {
    desc = "Dropbar próximo contexto",
})
