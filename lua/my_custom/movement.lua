return {
    packages = {
        -- Autojump but for Vim. Use `:J` to change directories
        -- or `:Cd` as a replacement to `:cd`.
        --
        {
            "padde/jump.vim",
            cmd = {
                "J",
                "Jc",
                "Jo",
                "Jco",
            },
        },

        -- TODO: Try this again
        -- {
        --     "nvim-telescope/telescope.nvim",
        --     dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
        --     tag = "0.1.1",
        --     cmd = {
        --     }
        -- },
        -- {
        --     "nvim-lua/plenary.nvim",
        --     lazy = true,
        -- },
        -- {
        --     "nvim-tree/nvim-web-devicons",
        --     lazy = true,
        -- },

        {
            "junegunn/fzf",
            build=function()
                vim.cmd[[call fzf#install()]]
            end,
        },
        {
            "junegunn/fzf.vim",
            config = function()
                -- vim.cmd[[let g:fzf_layout = { 'down': '~80%' }]]
                vim.cmd[[let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }]]
            end,
            dependencies = { "junegunn/fzf" },
            cmd = {
                "Buffers",
                "Files",
                "GFiles",
                "History",
                "Lines",
            },
        },

        -- A more modern, faster grep engine.
        -- Requires https://github.com/BurntSushi/ripgrep to be installed
        --
        {
            "jremmen/vim-ripgrep",
            cmd = "Rg",
        },

        -- A plugin that highlights the character to move to a word or WORD with f/t
        --
        -- Note:
        --     The original repo, unblevable/quick-scope, has been dead for a while
        --     bradford-smith94 has been added as a maintainer so hopefully the repo
        --     will get some action but, for now, use his fork
        --
        -- Reference:
        --     https://github.com/unblevable/quick-scope/issues/38
        --
        -- TODO: Check if lazy-loading can make this load faster
        --
        {
            "bradford-smith94/quick-scope",
            event = { "CursorMoved", "CursorMovedI" },
            config = function()
                -- Stop quick-scope highlighting after 160 characters
                vim.g.qs_max_chars = 160

                vim.api.nvim_create_augroup("qs_colors", { clear = true })
                vim.api.nvim_create_autocmd(
                    "ColorScheme",
                    {
                        group = "qs_colors",
                        pattern = "*",
                        command = "highlight QuickScopePrimary guifg='#5fffff' gui=underline ctermfg=112 cterm=underline",
                    }
                )
                vim.api.nvim_create_autocmd(
                    "ColorScheme",
                    {
                        group = "qs_colors",
                        pattern = "*",
                        command = "highlight QuickScopeSecondary guifg='#EAFF92' gui=underline ctermfg=140 cterm=underline",
                    }
                )
            end
        },

    }
}
