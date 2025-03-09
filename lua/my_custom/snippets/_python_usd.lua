local is_source_beginning = require("my_custom.utilities.snippet_helper").is_source_beginning
local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local snippet = luasnip.s

return {
    snippet(
        {
            trig = "ExportToString_usd",
            docstring = "Get a string that represents the USD.Stage",
        },
        format(
            [[
                print({}.GetRootLayer().ExportToString())
            ]],
            { index(1, "stage") }
        ),
        { show_condition = is_source_beginning("ExportToString_usd") }
    ),
}
