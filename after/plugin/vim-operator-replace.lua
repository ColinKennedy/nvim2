-- Change the p[ut] key to now be a text object, like yy!
vim.keymap.set(
    "n",
    "p",
    "<Plug>(operator-replace)",
    {desc="Change `p` to act more like `y`."}
)
vim.keymap.set("n", "pp", "p", {desc="Change `p` to act more like `y`."})

-- Set P to <NOP> so that it's not possible to accidentally put text
-- twice, using the P key.
--
vim.keymap.set("n", "P", "<NOP>", {desc="Prevent text from being put, twice."})
vim.keymap.set(
    "n",
    "PP",
    "P",
    {desc="Put text, like you normally would in Vim, but how [Y]ank does it."}
)
