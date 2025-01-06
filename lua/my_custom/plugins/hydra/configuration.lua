--- Set up Hydra submodes.
---
---@module 'my_custom.plugins.hydra.configuration'
---

local Hydra = require("hydra")
local actions = require("gitsigns.actions")
local config = require("gitsigns.config")
local gitsigns = require("gitsigns")
local hunks_ = require("gitsigns.hunks")
local selector = require("my_custom.utilities.selector")

local _GIT_DIFF_TAB_VARIABLE = "_hydra_git_diff_tab"
local _S_START_SQUARE_BRACE = nil
local _S_END_SQUARE_BRACE = nil

---@return boolean # Check if the user is currently visually selecting something.
local function _in_visual_mode()
    local current_mode = vim.fn.mode()

    if
        current_mode == "v"
        or current_mode == "vs"
        or current_mode == "V"
        or current_mode == "Vs"
        or current_mode == "\\<C-V>"
        or current_mode == "\\<C-Vs>"
    then
        return true
    end

    return false
end

--- Find all modified files from the repository on-or-above `directory`.
---
---@param directory string
---    A directory that is either on or underneath a git repository.
---@return string[]
---    All of the found modified files, if any.
---
local function _get_git_diff_paths(directory)
    -- These paths are relative to the root of the git repository
    local relative_paths = vim.fn.systemlist("git diff --name-only", directory)

    ---@type string[]
    local output = {}

    for _, path in ipairs(relative_paths) do
        -- TODO: Account for windows \ separators
        local absolute = directory .. "/" .. path
        table.insert(output, absolute)
    end

    return output
end

