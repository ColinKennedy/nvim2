local Hydra = require("hydra")
local config = require("gitsigns.config")
local gitsigns = require("gitsigns")
local gitsigns_utility = require("my_custom.plugins.data.gitsigns")


local _GIT_DIFF_TAB_VARIABLE = "_hydra_git_diff"
local _S_START_SQUARE_BRACE = nil
local _S_END_SQUARE_BRACE = nil


local function _in_existing_quick_fix_entry()
    local buffer = vim.fn.bufname('%')
    local line = vim.fn.line('.')

    for _, entry in ipairs(vim.fn.getqflist())
    do
        if entry.filename == buffer and entry.lnum == line
        then
            return true
        end
    end

    return false
end


local function _get_visual_lines()
    local _, start_line, _, _ = unpack(vim.fn.getpos("v"))
    local _, end_line, _, _ = unpack(vim.fn.getpos("."))

    if start_line > end_line
    then
        start_line, end_line = end_line, start_line
    end

    return {start_line, end_line}
end


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


local git_hint = [[
 Movement       Control                Display             Diagnose
 _J_: next hunk   _t_: s[t]age hunk        _d_: show [d]eleted   _b_: blame line
 ^ ^              _r_: [r]eset hunk        ^ ^                   ^ ^
 _K_: prev hunk   _c_: [c]heckout hunk     _p_: [p]review hunk   _B_: blame show full
 ^ ^              _T_: stage buffer        ^ ^                   _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit                _q_: exit
]]

Hydra(
    {
        name = "Git",
        hint = git_hint,
        config = {
            color = "pink",
            hint = {
                border = "rounded"
            },
            invoke_on_body = true,
            on_enter = function()
                vim.cmd "silent! %foldopen!"
                gitsigns.toggle_signs(true)
                gitsigns.toggle_linehl(true)
            end,
            on_exit = function()
                local cursor_pos = vim.api.nvim_win_get_cursor(0)
                vim.api.nvim_win_set_cursor(0, cursor_pos)
                vim.cmd 'normal zv'  -- Unfold evrything at the current cursor
                gitsigns.toggle_signs(false)
                gitsigns.toggle_linehl(false)
                gitsigns.toggle_deleted(false)
            end,
        },
        mode = {"n","x"},
        body = "<Space>GG",
        heads = {
            {
                "J",
                function()
                    if vim.wo.diff then return "]q" end
                    vim.schedule(function() gitsigns_utility.next_hunk() end)
                    return "<Ignore>"
                end,
                { expr = true, desc = "next hunk" } },
            {
                "K",
                function()
                    if vim.wo.diff then return "[q" end
                    vim.schedule(function() gitsigns_utility.previous_hunk() end)
                    return "<Ignore>"
                end,
                { expr = true, desc = "prev hunk" } },
            {
                "c",
                gitsigns.reset_hunk,
                { silent = true, desc = "[c]heckout hunk" },
            },
            { "t", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "stage hunk" } },
            {
                "r",
                gitsigns.undo_stage_hunk,
                { desc = "[r]eset staged hunk" },
            },
            { "T", gitsigns.stage_buffer, { desc = "stage buffer" } },
            { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
            { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
            { "b", gitsigns.blame_line, { desc = "blame" } },
            { "B", function() gitsigns.blame_line{ full = true } end, { desc = "blame show full" } },
            { "/", gitsigns.show, { exit = true, desc = "show base file" } }, -- show the base of the file
            { "<Enter>", "<Cmd>Neogit<CR>", { exit = true, desc = "Neogit" } },
            { "q", nil, { exit = true, nowait = true, desc = "exit" } },
        }
    }
)


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
        name = "Git Diff",
        hint = git_diff_hint,
        config = {
            color = "pink",
            hint = {
                position = "top-right",
                border = "rounded",
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

                local git_diff = require("my_custom.utilities.git_diff")
                local directory = vim.fn.getcwd()
                local entries = git_diff.get_git_diff(directory)
                local current_window = vim.api.nvim_get_current_win()
                vim.fn.setqflist(entries)
                vim.cmd[[copen]]
                vim.api.nvim_set_current_win(current_window)

                if not _in_existing_quick_fix_entry()
                then
                    -- Important: Requires https://github.com/tpope/vim-unimpaired
                    vim.cmd[[norm ]q]]
                end

                _save_other_s_mappings()
            end,
            on_exit = function()
                vim.cmd("tabclose " .. _GIT_DIFF_TAB_NUMBER)

                gitsigns.toggle_signs(previous_diff_signs)
                gitsigns.toggle_linehl(previous_diff_line_highlight)
                gitsigns.toggle_deleted(previous_diff_deleted)

                _restore_other_s_mappings()
            end,
        },
        mode = {"n","x"},
        body = "<Space>GD",
        heads = {
            {
                "J",
                function()
                    if vim.wo.diff then return "]q" end
                    vim.schedule(
                        function()
                            -- Important: Requires https://github.com/tpope/vim-unimpaired
                            vim.cmd[[norm ]q]]
                        end
                    )
                    return "<Ignore>"
                end,
                { expr = true, desc = "next hunk" } },
            {
                "K",
                function()
                    if vim.wo.diff then return "[c" end
                    vim.schedule(
                        function()
                            -- Important: Requires https://github.com/tpope/vim-unimpaired
                            vim.cmd[[norm [q]]
                        end
                    )
                    return "<Ignore>"
                end,
                { expr = true, desc = "previous hunk" } },
            {
                "c",
                function()
                    if vim.wo.diff then return "]q" end

                    vim.schedule(
                        function()
                            gitsigns.reset_hunk(_get_visual_lines())

                            -- Important: Requires https://github.com/tpope/vim-unimpaired
                            vim.cmd[[norm ]q]]
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
                    if vim.wo.diff then return "]q" end

                    vim.schedule(
                        function()
                            gitsigns.stage_hunk(_get_visual_lines())

                            -- Important: Requires https://github.com/tpope/vim-unimpaired
                            vim.cmd[[norm ]q]]
                        end
                    )

                    return "<Ignore>"
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
