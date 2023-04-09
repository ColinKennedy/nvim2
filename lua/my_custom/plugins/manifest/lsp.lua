return {
    {
        "neovim/nvim-lspconfig",
        init = function()
            require("my_custom.utilities.utility").lazy_load("nvim-lspconfig")
        end,
        config = function()
            require("my_custom.plugins.data.nvim_lsp_config")

            vim.keymap.set(
                "n",
                "<leader>d",
                'lua require("my_custom.utilities.diagnostic_status_display").show_line_diagnostics()'
            )
        end,
    },

    -- {
    --     "python-lsp/python-lsp-server",
    --     config = function()
    --         require("lspconfig").pylsp.setup{ }
    --     end,
    --     -- TODO: Add defer, later. Maybe
    --     -- lazy = true,
    -- },
    {
        "pappasam/jedi-language-server",
        lazy = true,
    },

    -- A visual progress indicator for slow LSPs. Very useful for C++ & USD
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end,
        init = function()
            require("my_custom.utilities.utility").lazy_load("fidget.nvim")
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("my_custom.plugins.data.nvim_cmp")
        end,
        dependencies = require("my_custom.plugins.data.nvim_cmp_dependencies"),
    },

    -- Allows (but does not link) LuaSnip snippets to nvim-cmp
    {
        "saadparwaiz1/cmp_luasnip",
        lazy = true,
    },

    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip.loaders.from_lua").lazy_load(
                { paths = "./snippets" }
            )
            local ls = require("luasnip").config.set_config(
                {
                    updateevents = "TextChanged,TextChangedI",
                    enable_autosnippets = true,
                }
            )
        end,
        init = function()
            require("my_custom.utilities.utility").lazy_load("LuaSnip")
        end,
        -- follow latest release.
        version = "1.*",
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

    -- Important: CentOS 7 doesn't include an ensurepip/_bundled folder. It's
    -- incredibly annoying but you can fix it by manually installing the missing files.
    -- Reference: https://stackoverflow.com/a/33767179
    --
    -- Note: You can install specific versions of a package using ``:MasonInstall name@1.2.3``
    -- Reference: https://github.com/williamboman/mason.nvim/discussions/1024
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",  -- :MasonUpdate updates registry contents
        config = function()
            require("mason").setup()
        end,
        cmd = {"Mason", "MasonInstall", "MasonUninstall", "MasonUpdate"}
    },

    -- Integrates linters, formatters, and other features into Neovim's own LSP. Cool!
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local sources = {
                null_ls.builtins.diagnostics.pydocstyle,
                null_ls.builtins.diagnostics.pylint,
                -- null_ls.builtins.diagnostics.ruff,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.trim_whitespace,
            }
            null_ls.setup({ sources = sources })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
    },
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
}
