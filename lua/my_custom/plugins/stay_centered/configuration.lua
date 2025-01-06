require("stay-centered").setup {
    -- Reference: https://github.com/akinsho/toggleterm.nvim
    skip_filetypes = { "toggleterm" },
}

-- Force Vim's cursor to stay in the center of the screen, in
-- a terminal We use a slightly different way of centering because
-- it doesn't look at good on a terminal buffer compared to
-- a normal buffer.
--
vim.api.nvim_create_autocmd("TermEnter", {
    callback = function()
        vim.api.nvim_create_autocmd({ "WinNew" }, {
            callback = function()
                vim.wo.scrolloff = 999
            end,
            once = true,
        })
    end,
    pattern = "term://*toggleterm#*",
    once = true,
})
