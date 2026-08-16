local leap = require("leap")

-- Mantém o fluxo próximo ao Flash: quando houver vários destinos,
-- o Leap espera a escolha explícita de um label em vez de auto-pular.
leap.opts.safe_labels = ""

leap.opts.preview = function(ch0, ch1, ch2)
    return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
end

local keymap = vim.keymap.set
local modes = { "n", "x", "o" }

keymap(modes, "s", "<Plug>(leap)", { desc = "Leap no buffer atual" })

keymap({ "n", "o" }, "gs", "<Plug>(leap-remote)", { desc = "Leap remoto" })
keymap({ "n", "o" }, "gS", "<Plug>(leap-remote-linewise)", { desc = "Leap remoto por linha" })
keymap("o", "R", "<Plug>(leap-remote-line)", { desc = "Leap remoto em uma linha" })
keymap({ "x", "o" }, "ar", "<Plug>(leap-remote-text-object)", { desc = "Leap objeto remoto externo" })
keymap({ "x", "o" }, "ir", "<Plug>(leap-remote-inner-text-object)", { desc = "Leap objeto remoto interno" })

keymap({ "x", "o" }, "an", function()
    require("leap.treesitter").select({
        opts = require("leap.user").with_traversal_keys("n", "N"),
    })
end, { desc = "Leap nó Treesitter" })

keymap(modes, "<leader>jw", "<Plug>(leap-from-window)", { desc = "Leap a partir de outra janela" })
keymap(modes, "<leader>ja", "<Plug>(leap-anywhere)", { desc = "Leap em todas as janelas" })
keymap(modes, "<leader>jf", "<Plug>(leap-forward)", { desc = "Leap para frente" })
keymap(modes, "<leader>jb", "<Plug>(leap-backward)", { desc = "Leap para trás" })
keymap(modes, "<leader>jF", "<Plug>(leap-forward-next-to)", { desc = "Leap para frente até antes" })
keymap(modes, "<leader>jB", "<Plug>(leap-backward-next-to)", { desc = "Leap para trás até depois" })
keymap(modes, "<leader>jt", "<Plug>(leap-next-to)", { desc = "Leap até próximo do alvo" })
