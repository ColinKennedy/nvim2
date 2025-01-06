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
        version = "0.*",
        keys = require("my_custom.plugins.vim_operator_replace.keys"),
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

    -- `vin(` to select around parentheses. etc etc.
    --
    -- A replacement for target.nvim
    --
    {
        "echasnovski/mini.ai",
        config = function()
            require("mini.ai").setup()
        end,
        event = "VeryLazy",
        version = "0.*",
    },

    -- TODO: Can I defer load this? Figure out how
    -- Comment / uncomment with ``gcc`` and other ``gc`` text motion commands
    {
        "numToStr/Comment.nvim",
        config = true,
        event = "VeryLazy",
        version = "0.*",
    },

    -- Lets you select inside indented blocks, using "iI" or "aI"
    -- ii = "the indented paragraph (stops at newlines)"
    -- ai = "the indented block (grabs the whole block)"
    --
    {
        "ColinKennedy/vim-indent-object",
        config = function()
            vim.g.indent_object_no_default_key_mappings = "1"
        end,
        version = "1.*",
        keys = require("my_custom.plugins.vim_indent_object.keys"),
    },

    {
        "kana/vim-textobj-indent",
        config = function()
            require("my_custom.plugins.vim_textobj_indent.configuration")
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
        keys = require("my_custom.plugins.vim_unimpaired.keys"),
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

    -- A life-changing text object extension. [ and ] now become directional pending operators.
    --
    -- d]ip deletes from the cursor down. d[ip deletes from the top to the cursor.
    -- Works with any text operator / text object. e.g. gc]ii works, etc etc.
    --
    {
        "ColinKennedy/cursor-text-objects.nvim",
        config = function()
            vim.keymap.set(
                { "o", "x" },
                "[",
                "<Plug>(cursor-text-objects-up)",
                { desc = "Run from your current cursor to the end of the text-object." }
            )
            vim.keymap.set(
                { "o", "x" },
                "]",
                "<Plug>(cursor-text-objects-down)",
                { desc = "Run from your current cursor to the end of the text-object." }
            )
        end,
        version = "v1.*",
    },

    -- Exchange any two text objects with a new text-motion, `cx`
    {
        "gbprod/substitute.nvim",
        config = true,
        keys = {
            {
                "cx",
                function()
                    require("substitute.exchange").operator()
                end,
                noremap = true,
            },
            {
                "cxx",
                function()
                    require("substitute.exchange").line()
                end,
                noremap = true,
            },
            {
                "X",
                mode = { "x" },
                function()
                    require("substitute.exchange").visual()
                end,
                noremap = true,
            },
            {
                "cxc",
                function()
                    require("substitute.exchange").cancel()
                end,
                noremap = true,
            },
        },
    },

    -- Add comment text objects ``ac`` / ``ic``.
    -- e.g. ``dac`` (delete comment) or ``gcac`` (requires ``numToStr/Comment.nvim``)
    --
    {
        "glts/vim-textobj-comment",
        dependencies = { "kana/vim-textobj-user" },
        version = "1.*",
    },

    -- Use gs to sort stuff
    --
    -- Normal mode: gsip sorts a paragraph
    -- Visual mode: gs
    --
    {
        "ralismark/opsort.vim",
        keys = { { "gs", desc = "A [s]orting operator.", mode = { "n", "o", "v" } } },
    },
}
