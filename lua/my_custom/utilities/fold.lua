local M = {}

local startswith = function(full_string, starting_text)
    return string.sub(full_string, 1, string.len(starting_text)) == starting_text
end


-- Check if ``line_number`` is meant to have a fold or not.
--
-- If ``line_number`` is inside of a docstring, it should be folded.
--
-- Args:
--     line_number (int): A 0-or-greater value indicating the line to check.
--
-- Returns:
--     int: The suggested fold level. 0 == no fold, 1 == fold.
--
function M.get_fold_level(line_number)
    local first_non_empty_column = vim.fn.match(vim.fn.getline(line_number + 1), "\\S")

    if first_non_empty_column == -1
    then
        first_non_empty_column = 0
    end

    result = vim.inspect_pos(0, line_number, first_non_empty_column, {filter={treesitter=true}})

    for _, capture in pairs(result["treesitter"])
    do
        if startswith(capture["hl_group"], "@string.documentation")
        then
            return 1
        end
    end

    return 0
end


return M
