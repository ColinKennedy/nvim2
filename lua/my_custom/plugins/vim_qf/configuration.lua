vim.g.qf_auto_resize = 0
vim.g.qf_window_bottom = 0

vim.api.nvim_create_autocmd(
    "FileType",
    {
        callback = function()
            vim.keymap.set(
                "n",
                "{",
                "<Plug>(qf_previous_file)",
                {
                    buffer=true,
                    desc="Select the previous quick-fix entry of a different file.",
                }
            )
            vim.keymap.set(
                "n",
                "}",
                "<Plug>(qf_next_file)",
                {
                    buffer=true,
                    desc="Select the next quick-fix entry of a different file.",
                }
            )
        end,
        pattern = "qf"
    }
)
