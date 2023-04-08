return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd(
                "LspAttach",
                {
                    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                    callback = function(ev)
                        -- Buffer local mappings.
                        -- See `:help vim.lsp.*` for documentation on any of the below functions
                        local opts = { buffer = ev.buf }
                        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
                        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
                        vim.keymap.set("n", "<space>wl", function()
                            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                        end, opts)
                        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
                        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                        vim.keymap.set("n", "<space>f", function()
                          vim.lsp.buf.format { async = true }
                        end, opts)
                    end,
                })
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
        event = { "CursorMoved", "CursorMovedI" },
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
        event = {"CursorMoved", "CursorMovedI"},
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
                null_ls.builtins.formatting.trim_whitespace,
                null_ls.builtins.completion.spell,
                null_ls.builtins.diagnostics.pydocstyle
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
