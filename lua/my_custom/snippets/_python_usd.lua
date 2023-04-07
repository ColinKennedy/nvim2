local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local snippet = luasnip.s


return {
    snippet(
        {
            trig="ExportToString_usd",
            docstring="Get a string that represents the USD.Stage",
        },
        format(
            [[
                print({}.GetRootLayer().ExportToString())
            ]],
            { index(1, "stage") }
        )
    )
}
