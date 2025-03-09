-- vim-hybrid doesn't come with syntax rules for nvim-cmp's menu. So we
-- need to add them, here.
--
-- luacheck: ignore 631
-- Reference: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
--
vim.cmd [[
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
local bordered = cmp.config.window.bordered({ winhighlight = "Normal:Normal,CursorLine:Visual,Search:None" })

local luasnip = require("luasnip")

cmp.setup({
    -- Reference: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#show-devicons-as-kind-field
    formatting = {
        format = function(entry, vim_item)
            return require("lspkind").cmp_format({ with_text = true })(entry, vim_item)
        end,
    },

    mapping = {
        -- Moving through completions
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),

        -- Accept ([y]es) the completion.
        --
        -- This will auto-import if your LSP supports it.
        -- This will expand snippets if the LSP sent a snippet.
        --
        ["<C-y>"] = cmp.mapping.confirm { select = true },

        -- <C-k> Move to the previous snippet jump location
        -- <C-j> Move to the next snippet jump location
        ["<C-j>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { "i", "s" }),

        -- Scrolling up and down pop-up documentation
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        ["<C-Space>"] = function(_)
            -- Don't choose any completion item and use raw input text, instead
            --
            -- Reference: https://github.com/hrsh7th/nvim-cmp/issues/429#issuecomment-954121524
            --
            cmp.abort()
        end,

        -- Toggle open / close the documentation panel
        ["<M-k>"] = cmp.mapping(function(fallback)
            if cmp.visible_docs() then
                cmp.close_docs()
            elseif cmp.visible() then
                cmp.open_docs()
            else
                fallback()
            end
        end),
    },

    -- Reference: https://www.reddit.com/r/neovim/comments/1f1rxtx/share_a_tip_to_improve_your_experience_in_nvimcmp
    performance = {
        debounce = 0, -- default is 60ms
        throttle = 0, -- default is 30ms
    },

    sources = cmp.config.sources({
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
            keyword_length = 3, -- Most paths will be at least 4 characters long.
            priority = 10,
        },
        -- Shows the function signature while you are typing
        { name = "nvim_lsp_signature_help" },
    }),

    -- Reference: https://www.reddit.com/r/neovim/comments/1gussvu/how_to_prioritise_local_or_scope_tokens_over
    -- sorting = {
    --   priority_weight = 2,
    --   comparators = {
    --     compare.locality,
    --     compare.offset,
    --     compare.exact,
    --     -- compare.scopes,
    --     compare.score,
    --     compare.recently_used,
    --     compare.kind,
    --     -- compare.sort_text,
    --     compare.length,
    --     compare.order,
    --   },
    -- },

    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
    },

    window = {
        completion = bordered,
        documentation = bordered,
    },
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
    }, { { name = "buffer" } }),
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        {
            name = "cmdline",
            option = {
                ignore_cmds = { "Man", "!" },
            },
        },
    }),
})
