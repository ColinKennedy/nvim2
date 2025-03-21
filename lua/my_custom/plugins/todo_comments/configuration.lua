require("todo-comments").setup {
    signs = false, -- Don't show signs in the Vim gutter
    keywords = {
        FIX = { alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "IMPORTANT" } },
    },
}

vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next [t]odo comment" })
vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
