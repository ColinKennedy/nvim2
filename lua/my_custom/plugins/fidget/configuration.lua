require("fidget").setup {
    notification = {
        window = {
            winblend = 10,
        },
    },
    progress = {
        display = {
            progress_icon = {
                pattern = "meter",
            },
        },
    },
}

vim.api.nvim_set_hl(0, "FidgetTask", { fg = "#4b5156", ctermfg = 65 })
vim.api.nvim_set_hl(0, "FidgetTitle", { link = "Identifier" })
