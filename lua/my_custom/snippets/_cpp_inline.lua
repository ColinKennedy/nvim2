local snippet_helper = require("my_custom.utilities.snippet_helper")
local is_source_beginning = snippet_helper.is_source_beginning
local or_ = snippet_helper.or_
local line_end = require("luasnip.extras.conditions.show").line_end
local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local snippet = luasnip.s
local text = luasnip.t

return {
    snippet(
        {
            docstring="TODO comment",
            trig="td",
        },
        format([[// TODO: {}]], { index(1, "") }),
        { show_condition = or_(is_source_beginning("td"), line_end) }
    ),

    snippet(
        {
            docstring="return",
            trig="r",
        },
        format([[return {}]], { index(1, "") }),
        { show_condition = is_source_beginning("r") }
    ),

    snippet(
        {
            docstring="return true",
            trig="rt",
        },
        text("return true"),
        { show_condition = is_source_beginning("rt") }
    ),

    snippet(
        {
            docstring="return false",
            trig="rf",
        },
        text("return false"),
        { show_condition = is_source_beginning("rf") }
    ),

    snippet(
        {
            docstring="Print the line to std::cout",
            trig="cout",
        },
        format([[std::cout << {} << '\n']], { index(1, "") }),
        { show_condition = is_source_beginning("cout") }
    ),
}
