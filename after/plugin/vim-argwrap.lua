vim.keymap.set(
    "n",
    "<leader>sa",
    ":ArgWrap<CR>",
    {
        desc="[s]plit [a]rgs - Split a line with arguments into multiple lines.",
        silent=true,
    }
)
