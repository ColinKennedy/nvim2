local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local snippet = luasnip.s
local text = luasnip.t

return {
    -- TODO: Add "beginning" context
    snippet(
        {
            docstring="TODO comment",
            trig="td",
        },
        format([[// TODO: {}]], { index(1, "") })
    ),

    -- TODO: Add "beginning" context
    snippet(
        {
            docstring="return",
            trig="r",
        },
        format([[return {}]], { index(1, "") })
    ),

    -- TODO: Add "beginning" context
    snippet(
        {
            docstring="return true",
            trig="rt",
        },
        text("return true")
    ),

    -- TODO: Add "beginning" context
    snippet(
        {
            docstring="return false",
            trig="rf",
        },
        text("return false")
    ),

    -- TODO: Add "beginning" context
    snippet(
        {
            docstring="Print the line to std::cout",
            text("return false"),
            trig="cout",
        },
        format([[std::cout << {} << '\n']], { index(1, "") })
    ),
}
