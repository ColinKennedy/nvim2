require("my_custom.start.speed_up")

vim.cmd[[
" Note: This should be a temporary measure. Once I am on the latest Neovim
" / Vim which natively discovers USD files, I shouldn't need this anymore.
"
" Reference: https://github.com/vim/vim/pull/12370
"
au BufNewFile,BufRead *.usda,*.usd setf usd
]]

-- Important: According to lazy.nvim, the leader key must be set before lazy.nvim is
-- called or else it will break various things.
--
vim.g.mapleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        }
    )
end

vim.opt.rtp:prepend(lazypath)


local filer = require("my_custom.utilities.filer")
local tabler = require("my_custom.utilities.tabler")
local extend = tabler.extend
local plugins = {}

vim.g.vim_home = filer.get_current_directory()

-- table.insert(
--     plugins,
--     {
--         "pogyomo/submode.nvim"
--     }
-- )

-- table.insert(
--    plugins,
--    {
--       'Dkendal/nvim-minor-mode',
--       config = function()
--          local gitsigns = require("gitsigns")
--          local gitsigns_utility = require("my_custom.plugins.data.gitsigns")
--          local minor_mode = require("minor-mode")
--
--          minor_mode.define_minor_mode(
--             "git",
--             [[
--             Control git with simple mappings
--             ]],
--             {
--                 command = "GitMode",
--                 keymap = {
--                   { 'n',
--                      'J',
--                      function()
--                         -- vim.schedule(function() gitsigns.next_hunk() end)
--                         vim.schedule(function() gitsigns_utility.next_hunk() end)
--                         if vim.wo.diff then return ']c' end
--                         -- vim.schedule(function() gitsigns.next_hunk() end)
--                         vim.schedule(function() gitsigns_utility.next_hunk() end)
--                         return '<Ignore>'
--                      end,
--                      { silent = true },
--                      -- { expr = true, desc = 'next hunk' },
--                   },
--                   { 'n',
--                     'K',
--                      function()
--                         if vim.wo.diff then return '[c' end
--                         vim.schedule(function() gitsigns.prev_hunk() end)
--                         return '<Ignore>'
--                      end,
--                      { silent = true },
--                   },
--                      -- { expr = true, desc = 'prev hunk' },
--                   {
--                      'n',
--                       'u',
--                       ':Gitsigns reset_hunk<CR>',
--                      { silent = true },
--                       -- { silent = true, desc = 'reset hunk' },
--                   },
--                   {
--                      'n',
--                      's',
--                      ':Gitsigns stage_hunk<CR>',
--                      { silent = true },
--                   },
--                {
--                   'n',
--                   'r',
--                   gitsigns.undo_stage_hunk,
--                   { desc = 'undo last stage' },
--                },
--                { 'n',
--                   'q',
--                   'GitMode',
--                }
--              }
--             }
--          )
--       end,
--    }
-- )

extend(plugins, require("my_custom.plugins.manifest.appearance"))
extend(plugins, require("my_custom.plugins.manifest.movement"))
extend(plugins, require("my_custom.plugins.manifest.text_object"))
extend(plugins, require("my_custom.plugins.manifest.workflow"))
extend(plugins, require("my_custom.plugins.manifest.lsp"))

-- ``root`` e.g. ~/personal/.config/nvim/bundle"
local configuration = { root = vim.g.vim_home .. "/bundle" }

require("lazy").setup(plugins, configuration)

require("my_custom.start.remap")
require("my_custom.start.initialization")
require("my_custom.start.setting")
require("my_custom.start.auto_commands")
require("my_custom.start.global_confirm")
vim.cmd("source " .. vim.g.vim_home .. "/plugin/miscellaneous_commands.vim")
