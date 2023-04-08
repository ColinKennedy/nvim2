vim.g.gitgutter_suppress_warnings = 1
vim.g.gitgutter_max_signs = 2000

-- Force gitgutter to update any time I save so make sure that signs are current
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
	pattern = "*",
	command = "GitGutter",
    }
)
