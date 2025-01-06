vim.cmd.colorscheme("hybrid2")

-- Show namespaces as a separate color
-- TODO: Get this color automatically
vim.api.nvim_set_hl(0, "@namespace", { fg = "#707880", ctermfg = 243 })

-- https://github.com/stsewd/tree-sitter-comment
--
-- Installed via ``:TSInstall comment``
--
vim.api.nvim_set_hl(0, "@text.danger", { link = "SpellBad" })
vim.api.nvim_set_hl(0, "@text.question", { link = "SpellLocal" })
vim.api.nvim_set_hl(0, "@text.note", { link = "SpellCap" })

-- Show trailing whitespace as red text
-- TODO: Get this color automatically
vim.api.nvim_set_hl(0, "NonText", { bg = "#5f0000", ctermbg = 52 })
