local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local snippet = luasnip.s
local text = luasnip.t

return {
    -- TODO: Add auto-expand and add beginning
    snippet(
        {
            docstring="#pragma once",
            trig="#prag",
        },
        text("#pragma once")
    ),

    -- TODO: Add auto-expand and add beginning
    snippet(
        {
            docstring="#include",
            trig="ii",
        },
        format("#include <{}>", { index(1, "") })
    ),

    -- TODO: Add auto-expand and add beginning
    snippet(
        {
            docstring="#ifndef pre-processor",
            trig="ifndef",
        },
        format(
            [[
                #ifndef
                {}
                #endif
            ]],
            { index(1, "") }
        )
    ),

    -- TODO: Add auto-expand and add beginning
    snippet(
        {
            docstring="Do a 'for (auto foo: bar)-style loop",
            trig="for_each",
        },
        format(
            [[
                for ({} {} : {}) {{
                    {}
                }}
            ]],
            { index(1, "auto"), index(2, "item"), index(3, "items"), index(4, "") }
        )
    ),
}
