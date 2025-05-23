--- Basic snippets that only span one line / one statement.
---
---@module 'my_custom.snippets._python_inline'
---

local texter = require("my_custom.utilities.texter")

local common_snippet = require("my_custom.snippets._common_snippet")
local is_source_beginning = require("my_custom.utilities.snippet_helper").is_source_beginning

local luasnip = require("luasnip")
local format = require("luasnip.extras.fmt").fmt
local function_ = luasnip.f
local index = luasnip.i
local repeat_ = require("luasnip.extras").rep
local snippet = luasnip.s
local text_ = luasnip.t

---@class luasnip.f A function wrapper that creates dynamic snippets.

--- Check if `trigger` is actually on a "raise ..." Python statement.
---
---@param trigger string
---    The snippet trigger text.
---@return { show_condition: luasnip.f }
---    A function that luasnip uses to check if the snippet should trigger.
---
local function is_beginning_of_exception(trigger)
    return { show_condition = is_source_beginning("raise " .. trigger) }
end

--- Change `foo = "bar"` line to just `"bar"`, to prep it for adding snippet text later.
---
--- TODO: This snippet sucks but I cannot figure out how to get
--- `remove_leading_equal_sign` to work as a "pre-expand" snippet without it
--- breaking things.
---
--- Reference: https://github.com/L3MON4D3/LuaSnip/discussions/383
---
---@param text string The snippet trigger text to modify.
---@return luasnip.f # A function that luasnip uses to check if the snippet should trigger.
---
local function remove_leading_equal_sign(text)
    return function_(function()
        local current_row = vim.fn.line(".") -- This is "1-or-greater"
        local current_line = vim.fn.getline(current_row)
        local leading_indent = string.sub(current_line, 0, (#current_line - #texter.lstrip(current_line)))

        local _, end_index = current_line:find("=")

        if end_index == nil then
            return
        end

        local current_buffer = 0

        local line_without_equals = current_line:sub(end_index + 1, #current_line)
        local stripped = text .. texter.lstrip(line_without_equals)
        local line = leading_indent .. stripped

        vim.schedule(function()
            vim.api.nvim_buf_set_lines(current_buffer, current_row - 1, current_row, true, { line })
        end)
    end)
end

local output = {
    common_snippet.print_snippet,

    snippet({
        docstring = "list comprehension",
        trig = "lc",
    }, format([[ [{} for {} in {}] ]], { index(1, "item"), repeat_(1), index(2) })),

    snippet({
        docstring = "set comprehension",
        trig = "sc",
    }, format([[ {{{} for {} in {}}} ]], { index(1, "item"), repeat_(1), index(2) })),

    -- TODO: This snippet sucks but I cannot figure out how to get
    -- `remove_leading_equal_sign` to work as a "pre-expand" snippet without it
    -- breaking things.
    --
    -- Reference: https://github.com/L3MON4D3/LuaSnip/discussions/383
    --
    snippet(
        {
            docstring = "return statement",
            trig = "r",
        },
        { text_("return "), index(1), remove_leading_equal_sign("return ") },
        { show_condition = is_source_beginning("r") }
    ),
}

for keyword, trigger in pairs({
    AttributeError = "A",
    EnvironmentError = "E",
    IndexError = "I",
    KeyError = "K",
    NotImplementedError = "N",
    RuntimeError = "R",
    TypeError = "T",
    ValueError = "V",
}) do
    table.insert(
        output,
        snippet(
            {
                docstring = string.format("raise %s", keyword),
                trig = trigger,
            },
            { text_(string.format("%s(", keyword)), index(1), common_snippet.append_parentheses_onto_line() },
            is_beginning_of_exception(trigger)
        )
    )
end

return output