--- Find the index (or closest index) of `element` in `items`.
---
---@param element string
---    An element that might be in `items` or just comparable to an element
---    that is in `items`.
---@param items string[]
---    All elements to consider.
---@return string?
---    The best next element, if found.
---
local function _get_next_in_list(element, items)
    if vim.tbl_isempty(items) then
        return nil
    end

    local found = false

    for index, item in ipairs(items) do
        if found then
            return item
        end

        if item == element then
            found = true

            if index == #items then
                -- NOTE: If at the last item, start from the beginning
                return items[1]
            end
        end
    end

    for _, item in ipairs(items) do
        if element > item then
            return item
        end
    end

    return items[#items]
end

--- Find the index (or closest index) of `element` in `items`.
---
---@param element string
---    An element that might be in `items` or just comparable to an element
---    that is in `items`.
---@param items string[]
---    All elements to consider.
---@return string?
---    The best previous element, if found.
---
local function _get_previous_in_list(element, items)
    if vim.tbl_isempty(items) then
        return nil
    end

    for _, item in ipairs(items) do
        if element < item then
            return item
        end
    end

    return items[1]
end

--- Move the cursor to the first unstaged hunk in `window`.
---
---@param window integer A 0-or-more value pointing to a view of a Vim buffer.
local function _go_to_first_hunk_in_buffer(window)
    local hunks = actions.get_hunks()

    if not hunks then
        return
    end

    window = window or 0
    local line = vim.api.nvim_win_get_cursor(window)[1]
    local wrap = false
    local index = hunks_.find_nearest_hunk(line, hunks, "first", wrap)

    if not index then
        vim.notify("No next hunk index could be found", vim.log.levels.ERROR)

        return
    end

    local hunk = hunks[index]
    local line = hunk.added.start or hunk.removed.start

    vim.api.nvim_win_set_cursor(0, { line, 0 })
end

--- Move the cursor to the last unstaged hunk in `window`.
---
---@param window integer A 0-or-more value pointing to a view of a Vim buffer.
---
local function _go_to_last_hunk_in_buffer(window)
    window = window or 0
    local hunks = actions.get_hunks()

    if not hunks then
        return
    end

    local line = vim.api.nvim_win_get_cursor(window)[1]
    local wrap = false
    local index, _ = hunks_.find_nearest_hunk(line, hunks, "last", wrap)
    local hunk = hunks[index]
    local line = hunk.added.start or hunk.removed.start

    vim.api.nvim_win_set_cursor(0, { line, 0 })
end

--- Go to the git hunk that is after this cursor / file, if any.
---
--- If the cursor is already at the bottom hunk of a file, we consult the `paths`
--- to find the next best location to jump to.
---
---@param paths string[] All modified file paths that contain at least one hunk.
---
local function _go_to_next_hunk(paths)
    local forwards = true

    if actions.has_next_hunk("next") then
        gitsigns.next_hunk()

        return
    end

    local current = vim.fn.expand("%:p")
    local next_ = _get_next_in_list(current, paths)

    if next_ == nil then
        vim.api.nvim_err_writeln("No next file could be found.")

        return
    end

    vim.cmd("edit " .. next_)
    _go_to_first_hunk_in_buffer()
end

--- Go to the git hunk that is before this cursor / file, if any.
---
--- If the cursor is already at the top hunk of a file, we consult the `paths`
--- to find the next best location to jump to.
---
---@param paths string[] All[] modified file paths that contain at least one hunk.
---
local function _go_to_previous_hunk(paths)
    local forwards = false

    if actions.has_next_hunk("prev") then
        gitsigns.prev_hunk()

        return
    end

    local current = vim.fn.expand("%:p")
    local previous = _get_previous_in_list(current, paths)

    if previous == nil then
        vim.api.nvim_err_writeln("No previous file could be found.")

        return
    end

    vim.cmd("edit " .. previous)
    _go_to_last_hunk_in_buffer()
end

--- Keep track of all of my `s` mappings so that they can be restored later, if needed.
local function _save_other_s_mappings()
    if vim.fn.maparg("s[", "n") ~= "" then
        _S_START_SQUARE_BRACE = vim.fn.maparg("s[", "n", false, true)
        vim.api.nvim_del_keymap("n", "s[")
    else
        _S_START_SQUARE_BRACE = nil
    end

    if vim.fn.maparg("s]", "n") ~= "" then
        _S_END_SQUARE_BRACE = vim.fn.maparg("s]", "n", false, true)
        vim.api.nvim_del_keymap("n", "s]")
    else
        _S_END_SQUARE_BRACE = nil
    end
end

--- Re-add my s-related mappings again.
local function _restore_other_s_mappings()
    local function _set(mapping, data)
        vim.keymap.set("n", mapping, data["callback"], {
            buffer = data.buffer == 1,
            expr = data.expr == 1,
            noremap = data.noremap == 1,
            nowait = data.nowait == 1,
            silent = data.silent == 1,
        })
    end

    if _S_START_SQUARE_BRACE ~= nil then
        _set("s[", _S_START_SQUARE_BRACE)
    end

    if _S_END_SQUARE_BRACE ~= nil then
        _set("s]", _S_END_SQUARE_BRACE)
    end
end

-- local git_hint = [[
--  Movement       Control                Display             Diagnose
--  _J_: next hunk   _s_: [s]tage hunk        _d_: show [d]eleted   _b_: blame line
--  ^ ^              _r_: [r]eset hunk        ^ ^                   ^ ^
--  _K_: prev hunk   _c_: [c]heckout hunk     _p_: [p]review hunk   _B_: blame show full
--  ^ ^              _S_: stage buffer        ^ ^                   _/_: show base file
--  ^
--  ^ ^              _<Enter>_: Neogit                _q_: exit
-- ]]
--
-- Hydra(
--     {
--         name = "Git",
--         hint = git_hint,
--         config = {
--             color = "pink",
--             hint = {
--                 float_opts = { border = "rounded" },
--             },
--             invoke_on_body = true,
--             on_enter = function()
--                 vim.cmd "silent! %foldopen!"
--                 gitsigns.toggle_signs(true)
--                 gitsigns.toggle_linehl(true)
--             end,
--             on_exit = function()
--                 local cursor_pos = vim.api.nvim_win_get_cursor(0)
--                 vim.api.nvim_win_set_cursor(0, cursor_pos)
--                 vim.cmd 'normal zv'  -- Unfold evrything at the current cursor
--                 gitsigns.toggle_signs(false)
--                 gitsigns.toggle_linehl(false)
--                 gitsigns.toggle_deleted(false)
--             end,
--         },
--         mode = {"n", "x"},
--         body = "<Space>GG",
--         heads = {
--             {
--                 "J",
--                 function()
--                     if vim.wo.diff then return "]q" end
--                     vim.schedule(function() gitsigns_utility.next_hunk() end)
--                     return "<Ignore>"
--                 end,
--                 { expr = true, desc = "next hunk" } },
--             {
--                 "K",
--                 function()
--                     if vim.wo.diff then return "[q" end
--                     vim.schedule(function() gitsigns_utility.previous_hunk() end)
--                     return "<Ignore>"
--                 end,
--                 { expr = true, desc = "prev hunk" } },
--             {
--                 "c",
--                 gitsigns.reset_hunk,
--                 { silent = true, desc = "[c]heckout hunk" },
--             },
--             {
--                 "r",
--                 gitsigns.undo_stage_hunk,
--                 { desc = "[r]eset staged hunk" },
--             },
--             { "s", "<cmd>Gitsigns stage_hunk<CR>", { silent = true, desc = "stage hunk" } },
--             { "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
--             { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
--             { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
--             { "b", gitsigns.blame_line, { desc = "blame" } },
--             { "B", function() gitsigns.blame_line{ full = true } end, { desc = "blame show full" } },
--             { "/", gitsigns.show, { exit = true, desc = "show base file" } }, -- show the base of the file
--             { "<Enter>", "<Cmd>Neogit<CR>", { exit = true, desc = "Neogit" } },
--             { "q", nil, { exit = true, nowait = true, desc = "exit" } },
--         }
--     }
-- )

local git_diff_hint = [[
 Movement       Control
 _J_: next hunk   _s_: [s]tage hunk
 ^ ^              _r_: [r]eset hunk
 _K_: prev hunk   _c_: [c]heckout hunk

 ^ ^              _q_: exit               _Q_: exit at position
]]

local previous_diff_deleted = nil
local previous_diff_line_highlight = nil
local previous_diff_signs = nil
local _GIT_DIFF_TAB_NUMBER = nil

Hydra(
    {
        name = "Git Interactive-Diff",
        hint = git_diff_hint,
        config = {
            color = "pink",
            hint = {
                position = "top-right",
                float_opts = { border = "rounded" },
            },
            invoke_on_body = true,
            on_enter = function()
                if vim.api.nvim_buf_get_name(0) ~= ""
                then
                    local row = vim.fn.line(".")
                    local column = vim.fn.col(".")

                    -- If the buffer is named, open a new tab pointing to it
                    vim.cmd[[tabnew %]]
                    vim.api.nvim_win_set_cursor(0, {row, column})
                else
                    vim.cmd[[tabnew]]
                end

                -- Open the current buffer in a new tab, Save-and-close the tab later
                _GIT_DIFF_TAB_NUMBER = vim.fn.tabpagenr()
                vim.api.nvim_tabpage_set_var(0, _GIT_DIFF_TAB_VARIABLE, "1")

                vim.cmd "silent! %foldopen!"

                previous_diff_deleted = config.config.show_deleted
                previous_diff_line_highlight = config.config.linehl
                previous_diff_signs = config.config.signcolumn

                gitsigns.toggle_deleted(true)
                gitsigns.toggle_signs(true)
                gitsigns.toggle_linehl(true)

                -- TODO: Maybe it should be based on the buffer instead. Probably.
                local directory = vim.fn.getcwd()
                vim.g._hydra_git_diff_paths = _get_git_diff_paths(directory)

                _save_other_s_mappings()
            end,
            on_exit = function()
                vim.cmd("tabclose " .. _GIT_DIFF_TAB_NUMBER)

                gitsigns.toggle_signs(previous_diff_signs)
                gitsigns.toggle_linehl(previous_diff_line_highlight)
                gitsigns.toggle_deleted(previous_diff_deleted)

                vim.g._hydra_git_diff_paths = nil

                _restore_other_s_mappings()
            end,
        },
        mode = {"n","x"},
        body = "<Space>GD",
        heads = {
            {
                "J",
                function() _go_to_next_hunk(vim.g._hydra_git_diff_paths) end,
                { desc = "next hunk" },
            },
            {
                "K",
                function() _go_to_previous_hunk(vim.g._hydra_git_diff_paths) end,
                { desc = "previous hunk" } },
            {
                "c",
                function()
                    vim.schedule(
                        function()
                            gitsigns.reset_hunk(selector.get_visual_lines())

                            -- -- Important: Requires https://github.com/tpope/vim-unimpaired
                            -- vim.cmd[[norm ]l]]
                        end
                    )

                    return "<Ignore>"
                end,
                { silent = true, desc = "[c]heckout hunk and move to next hunk" },
            },
            {
                "<M-c>",
                function()
                    if vim.wo.diff then return "<Ignore>" end

                    vim.schedule(function() gitsigns.reset_hunk(selector.get_visual_lines()) end)

                    return "<Ignore>"
                end,
                { silent = true, desc = "[c]heckout hunk" },
            },
            {
                "s",
                function()
                    local paths = vim.g._hydra_git_diff_paths

                    if _in_visual_mode()
                    then
                        vim.schedule(
                            function()
                                gitsigns.stage_hunk(selector.get_visual_lines())

                                _go_to_next_hunk(paths)
                            end
                        )

                        return
                    end

                    gitsigns.stage_hunk()
                    _go_to_next_hunk(paths)
                end,
                { silent = true, desc = "[s]tage hunk and move to next item" },
            },
            {
                "<M-s>",
                function()
                    if vim.wo.diff then return "<Ignore>" end

                    vim.schedule(function() gitsigns.stage_hunk(selector.get_visual_lines()) end)

                    return "<Ignore>"
                end,
                { silent = true, desc = "[s]tage hunk" },
            },
            {
                "r",
                function() gitsigns.undo_stage_hunk(selector.get_visual_lines()) end,
                { desc = "[r]eset staged hunk" },
            },
            { "q", nil, { exit = true, nowait = true, desc = "exit" } },
            { "Q", nil, { exit = true, nowait = true, desc = "exit and save position" } },
        }
    }
)

local debug_hint = [[
 Movement
 _h_: Move out  _j_: Skip over  _l_: Move into _<Space>: Continue

 _q_: Exit
]]

Hydra({
    name = "Debugging",
    hint = debug_hint,
    config = {
        color = "pink",
        hint = {
            float_opts = { border = "rounded" },
            position = "top-right",
        },
        invoke_on_body = true,
    },
    mode = { "n", "x" },
    body = "<Space>D",
    heads = {
        { "h", "<cmd>DapStepOut<CR>", { silent = true, desc = "Move out of the current function call." } },
        { "j", "<cmd>DapStepOver<CR>", { silent = true, desc = "Skip over the current line." } },
        { "l", "<cmd>DapStepInto<CR>", { silent = true, desc = "Move into a function call." } },
        { "<Space>", "<cmd>DapContinue<CR>", { silent = true, desc = "Continue to the next breakpoint." } },
        { "q", nil, { exit = true, nowait = true, desc = "Exit." } },
    },
})
