vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

local treesitter = require("nvim-treesitter")

treesitter.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
})

local parsers = {
    "lua",
    "cpp",
    "vim",
    "vimdoc",
    "query",
}

treesitter.install(parsers):wait(300000)

vim.api.nvim_create_autocmd("FileType", {
    pattern = parsers,
    callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
