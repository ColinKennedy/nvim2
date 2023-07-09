-- vim-hybrid doesn't come with syntax rules for nvim-cmp's menu. So we
-- need to add them, here.
--
-- Reference: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
--
vim.cmd[[
    highlight! CmpItemAbbr guibg=NONE gui=strikethrough guifg=111111
    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
    highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6

    highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
    highlight! link CmpItemKindClass Type
    highlight! link CmpItemKindFunction Function
    highlight! link CmpItemKindInterface Type
    highlight! link CmpItemKindKeyword Keyword
    highlight! link CmpItemKindMethod CmpItemKindFunction
    highlight! link CmpItemKindProperty CmpItemKindKeyword
    highlight! link CmpItemKindText String
    highlight! link CmpItemKindUnit CmpItemKindKeyword
    highlight! link CmpItemKindVariable Identifier
]]

local cmp = require("cmp")
local bordered = cmp.config.window.bordered(
    { winhighlight="Normal:Normal,CursorLine:Visual,Search:None" }
)

cmp.setup(
    {
        -- Reference: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#show-devicons-as-kind-field
        formatting = {
            format = function(entry, vim_item)
                return require("lspkind").cmp_format({ with_text = true })(entry, vim_item)
            end
        },

        mapping = {
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = function(fallback)
                -- Reference: https://github.com/hrsh7th/nvim-cmp/issues/429#issuecomment-954121524
                cmp.abort()
            end,
            ["<Space>"] = function(fallback)
                -- Reference: https://github.com/hrsh7th/nvim-cmp/issues/429#issuecomment-954121524
                cmp.abort()

                fallback()
            end,
            ["<CR>"] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,  -- Don't delete the word to the right
                select = false,
            },
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                -- expand_or_locally_jumpable prevents the snippet from being re-entered.
                --
                -- Reference: https://github.com/L3MON4D3/LuaSnip/issues/799
                --
                -- elseif require("luasnip").expand_or_jumpable() then
                --
                -- There's apparently other approaches that do the same thing which I haven't tried.
                --
                -- e.g. ``region_check_events`` from https://github.com/L3MON4D3/LuaSnip/issues/770
                -- e.g. ``leave_snippet`` from https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1011938524
                --
                elseif require("luasnip").expand_or_locally_jumpable() then
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
                -- Complete snippet engine results
                {
                    name = "luasnip",
                    priority = 99,
                },
                {
                    -- Complete text from buffers other than the current one
                    name = "buffer",
                    keyword_length = 3,
                    priority = 20,
                },
                {
                    -- And auto-complete from LSPs
                    name = "nvim_lsp",
                    priority = 90,
                },
                {
                    -- Check text in other tmux panes
                    name = "tmux",
                    keyword_length = 3,
                    priority = 80,
                },
                {
                    -- Complete from file paths
                    name = "path",
                    keyword_length = 3,  -- Most paths will be at least 4 characters long.
                    priority = 10,
                },
            }
        ),

        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            end,
        },

        window = {
            completion = bordered,
            documentation = bordered,
        }
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

-- Set up lspconfig.
local lspconfig = require("lspconfig")
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local disable_completion = function(client)
    -- Disable completion from pylsp because ``jedi_language_server``'s options are better.
    -- Everything else is good though and should be kept.
    --
    -- Reference: https://github.com/hrsh7th/nvim-cmp/issues/822
    --
    client.server_capabilities.completionProvider = false
end

lspconfig.pyright.setup { capabilities=capabilities }
lspconfig.jedi_language_server.setup { capabilities=capabilities }
lspconfig.pylsp.setup { capabilities=capabilities, on_attach = disable_completion }


lspconfig.pyright.setup { capabilities=capabilities }
lspconfig.jedi_language_server.setup { capabilities=capabilities }
lspconfig.pylsp.setup { capabilities=capabilities, on_attach = disable_completion }
