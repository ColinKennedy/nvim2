local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local snippet = luasnip.s


luasnip.add_snippets(
    "lua",
    {
        snippet(
            {
                docstring="-- TODO",
                trig="td",
            },
            format([[-- TODO: {}]], { index(1, "")})
        )
    }
)
