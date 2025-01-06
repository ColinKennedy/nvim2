return {
    -- TODO: Fix this again
    -- Enable auto-completion in Neovim
    {
        "iguanacucumber/magazine.nvim",
        config = function()
            require("my_custom.plugins.nvim_cmp.configuration")
        end,
        dependencies = require("my_custom.plugins.nvim_cmp.dependencies"),
        name = "nvim-cmp", -- Otherwise highlighting gets messed up
        -- TODO: Possibly re-add tags if this issue ever addresses it.
        --
        -- Reference: https://github.com/hrsh7th/nvim-cmp/issues/1830
        --
        -- version = "0.*",
    },

    -- Auto-complete the command-line
    {
        "ColinKennedy/cmp-cmdline",
        branch = "combined_branch",
        lazy = true,
    },

    -- Allows (but does not link) LuaSnip snippets to nvim-cmp
    {
        "saadparwaiz1/cmp_luasnip",
        lazy = true,
    },
}
