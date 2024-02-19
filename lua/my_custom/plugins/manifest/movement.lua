return {
    -- Zoxide auto-jump, but for Vim
    {
        "nanotee/zoxide.vim",
        cmd = {"Z", "Zi"},
        dependencies = {
            "junegunn/fzf.vim",  -- Needed for ``:Zi``
        },
        keys = {
            {
                "<Space>Z",
                ":Zi<CR>",
                desc="[Z]oxide's interative pwd switcher.",
            },
        },
    },

    {
        "junegunn/fzf",
        build=function()
            vim.cmd[[call fzf#install()]]
        end,
        lazy = true,
        version = "0.*",
    },
    {
        "junegunn/fzf.vim",
        config = function()
            -- Define Zz to get around an error in lazy.nvim
            -- This should be temporary, ideally. Delete, later
            --
            -- Reference: https://github.com/folke/lazy.nvim/issues/718
            --
            vim.cmd[[let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }]]
            vim.api.nvim_create_user_command(
                "Args",
                ":call fzf#run(fzf#wrap({'source': sort(argv())}))",
                {}
            )

            vim.api.nvim_create_user_command(
                "FzfCd",
                ":call FzfCd()",
                {
                    desc="Search within the current :pwd for a new directory and :cd into it.",
                }
            )
        end,
        dependencies = { "junegunn/fzf" },
        cmd = {
            "Args",
            "Buffers",
            "Commands",
            "FZF",
            "Files",
            "FzfCd",
            "GFiles",
            "Helptags",
            "History",
            "Lines",
        },
        keys = {
            {
                "<space>B",
                ":Buffers<CR>",
                desc="Search existing [B]uffers and select + view it.",
            },
            {
                "<leader>cD",
                ":FzfCd<CR>",
                desc="Search within the current :pwd for a new directory and :cd into it.",
                silent=true,
            },
            {
                "<space>e",
                ":Files<CR>",
                desc="Find and [e]dit a file starting from `:pwd`.",
            },
            {
                "<space>L",
                ":Lines<CR>",
                desc="[L]ines searcher (current file)",
            },
            {
                "<space>A",
                ":Args<CR>",
                desc="Select a new [A]rgs file from the `:args` list.",
            },
            {
                "<space>E",
                ":call searcher#search_project_files()<CR>",
                desc="[E]dit a new project root file.",
            },
        },
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
        config = function()
            require("my_custom.plugins.data.quick_scope")
        end,
        init = function()
            require("my_custom.utilities.utility").lazy_load("quick-scope")
        end,
        event = "VeryLazy",
        version = "2.*",
    },

    -- Use the s/S key to hop quickly from one place to another.
    --
    -- Usage:
    --     - Press s
    --     - Type a letter
    --     - Type another letter
    --     - If your text that you want to jump to **doesn't** light up then press <Enter>
    --         - You're done
    --     - If it has a lit-up letter next to it, press it
    --         - You're done
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").init_highlight()

            require('leap').opts.safe_labels = {
                "a", "s", "d", "f", "j", "k", "l", ";",
                "g", "h",
                "A", "S", "D", "F", "J", "K", "L",
            }
        end,
        keys = {
            { "S", "<Plug>(leap-backward-to)", desc = "Leap backward to", silent = true },
            { "s", "<Plug>(leap-forward-to)", desc = "Leap forward to", silent = true },
        },
    },

    -- Use `jk` to exit -- INSERT -- mode. AND there's j/k input delay. Pretty useful.
    {
        "max397574/better-escape.nvim",
        config = function()
          require("better_escape").setup()
        end,
        event = "InsertEnter",
    },

}
