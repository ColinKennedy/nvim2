local line_begin = require("luasnip.extras.expand_conditions").line_begin

local module = {}

local in_docstring = function()
    local current_node = vim.treesitter.get_node({ buffer = 0 })

    if not current_node then
        return false
    end

    local type_name = current_node:type()

    if vim.bo.filetype == "python" then
        return type_name == "string_content"
    end

    vim.api.nvim_err_writeln('Type name"' .. type_name .. "\" is unknown. Cannot check if we're in a docstring.")

    return false
end

-- Reference: https://snippets.bentasker.co.uk/page-1706031025-Trim-whitespace-from-beginning-of-string-LUA.html
local ltrim = function(text)
    return text:match "^%s*(.*)"
end

local strip_spaces = function(text)
    return text:gsub("%s+", "")
end

local and_ = function(...)
    local functions = { ... }

    return function(...)
        for _, function_ in ipairs(functions) do
            if not function_(...) then
                return false
            end
        end
        return true
    end
end

local is_line_beginning = function(line_to_cursor)
    return strip_spaces(line_to_cursor) == ""
end

local is_source_beginning = function(trigger)
    local wrapper = function(line_to_cursor)
        return line_begin(ltrim(line_to_cursor), trigger) ~= nil
    end

    return wrapper
end

local or_ = function(...)
    local functions = { ... }

    return function(...)
        for _, function_ in ipairs(functions) do
            if function_(...) then
                return true
            end
        end
        return false
    end
end

module.in_docstring = in_docstring
module.is_line_beginning = is_line_beginning
module.is_source_beginning = is_source_beginning
module.and_ = and_
module.or_ = or_

return module
