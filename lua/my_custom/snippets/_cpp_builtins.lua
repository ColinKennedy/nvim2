local is_source_beginning = require("my_custom.utilities.snippet_helper").is_source_beginning
local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local index = luasnip.i
local snippet = luasnip.s
local text = luasnip.t

return {
    snippet({
        docstring = "#pragma once",
        trig = "#prag",
    }, text("#pragma once"), { show_condition = is_source_beginning("#prag") }),

    snippet({
        docstring = "#include",
        trig = "ii",
    }, format("#include <{}>", { index(1, "") }), { show_condition = is_source_beginning("ii") }),

    -- TODO: Add auto-expand and add beginning
    snippet(
        {
            docstring = "#ifndef pre-processor",
            trig = "#ifndef",
        },
        format(
            [[
                #ifndef
                {}
                #endif
            ]],
            { index(1, "") }
        ),
        { show_condition = is_source_beginning("#ifndef") }
    ),

    snippet(
        {
            docstring = "Do a 'for (auto foo: bar)-style loop",
            trig = "for_each",
        },
        format(
            [[
                for ({} {} : {}) {{
                    {}
                }}
            ]],
            { index(1, "auto"), index(2, "item"), index(3, "items"), index(4, "") }
        ),
        { show_condition = is_source_beginning("for_each") }
    ),
}
