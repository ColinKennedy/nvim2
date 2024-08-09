return {
    -- The plug-in that adds LSPs of all languages to Neovim
    {
        "neovim/nvim-lspconfig",
        config = function() require("my_custom.plugins.nvim_lspconfig.configuration") end,
        dependencies = {
            "folke/neodev.nvim",  -- Needed for Neovim LSP auto-complete
            "williamboman/mason.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
    },

    {
        "pappasam/jedi-language-server",
        lazy = true,
        version = "0.*",
    },

    -- TODO: Fix this again
    -- Enable auto-completion in Neovim
    {
        "hrsh7th/nvim-cmp",
        config = function() require("my_custom.plugins.nvim_cmp.configuration") end,
        dependencies = require("my_custom.plugins.nvim_cmp.dependencies"),
        event = { "InsertEnter" },
        -- TODO: Possibly re-add tags if this issue ever addresses it.
        --
        -- Reference: https://github.com/hrsh7th/nvim-cmp/issues/1830
        --
        -- version = "0.*",
    },

    -- Allows (but does not link) LuaSnip snippets to nvim-cmp
    {
        "saadparwaiz1/cmp_luasnip",
        lazy = true,
    },

    -- Neovim snippet engine (which also displays in nvim-cmp)
    {
        "L3MON4D3/LuaSnip",
        config = function() require("my_custom.plugins.luasnip.configuration") end,
        event = "InsertEnter",
        version = "2.*",
    },

    --     -- TODO: Consider deprecating my current auto-pairs for this?
    --     -- autopairing of (){}[] etc
    --     -- {
    --     --   "windwp/nvim-autopairs",
    --     --   opts = {
    --     --     fast_wrap = {},
    --     --     disable_filetype = { "TelescopePrompt", "vim" },
    --     --   },
    --     --   config = function(_, opts)
    --     --     require("nvim-autopairs").setup(opts)
    --     --
    --     --     -- setup cmp for autopairs
    --     --     local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    --     --     require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    --     --   end,
    --     -- },

    -- -- TODO: Consider removing
    -- -- A mason.nvim and null-ls are great tools but they don't know how to communicate
    -- -- with one another. This plugin makes them cross-talk.
    -- --
    -- -- "Modern problems require modern solutions" - Dave Chappelle
    -- --
    -- {
    --     "jay-babu/mason-null-ls.nvim",
    --     config = function()
    --         require("mason-null-ls").setup(
    --             {
    --                 ensure_installed = nil,
    --                 automatic_installation = true,
    --                 automatic_setup = false,
    --             }
    --         )
    --     end,
    --     lazy = true,
    --     version = "2.*",
    -- },

    -- Linter package container / manager
    -- Important: CentOS 7 doesn't include an ensurepip/_bundled folder. It's
    -- incredibly annoying but you can fix it by manually installing the missing files.
    -- Reference: https://stackoverflow.com/a/33767179
    --
    -- Note: You can install specific versions of a package using ``:MasonInstall name@1.2.3``
    -- Reference: https://github.com/williamboman/mason.nvim/discussions/1024
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",  -- :MasonUpdate updates registry contents
        cmd = {"Mason", "MasonInstall", "MasonUninstall", "MasonUpdate"},
        config = function() require("my_custom.plugins.mason.configuration") end,
        version = "1.*",
    },

    -- -- TODO: Consider removing
    -- -- Integrates linters, formatters, and other features into Neovim's own LSP. Cool!
    -- {
    --     "nvimtools/none-ls.nvim",
    --     config = function()
    --         local null_ls = require("null-ls")
    --         local sources = {
    --             null_ls.builtins.code_actions.gitsigns,
    --             null_ls.builtins.diagnostics.pydocstyle.with(
    --                 {
    --                     diagnostic_config = { signs = false },
    --                     extra_args = { "--convention=google" }
    --                 }
    --             ),
    --             null_ls.builtins.diagnostics.pylint.with({diagnostic_config={signs=false}}),
    --             null_ls.builtins.formatting.black,
    --             null_ls.builtins.formatting.isort,
    --             null_ls.builtins.formatting.trim_whitespace,
    --             -- null_ls.builtins.diagnostics.ruff,
    --         }
    --         null_ls.setup({ sources = sources })
    --     end,
    --     dependencies = {
    --         "jay-babu/mason-null-ls.nvim",  -- Bootstrap pydocstyle, pylint, etc
    --         "ColinKennedy/plenary.nvim"
    --     },
    --     event = "VeryLazy",
    -- },

    -- Added my own fork of plenary.nvim because it doesn't work with older curl versions
    --
    -- Reference: https://github.com/nvim-lua/plenary.nvim/issues/495
    --
    {
        "ColinKennedy/plenary.nvim",
        branch = "fix_old_curl_version",
        lazy = true,
    },

    -- A visual progress indicator for slow LSPs. Very useful for C++ & USD
    {
        "j-hui/fidget.nvim",
        config = function() require("my_custom.plugins.fidget.configuration") end,
        event = { "LspAttach" },
    },

    -- Rust LSP tools
    {
        "ColinKennedy/rust-tools.nvim",
        config = function()
            local rust_tools = require("rust-tools")

            rust_tools.setup({})
        end,
        ft = "rust",
    },

    -- TODO: Possibly remove
    -- A simple linter that integrates with LSPs automatically
    {
        "mfussenegger/nvim-lint",
        config = function() require("my_custom.plugins.nvim_lint.configuration") end,
        event = "VeryLazy",
    },

    -- Autocomplete and other niceties for developing with Neovim
    {"folke/neodev.nvim", opts = {}, lazy = true},
}
