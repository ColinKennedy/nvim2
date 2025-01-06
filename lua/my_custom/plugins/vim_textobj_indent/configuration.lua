vim.g.textobj_indent_no_default_key_mappings = "1"

vim.keymap.set(
    "o",
    "ai",
    "<Plug>(textobj-indent-i)",
    { desc = "Select [a]round [i]ndent + outer indent. Stop at whitespace." }
)
vim.keymap.set(
    "x",
    "ai",
    "<Plug>(textobj-indent-i)",
    { desc = "Select [a]round [i]ndent + outer indent. Stop at whitespace." }
)
vim.keymap.set(
    "o",
    "ii",
    "<Plug>(textobj-indent-i)",
    { desc = "Select [i]nside all [i]ndent lines. Stop at whitespace." }
)
vim.keymap.set(
    "x",
    "ii",
    "<Plug>(textobj-indent-i)",
    { desc = "Select [i]nside all [i]ndent lines. Stop at whitespace." }
)
