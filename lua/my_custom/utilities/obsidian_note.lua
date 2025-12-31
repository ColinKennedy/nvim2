local obsidian_state = require("my_custom.utilities.obsidian_state")

local _P = {}
local M = {}

--- Use `title` to recommend a simplified ID for the Obsidian note.
---
---@param title string Some word or phrase to make into a note.
---@return string # The generated ID.
---
function _P.get_note_identifier(title)
    local suffix = ""

    if title ~= nil and title ~= "" then
        suffix = title
            :gsub("%s+", "-") -- spaces → hyphens
            :gsub("[^A-Za-z0-9-]", "") -- strip invalid chars
            :lower()
    else
        for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
        end
    end

    return tostring(os.time()) .. "-" .. suffix
end

--- Make a note in an Obsidian vault.
---
---@param title string Some word or phrase to identify the note.
---
function M.create_note(title)
    local vault = obsidian_state.get_workspace_path()
    local identifier = _P.get_note_identifier(title)
    local path = vim.fs.joinpath(vault, identifier .. ".md")

    local date = os.date("%Y-%m-%d")
    local time = os.date("%H:%M")

    -- File contents
    local lines = {
        "---",
        "id: " .. identifier,
        "date: " .. date,
        "time: " .. time,
        "aliases:",
        "  - " .. title,
        "tags: []",
        "---",
        "",
        "# " .. title,
        "",
    }

    vim.fn.mkdir(vim.fs.dirname(path), "p")
    vim.fn.writefile(lines, path)
    vim.cmd.edit(path)
end

return M
