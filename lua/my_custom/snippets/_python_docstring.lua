local is_source_beginning = require("my_custom.utilities.snippet_helper").is_source_beginning
local luasnip = require("luasnip")
local snippet = luasnip.s
local dynamicNode = require("luasnip.nodes.dynamicNode").D
local snippetNode = require("luasnip.nodes.snippet").SN


local function _make_section_snippet_node(section)
    return dynamicNode(
        1,
        function(args)
            local neogen = require("neogen")

            local lines = neogen.generate(
                {return_snippet = true, sections = {section}}
            )

            local nodes = luasnip.parser.parse_snippet(
                nil,
                table.concat(lines, "\n"),
                { trim_empty = false, dedent = true }
            )

            return snippetNode(nil, nodes)
        end
    )
end

local function _make_section_snippet(trigger, section)
    return snippet(
        {
            trig=trigger,
            docstring="Auto-fill a docstring's Args: section, using Neogen",
        },
        {
            _make_section_snippet_node(section)
        },
        { show_condition = is_source_beginning(trigger) }
    )
end

return {
    _make_section_snippet("Args:", "parameter"),
    _make_section_snippet("Raises:", "throw"),
    _make_section_snippet("Returns:", "return"),
    _make_section_snippet("Yields:", "yield"),
}
