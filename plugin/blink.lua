local blink = require("blink.cmp")

blink.build():pwait()

blink.setup({
    keymap = { preset = "default" },

    appearance = {
        nerd_font_variant = "mono",
    },

    snippets = { preset = "default" },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },

    signature = { enabled = true },

    completion = {
        documentation = {
            auto_show = true,
            window = { border = "rounded" },
        },
        menu = {
            draw = {
                treesitter = { "lsp" },
                columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
            },
        },
    },
})
