return {
    {
        -- Async Make + awesome quick-fix window error reporting
        "ColinKennedy/vim-dispatch",
        -- If `Dispatch ...` auto-complete is slow in WSL, remember to remove Windows paths.
        --
        -- Reference: https://stackoverflow.com/questions/51336147/how-to-remove-the-win10s-path-from-wsl
        --
        cmd = { "Dispatch", "Make" },
        config = function()
            vim.g.dispatch_no_maps = 1
        end,
        version = "1.*",
    },

    -- Quickfix auto previews and other fun features
    {
        "kevinhwang91/nvim-bqf",
        dependencies = { "junegunn/fzf", "nvim-treesitter/nvim-treesitter" },
        ft = "qf",
        -- TODO: Add back in once there are new tags that include this patch
        --
        -- Reference: https://github.com/kevinhwang91/nvim-bqf/issues/134
        --
        -- version = "1.*",
    },

    -- Extra quick-fix commands
    {
        "ColinKennedy/vim-qf",
        branch = "custom_edits",
        config = function()
            require("my_custom.plugins.vim_qf.configuration")
        end,
        ft = "qf",
        keys = {
            {
                "<leader>tq",
                "<Plug>(qf_qf_toggle_stay)",
                desc = "[t]oggle [q]uickfix window.",
            },
        },
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
