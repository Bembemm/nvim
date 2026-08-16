local gitsigns = require("gitsigns")

gitsigns.setup({
    signcolumn = true,
    numhl = true,
    linehl = false,
    word_diff = false,
    current_line_blame = false,
    current_line_blame_opts = {
        delay = 500,
        virt_text = true,
        virt_text_pos = "eol",
        ignore_whitespace = true,
        use_focus = true,
    },
    on_attach = function(bufnr)
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
                buffer = bufnr,
                silent = true,
                desc = desc,
            })
        end

        -- Navegação entre alterações Git
        map("n", "]h", function()
            gitsigns.nav_hunk("next")
        end, "Próximo hunk")

        map("n", "[h", function()
            gitsigns.nav_hunk("prev")
        end, "Hunk anterior")

        -- Stage / reset de hunks
        map("n", "<leader>gs", gitsigns.stage_hunk, "Stage/unstage hunk")
        map("v", "<leader>gs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage/unstage seleção")

        map("n", "<leader>gr", gitsigns.reset_hunk, "Reset hunk")
        map("v", "<leader>gr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset seleção")

        -- Inspeção de alterações
        map("n", "<leader>gp", gitsigns.preview_hunk, "Preview do hunk")
        map("n", "<leader>gi", gitsigns.preview_hunk_inline, "Preview inline do hunk")
        map("n", "<leader>gb", function()
            gitsigns.blame_line({ full = true })
        end, "Blame da linha")
        map("n", "<leader>gB", gitsigns.toggle_current_line_blame, "Alternar blame inline")

        -- Diff do arquivo
        map("n", "<leader>gd", gitsigns.diffthis, "Diff do arquivo")
        map("n", "<leader>gD", function()
            gitsigns.diffthis("~")
        end, "Diff contra revisão anterior")

        -- Toggles visuais sob demanda
        map("n", "<leader>gw", gitsigns.toggle_word_diff, "Alternar word diff")

        -- Text object do hunk atual
        map({ "o", "x" }, "ih", gitsigns.select_hunk, "Selecionar hunk")
    end,
})
