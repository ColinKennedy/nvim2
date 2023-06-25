-- Define a snippet for Python's `super()` command. Auto-fills out all of its parameters.

local luasnip = require("luasnip")
local snippet = luasnip.s
local dynamicNode = require("luasnip.nodes.dynamicNode").D
local snippetNode = require("luasnip.nodes.snippet").SN

return {
    snippet(
        {
            trig="super",
            docstring="super().foo() auto-generator.",
        },
        {
            dynamicNode(
                1,
                function(args)
                    local super_test = require("my_custom.utilities.super_test")  -- TODO: Move this, later
                    local nodes = super_test.get_current_function_super_text()

                    return snippetNode(nil, nodes)
                end
            )
        }
    )
}
