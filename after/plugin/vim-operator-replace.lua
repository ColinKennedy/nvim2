-- Change the p[ut] key to now be a text object, like yy!
vim.keymap.set("n", "p", "<Plug>(operator-replace)")
vim.keymap.set("n", "pp", "p")

-- Set P to <NOP> so that it's not possible to accidentally put text
-- twice, using the P key.
--
vim.keymap.set("n", "P", "<NOP>")
vim.keymap.set("n", "PP", "P")
