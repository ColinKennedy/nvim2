local common_snippet = require("my_custom.snippets._common_snippet")
local is_source_beginning = require("my_custom.utilities.snippet_helper").is_source_beginning

local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local function_ = luasnip.f
local index = luasnip.i
local repeat_ = require("luasnip.extras").rep
local snippet = luasnip.s
local text = luasnip.t


local is_beginning_of_exception = function(trigger)
    return {
        show_condition = is_source_beginning("raise " .. trigger)
    }
end


local lstrip = function(text)
    return text:match("^%s*(.*)")
end


-- TODO: This snippet sucks but I cannot figure out how to get
-- `remove_leading_equal_sign` to work as a "pre-expand" snippet without it
-- breaking things.
--
-- Reference: https://github.com/L3MON4D3/LuaSnip/discussions/383
--
local remove_leading_equal_sign = function(text)
    return function_(
        function(_, _)
            local current_row = vim.fn.line(".")  -- This is "1-or-greater"
            local current_line = vim.fn.getline(current_row)
            local leading_indent = string.sub(current_line, 0, (#current_line - #lstrip(current_line)))

            _, end_index = current_line:find("=")

            if end_index == nil
            then
                return ""
            end

            local current_buffer = 0

            line_without_equals = current_line:sub(end_index + 1, #current_line)
            stripped = text .. lstrip(line_without_equals)
            line = leading_indent .. stripped

            vim.schedule(
                function()
                    vim.api.nvim_buf_set_lines(
                        current_buffer,
                        current_row - 1,
                        current_row,
                        true,
                        { line }
                    )
                end
            )
        end
    )
end


return {
    common_snippet.print_snippet,

    snippet(
        {
            docstring="list comprehension",
            trig="lc",
        },
        format([[ [{} for {} in {}] ]], { index(1, "item"), repeat_(1), index(2) })
    ),

    snippet(
        {
            docstring="set comprehension",
            trig="sc",
        },
        format([[ {{{} for {} in {}}} ]], { index(1, "item"), repeat_(1), index(2) })
    ),

    -- TODO: This snippet sucks but I cannot figure out how to get
    -- `remove_leading_equal_sign` to work as a "pre-expand" snippet without it
    -- breaking things.
    --
    -- Reference: https://github.com/L3MON4D3/LuaSnip/discussions/383
    --
    snippet(
        {
            docstring="return statement",
            trig="r",
        },
        { text("return "), index(1), remove_leading_equal_sign("return ") },
        { show_condition = is_source_beginning("p") }
    ),

    snippet(
        {
            docstring="raise AttributeError",
            trig="A",
        },
        { text("AttributeError("), index(1), common_snippet.append_parentheses_onto_line() },
        is_beginning_of_exception("A")
    ),

    snippet(
        {
            docstring="raise EnvironmentError",
            trig="E",
        },
        { text("EnvironmentError("), index(1), common_snippet.append_parentheses_onto_line() },
        is_beginning_of_exception("E")
    ),

    snippet(
        {
            docstring="raise IndexError",
            trig="I",
        },
        { text("IndexError("), index(1), common_snippet.append_parentheses_onto_line() },
        is_beginning_of_exception("I")
    ),

    snippet(
        {
            docstring="raise KeyError",
            trig="K",
        },
        { text("KeyError("), index(1), common_snippet.append_parentheses_onto_line() },
        is_beginning_of_exception("K")
    ),

    snippet(
        {
            docstring="raise NotImplementedError",
            trig="N",
        },
        { text("NotImplementedError("), index(1), common_snippet.append_parentheses_onto_line() },
        is_beginning_of_exception("N")
    ),

    snippet(
        {
            docstring="raise RuntimeError",
            trig="R",
        },
        { text("RuntimeError("), index(1), common_snippet.append_parentheses_onto_line() },
        is_beginning_of_exception("R")
    ),

    snippet(
        {
            docstring="raise TypeError",
            trig="T",
        },
        { text("TypeError("), index(1), common_snippet.append_parentheses_onto_line() },
        is_beginning_of_exception("T")
    ),

    snippet(
        {
            docstring="raise ValueError",
            trig="V",
        },
        { text("ValueError("), index(1), common_snippet.append_parentheses_onto_line() },
        is_beginning_of_exception("V")
    ),
}
