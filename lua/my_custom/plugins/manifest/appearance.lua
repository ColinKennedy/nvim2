return {
    {
        "ColinKennedy/hybrid2.nvim",
        priority = 1000,  -- Load this first
        config = function() require("my_custom.plugins.hybrid2.configuration") end,
        version = "1.*"
    },

    {
        "romainl/vim-cool",
        event = "VeryLazy",
    },

    -- TODO: Make this prettier. Like how NvChad works
    -- Shows added, removed, etc git hunks
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require("gitsigns")

            gitsigns.setup({ signs = { changedelete = { text = "～" } } })
        end,
        ft = "gitcommit",
        init = function() require("my_custom.plugins.gitsigns.initialization") end,
        keys = require("my_custom.plugins.gitsigns.keys"),
        -- version = "0.*"  -- This release is super old and has bugs. But ideally we'd use it
    },

    -- TODO: Add this later
    --
    -- A plugin that adds Prim type names to USD auto-complete results
    -- Plug 'https://korinkite@bitbucket.org/korinkite/vim-usd-complete-schemas.git'

    -- Add a quick status bar plugin
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function() require("my_custom.plugins.lualine.configuration") end,
        event = "VeryLazy",
    },

    -- Extra, optional icons for ``ColinKennedy/nvim-dap-ui``
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("my_custom.plugins.nvim_web_devicons.configuration")
        end,
        lazy = true,
    },

    -- TODO: Do I even still need this? Remove?
    -- Enhanced markdown highlighting and syntax
    {
        "tpope/vim-markdown",
        ft = "markdown",
        config = function()
            vim.g.markdown_fenced_languages = {
                "bash=sh",
                "cpp",
                "js=javascript",
                "json",
                "lua",
                "php",
                "python",
                "sh",
                "sql",
                -- "usd=usda",  -- TODO: Add this, later
                -- "usda",  -- TODO: Add this, later
                "yaml",
            }
        end,
    },

    -- Show the current context at the top of the Vim window
    --
    -- Somewhat unrelated but a useful reference:
    --     https://github.com/ray-x/nvim/blob/c501ff52438d77652f529d13bea55b799850d8a7/lua/modules/ui/winbar.lua
    --
    {
        "ColinKennedy/winbar.nvim",
        config = function() require("my_custom.plugins.winbar.configuration") end,
        dependencies = {"ColinKennedy/nvim-gps", "nvim-tree/nvim-web-devicons"},
        event = "VeryLazy",
    },

    -- Use treesitter to show your current cursor context (class > function > etc)
    {
        "ColinKennedy/nvim-gps",
        config = true,
        dependencies = {"nvim-treesitter/nvim-treesitter"},
        lazy = true,
    },

    -- TODO: Figure out how to lazy-load this plug-in
    --
    -- Overrides Vim's default Command mode and provides "wild card" results
    -- + icons. Mostly cosmetic and isn't "necessary", but it is a fun little
    -- plug-in as long as it's harmless.
    --
    {
        "gelguy/wilder.nvim",
        config = function() require("my_custom.plugins.wilder.configuration") end,
        dependencies = {"romgrk/fzy-lua-native"},
        -- Reference: https://github.com/gelguy/wilder.nvim#faster-startup-time
        event = "CmdlineEnter",
    },

    -- Keep the Vim cursor in the center of the screen, even at the bottom of the buffer.
    --
    -- Maybe in the future this will change and Vim will have native support for this.
    --
    -- Reference: https://github.com/vim/vim/issues/13428
    --
    {
        "arnamak/stay-centered.nvim",
        config = function() require("my_custom.plugins.stay_centered.configuration") end,
    },

    -- Highlight the whole line when you're in linewise selection mode.
    --
    -- Why is this not Vim's default behavior??
    --
    {
        "ColinKennedy/full_visual_line.nvim",
        -- TODO: Remove this fork + branch once the PR is merged
        --
        -- Reference: https://github.com/0xAdk/full_visual_line.nvim/pull/3
        --
        branch = "fix_visual_line_with_vim_ninja_feet",
        keys = "V",
        opts = {},
    },
}
