local is_source_beginning = require("my_custom.utilities.snippet_helper").is_source_beginning
local events = require("luasnip.util.events")
local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local function_ = luasnip.f
local index = luasnip.i
local snippet = luasnip.s
local text = luasnip.t


local is_beginning_of_exception = function(trigger)
    return {
        show_condition = is_source_beginning("raise " .. trigger)
    }
end


local append_parentheses_onto_line = function()
    return function_(
        function(_, _)
            local current_row = vim.fn.line(".")  -- This is "1-or-greater"
            local current_line = vim.fn.getline(current_row)
            local current_buffer = 0

            vim.schedule(
                function()
                    vim.api.nvim_buf_set_lines(
                        current_buffer,
                        current_row - 1,
                        current_row,
                        true,
                        { current_line .. ")" }
                    )
                end
            )
        end
    )
end


return {
    snippet(
        {
            docstring="A print() call",
            trig="p",
        },
        { text("print("), index(1)}  -- TODO: Re-add append_parentheses_onto_line
    ),

    snippet(
        {
            docstring="return statement",
            trig="r",
        },
        { text("return "), index(1) }
    ),

    snippet(
        {
            docstring="raise AttributeError",
            trig="A",
        },
        { text("AttributeError("), index(1), append_parentheses_onto_line() },
        is_beginning_of_exception("A")
    ),

    snippet(
        {
            docstring="raise EnvironmentError",
            trig="E",
        },
        { text("EnvironmentError("), index(1), append_parentheses_onto_line() },
        is_beginning_of_exception("E")
    ),

    snippet(
        {
            docstring="raise IndexError",
            trig="I",
        },
        { text("IndexError("), index(1), append_parentheses_onto_line() },
        is_beginning_of_exception("I")
    ),

    snippet(
        {
            docstring="raise KeyError",
            trig="K",
        },
        { text("KeyError("), index(1), append_parentheses_onto_line() },
        is_beginning_of_exception("K")
    ),

    snippet(
        {
            docstring="raise NotImplementedError",
            trig="N",
        },
        { text("NotImplementedError("), index(1), append_parentheses_onto_line() },
        is_beginning_of_exception("N")
    ),

    snippet(
        {
            docstring="raise RuntimeError",
            trig="R",
        },
        { text("RuntimeError("), index(1), append_parentheses_onto_line() },
        is_beginning_of_exception("R")
    ),

    snippet(
        {
            docstring="raise TypeError",
            trig="T",
        },
        { text("TypeError("), index(1), append_parentheses_onto_line() },
        is_beginning_of_exception("T")
    ),

    snippet(
        {
            docstring="raise ValueError",
            trig="V",
        },
        { text("ValueError("), index(1), append_parentheses_onto_line() },
        is_beginning_of_exception("V")
    ),
}
