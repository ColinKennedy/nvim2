local Hydra = require("hydra")
local async = require("gitsigns.async")
local actions_extended = require("gitsigns.actions_extended")
local config = require("gitsigns.config")
local gitsigns = require("gitsigns")
local gitsigns_utility = require("my_custom.plugins.data.gitsigns")


local _GIT_DIFF_TAB_VARIABLE = "_hydra_git_diff_tab"
local _S_START_SQUARE_BRACE = nil
local _S_END_SQUARE_BRACE = nil

--- @alias _CursorRange table<integer, integer>
---     Two values, both 1-or-more, indicating the start and end line of a text block.


--- Check if the current line is already inside of a Location List's entries.
---
--- @param window_identifier integer
---     A 0-or-more value for the window to check.
--- @param list_identifier integer
---     A 1-or-more value for the Location List that (we assume) is paired with
---     `window_identifier`.
--- @return boolean
---     If the cursor is within the Location List already, return `true`.
---
local function _in_existing_list_entry(window_identifier, list_identifier)
    local buffer vim.api.nvim_win_get_buf(window_identifier)
    local line, _ = unpack(vim.api.nvim_win_get_cursor(window_identifier))

    for _, entry in ipairs(
        vim.fn.getloclist(window_identifier, {id=list_identifier, items=1}).items or {}
    )
    do
        if entry.filename == buffer and entry.lnum == line
        then
            return true
        end
    end

    return false
end


local function _in_visual_mode()
    local current_mode = vim.fn.mode()

    if (
        current_mode == "v"
        or current_mode == "vs"
        or current_mode == "V"
        or current_mode == "Vs"
        or current_mode == "\\<C-V>"
        or current_mode == "\\<C-Vs>"
    )
    then
        return true
    end

    return false
end


--- Check if the Location List tied to `window` is empty.
---
--- @param window integer A 0-or-more identifier for the source window to check.
--- @return boolean # If `window` has no Location List or empty, return `true`.
---
local function _is_location_list_empty(window)
    return vim.tbl_isempty(vim.fn.getloclist(window))
end


local function _get_git_diff_paths(directory)
    -- These paths are relative to the root of the git repository
    local relative_paths = vim.fn.systemlist(
        "git diff --name-only",
        directory
    )

    local output = {}

    for _, path in ipairs(relative_paths)
    do
        -- TODO: Account for windows \ separators
        local absolute = directory .. "/" .. path
        table.insert(output, absolute)
    end

    return output
end


--- @return _CursorRange # Get the start/end lines of a visual selection.
local function _get_visual_lines()
    local _, start_line, _, _ = unpack(vim.fn.getpos("v"))
    local _, end_line, _, _ = unpack(vim.fn.getpos("."))

    if start_line > end_line
    then
        start_line, end_line = end_line, start_line
    end

    return {start_line, end_line}
end


