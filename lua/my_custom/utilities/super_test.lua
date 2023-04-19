-- Define functions which make parsing a Python `super()` command easier.
--
-- See Also:
--     {nvim_root}/lua/my_custom/snippets/_python_super.lua
--

local luasnip = require("luasnip")

local _PYTHON_3_STYLE = vim.g._snippet_python_3_style or false
local _CURRENT_BUFFER = 0
local _PREFER_KEYWORDS = vim.g._snippet_super_prefer_keywords
local _PYTHON_STATICMETHOD_RESERVED_NAME = "@staticmethod"

local M = {}

-- Check if `decorated_parent` Python node is a staticmethod.
--
-- Example:
--     >>> @foo
--     >>> @staticmethod
--     >>> @bar
--     >>> def something(value):
--     ...     pass
--
-- Args:
--     decorated_parent (TSNode): A decorated function or method, in Python.
--
-- Returns:
--     boolean: If `decorated_parent` contains "@staticmethod" as a decorator.
--
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


-- Find the parent "decorated_definition" TSNode, from `node`.
--
-- Args:
--     node (TSNode): The child node of some Python-decorator-enhanced function.
--
-- Returns:
--     TSNode or nil: The found top-level parent node, if any.
--
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


-- Check if `node` Python object is a staticmethod.
--
-- Example:
--     >>> @foo
--     >>> @staticmethod
--     >>> @bar
--     >>> def something(value):
--     ...     pass
--
-- Args:
--     node (TSNode): A decorated function or a child node of decorated function.
--
-- Returns:
--     boolean: If `node` contains "@staticmethod" as a decorator.
--
local _is_static = function(function_node)
    local decorated_parent = _get_nearest_decorated_definition(function_node)

    if decorated_parent == nil
    then
        return false
    end

    return _has_staticmethod(decorated_parent)
end


-- Parse parameter information from `node`.
--
-- Important:
--     It's assumed that `node` is an instance method or a classmethod so it
--     should always have at least one parameter, even if it's just "self" or
--     "cls" or "mcls" or something.
--
-- Args:
--     node (TSNode):
--         A regular is a "function_definition" treesitter Python node. This
--         node contains 1-or-more parameter details.
--
-- Returns:
--     bound_variable (TSNode): The found, first "self / cls" node.
--     parameters (table[luasnip.i or luasnip.t]): The data to expand via LuaSnip.
--
local _get_method_parameters = function(node)
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


-- Find a parent "class_definition" nvim-treesitter node, starting from `node` child.
--
-- Args:
--     node (TSNode): A child node of some "class_definition" object.
--
-- Returns:
--     TSNode or nil:
--         The found parent, if any. Regular functions not within a class return `nil`.
--
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
-- Args:
--     node (TSNode):
--         A child node to search put for some function parent. This node usually
--         represents the node at the user's current cursor position in the buffer
--         and is not a "function_definition" node, itself.
--
-- Returns:
--      TSNode or nil: The found "function_definition" node, if any.
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


-- Get a "Python 2-style" super block of text.
--
-- In Python 3, you can define a super() command as "super().foo(bar)" but in
-- Python 2, you must provide class and bound variable information like
-- "super(MyClass, self).foo(bar)".
--
-- This function gets the "MyClass, self" part.
--
-- Args:
--     function_node (TSNode):
--         A "function_definition" node to search within.
--     self_or_cls (TSNode):
--         The first parameter of "function_node" that we assume is the bound
--         variable. By convention it will be called "self" or "cls" but
--         technically could be anything.
--
-- Returns:
--     string: The generated Python 2 super code.
--
local _get_super_contents = function(function_node, self_or_cls)
    local class_top_node = _get_nearest_class(function_node)
    local class_name_node = class_top_node:field("name")
    local class_name = vim.treesitter.get_node_text(class_name_node[1], _CURRENT_BUFFER)

    return class_name .. ", " .. vim.treesitter.get_node_text(self_or_cls, _CURRENT_BUFFER)
end


-- Get snippet information for a "super()" command that will be expanded later.
--
-- Args:
--     node (TSNode):
--         A child node to search put for some function parent. This node usually
--         represents the node at the user's current cursor position in the buffer
--         and is not a "function_definition" node, itself.
--
-- Returns:
--     table[luasnip.i or luasnip.t] or nil:
--         The generated snippet information or `nil`, if no snippet
--         information could be created (because `node` isn't within a method
--         or some other reason).
--
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

    local data = _get_method_parameters(function_node)
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


-- Generate snippet information to LuaSnip which generates some "super().foo()" command.
--
-- Returns:
--     table[luasnip.i or luasnip.t]: All snippets for LuaSnip to expand, later.
--
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

    if output
    then
        return output
    end

    -- Check the line above for a function definition to fill out the super text
    row = row - 1
    first_non_empty_column = 10  -- TODO: Make this real
    node = vim.treesitter.get_node({bufnr=buffer, pos={row, first_non_empty_column}})
    output = _get_super_text(node)

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
