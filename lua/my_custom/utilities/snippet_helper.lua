local line_begin = require("luasnip.extras.expand_conditions").line_begin

local module = {}

-- Reference: https://snippets.bentasker.co.uk/page-1706031025-Trim-whitespace-from-beginning-of-string-LUA.html
local ltrim = function(text)
  return text:match'^%s*(.*)'
end


local and_ = function(...)
    local functions = {...}

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
    return line_to_cursor:sub(1, 1) ~= " "
end


local is_source_beginning = function(trigger)
    local wrapper = function(line_to_cursor)
	return line_begin(ltrim(line_to_cursor), trigger) ~= nil
    end

    return wrapper
end


local or_ = function(...)
    local functions = {...}

    return function(...)
        for _, function_ in ipairs(functions) do
            if function_(...) then
                return true
            end
        end
        return false
    end
end


module.is_line_beginning = is_line_beginning
module.is_source_beginning = is_source_beginning
module.and_ = and_
module.or_ = or_

return module
