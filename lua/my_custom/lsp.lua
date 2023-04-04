return {
    packages = {
        {
            "neovim/nvim-lspconfig",
        },

        {
            "python-lsp/python-lsp-server",
            config = function()
                require("lspconfig").pylsp.setup{ }
            end,
            -- TODO: Add defer, later. Maybe
            -- lazy = true,
        },
        {
            "pappasam/jedi-language-server",
            config = function()
                require("lspconfig").jedi_language_server.setup{}
            end,
            -- TODO: Add defer, later. Maybe
            -- lazy = true,
        },

        -- A visual progress indicator for slow LSPs. Very useful for C++ & USD
        {
            "j-hui/fidget.nvim",
            -- TODO: Add defer, later. Maybe
            -- event = { "CursorMoved", "CursorMovedI" },
        },

        {
            "hrsh7th/nvim-cmp",
            config = function()
                local cmp = require("cmp")

                cmp.setup(
                    {
                        snippet = {
                            expand = function(args)
                                -- TODO: Consider adding luasnip or something here
                                vim.fn["UltiSnips#Anon"](args.body)
                            end,
                        },
                        mapping = cmp.mapping.preset.insert({
                          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                          ["<C-f>"] = cmp.mapping.scroll_docs(4),
                          ["<C-Space>"] = cmp.mapping.complete(),
                          ["<C-e>"] = cmp.mapping.abort(),
                          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                        }),
                        sources = cmp.config.sources(
                            {
                                -- TODO: Consider adding luasnip or something here
                                { name = "ultisnips" },

                                { name = "tmux" },
                                { name = "buffer"  },
                            }
                        ),
                    }
                )

                -- Set configuration for specific filetype.
                cmp.setup.filetype(
                    "gitcommit",
                    {
                        sources = cmp.config.sources(
                            {
                                { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
                            },
                            { { name = "buffer" }, }
                        )
                    }
                )
                
                -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline(
                    { "/", "?" },
                    {
                        mapping = cmp.mapping.preset.cmdline(),
                        sources = { { name = "buffer" } }
                    }
                )

                -- Set up lspconfig.
                local capabilities = require("cmp_nvim_lsp").default_capabilities()

                -- Add your LSP servers here
                require("lspconfig")["jedi_language_server"].setup {
                    capabilities = capabilities
                }
                require("lspconfig")["pylsp"].setup {
                    capabilities = capabilities
                }
            end,
            dependencies = {
                -- TODO: Consider changing to LuaSnip
                -- UltiSnips stuff
                --
                {
                    "SirVer/ultisnips",
                    "quangnguyen30192/cmp-nvim-ultisnips",
                },

                -- Completion sources
                -- TODO: If I remember right, one of these is bugged when I type in the
                -- command-line. I think it was cmp-cmdline?
                --
                {
                    -- LSP completion sources
                    "python-lsp/python-lsp-server",
                    "pappasam/jedi-language-server",

                    -- Generic completion sources
                    "andersevenrud/cmp-tmux",
                    "hrsh7th/cmp-buffer",
                    "hrsh7th/cmp-cmdline",
                    "hrsh7th/cmp-nvim-lsp",
                    "hrsh7th/cmp-path",
                    "hrsh7th/nvim-cmp",
                    "neovim/nvim-lspconfig",
                },
            },
        },
        {
            "quangnguyen30192/cmp-nvim-ultisnips",
            config = function()
                -- optional call to setup (see customization section)
                require("cmp_nvim_ultisnips").setup{}
            end,
            -- If you want to enable filetype detection based on treesitter:
            -- requires = { "nvim-treesitter/nvim-treesitter" },
        },

        -- TODO: Consider removing / using this
        -- {
        --     "hrsh7th/nvim-cmp",
        --     event = "InsertEnter",
        --     dependencies = {
        --     -- {
        --     --   -- snippet plugin
        --     --   "L3MON4D3/LuaSnip",
        --     --   dependencies = "rafamadriz/friendly-snippets",
        --     --   opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        --     --   config = function(_, opts)
        --     --     require("plugins.configs.others").luasnip(opts)
        --     --   end,
        --     -- },
        --
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
        --
        --     -- cmp sources plugins
        --     {
        --       -- "saadparwaiz1/cmp_luasnip",  TODO: Consider changing, later
        --       "hrsh7th/cmp-nvim-lua",
        --       "hrsh7th/cmp-nvim-lsp",
        --       "hrsh7th/cmp-buffer",
        --       "hrsh7th/cmp-path",
        --     },
        --   },
        --
        --   opts = function()
        --     return require "plugins.configs.cmp"
        --   end,
        --   config = function(_, opts)
        --     require("cmp").setup(opts)
        --   end,
        -- },
    }
}
