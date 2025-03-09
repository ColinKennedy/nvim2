-- A simper treesitter-based docstring parser, used to generate vim fold markers.
-- Normally, Vim generates folds per-line, using regex. That process only kind of works
-- and is actually pretty fragile and slow on bigger files.
--
-- Instead, this module uses treesitter to parse the entire file and cache its
-- results. When individual lines are queried for "folded-ness", the cached
-- line result is returned instead. In other words, the folds are only computed
-- a fraction of the time that they're requested. That + treesitter is already
-- pretty quick and you've got yourself lightning-speed auto-fold docstrings!
--

local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

--- Find all lines that contain Python docstrings in `buffer`.
---
---@param buffer number A 0-or-more value that points to some lines.
---@return {start_row: number, end_row: number}[] # All found start / end ranges.
---
local function get_all_docstring_ranges(buffer)
    local file_type = vim.bo.filetype

    local parser = vim.treesitter.get_parser(buffer, file_type)

    if not parser then
        vim.notify(string.format('Buffer / File type "%s / %s" has no treesitter parser.', buffer, file_type), 0)

        return {}
    end

    local tree = parser:parse()

    if not tree then
        vim.notify(
            string.format('Buffer / File type "%s / %s" no treesitter parser but no tree was found.', buffer, file_type),
            0
        )

        return {}
    end

    local root = tree[1]:root()

    -- TODO: This query is Python-specific. Try to "generisize" it for other languages
    local query = vim.treesitter.query.parse(
        file_type,
        [[
            (
              (function_definition
                (block
                  .
                  (expression_statement
                    (string (string_content) @documentation.inner)) @documentation.outer
                )
              )
            )
        ]]
    )

    ---@type {start_row: number, end_row: number}[]
    local output = {}

    for _, captures, _ in query:iter_matches(root, buffer) do
        for _, node in ipairs(captures[1]) do
            local start_row, _, end_row, _ = node:range()
            table.insert(output, { start_row = start_row, end_row = end_row })
        end
    end

    return output
end

--- Declare a special cached function that can track the computed docstring start / end.
local get_cached_buffer_folds = ts_utils.memoize_by_buf_tick(function(buffer)
    ---@type table<number, number>
    local lines = {}

    for _, range in pairs(get_all_docstring_ranges(buffer)) do
        for line = range["start_row"], range["end_row"] do
            lines[line] = 1
        end
    end

    return lines
end)

--- Check if ``line_number`` is meant to have a fold or not.
---
--- If ``line_number`` is inside of a docstring, it should be folded.
---
---@param line_number number A 0-or-greater value indicating the line to check.
---@return number # The suggested fold level. 0 == no fold, 1 == fold.
---
function M.get_fold_level(line_number)
    if not line_number then
        return 0
    end

    local buffer = vim.api.nvim_get_current_buf()
    local levels = get_cached_buffer_folds(buffer) or {}

    return levels[line_number] or 0
end

--- Force-set folds in the buffer.
---
--- Important:
---     Calling this function will remove existing folds and take over the buffer's foldmethod.
---
---@param buffer number?
---    A 0-or-more value indicating the buffer to edit. Passing nothing or
---    explicitly passing ``0`` indicate "do this on the current buffer".
---
function M.fold_buffer_manually(buffer)
    -- Clear folds so they can be recomputed. Allow manual folding for the code to come.
    vim.cmd [[setlocal foldmethod=manual]]
    vim.cmd [[normal zE]]

    buffer = buffer or vim.api.nvim_get_current_buf()

    for _, range in pairs(get_all_docstring_ranges(buffer)) do
        vim.cmd((range["start_row"] + 1) .. "," .. (range["end_row"] + 1) .. "fold")
    end
end

return M
