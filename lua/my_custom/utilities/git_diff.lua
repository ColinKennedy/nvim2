--- @class _DiffDetails The line or row (line number) details that were found.
--- @field path string An absolute or relative path to a file or directory on-disk.
--- @field row integer A 1-or-more number indicating the line of some changed text.

--- @class _QuickFixEntry A description of file + line + text to send to `setqflist()`.
--- @field filename string An absolute / relative path on-disk.
--- @field lnum integer A 1-or-more number indicating the line of the quickfix entry.
--- @field text string The raw line text to display as part of the quickfix entry.

local M = {}


--- Check if `text` is an added / removed `git diff` line.
---
--- @param text string Some raw `git diff` line to check.
--- @return boolean # If `text` is an added / removed line, return `true`.
---
local function _is_changed(text)
    return string.match(text, "^[-%+].*") ~= nil
end


--- Check if `text` is not actually a `git diff` line but a surrounding context line.
---
--- A `git diff` marks any added/removed lines with + or - so any line that
--- doesn't have it must just be there to help make viewing the diff easier.
---
--- @param text string Some raw `git diff` line to check.
--- @return boolean # If `text` isn't part of the diff, return `true`.
---
local function _is_not_part_of_the_diff(text)
    return string.match(text, "^%s") ~= nil
end


--- Find a `git diff`-related file from `text`.
---
--- The `git diff` line may look like:
---
---     @@ -1,6 +2,6 @@
---
--- Where "+1" indicates the most up-to-date line number.
---
--- @param text string Some raw `git diff` line to check.
--- @return integer? # The found, 1-or-more row number, if any.
---
local function _get_row(text)
    local result = string.match(text, "^@@.+%+(%d+).*@@")

    if result == nil
    then
        return nil
    end

    return tonumber(result)
end


--- Find a `git diff`-related file from `text`.
---
--- The `git diff` file may look like:
---
---     --- a/README.md
---     +++ b/README.md
---
--- Where "---" indicates the file's old name and "+++" is the file's
--- most current, on-disk name.
---
--- @param text string Some raw `git diff` line to check.
--- @return string? # The found file path, if any.
---
local function _get_path(text)
    return string.match(text, "^%+%+%+ (.+)")
end


--- Parse `line` for any `git diff` related details.
---
--- @param line string A raw `git diff` line to check for data.
--- @return _DiffDetails # The line or row (line number) details that were found.
---
local function _get_details(line)
    local row = _get_row(line)

    if row ~= nil
    then
        return {row=row}
    end

    local path = _get_path(line)

    if path ~= nil
    then
        return {path=path}
    end

    return {}
end


--- Strip all `git diff` related strings from `text.
---
--- @param text string A line which (we assume) has some `git diff` notation applied.
--- @return string # The real source code of `text`.
---
local function _get_source_line(text)
    return string.match(text, ".(.+)")
end


--- Run `git diff` from `directory` and gather its results for a quickfix list.
---
--- @param directory string An absolute or relative path to some git repository.
--- @return _QuickFixEntry[] # All of the found `git diff` results, if any.
---
function M.get_git_diff(directory)
    local command = "git diff --no-prefix --relative"
    local row = nil
    local path = nil
    local output = {}

    for _, line in ipairs(vim.fn.systemlist(command, directory))
    do
        local details = _get_details(line)

        if details.path ~= nil
        then
            path = details.path
        elseif details.row ~= nil
        then
            row = details.row
        end

        if path ~= nil and row ~= nil
        then
            if _is_not_part_of_the_diff(line)
            then
                row = row + 1
            elseif _is_changed(line)
            then
                local source = _get_source_line(line)
                table.insert(output, {filename=path, lnum=row, text=source})

                -- Reset the row so that only one entry is found per "git hunk"
                row = nil
            end
        end
    end

    return output
end


--- Run `git diff` from `directory` and add set the quickfix list with the results.
---
--- @param directory string An absolute or relative path to some git repository.
---
function M.load_git_diff(directory)
    local entries = M.get_git_diff(directory)

    if not vim.tbl_isempty(entries)
    then
        vim.fn.setqflist(entries)
        vim.cmd[[copen]]
    else
        vim.api.nvim_err_writeln('Directory "' .. directory .. '" as no git diff.')
    end
end


return M
