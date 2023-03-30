-- Stop quick-scope highlighting after 160 characters
vim.g.qs_max_chars = 160

local color_group = vim.api.nvim_create_augroup("quick_scope_highlight_colors", { clear = true })

vim.api.nvim_create_autocmd(
    "ColorScheme",
    {
	command = "highlight QuickScopePrimary guifg='#5fffff' gui=underline ctermfg=112 cterm=underline",
	group = color_group,
	pattern = "*",
    }
)
vim.api.nvim_create_autocmd(
    "ColorScheme",
    {
	command = "highlight QuickScopeSecondary guifg='#EAFF92' gui=underline ctermfg=140 cterm=underline",
	group = color_group,
	pattern = "*",
    }
)

local display_group = vim.api.nvim_create_augroup("quick_scope_display_group", { clear = true })

-- Disable quick-scope on Terminal buffers because it tends to be distracting
--
-- Reference: https://github.com/unblevable/quick-scope#toggle-highlighting
--
vim.api.nvim_create_autocmd(
    {"TermEnter", "TermOpen"},
    {
	command = "let b:qs_local_disable=1",
	group = display_group,
	pattern = "*",
    }
)
