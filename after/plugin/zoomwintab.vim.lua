vim.keymap.set(
    "n",
    "<C-w>o",
    ":ZoomWinTabToggle<CR>",
    {desc="Toggle full-screen or minimize a window."}
)
vim.keymap.set(
    "n",
    "<C-w><C-o>",
    ":ZoomWinTabToggle<CR>",
    {desc="Toggle full-screen or minimize a window."}
)
vim.cmd[[nnoremap <C-w_o> :ZoomWinTabToggle<CR>]]  -- Not sure what this mapping does.
