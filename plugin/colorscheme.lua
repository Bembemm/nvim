local monokai = require("monokai")
local palette = vim.deepcopy(monokai.classic)

palette.brown = "#625E4C"

monokai.setup({
    palette = palette,
    italics = true,
})
