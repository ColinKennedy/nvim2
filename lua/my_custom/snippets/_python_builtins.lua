local is_source_beginning = require("my_custom.utilities.snippet_helper").is_source_beginning
local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local index = luasnip.i
local snippet = luasnip.s
local text = luasnip.t

return {
    snippet(
        {
            docstring="Class definition",
            trig="c",
        },
        format(
            [[
                class {}({}):
                    def __init__(self{}):
                        super({}, self).__init__({})
            ]],
            {
                index(1, "MyClass"),
                index(2, "object"),
                index(3, ""),
                rep(1),
                index(4, ""),
            }
        ),
        { show_condition = is_source_beginning("c") }
    ),

    snippet(
        {
            docstring="Return True",
            trig="rt",
        },
        text("return True"),
        { show_condition = is_source_beginning("rt") }
    ),

    snippet(
        {
            docstring="Return False",
            trig="rf",
        },
        text("return False"),
        { show_condition = is_source_beginning("rf") }
    ),

    snippet(
        {
            docstring="Return None",
            trig="rn",
        },
        text("return None"),
        { show_condition = is_source_beginning("rn") }
    ),

    snippet(
        {
            docstring="Make a format block",
            trig="'.f",
        },
        format("'.format({})", { index(1, "") })
    ),

    snippet(
        {
            docstring="Make a format block",
            trig='".f',
        },
        format('".format({})', { index(1, "") })
    ),

    snippet(
        {
            docstring="raise",
            trig="ra",
        },
        format("raise {}", { index(1, "") }),
        { show_condition = is_source_beginning("ra") }
    ),

    snippet(
        {
            docstring="yield",
            trig="y",
        },
        format("yield {}", { index(1, "") }),
        { show_condition = is_source_beginning("y") }
    ),

    snippet(
        {
            docstring="import",
            trig="ii",
        },
        format("import {}", { index(1, "") }),
        { show_condition = is_source_beginning("ii") }
    ),

    snippet(
        {
            docstring="@classmethod",
            trig="@c",
        },
        text("@classmethod"),
        { show_condition = is_source_beginning("@c") }
    ),

    snippet(
        {
            docstring="@staticmethod",
            trig="@s",
        },
        text("@staticmethod"),
        { show_condition = is_source_beginning("@s") }
    ),

    snippet(
        {
            docstring="@property",
            trig="@p",
        },
        text("@property"),
        { show_condition = is_source_beginning("@p") }
    ),

    snippet(
        {
            docstring="self.$1",
            trig="s",
        },
        format([[self.{}]], {index(1, "blah")})
    ),


    -- Blocks
    snippet(
        {
            docstring="for item in items:",
            trig="for",
        },
        format(
            [[
                for {} in {}:
                    {}
            ]],
            {
                index(1, "item"),
                index(2, "items"),
                index(3, "pass"),
            }
        )
    ),

    snippet(
        {
            docstring="with foo as handler:",
            trig="with",
        },
        format(
            [[
                with {} as {}:
                    {}
            ]],
            {
                index(1, "open()"),
                index(2, "handler"),
                index(3, "pass"),
            }
        )
    ),
}
