-- NOTE: Needed or zoomwintab will define keymaps
vim.g.zoomwintab_remap = 0

return {
    -- Zoxide auto-jump, but for Vim
    {
        "nanotee/zoxide.vim",
        dependencies = {
            -- TODO: Try to remove this fzf dependency
            "junegunn/fzf",  -- Needed for Zi
        },
        cmd = { "Z", "Zi" },
    },
    {
        "junegunn/fzf",
        build=function()
            -- vim.cmd[[call fzf#install()]]
            vim.fn["fzf#install"]()
        end,
        lazy = true,
        version = "0.*",
    },

    -- Integrate FZF into Neovim
    {
        "ibhagwan/fzf-lua",
        cmd = {
            "Commands",
            "FzfLua",
            "GFiles",
            "Helptags",
            "History",
            "Keymaps",
        },
        config = function() require("my_custom.plugins.fzf_lua.configuration") end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = require("my_custom.plugins.fzf_lua.keys"),
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
        config = function() require("my_custom.plugins.quick_scope.configuration") end,
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
        config = function() require("my_custom.plugins.leap.configuration") end,
        keys = {
            { "S", "<Plug>(leap-backward-to)", desc = "Leap backward to", silent = true },
            { "s", "<Plug>(leap-forward-to)", desc = "Leap forward to", silent = true },
        },
    },

    -- Use `jk` to exit -- INSERT -- mode. AND there's j/k input delay. Pretty useful.
    {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup{
                mappings = {
                    -- NOTE: This prevents jk from leaving VISUAL mode
                    v = {j = {k = "k"}},
                    t = {
                        j = {
                            k = [[<C-\><C-n>]],
                            j = "j",
                        },
                    },
                }
            }
        end,
    },


    -- Allow quick and easy navigation to common project files
    -- Files are saved in `:lua print(vim.fn.stdpath("data") .. "/grapple")`
    --
    {
        "cbochs/grapple.nvim",
        dependencies = {"ColinKennedy/plenary.nvim"},
        config = function() require("grapple").setup({ scope = "git_branch" }) end,
        keys = require("my_custom.plugins.grapple.keys"),
        version = "v0.*",
    },

    {
        -- Note: This plugin needs to load on-start-up I think. You can't defer-load it.
        "troydm/zoomwintab.vim",
        cmd = {"ZoomWinTabOut", "ZoomWinTabToggle"},
        keys = {
            {
                "<C-w>o",
                "<cmd>ZoomWinTabToggle<CR>",
                desc="Toggle full-screen or minimize a window.",
            },
        },
    },

    --- Use ctrl + alt + {h,j,k,l} to move quickly around a buffer
    {
        "aaronik/treewalker.nvim",
        keys = {
            {
                "<C-A-h>",
                '<cmd>Treewalker Left<CR>',
                noremap = true,
                silent = true,
            },
            {
                "<C-A-j>",
                '<cmd>Treewalker Down<CR>',
                noremap = true,
                silent = true,
            },
            {
                "<C-A-k>",
                '<cmd>Treewalker Up<CR>',
                noremap = true,
                silent = true,
            },
            {
                "<C-A-l>",
                '<cmd>Treewalker Right<CR>',
                noremap = true,
                silent = true,
            },
        }
    },

    -- This lets you repeat motions. e.g. [q / ]q can be repeated with just
    -- ; (forwards) or , (backwards). It's super useful!
    --
    {
        'mawkler/demicolon.nvim',
        keys = { ',', ';', 'F', 'T', 'f', 't' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        opts = {
            integrations = {
                gitsigns = {
                    enabled = true,
                    keymaps = {
                        -- NOTE: The default mappings for gitsigns.nvim is [c and ]c but
                        -- I use [g and ]g.
                        --
                        next = ']g',
                        prev = '[g',
                    },
                },
            },
        },
    }
}
