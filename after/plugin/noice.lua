local noice = require("noice")

noice.setup({
    cmdline = {
        enabled = true,
        view = "cmdline_popup",
    },
    messages = {
        enabled = true,
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
    },
    popupmenu = {
        enabled = true,
        backend = "nui",
    },
    notify = {
        enabled = true,
        view = "notify",
    },
    lsp = {
        progress = {
            enabled = true,
            view = "mini",
        },
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
        },
        hover = {
            enabled = true,
            silent = false,
        },
        signature = {
            enabled = true,
            auto_open = {
                enabled = true,
                trigger = true,
                throttle = 50,
            },
        },
    },
    views = {
        notify = {
            backend = "snacks",
            fallback = "mini",
        },
        cmdline_popup = {
            border = {
                style = "rounded",
            },
        },
        popupmenu = {
            border = {
                style = "rounded",
            },
        },
    },
    presets = {
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
    },
})

vim.keymap.set("n", "<leader>nn", "<cmd>Noice<CR>", {
    desc = "Noice histórico",
})

vim.keymap.set("n", "<leader>np", "<cmd>Noice pick<CR>", {
    desc = "Noice picker",
})

vim.keymap.set("n", "<leader>nl", "<cmd>Noice last<CR>", {
    desc = "Noice última mensagem",
})

vim.keymap.set("n", "<leader>ne", "<cmd>Noice errors<CR>", {
    desc = "Noice erros",
})

vim.keymap.set("n", "<leader>nd", "<cmd>Noice dismiss<CR>", {
    desc = "Noice dispensar mensagens",
})
