local Hydra = require("hydra")
local gitsigns = require('gitsigns')
local gitsigns_utility = require("my_custom.plugins.data.gitsigns")

local hint = [[
 _J_: next hunk   _t_: s[t]age hunk        _d_: show [d]eleted   _b_: blame line
 ^ ^              _r_: [r]eset hunk        ^ ^                   ^ ^
 _K_: prev hunk   _c_: [c]heckout hunk     _p_: [p]review hunk   _B_: blame show full
 ^ ^              _T_: stage buffer        ^ ^                   _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit                _q_: exit
]]

Hydra({
   name = 'Git',
   hint = hint,
   config = {
      buffer = bufnr,
      color = 'pink',
      invoke_on_body = true,
      hint = {
         border = 'rounded'
      },
      on_enter = function()
         vim.cmd 'mkview'
         vim.cmd 'silent! %foldopen!'
         -- vim.bo.modifiable = false
         gitsigns.toggle_signs(true)
         gitsigns.toggle_linehl(true)
      end,
      on_exit = function()
         local cursor_pos = vim.api.nvim_win_get_cursor(0)
         vim.cmd 'loadview'
         vim.api.nvim_win_set_cursor(0, cursor_pos)
         vim.cmd 'normal zv'
         gitsigns.toggle_signs(false)
         gitsigns.toggle_linehl(false)
         gitsigns.toggle_deleted(false)
      end,
   },
   mode = {'n','x'},
   body = '<Space>G',
   heads = {
      { 'J',
         function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gitsigns_utility.next_hunk() end)
            return '<Ignore>'
         end,
         { expr = true, desc = 'next hunk' } },
      { 'K',
         function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns_utility.previous_hunk() end)
            return '<Ignore>'
         end,
         { expr = true, desc = 'prev hunk' } },
      {
          'c',
          gitsigns.reset_hunk,
          { silent = true, desc = '[c]heckout hunk' },
      },
      { 't', ':Gitsigns stage_hunk<CR>', { silent = true, desc = 'stage hunk' } },
      {
         'r',
         gitsigns.undo_stage_hunk,
         { desc = '[r]eset staged hunk' },
      },
      { 'T', gitsigns.stage_buffer, { desc = 'stage buffer' } },
      { 'p', gitsigns.preview_hunk, { desc = 'preview hunk' } },
      { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
      { 'b', gitsigns.blame_line, { desc = 'blame' } },
      { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'blame show full' } },
      { '/', gitsigns.show, { exit = true, desc = 'show base file' } }, -- show the base of the file
      { '<Enter>', '<Cmd>Neogit<CR>', { exit = true, desc = 'Neogit' } },
      { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
   }
})
