--- Create LuaSnip snippets that can auto-expand Neogen's snippet engine.
---
--- @module 'my_custom.snippets._python_docstring'
---

local snippet_helper = require("my_custom.utilities.snippet_helper")
local luasnip = require("luasnip")
local snippet = luasnip.s
local dynamicNode = require("luasnip.nodes.dynamicNode").D
local snippetNode = require("luasnip.nodes.snippet").SN

---@class LuaSnip.DynamicNode
---@class LuaSnip.Snippet

--- Create a dynamic LuaSnip snippet-node whose contents are created by Neogen.
---
---@param section string The Neogen section name to create a LuaSnip snippet.
---@return LuaSnip.DynamicNode # The created node.
---
local function _make_section_snippet_node(section)
    return dynamicNode(1, function()
        local neogen = require("neogen")

        local lines = neogen.generate(
            -- TODO: Provide an explicit snippet engine (once there's an
            -- argument for it).
            { return_snippet = true, sections = { section }, snippet_engine = "luasnip" }
        )

        local nodes =
            luasnip.parser.parse_snippet(nil, table.concat(lines, "\n"), { trim_empty = false, dedent = true })

        return snippetNode(nil, nodes)
    end)
end

--- Create a LuaSnip snippet for some `section`. Run it when `trigger` is found.
---
---@param trigger string
---    A word that LuaSnip uses to decide when the snippet should run. e.g. `"Args:"`.
---@param section string
---    The parts of a docstring that Neogen needs to generate.
---@return LuaSnip.Snippet
---    The generated auto-complete snippet.
---
local function _make_section_snippet(trigger, section)
    return snippet({
        trig = trigger,
        docstring = string.format('Auto-fill a docstring\'s "%s" section, using Neogen', trigger),
    }, {
        _make_section_snippet_node(section),
    }, {
        show_condition = function()
            return (snippet_helper.in_docstring() and snippet_helper.is_source_beginning(trigger))
        end,
    })
end

return {
    _make_section_snippet("Args:", "parameter"),
    _make_section_snippet("Raises:", "throw"),
    _make_section_snippet("Returns:", "return"),
    _make_section_snippet("Yields:", "yield"),
}
