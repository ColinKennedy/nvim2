return {
    -- Adds `al/il` text objects for the current line
    {
        "kana/vim-textobj-line",
        dependencies = { "kana/vim-textobj-user" },
        init = function()
            require("my_custom.utilities.utility").lazy_load("vim-textobj-line")
        end,
        event = "VeryLazy",
        version = "0.*",
    },

    -- Surround plugin. Lets you change stuff would words really easily
    {
        "tpope/vim-surround",
        keys = {
            { "cs", desc = "[c]hange [s]urrounding characters." },
            { "ds", desc = "[d]elete [s]urrounding characters." },
            { "ys", desc = "add [s]urrounding characters." },
        },
        version = "2.*",
    },

    -- Enables ``piw`` and other awesome text objects
    {
        "kana/vim-operator-replace",
        dependencies = { "kana/vim-operator-user" },
        event = "VeryLazy",
        version = "0.*",
    },
    {
        "kana/vim-operator-user",
        dependencies = {
            "kana/vim-textobj-user",
        },
        lazy = true,
        version = "0.*",
    },
    {
        "kana/vim-textobj-user",
        lazy = true,
        version = "0.*",
    },

    -- XXX: Removed due to this issue: https://github.com/wellle/targets.vim/issues/268
    -- Targets - A great companion to vim-surround
    {
        "wellle/targets.vim",
        config=function()
            -- TODO: Add this, later
            -- " Add `@` as a text object. di@ will delete between two @s. Useful for authoring USD!
            -- autocmd User targets#mappings#user call targets#mappings#extend({
            --     \ '@': {'quote': [{'d': '@'}]},
            --     \ })
        end,
        event = "VeryLazy",
        version = "0.*",
    },


    -- TODO: Can I defer load this? Figure out how
    -- Comment / uncomment with ``gcc`` and other ``gc`` text motion commands
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
        event = "VeryLazy",
        version = "0.*",
    },

    -- Lets you select inside indented blocks, using "iI" or "aI"
    -- ii = "the indented paragraph (stops at newlines)"
    -- ai = "the indented block (grabs the whole block)"
    --
    {
        "ColinKennedy/vim-indent-object",
        config=function()
            vim.g.indent_object_no_default_key_mappings = "1"

            vim.keymap.set(
                "o",
                "aI",
                ':<C-u>cal HandleTextObjectMapping(0, 0, 0, [line("."), line("."), col("."), col(".")])<CR>',
                {
                    desc="Select [a]round lines of same + outer [I]ndentation, spanning whitespace.",
                    silent=true,
                }
            )
            vim.keymap.set(
                "o",
                "iI",
                ':<C-u>cal HandleTextObjectMapping(1, 0, 0, [line("."), line("."), col("."), col(".")])<CR>',
                {
                    desc="Select [i]nside lines of same [I]ndentation, spanning whitespace.",
                    silent=true,
                }
            )

            vim.keymap.set(
                "v",
                "aI",
                ':<C-u>cal HandleTextObjectMapping(0, 0, 1, [line("\'<"), line("\'>"), col("\'<"), col("\'>")])<CR><Esc>gv',
                {
                    desc="Select [a]round lines of same + outer [I]ndentation, spanning whitespace.",
                    silent=true,
                }
            )
            vim.keymap.set(
                "v",
                "iI",
                ':<C-u>cal HandleTextObjectMapping(1, 0, 1, [line("\'<"), line("\'>"), col("\'<"), col("\'>")])<CR><Esc>gv',
                {
                    desc="Select [i]nside lines of same [I]ndentation, spanning whitespace.",
                    silent=true,
                }
            )
        end,
        event = "VeryLazy",
        version = "1.*",
    },

    {
        "kana/vim-textobj-indent",
        config=function()
            vim.g.textobj_indent_no_default_key_mappings = "1"

            vim.keymap.set(
                "o",
                "ai",
                "<Plug>(textobj-indent-i)",
                {desc="Select [a]round [i]ndent + outer indent. Stop at whitespace."}
            )
            vim.keymap.set(
                "x",
                "ai",
                "<Plug>(textobj-indent-i)",
                {desc="Select [a]round [i]ndent + outer indent. Stop at whitespace."}
            )
            vim.keymap.set(
                "o",
                "ii",
                "<Plug>(textobj-indent-i)",
                {desc="Select [i]nside all [i]ndent lines. Stop at whitespace."}
            )
            vim.keymap.set(
                "x",
                "ii",
                "<Plug>(textobj-indent-i)",
                {desc="Select [i]nside all [i]ndent lines. Stop at whitespace."}
            )
        end,
        dependencies = { "kana/vim-textobj-user" },
        event = "VeryLazy",
        version = "0.*",
    },

    -- Gives vim a few tools to navigate through indented blocks more easily
    {
        "jeetsukumaran/vim-indentwise",
        keys = {
            { "[+", desc = "Go to the previous line of greater indent." },
            { "[-", desc = "Go to the previous line of lesser indent." },
            { "[=", desc = "Go to the previous line of equal indent." },
            -- "[_",
            { "]+", desc = "Go to the next line of greater indent." },
            { "]-", desc = "Go to the next line of lesser indent." },
            { "]=", desc = "Go to the next line of equal indent." },
            -- "]_",
        },
        version = "1.*",
    },

    -- Advanced paragraph movement options - lets {}s skip folds with some
    -- minor customization.
    --
    {
        "justinmk/vim-ipmotion",
        config = function()
            vim.g.ip_skipfold = 1
        end,
        keys = {
            { "{", desc = "Go to the previous paragraph including whitespace." },
            { "}", desc = "Go to the next paragraph including whitespace." },
        },
        -- version = "1.*",  TODO There is a tag but it's broken so we get the latest commits
    },

    -- TODO: Replace this with treesitter, sometime in the future
    -- -- A text-object that helps you select Python source-code blocks
    -- {
    --     "ColinKennedy/vim-textobj-block-party",
    --     dependencies = { "kana/vim-textobj-user" },
    --     -- init = function()
    --     --     require("my_custom.utilities.utility").lazy_load("vim-textobj-block-party")
    --     -- end,
    --     keys = {"ab", "ib"},
    -- },

    -- Adds pair mappings (like ]l [l) to Vim
    {
        "tpope/vim-unimpaired",
        config = function()
        end,
        keys = {
            { "<P", desc = "Do [p]ut, but dedented onto the previous line." },
            { ">P", desc = "Do [p]ut, but indented onto the previous line." },
            { "<p", desc = "Do [p]ut, but dedented onto the next line." },
            { ">p", desc = "Do [p]ut, but indented onto the next line." },
            -- "=P", "=p", -- equal indentation put
            { "[<Space>", desc = "Add a newline above the current line." },
            { "]<Space>", desc = "Add a newline below the current line." },
            { "[A", desc = "Go to the first [A]rgs." },
            { "]A", desc = "Go to the last [A]rgs." },
            { "[B", desc = "Go to the first [B]uffer." },
            { "]B", desc = "Go to the last [B]uffer." },
            { "[L", desc = "Go to the first [L]ocation list entry." },
            { "]L", desc = "Go to the last [L]ocation list entry." },
            { "[Q", desc = "Go to the first [Q]uickfix entry." },
            { "]Q", desc = "Go to the last [Q]uickfix entry." },
            { "[T", desc = "Go to the first tag." },
            { "]T", desc = "Go to the last tag." },
            { "[a", desc = "Go to the previous [a]rgs." },
            { "]a", desc = "Go to the next [a]rgs." },
            { "[b", desc = "Go to the previous [b]uffer." },
            { "]b", desc = "Go to the next [b]uffer." },
            { "[p", desc = "Do [p]ut to the previous line." },
            { "]p", desc = "Do [p]ut to the next line." },
            -- "[t", "]t",  tags
            {
                "[q",
                function()
                    local fixer = require("my_custom.utilities.quick_fix_selection_fix")

                    fixer.choose_last_window()
                    fixer.safe_run([[CAbove]])
                end,
                desc="Move up the [q]uickfix window.",
            },
            {
                "]q",
                function()
                    local fixer = require("my_custom.utilities.quick_fix_selection_fix")

                    fixer.choose_last_window()
                    fixer.safe_run([[CBelow]])
                end,
                desc="Move down the [q]uickfix window.",
            },
            {
                "[l",
                function()
                    local fixer = require("my_custom.utilities.quick_fix_selection_fix")
                    fixer.safe_run([[LAbove]])
                end,
                desc="Move up the [l]ocation list window.",
            },
            {
                "]l",
                function()
                    local fixer = require("my_custom.utilities.quick_fix_selection_fix")
                    fixer.safe_run([[LBelow]])
                end,
                desc="Move down the [l]ocation list window.",
            },
        },
        version = "2.*",
    },

    -- A simple plugin that lets you grab inner parts of a variable
    --
    -- e.g. civqueez "foo_b|ar_fizz" -> foo_queez|_fizz
    -- e.g. dav "foo_b|ar_fizz" -> foo_fizz
    --
    {
        "Julian/vim-textobj-variable-segment",
        dependencies = { "kana/vim-textobj-user" },
        event = "VeryLazy",
    },

    -- Life-changing text object extension. It's hard to explain but ...
    --
    -- Use z[i} to move to the insert from the beginning of a paragraph.
    -- Use z]i} to move to the insert from the end of a paragraph.
    -- But you can do the do this with __any__ text object
    -- Also, you can use d]/d[ and c]/c[ to delete / change from other text objects
    --
    -- {"ColinKennedy/vim-ninja-feet", keys = {"d[", "d]"}},
    {
        "ColinKennedy/vim-ninja-feet",
        keys = {
            { "c[", desc = "Make an edit from the cursor to the start of a text object and [c]hange it." },
            { "c]", desc = "Make an edit from the cursor to the end of a text object and [c]hange it." },
            { "d[", desc = "Make an edit from the cursor to the start of a text object and [d]elete it." },
            { "d]", desc = "Make an edit from the cursor to the end of a text object and [d]elete it." },
            -- "p[", "p]",

            { "s[", desc = "Make an edit from the cursor to the start of a text object and [s]elect it." },
            { "s]", desc = "Make an edit from the cursor to the end of a text object and [s]elect it." },
            { "z[", desc = "Make to the start of a text object." },
            { "z]", desc = "Move to the end of a text object." },
        },
    },

    -- Exchange any two text objects with a new text-motion, `cx`
    {
        "tommcdo/vim-exchange",
        keys = {
            {
                "cx",
                desc = "[c]hange and e[x]change two text objects.",
            },
        },
    },

    -- Add comment text objects ``ac`` / ``ic``. e.g. ``dac`` (delete comment) or  ``gcac`` (requires ``numToStr/Comment.nvim``)
    {
        "glts/vim-textobj-comment",
        dependencies = { "kana/vim-textobj-user" },
        version = "1.*",
    },
}
