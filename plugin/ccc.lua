local ccc = require("ccc")

ccc.setup({
    inputs = {
        ccc.input.rgb,
        ccc.input.hsl,
        ccc.input.hwb,
        ccc.input.lab,
        ccc.input.lch,
        ccc.input.oklab,
        ccc.input.oklch,
        ccc.input.cmyk,
        ccc.input.hsluv,
        ccc.input.okhsl,
        ccc.input.hsv,
        ccc.input.okhsv,
        ccc.input.xyz,
    },
    outputs = {
        ccc.output.hex,
        ccc.output.hex_short,
        ccc.output.css_rgb,
        ccc.output.css_rgba,
        ccc.output.css_hsl,
        ccc.output.css_hwb,
        ccc.output.css_lab,
        ccc.output.css_lch,
        ccc.output.css_oklab,
        ccc.output.css_oklch,
        ccc.output.float,
    },
    pickers = {
        ccc.picker.hex,
        ccc.picker.css_rgb,
        ccc.picker.css_hsl,
        ccc.picker.css_hwb,
        ccc.picker.css_lab,
        ccc.picker.css_lch,
        ccc.picker.css_oklab,
        ccc.picker.css_oklch,
        ccc.picker.css_name,
    },
    preserve = true,
    alpha_show = "auto",
    highlight_mode = "virtual",
    virtual_symbol = "■ ",
    virtual_pos = "inline-left",
    lsp = true,
    highlighter = {
        auto_enable = true,
        lsp = true,
        update_insert = true,
    },
})

vim.keymap.set("n", "<leader>cp", "<cmd>CccPick<CR>", { desc = "Escolher / editar cor" })
vim.keymap.set("n", "<leader>cc", "<cmd>CccConvert<CR>", { desc = "Converter formato da cor" })
vim.keymap.set("n", "<leader>ct", "<cmd>CccHighlighterToggle<CR>", { desc = "Alternar destaque de cores" })
