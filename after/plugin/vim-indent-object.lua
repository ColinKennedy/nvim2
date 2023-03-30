vim.keymap.set("o", "aI", ':<C-u>cal HandleTextObjectMapping(0, 0, 0, [line("."), line("."), col("."), col(".")])<CR>', {silent=true})
vim.keymap.set("o", "iI", ':<C-u>cal HandleTextObjectMapping(1, 0, 0, [line("."), line("."), col("."), col(".")])<CR>', {silent=true})
vim.keymap.set("v", "aI", ':<C-u>cal HandleTextObjectMapping(0, 0, 1, [line("\'<"), line("\'>"), col("\'<"), col("\'>")])<CR><Esc>gv', {silent=true})
vim.keymap.set("v", "iI", ':<C-u>cal HandleTextObjectMapping(1, 0, 1, [line("\'<"), line("\'>"), col("\'<"), col("\'>")])<CR><Esc>gv', {silent=true})
