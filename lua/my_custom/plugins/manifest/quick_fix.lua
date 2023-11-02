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
        config = function()
            vim.api.nvim_create_autocmd(
                "FileType",
                {
                    callback = function()
                        vim.keymap.set(
                            "n",
                            "<Enter>",
                            function()
                                local fixer = require("my_custom.utilities.quick_fix_selection_fix")

                                -- Switch to the proper window for quick-fix to
                                -- apply to. Then quickly switch back to the
                                -- quick-fix buffer (because if we don't then
                                -- `require("bqf.qfwin.handler").open(false)`
                                -- will fail.
                                --
                                local current_window = vim.api.nvim_get_current_win()
                                fixer.choose_last_window()
                                vim.api.nvim_set_current_win(current_window)

                                require("bqf.qfwin.handler").open(false)
                            end,
                            {
                                nowait=true,
                                buffer=true,
                                desc="Select the current quick-fix entry.",
                            }
                        )
                    end,
                    pattern = "qf"
                }
            )
        end,
        dependencies = {"junegunn/fzf", "nvim-treesitter/nvim-treesitter"},
        ft = "qf",
        version = "0.*",
    },

    -- Extra quick-fix commands
    {
        "romainl/vim-qf",
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
