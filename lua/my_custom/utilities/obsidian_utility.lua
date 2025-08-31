--- Extra functions to make obsidian.nvim better.
---
---@module 'my_custom.utilities.obsidian_utility'
---

local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local state = require("telescope.actions.state")
local telescope_config = require("telescope.config").values

-- NOTE: obsidian.nvim separates the top-level note data from the rest of the
-- document using these characters.
--
local _METADATA_MARKER = "---"
-- NOTE: obsidian.nvim uses YAML and aliases is a string[] that starts with "aliases:"
local _ALIASES_START_MARKER = "aliases:"
local _P = {}
local M = {}

---@class obsidian._types.FoundAlias
---    A note + its aliases.
---@field path string
---    The absolute path on-disk to the obsidian note that has 1+ alias.
---@field aliases string[]
---    All of the found aliases.

function _P.is_alias_line(line)
    local character = line[1]

    return character and character ~= " "
end

--- Find the alias from `text`, if any.
---
---@param text string The line to query. e.g. ` - some_tag/here`.
---@return string? # The found match, if any.
---
function _P.get_alias_text(text)
    return (string.match(text, "%s*-%s*(.*)"))
end

--- Find all file aliases from some obsidian.nvim note `path`.
---
--- Raises:
---     If `path` cannot be read for data.
---
---@param path string An absolute path on-disk to some obsidian note to query from.
---@return string[]  # All found aliases, if any.
---
function _P.get_aliases(path)
    local handler = io.open(path)

    if not handler then
        error(string.format('File "%s" could not be opened.', path), 0)
    end

    local started = false
    local aliases_started = false
    ---@type string[]
    local output = {}

    for line in handler:lines() do
        if line == _METADATA_MARKER then
            if not started then
                started = true
            else
                break
            end
        elseif line == _ALIASES_START_MARKER then
            aliases_started = true
        elseif aliases_started then
            local alias = _P.get_alias_text(line)

            if alias then
                table.insert(output, alias)
            elseif not _P.is_alias_line(line) then
                break
            end
        end
    end

    return output
end

--- Create a telescope.nvim picker to display `aliases`.
---
---@param aliases obsidian._types.FoundAlias[]
---    All of the aliases / paths to display.
---
function _P.make_picker(aliases)
    local options = {}

    ---@type string[]
    local results = {}

    ---@type table<string, string>
    local alias_to_path = {}

    for _, value in ipairs(aliases) do
        local aliases_ = value.aliases
        vim.list_extend(results, aliases_)

        for _, alias in ipairs(aliases_) do
            alias_to_path[alias] = value.path
        end
    end

    return pickers.new(options, {
        prompt_title = "Obsidian Aliases",
        finder = finders.new_table({
            results = results,
            entry_maker = function(entry)
                local result = {}

                result.value = entry
                local path = alias_to_path[entry]
                result.path = path
                result.fields = {
                    path = path,
                }
                result.display = entry
                result.ordinal = entry

                return result
            end,
        }),
        previewer = previewers.vim_buffer_cat.new({ title = "Node" }),
        sorter = telescope_config.file_sorter(options),
        attach_mappings = function(prompt_buffer, map)
            map(
                "i",
                "<CR>",
                function()
                    local selection = state.get_selected_entry()

                    if not selection or vim.tbl_isempty(selection) then
                        return
                    end

                    actions.close(prompt_buffer)

                    vim.cmd.edit(selection.fields.path)
                end,
                -- NOTE: `desc` is currently unsupported by telescope.nvim
                -- Reference: https://github.com/nvim-telescope/telescope.nvim/issues/2981
                --
                { desc = "Select the alias(s) and open their files." }
            )

            return true
        end,
    })
end

--- Open the picker
function M.main()
    local vault_root = "~/vaults" -- TODO: Get this more dynamically later
    local template = vim.fs.joinpath(vault_root, "**", "*.md")
    ---@type obsidian._types.FoundAlias[]
    local found = {}

    for _, path in ipairs(vim.fn.glob(template, true, true)) do
        local aliases = _P.get_aliases(path)

        if aliases then
            table.insert(found, { path = path, aliases = aliases })
        end
    end

    local picker = _P.make_picker(found)
    picker:find()
end

return M
