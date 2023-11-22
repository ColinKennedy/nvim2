local Hydra = require("hydra")
local config = require("gitsigns.config")
local gitsigns = require("gitsigns")
local gitsigns_utility = require("my_custom.plugins.data.gitsigns")


local _GIT_DIFF_TAB_VARIABLE = "_hydra_git_diff"


local function _is_git_diff_tab_exists(tab)
    local tabs = vim.fn.tabpagebuflist()
    local exists = vim.tbl_contains(tabs, tab)

    if not exists
    then
        return false
    end

    if vim.fn.exists("t:" .. _GIT_DIFF_TAB_VARIABLE) == 1
    then
        return true
    end

    return false
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
                    if vim.wo.diff then return "]c" end
                    vim.schedule(function() gitsigns_utility.next_hunk() end)
                    return "<Ignore>"
                end,
                { expr = true, desc = "next hunk" } },
            {
                "K",
                function()
                    if vim.wo.diff then return "[c" end
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
 Movement       Control                Display
 _J_: next hunk   _t_: s[t]age hunk        _d_: show [d]eleted
 ^ ^              _r_: [r]eset hunk
 _K_: prev hunk   _c_: [c]heckout hunk
 ^ ^              _T_: stage buffer
 ^ ^              ^ ^                      _q_: exit
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
                    -- If the buffer is named, open a new tab pointing to it
                    vim.cmd[[tabnew %]]
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
            end,
            on_exit = function()
                if _is_git_diff_tab_exists(_GIT_DIFF_TAB_NUMBER)
                then
                    vim.cmd("tabclose " .. _GIT_DIFF_TAB_NUMBER)
                end

                gitsigns.toggle_signs(previous_diff_signs)
                gitsigns.toggle_linehl(previous_diff_line_highlight)
                gitsigns.toggle_deleted(previous_diff_deleted)
            end,
        },
        mode = {"n","x"},
        body = "<Space>GD",
        heads = {
            {
                "J",
                function()
                    if vim.wo.diff then return "]c" end
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
            { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
            { "q", nil, { exit = true, nowait = true, desc = "exit" } },
        }
    }
)
