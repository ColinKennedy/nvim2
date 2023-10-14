local snippet_helper = require("my_custom.utilities.snippet_helper")
local is_source_beginning = snippet_helper.is_source_beginning
local luasnip = require("luasnip")
local function_ = luasnip.f
local index = luasnip.i
local snippet = luasnip.s
local text = luasnip.t


local M = {}


function M.append_parentheses_onto_line()
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


M.print_snippet = snippet(
    {
        docstring="A print() call",
        trig="p",
    },
    { text("print("), index(1), M.append_parentheses_onto_line() },
    { show_condition = is_source_beginning("p") }
)


return M
