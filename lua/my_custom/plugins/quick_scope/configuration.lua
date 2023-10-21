-- Stop quick-scope highlighting after 160 characters
vim.g.qs_max_chars = 160

vim.api.nvim_set_hl(0, "QuickScopePrimary", { fg = "#D7FFAF", ctermfg = 193, underline = true })
vim.api.nvim_set_hl(0, "QuickScopeSecondary", { fg = "#5FFFFF", ctermfg = 189, underline = true })

local display_group = vim.api.nvim_create_augroup("quick_scope_display_group", { clear = true })

-- Disable quick-scope on Terminal buffers because it tends to be distracting
--
-- Reference: https://github.com/unblevable/quick-scope#toggle-highlighting
--
vim.api.nvim_create_autocmd({ "TermEnter", "TermOpen" }, {
    command = "let b:qs_local_disable=1",
    group = display_group,
    pattern = "*",
})
