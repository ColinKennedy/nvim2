return {
    -- Adds `al/il` text objects for the current line
    {
        "kana/vim-textobj-line",
        dependencies = { "kana/vim-textobj-user" },
        init = function()
            require("my_custom.utilities.utility").lazy_load("vim-textobj-line")
        end,
    },

    -- Surround plugin. Lets you change stuff would words really easily
    {
        "tpope/vim-surround",
        keys = { "cs", "ds", "ys" },
    },

    -- Enables ``piw`` and other awesome text objects
    {
        "kana/vim-operator-replace",
        dependencies = { "kana/vim-operator-user" },
    },
    {
        "kana/vim-operator-user",
        dependencies = {
            "kana/vim-textobj-user",
        },
        lazy = true,
    },
    {
        "kana/vim-textobj-user",
        lazy = true,
    },

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
    },


    -- TODO: Can I defer load this? Figure out how
    -- Comment / uncomment with ``gcc`` and other ``gc`` text motion commands
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    -- Lets you select inside indented blocks, using "ii"or "ai"
    -- ii = "the indented paragraph (stops at newlines)"
    -- ai = "the indented block (grabs the whole block)"
    --
    {
        "ColinKennedy/vim-indent-object",
        config=function()
            vim.g.indent_object_no_default_key_mappings = "1"
        end,
    },

    {
        "kana/vim-textobj-indent",
        config=function()
            vim.g.textobj_indent_no_default_key_mappings = "1"
        end,
        dependencies = { "kana/vim-textobj-user" },
    },

    -- Gives vim a few tools to navigate through indented blocks more easily
    {
        "jeetsukumaran/vim-indentwise",
        keys = { "[%", "[+", "[-", "[=", "[_", "]%", "]+", "]-", "]=", "]_" },
    },

    -- Advanced paragraph movement options - lets {}s skip folds with some
    -- minor customization.
    --
    {
        "justinmk/vim-ipmotion",
        config = function()
            vim.g.ip_skipfold = 1
        end,
        keys = {"{", "}"},
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
        keys = {
            "<P", ">P",
            "<p", ">p",
            "=P", "=p",
            "[A", "]A",
            "[B", "]B",
            "[L", "]L",
            "[Q", "]Q",
            "[T", "]T",
            "[a", "]a",
            "[b", "]b",
            "[l", "]l",
            "[p", "]p",
            "[q", "]q",
            "[t", "]t",
        },
    },

    -- A simple plugin that lets you grab inner parts of a variable
    --
    -- e.g. civqueez "foo_b|ar_fizz" -> foo_queez|_fizz
    -- e.g. dav "foo_b|ar_fizz" -> foo_fizz
    --
    {
        "Julian/vim-textobj-variable-segment",
        dependencies = { "kana/vim-textobj-user" },
        keys = {"dav", "div", "vav", "viv"},
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
            "c[", "c]",
            "d[", "d]",
            "p[", "p]",
            "s[", "s]",
            "z[", "z]",
        },
    },

    -- Exchange any two text objects with a new text-motion, `cx`
    {"tommcdo/vim-exchange", keys = {"cx"}},
}
