local luasnip = require("luasnip")

local _PYTHON_3_STYLE = false  -- TODO: Find this dynamically, somehow
local _CURRENT_BUFFER = 0
local _PREFER_KEYWORDS = true  -- TODO: Add configuration value
local _PYTHON_STATICMETHOD_RESERVED_NAME = "@staticmethod"

local M = {}

local _has_staticmethod = function(decorated_parent)
    current = decorated_parent:named_child(0)

    while current ~= nil
    do
        local current_type = current:type()

        if current_type == "decorator"
        then
            local text = vim.treesitter.get_node_text(current, _CURRENT_BUFFER)

            if text == _PYTHON_STATICMETHOD_RESERVED_NAME
            then
                return true
            end
        end

        if current_type == "function_definition"
        then
            return false
        end

        current = current:next_named_sibling()
    end

    return false
end


local _get_nearest_decorated_definition = function(node)
    local current = node

    while current ~= nil
    do
        if current:type() == "decorated_definition"
        then
            return current
        end

        current = current:parent()
    end

    return nil
end


local _is_static = function(function_node)
    local decorated_parent = _get_nearest_decorated_definition(function_node)

    if decorated_parent == nil
    then
        return false
    end

    return _has_staticmethod(decorated_parent)
end


-- -- TODO: Finish doc
-- `node` is a function_definition
local _get_function_parameters = function(node)
    local parameters_node = node:named_child(1)
    local self_or_cls = parameters_node:named_child(0)
    local parameters = {}

    local current = self_or_cls:next_named_sibling()
    local keywords_required = false

    local output_index = 0
    local luasnip_index = 0

    local add_indexed_line = function(node, always_keyword)
        always_keyword = always_keyword or false
        local text = vim.treesitter.get_node_text(node, _CURRENT_BUFFER)
        local line = ""

        if always_keyword or keywords_required
        then
            output_index = output_index + 1
            parameters[output_index] = luasnip.t(text .. "=")
        end

        output_index = output_index + 1
        luasnip_index = luasnip_index + 1
        parameters[output_index] = luasnip.i(luasnip_index, text)
        output_index = output_index + 1
        parameters[output_index] = luasnip.t(", ")
    end

    while current ~= nil
    do
        local current_type = current:type()

        if current_type == "identifier"
        then
            -- A regular parameter name should be positional
            -- unless keywords are needed / wanted.
            --
            add_indexed_line(current)
        elseif current_type == "default_parameter" or current_type == "typed_default_parameter"
        then
            local identifier_node = current:field("name")[1]
            add_indexed_line(identifier_node, _PREFER_KEYWORDS)
        elseif current_type == "list_splat_pattern" or current_type == "dictionary_splat_pattern"
        then
            add_indexed_line(current)
        elseif current_type == "typed_parameter"
        then
            local identifier_node = current:named_child(0)

            add_indexed_line(identifier_node)
        elseif current_type == "keyword_separator"
        then
            -- e.g. the `*` in `foo(foo, *, bar=8,
            -- thing=None)`. Every parameter after this point
            -- MUST be keyword-only.
            --
            keywords_required = true
        end

        current = current:next_named_sibling()
    end

    local parameters_size = #parameters
    table.remove(parameters, parameters_size)  -- Remove the last, trailing ", " node

    local output = {}

    output.bound_variable = self_or_cls
    output.parameters = parameters

    return output
end


local _get_nearest_class = function(node)
    local current = node
    local recent_function = nil

    while current ~= nil
    do
        if current:type() == "function_definition"
        then
            recent_function = current
        end

        if current:type() == "class_definition"
        then
            return current
        end

        current = current:parent()
    end

    return nil
end


-- Find the top-most function that is still inside of a Python class.
--
-- If found, that function is the target we'd need for a ``super()`` snippet.
--
local _get_nearest_function = function(node)
    local current = node
    local recent_function = nil

    while current ~= nil
    do
        local name = current:type()

        if name == "function_definition"
        then
            recent_function = current
        end

        if name == "class_definition"
        then
            return recent_function
        end

        current = current:parent()
    end

    return nil
end


local _get_super_contents = function(function_node, self_or_cls)
    local class_top_node = _get_nearest_class(function_node)
    local class_name_node = class_top_node:field("name")
    local class_name = vim.treesitter.get_node_text(class_name_node[1], _CURRENT_BUFFER)

    return class_name .. ", " .. vim.treesitter.get_node_text(self_or_cls, _CURRENT_BUFFER)
end


local _get_super_text = function(node)
    local function_node = _get_nearest_function(node)

    if function_node == nil
    then
        return nil
    end

    if _is_static(function_node)
    then
        return nil
    end

    local data = _get_function_parameters(function_node)
    local self_or_cls = data.bound_variable

    local super_contents = ""

    if not _PYTHON_3_STYLE
    then
        super_contents = _get_super_contents(function_node, self_or_cls)
    end

    local method_name = vim.treesitter.get_node_text(function_node:field("name")[1], _CURRENT_BUFFER)

    local output = {
        luasnip.t("super(" .. super_contents .. ")." .. method_name .. "(")
    }

    for _, value in pairs(data.parameters)
    do
        table.insert(output, value)
    end

    table.insert(output, luasnip.t(")"))

    return output
end


function M.get_current_function_super_text()
    buffer = 0  -- The current buffer
    result = vim.fn.getpos(".")
    -- Vim returns rows as "1-or-more". The treesitter API expects "0-or-more".
    -- So we need to ``- 1``
    --
    row = result[2] - 1
    column = result[3]

    local node = vim.treesitter.get_node({bufnr=buffer, pos={row, column}})
    local output = _get_super_text(node)

    if not output
    then
        row = row - 1
        first_non_empty_column = 10  -- TODO: Make this real
        node = vim.treesitter.get_node({bufnr=buffer, pos={row, first_non_empty_column}})
        output = _get_super_text(node)
    end

    if output
    then
        return output
    end

    vim.api.nvim_err_writeln(
        "super() was called outside of a {instance,class}method. Cannot continue"
    )

    return {}
end


return M
