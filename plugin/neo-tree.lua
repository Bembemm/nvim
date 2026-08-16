local neotree = require("neo-tree")

neotree.setup({
    -- Neo-tree is the visual IDE-style sidebar; Oil remains the default directory editor.
    sources = { "filesystem" },
    close_if_last_window = false,
    popup_border_style = "",
    enable_git_status = true,
    enable_diagnostics = true,
    enable_modified_markers = true,
    enable_opened_markers = true,
    git_status_async = true,

    -- Reuse Snacks.input through vim.ui.input instead of adding another input UI.
    use_popups_for_input = false,

    open_files_do_not_replace_types = {
        "terminal",
        "Trouble",
        "qf",
        "snacks_dashboard",
        "oil",
        "dap-view",
    },

    default_component_configs = {
        container = {
            enable_character_fade = true,
        },
        indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            with_expanders = true,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            default = "",
        },
        modified = {
            symbol = "●",
            highlight = "NeoTreeModified",
        },
        git_status = {
            symbols = {
                added = "✚",
                modified = "",
                deleted = "✖",
                renamed = "󰁕",
                untracked = "",
                ignored = "",
                unstaged = "󰄱",
                staged = "",
                conflict = "",
            },
        },
    },

    window = {
        position = "left",
        width = 32,
        auto_expand_width = false,
        mappings = {
            ["l"] = "open",
            ["h"] = "close_node",
        },
    },

    filesystem = {
        -- Do not take over directory opening: Oil owns that responsibility.
        hijack_netrw_behavior = "disabled",
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
        },
        use_libuv_file_watcher = true,
        group_empty_dirs = true,
        filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = false,
        },
    },
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle filesystem left<cr>", { desc = "Explorer (Neo-tree)" })
vim.keymap.set("n", "<leader>E", "<cmd>Neotree reveal filesystem left<cr>", { desc = "Revelar arquivo no Neo-tree" })
