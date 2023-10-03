local common_snippet = require("my_custom.snippets._common_snippet")
local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local snippet = luasnip.s


luasnip.add_snippets(
    "lua",
    {
        common_snippet.print_snippet,

        snippet(
            {
                docstring="-- TODO",
                trig="td",
            },
            format([[-- TODO: {}]], { index(1, "")})
        )
    }
)
