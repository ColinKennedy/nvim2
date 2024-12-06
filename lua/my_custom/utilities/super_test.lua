--- Define functions which make parsing a Python `super()` command easier.
---
--- See Also:
---     {nvim_root}/lua/my_custom/snippets/_python_super.lua
---

---@class luasnip.i An index (jumpable tabstop location).
---@class luasnip.t Raw text.

local luasnip = require("luasnip")

local _PYTHON_3_STYLE = vim.g._snippet_python_3_style or false
local _PREFER_KEYWORDS = vim.g._snippet_super_prefer_keywords
local _PYTHON_STATICMETHOD_RESERVED_NAME = "@staticmethod"

local M = {}

--- Check if `decorated_parent` Python node is a staticmethod.
---
--- Example:
---     >>> @foo
---     >>> @staticmethod
---     >>> @bar
---     >>> def something(value):
---     ...     pass
---
---@param decorated_parent TSNode A decorated function or method, in Python.
---@param buffer number A 0-or-more value where `node` came from. 0 means "the current buffer".
---@return boolean # If `decorated_parent` contains "@staticmethod" as a decorator.
---
local function _has_staticmethod(decorated_parent, buffer)
    local current = decorated_parent:named_child(0)

    while current ~= nil
    do
        local current_type = current:type()

        if current_type == "decorator"
        then
            local text = vim.treesitter.get_node_text(current, buffer)

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


--- Find the parent "decorated_definition" TSNode, from `node`.
---
---@param node TSNode The child node of some Python-decorator-enhanced function.
---@return TSNode? # The found top-level parent node, if any.
---
local function _get_nearest_decorated_definition(node)
    local current = node

    while current ~= nil
    do
        if current:type() == "decorated_definition"
        then
            return current
        end

        local parent = current:parent()

        if not parent then
            return nil
        end

        current = parent
    end

    return nil
end


--- Check if `node` Python object is a staticmethod.
---
--- Example:
---     >>> @foo
---     >>> @staticmethod
---     >>> @bar
---     >>> def something(value):
---     ...     pass
---
---@param function_node TSNode A decorated function or a child node of decorated function.
---@param buffer number A 0-or-more value where `node` came from. 0 means "the current buffer".
---@return boolean # If `node` contains "@staticmethod" as a decorator.
---
local function _is_static(function_node, buffer)
    local decorated_parent = _get_nearest_decorated_definition(function_node)

    if decorated_parent == nil
    then
        return false
    end

    return _has_staticmethod(decorated_parent, buffer)
end


--- Parse parameter information from `node`.
---
--- Important:
---     It's assumed that `node` is an instance method or a classmethod so it
---     should always have at least one parameter, even if it's just "self" or
---     "cls" or "mcls" or something.
---
---@param node TSNode
---     A regular is a "function_definition" treesitter Python node. This
---     node contains 1-or-more parameter details.
---@param buffer number
---     A 0-or-more value where `node` came from. 0 means "the current buffer".
---@return { bound_variable: TSNode, parameters: (luasnip.i | luasnip.t)[] }
---     The found, first "self / cls" node and The data to expand via LuaSnip.
---
local function _get_method_parameters(node, buffer)
    local parameters_node = node:named_child(1)

    if not parameters_node then
        vim.notify(
            string.format('Method "%s" has no parameters.', vim.treesitter.get_node_text(node, buffer)),
            vim.log.levels.ERROR
        )

        return {}
    end

    local self_or_cls = parameters_node:named_child(0)

    if not self_or_cls then
        vim.notify(
            string.format('Method "%s" has no self / cls.', vim.treesitter.get_node_text(parameters_node, buffer)),
            vim.log.levels.ERROR
        )

        return {}
    end

    ---@type (luasnip.i | luasnip.t)[]
    local parameters = {}

    local current = self_or_cls:next_named_sibling()
    local keywords_required = false

    local output_index = 0
    local luasnip_index = 0

    local add_indexed_line = function(node_, always_keyword)
        always_keyword = always_keyword or false
        local text = vim.treesitter.get_node_text(node_, buffer)

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


--- Find a parent "class_definition" nvim-treesitter node, starting from `node` child.
---
---@param node TSNode A child node of some "class_definition" object.
---@return TSNode? # The found parent, if any. Regular functions not within a class return `nil`.
---
local function _get_nearest_class(node)
    local current = node

    while current ~= nil
    do
        if current:type() == "class_definition"
        then
            return current
        end

        local parent = current:parent()

        if not parent then
            return nil
        end

        current = parent
    end

    return nil
