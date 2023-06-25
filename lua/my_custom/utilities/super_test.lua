local _PYTHON_3_STYLE = false  -- TODO: Find this dynamically, somehow

local M = {}

local _is_static = function(function_node)
    return false
    -- TODO: Add support for this later
    -- local decorated_parent = _get_nearest_decorated_definition(function)
    --
    -- if decorated_parent == nil
    -- then
    --     return false
    -- end
    --
    -- return _has_staticmethod(decorated_parent)
end


local _get_function_parameters = function(node)
end


-- local _get_nearest_decorated_definition = function(node)
-- end

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
            return recent_function
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
    if _PYTHON_3_STYLE
    then
        return ""
    end

    local class_node = _get_nearest_class(function_node)
    local class_name = class_node:field("name")

    return class_name .. ", " .. self_or_cls
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
    local self_or_cls = data.first_parameter
    local super_contents = _get_super_contents(function_node, self_or_cls)

    return "super(" .. super_contents .. ")"
    -- return "super(" .. super_contents .. ")." .. function:field("name") .. "(" .. arguments_contents .. ")"
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
    local result = _get_super_text(node)

    if result == nil
    then
        vim.api.nvim_err_writeln(
            "super() was called outside of a {instance,class}method. Cannot continue"
        )

        return ""
    end

    return result
end


return M