local function _get_next_in_list(element, items)
    if vim.tbl_isempty(items)
    then
        return nil
    end

    local previous = nil

    for index, item in ipairs(items)
    do
        if element > item
        then
            return item
        end
    end

    return items[#items]
end


local function _get_previous_in_list(element, items)
    if vim.tbl_isempty(items)
    then
        return nil
    end

    local previous = nil

    for index, item in ipairs(items)
    do
        if element < item
        then
            return item
        end
    end

    return items[1]
end


local function _go_to_next_hunk(paths)
    local forwards = true

    if actions_extended.has_next_hunk(forwards)
    then
        -- gitsigns is async. We need to schedule so gitsigns has time to fill its cache
        vim.schedule(function() gitsigns.next_hunk() end)

        return
    end

    local current = vim.fn.expand("%:p")
    local next = _get_next_in_list(current, paths)

    if next == nil
    then
        vim.api.nvim_err_writeln("No next file could be found.")

        return
    end

    vim.cmd("edit " .. next)
    actions_extended.move_to_first_hunk()

    -- vim.schedule(
    -- async.void(
    --     function()
    --         async.scheduler()
    --         local hunks = actions_extended.get_head_hunks() or {}
    --
    --         if vim.tbl_isempty(hunks)
    --         then
    --             print("STOPPING")
    --             return
    --         end
    --
    --         local hunk = hunks[1]
    --         print('DEBUGPRINT[9]: hydra.lua:180: hunk=' .. vim.inspect(hunk))
    --         local line = hunk.added.start or hunk.removed.start
    --         print('DEBUGPRINT[10]: hydra.lua:182: line=' .. vim.inspect(line))
    --
    --         vim.api.nvim_win_set_cursor(0, {line, 0})
    --     end
    -- )()

    -- vim.cmd[[normal gg]]
    --
    -- if not actions_extended.in_hunk()
    -- then
    --     -- gitsigns is async. We need to schedule so gitsigns has time to fill its cache
    --     vim.schedule(function() gitsigns.next_hunk() end)
    -- end
    -- vim.schedule(
    --     function()
    --     vim.cmd[[normal gg]]
    --     gitsigns.next_hunk()
    --     --
    --     -- if not actions_extended.in_hunk()
    --     -- then
    --     --     -- gitsigns is async. We need to schedule so gitsigns has time to fill its cache
    --     --     gitsigns.next_hunk()
    --     -- end
    -- end)
end


local function _go_to_previous_hunk(paths)
    local forwards = false

    if actions_extended.has_next_hunk(forwards)
    then
        -- gitsigns is async. We need to schedule so gitsigns has time to fill its cache
        vim.schedule(function() gitsigns.prev_hunk() end)

        return
    end

    local current = vim.fn.expand("%:p")
    local previous = _get_previous_in_list(current, paths)

    if previous == nil
    then
        vim.api.nvim_err_writeln("No previous file could be found.")

        return
    end

    vim.cmd("edit " .. previous)
    vim.cmd[[normal gg]]

    if not actions_extended.in_hunk()
    then
        -- gitsigns is async. We need to schedule so gitsigns has time to fill its cache
        vim.schedule(function() gitsigns.prev_hunk() end)
    end
end


--- Keep track of all of my `s` mappings so that they can be restored later, if needed.
local function _save_other_s_mappings()
    if vim.fn.maparg("s[", "n") ~= ""
    then
        _S_START_SQUARE_BRACE = vim.fn.maparg("s[", "n", false, true)
        vim.api.nvim_del_keymap("n", "s[")
    else
        _S_START_SQUARE_BRACE = nil
    end

    if vim.fn.maparg("s]", "n") ~= ""
    then
        _S_END_SQUARE_BRACE = vim.fn.maparg("s]", "n", false, true)
        vim.api.nvim_del_keymap("n", "s]")
    else
        _S_END_SQUARE_BRACE = nil
    end
end


--- Re-add my s-related mappings again.
local function _restore_other_s_mappings()
    local function _set(mapping, data)
        vim.keymap.set(
            "n",
            mapping,
            data["callback"],
            {
                buffer = data.buffer == 1,
                expr = data.expr == 1,
                noremap = data.noremap == 1,
                nowait = data.nowait == 1,
                silent = data.silent == 1,
            }
        )
    end

    if _S_START_SQUARE_BRACE ~= nil
    then
        _set("s[", _S_START_SQUARE_BRACE)
    end

    if _S_END_SQUARE_BRACE ~= nil
    then
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
--             { "s", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "stage hunk" } },
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
                    if vim.wo.diff then return "]l" end

                    vim.schedule(
                        function()
                            gitsigns.reset_hunk(_get_visual_lines())

                            -- Important: Requires https://github.com/tpope/vim-unimpaired
                            vim.cmd[[norm ]l]]
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

                    vim.schedule(function() gitsigns.reset_hunk(_get_visual_lines()) end)

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
                                gitsigns.stage_hunk(_get_visual_lines())

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

                    vim.schedule(function() gitsigns.stage_hunk(_get_visual_lines()) end)

                    return "<Ignore>"
                end,
                { silent = true, desc = "[s]tage hunk" },
            },
            {
                "r",
                function() gitsigns.undo_stage_hunk(_get_visual_lines()) end,
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

Hydra(
    {
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
        mode = {"n", "x"},
        body = "<Space>D",
        heads = {
            { "h", ":DapStepOut<CR>", { silent = true, desc = "Move out of the current function call." } },
            { "j", ":DapStepOver<CR>", { silent = true, desc = "Skip over the current line." } },
            { "l", ":DapStepInto<CR>", { silent = true, desc = "Move into a function call." } },
            { "<Space>", ":DapContinue<CR>", { silent = true, desc = "Continue to the next breakpoint." } },
            { "q", nil, { exit = true, nowait = true, desc = "Exit." } },
        }
    }
)
