require("live-rename").setup({
    prepare_rename = true,
    request_timeout = 3000,
    show_other_ocurrences = true,
    use_patterns = true,
    scratch_register = "l",
    hl = {
        current = "CurSearch",
        others = "Search",
    },
})
