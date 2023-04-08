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
	    behavior = cmp.ConfirmBehavior.Insert,  -- Don't delete the word to the right
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
		{ name = "nvim_lsp" },  -- And auto-complete from LSPs
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

-- Set up lspconfig.
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.jedi_language_server.setup { capabilities=capabilities }

-- Disable completion from pylsp because ``jedi_language_server``'s options are better.
-- Everything else is good though and should be kept.
--
-- Reference: https://github.com/hrsh7th/nvim-cmp/issues/822
--
local configuration = require("cmp_nvim_lsp").default_capabilities()
lspconfig.pylsp.setup {
    capabilities=capabilities,
    on_attach = function(client)
	client.server_capabilities.completionProvider = false
    end,
}
