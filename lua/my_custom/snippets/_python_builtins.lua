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
            trig="^c",
            regTrig=True,
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
        )
    ),

    snippet(
        {
            docstring="Return True",
            trig="rt",
        },
        text("return True")
    ),

    snippet(
        {
            docstring="Return False",
            trig="rf",
        },
        text("return False")
    ),

    snippet(
        {
            docstring="Return None",
            trig="rn",
        },
        text("return None")
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

    -- TODO: Beginning of the line, only
    snippet(
        {
            docstring="raise",
            trig="ra",
        },
        format("raise {}", { index(1, "") })
    ),

    -- TODO: Beginning of the line, only
    snippet(
        {
            docstring="yield",
            trig="y",
        },
        format("yield {}", { index(1, "") })
    ),

    -- TODO: Beginning of the line, only
    snippet(
        {
            docstring="import",
            trig="ii",
        },
        format("import {}", { index(1, "") })
    ),

    -- TODO: Beginning of the line, only
    snippet(
        {
            docstring="@classmethod",
            trig="@c",
        },
        text("@classmethod")
    ),

    -- TODO: Beginning of the line, only
    snippet(
        {
            docstring="@staticmethod",
            trig="@s",
        },
        text("@staticmethod")
    ),

    -- TODO: Beginning of the line, only
    snippet(
        {
            docstring="@property",
            trig="@p",
        },
        text("@property")
    ),
}
