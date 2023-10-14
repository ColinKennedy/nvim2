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
                -- Don't choose any completion item and use raw input text, instead
                --
                -- Reference: https://github.com/hrsh7th/nvim-cmp/issues/429#issuecomment-954121524
                --
                cmp.abort()
            end,
            ["<Space>"] = function(fallback)
                -- Use whatever current text (completed or not) exists and stop completing
                local visible = cmp.visible()
                local has_entry = cmp.get_selected_entry() ~= nil

                cmp.close()

                -- If the completion menu pops up as you're typing but you're
                -- ignoring the completion menu, interpret <Space> just as
                -- space. But if the completion menu is up and an entry is
                -- selected then assume that the user was attempting to do
                -- auto-completion and DON'T insert a <Space> to keep it
                -- consistent with the <C-Space> mapping
                --
                if not visible or (visible and not has_entry)
                then
                    fallback()
                end
            end,
            ["<CR>"] = cmp.mapping.confirm {
                -- Choose the currently selected completion item
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

-- Stop snippet expansion after leaving -- INSERT -- mode
--
-- Reference: https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
--
vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = '*',
    callback = function()
        if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
            and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require('luasnip').session.jump_active
        then
            require('luasnip').unlink_current()
        end
    end
})
