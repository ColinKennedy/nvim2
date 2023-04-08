-- Stop quick-scope highlighting after 160 characters
vim.g.qs_max_chars = 160

vim.api.nvim_create_augroup("qs_colors", { clear = true })
vim.api.nvim_create_autocmd(
    "ColorScheme",
    {
	group = "qs_colors",
	pattern = "*",
	command = "highlight QuickScopePrimary guifg='#5fffff' gui=underline ctermfg=112 cterm=underline",
    }
)
vim.api.nvim_create_autocmd(
    "ColorScheme",
    {
	group = "qs_colors",
	pattern = "*",
	command = "highlight QuickScopeSecondary guifg='#EAFF92' gui=underline ctermfg=140 cterm=underline",
    }
)
