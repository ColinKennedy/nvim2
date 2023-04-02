-- Force gitgutter to update any time I save so make sure that signs are current
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*",
        command = "GitGutter",
    }
)
