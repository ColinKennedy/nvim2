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
                -- vim-hybrid doesn't come with syntax rules for nvim-cmp's menu. So we
                -- need to add them, here.
                --
                -- Reference: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
                --
                vim.cmd[[
                    " white
                    highlight! CmpItemAbbr guibg=NONE gui=strikethrough guifg=888888

                    " gray
                    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
                    " blue
                    highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
                    highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
                    " light blue
                    highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
                    highlight! link CmpItemKindInterface CmpItemKindVariable
                    highlight! link CmpItemKindText CmpItemKindVariable
                    " pink
                    highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
                    highlight! link CmpItemKindMethod CmpItemKindFunction
                    " front
                    highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
                    highlight! link CmpItemKindProperty CmpItemKindKeyword
                    highlight! link CmpItemKindUnit CmpItemKindKeyword
                ]]
                local cmp = require("cmp")

                cmp.setup(
                    {
                        -- Reference: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#show-devicons-as-kind-field
                        formatting = {
                          format = function(entry, vim_item)
                            if vim.tbl_contains({ "path" }, entry.source.name) then
                              local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
                              if icon then
                                vim_item.kind = icon
                                vim_item.kind_hl_group = hl_group
                                return vim_item
                              end
                            end
                            return require("lspkind").cmp_format({ with_text = true })(entry, vim_item)
                          end
                        },
                        snippet = {
                            expand = function(args)
                                require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                            end,
                        },
                        mapping = {
                          ["<C-p>"] = cmp.mapping.select_prev_item(),
                          ["<C-n>"] = cmp.mapping.select_next_item(),
                          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                          ["<C-f>"] = cmp.mapping.scroll_docs(4),
                          ["<C-Space>"] = cmp.mapping.complete(),
                          ["<C-e>"] = cmp.mapping.close(),
                          ["<CR>"] = cmp.mapping.confirm {
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = false,
                          },
                          ["<Tab>"] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                              cmp.select_next_item()
                            elseif require("luasnip").expand_or_jumpable() then
                              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                            else
                              fallback()
                            end
                          end, {
                            "i",
                            "s",
                          }),
                          ["<S-Tab>"] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                              cmp.select_prev_item()
                            elseif require("luasnip").jumpable(-1) then
                              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                            else
                              fallback()
                            end
                          end, {
                            "i",
                            "s",
                          }),
                        },
                        sources = cmp.config.sources(
                            {
                                { name = "luasnip" },

                                { name = "buffer"  },
                                { name = "tmux" },  -- Check text in other tmux panes
                                { name = "path" },  -- Complete from file paths
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
                -- require("lspconfig")["pylsp"].setup {
                --     capabilities = capabilities
                -- }
            end,
            dependencies = {
                -- Snippet related
                {
                    "L3MON4D3/LuaSnip",
                    "saadparwaiz1/cmp_luasnip",
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

                -- For optional, fun icons in the completion menu
                {
                    "nvim-tree/nvim-web-devicons",
                    "onsails/lspkind.nvim",
                }
            },
        },

        "saadparwaiz1/cmp_luasnip",
        {
            "L3MON4D3/LuaSnip",
            config = function()
                -- -- require("luasnip.loaders.from_snipmate").lazy_load(
                -- --     { paths = "./snippets" }
                -- -- )
                -- TODO: See if I can lazy_load here, later
                require("luasnip.loaders.from_lua").load(
                    { paths = "./snippets" }
                )
                local ls = require("luasnip").config.set_config(
                    {
                        updateevents = "TextChanged,TextChangedI",
                        enable_autosnippets = true,
                    }
                )
            end,
            -- follow latest release.
            version = "1.*",
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
