local treesitter = require("nvim-treesitter")

treesitter.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
})

local parsers = {
    "lua",
    "c",
    "cpp",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
}

treesitter.install(parsers):wait(300000)

vim.api.nvim_create_autocmd("FileType", {
    pattern = parsers,
    callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
