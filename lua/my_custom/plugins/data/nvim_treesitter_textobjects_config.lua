local installation_directory = vim.g.vim_home .. "/parsers/" .. vim.loop.os_uname().sysname

-- If you need to change the installation directory of the parsers (see
-- "Advanced Setup" in the nvim-treesitter documentation).
--
vim.opt.runtimepath:append(installation_directory)


local value = "V"

require("nvim-treesitter.configs").setup {
    parser_install_dir = installation_directory,
    highlight = { enable = true },

    textobjects = {
	-- TODO: Not working, fix
	move = {
	  enable = true,
	  set_jumps = true, -- whether to set jumps in the jumplist
	  goto_next_start = {
	    ["]k"] = "@class.outer",
	    ["]m"] = "@function.outer",
	  },
	  goto_next_end = {
	    ["]K"] = "@class.outer",
	    ["]M"] = "@function.outer",
	  },
	  goto_previous_start = {
	    ["[k"] = "@class.outer",
	    ["[m"] = "@function.outer",
	  },
	  goto_previous_end = {
	    ["[K"] = "@class.outer",
	    ["[M"] = "@function.outer",
	  },
	},

	select = {
	    enable = true,

	    -- Automatically jump forward to textobj, similar to targets.vim
	    lookahead = true,

	    keymaps = {
		["ab"] = {
		    desc = "Delete the current if / for / try / while block.",
		    query = "@block.outer",
		},

		["ad"] = {
		    -- Reference: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/439#issuecomment-1505411083
		    desc = "Select around an entire docstring",
		    query = "@string.documentation",
		    query_group = "highlights",
		},
		-- TODO: Add ``did`` support
		-- Requires:
		--
		-- (
		--   (function_definition
		--     (block
		--       .
		--       (expression_statement
		--         (string (string_content) @documentation.inner)) @documentation.outer
		--     )
		--   )
		-- )
		--
		["id"] = {
		    desc = "Select the inside of a docstring",
		    query = "@documentation.inner",
		},

		["af"] = {
		    desc = "Select function + whitespace to the next function / class",
		    query = "@function.outer",
		},
		["if"] = {
		    desc = "Select function up to last source code line (no trailing whitespace)",
		    query = "@function.inner",
		},

		-- Note: I use aC / iC (capital C) so that I can use ac / ic
		-- for ``glts/vim-textobj-comment``, which is a much more
		-- common case.
		--
		["aC"] = {
		    desc = "Select class + whitespace to the next class / class",
		    query = "@class.outer",
		},
		["iC"] = {
		    desc = "Select class up to last source code line (no trailing whitespace)",
		    query = "@class.inner",
		},
	    },
	    -- You can choose the select mode (default is charwise 'v')
	    --
	    -- Can also be a function which gets passed a table with the keys
	    -- * query_string: eg '@function.inner'
	    -- * method: eg 'v' or 'o'
	    -- and should return the mode ('v', 'V', or '<c-v>') or a table
	    -- mapping query_strings to modes.
	    selection_modes = {
		["@class.inner"] = value,
		["@class.outer"] = value,
		["@function.inner"] = value,
		["@function.outer"] = value,
	    },
	},
    },
}