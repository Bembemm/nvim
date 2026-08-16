local snacks = require("snacks")

-- Use Snacks' compact status column without enabling another overlapping plugin.
-- It keeps marks/diagnostics on the left, line numbers in the middle and Git/folds on the right.
snacks.config.statuscolumn = {
    left = { "mark", "sign" },
    right = { "fold", "git" },
    folds = {
        open = false,
        git_hl = true,
    },
    refresh = 50,
}

-- Configure it manually so :checkhealth snacks reports it as an intentional
-- statuscolumn while preserving the rest of the Snacks setup in plugin/snacks.lua.
vim.o.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
