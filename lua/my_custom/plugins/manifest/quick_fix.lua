return {
    {
        -- Async Make + awesome quick-fix window error reporting
        "ColinKennedy/vim-dispatch",
        cmd = { "Dispatch", "Make" },
        config = function()
            vim.g.dispatch_no_maps = 1
        end,
        version = "1.*",
    },

    -- Quickfix auto previews and other fun features
    {
        "kevinhwang91/nvim-bqf",
        dependencies = {"junegunn/fzf", "nvim-treesitter/nvim-treesitter"},
        ft = "qf",
        version = "0.*",
    },

    -- Extra quick-fix commands
    {
        "ColinKennedy/vim-qf",
        branch = "custom_edits",
        config = function()
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
        end,
        ft = "qf"
    },

    -- Allow the quickfix buffer to be directly editted. Finally!
    -- I hear this plug-in might be a bit buggy. Keep an eye out for it.
    --
    -- Possible alternative - https://github.com/stefandtw/quickfix-reflector.vim
    --
    -- Reference: https://www.reddit.com/r/neovim/comments/16k6spq/best_quickfixlist_plugin/
    --
    {
        "itchyny/vim-qfedit",
        ft = "qf",
    },
}
