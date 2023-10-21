-- Define a snippet for Python's `super()` command. Auto-fills out all of its parameters.

local snippet_helper = require("my_custom.utilities.snippet_helper")
local is_source_beginning = snippet_helper.is_source_beginning

local luasnip = require("luasnip")
local snippet = luasnip.s
local dynamicNode = require("luasnip.nodes.dynamicNode").D
local snippetNode = require("luasnip.nodes.snippet").SN

return {
    snippet({
        trig = "super",
        docstring = "super().foo() auto-generator.",
    }, {
        dynamicNode(1, function()
            local super_test = require("my_custom.utilities.super_test") -- TODO: Move this, later
            local nodes = super_test.get_current_function_super_text()

            return snippetNode(nil, nodes)
        end),
    }, { show_condition = is_source_beginning("super") }),
}