end


--- Find the top-most function that is still inside of a Python class.
---
--- If found, that function is the target we'd need for a ``super()`` snippet.
---
---@param node TSNode
---     A child node to search put for some function parent. This node usually
---     represents the node at the user's current cursor position in the buffer
---     and is not a "function_definition" node, itself.
---@return TSNode?
---     The found "function_definition" node, if any.
---
local function _get_nearest_function(node)
    local current = node

    while current ~= nil
    do
        local recent_function = nil
        local name = current:type()

        if name == "function_definition"
        then
            recent_function = current
        end

        if name == "class_definition"
        then
            return recent_function
        end

        local parent = current:parent()

        if not parent then
            return nil
        end

        current = parent
    end

    return nil
end


--- Get a "Python 2-style" super block of text.
---
--- In Python 3, you can define a super() command as "super().foo(bar)" but in
--- Python 2, you must provide class and bound variable information like
--- "super(MyClass, self).foo(bar)".
---
--- This function gets the "MyClass, self" part.
---
---@param function_node TSNode
---    A "function_definition" node to search within.
---@param self_or_cls TSNode
---    The first parameter of "function_node" that we assume is the bound
---    variable. By convention it will be called "self" or "cls" but
---    technically could be anything.
---@param buffer number
---     A 0-or-more value where `node` came from. 0 means "the current buffer".
---@return string
---    The generated Python 2 super code, if any.
---
local function _get_super_contents(function_node, self_or_cls, buffer)
    local class_top_node = _get_nearest_class(function_node)

    if not class_top_node then
        local text = vim.treesitter.get_node_text(function_node, buffer)
        vim.notify(
            string.format('Function node "%s" is not in a class.', text),
            vim.log.levels.WARN
        )

        return ""
    end

    local class_name_node = class_top_node:field("name")
    local class_name = vim.treesitter.get_node_text(class_name_node[1], buffer)

    return class_name .. ", " .. vim.treesitter.get_node_text(self_or_cls, buffer)
end


--- Get snippet information for a "super()" command that will be expanded later.
---
---@param node TSNode
---     A child node to search put for some function parent. This node usually
---     represents the node at the user's current cursor position in the buffer
---     and is not a "function_definition" node, itself.
---@param buffer number
---     A 0-or-more value where `node` came from. 0 means "the current buffer".
---@return (luasnip.i | luasnip.t)?
---     The generated snippet information or `nil`, if no snippet
---     information could be created (because `node` isn't within a method
---     or some other reason).
---
local function _get_super_text(node, buffer)
    local function_node = _get_nearest_function(node)

    if function_node == nil
    then
        return nil
    end

    if _is_static(function_node, buffer)
    then
        return nil
    end

    local data = _get_method_parameters(function_node, buffer)
    local self_or_cls = data.bound_variable

    local super_contents = ""

    if not _PYTHON_3_STYLE
    then
        super_contents = _get_super_contents(function_node, self_or_cls, buffer)
    end

    local method_name = vim.treesitter.get_node_text(function_node:field("name")[1], buffer)

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

--- Generate snippet information to LuaSnip which generates some "super().foo()" command.
---
---@return (luasnip.i | luasnip.t)[] # All of the snippet pieces to expand, later.
---
function M.get_current_function_super_text()
    local buffer = 0  -- The current buffer
    local result = vim.fn.getpos(".")

    -- Vim returns rows as "1-or-more". The treesitter API expects "0-or-more".
    -- So we need to ``- 1``
    --
    local row = result[2] - 1
    local column = result[3]

    local node = vim.treesitter.get_node({bufnr=buffer, pos={row, column}})

    if node then
        local output = _get_super_text(node, buffer)

        if output
        then
            return output
        end
    end

    -- Check the line above for a function definition to fill out the super text
    row = row - 1
    local first_non_empty_column = 10  -- TODO: Make this real
    node = vim.treesitter.get_node({bufnr=buffer, pos={row, first_non_empty_column}})

    if not node then
        vim.notify(
            string.format('"super() with line / column "%s / %s" has no node.', row, first_non_empty_column),
            vim.log.levels.ERROR
        )

        return {}
    end

    local output = _get_super_text(node, buffer)

    if output
    then
        return output
    end

    vim.notify(
        "super() was called outside of a {instance,class}method. Cannot continue",
        vim.log.levels.ERROR
    )

    return {}
end


return M
