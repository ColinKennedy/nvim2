-- require("my_custom.start.speed_up")

-- TODO: Remove this line after updating Neovim to (fb3e2bf7b1fc26fef4d168fd2eb2d8eaba1d9390) (a.k.a vim-patch:9.0.1549)
--
-- Reference: https://github.com/neovim/neovim/pull/23608
--
vim.cmd[[au BufNewFile,BufRead *.cppobjdump,*.objdump setf objdump]]


-- Important: According to lazy.nvim, the leader key must be set before lazy.nvim is
-- called or else it will break various things.
--
vim.g.mapleader = ","

-- if vim.env.PROF then
--   -- example for lazy.nvim
--   -- change this to the correct path for your plugin manager
--   local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
--   vim.opt.rtp:append(snacks)
--   require("snacks.profiler").startup({
--     startup = {
--       event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
--       -- event = "UIEnter",
--       -- event = "VeryLazy",
--     },
--   })
-- end

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

require("my_custom.start.fix_terminal_padding")

table.insert(
    plugins,
    {
        "ColinKennedy/nvim-best-practices-plugin-template",
        dependencies = { "ColinKennedy/mega.cmdparse", "ColinKennedy/mega.logging" },
        -- TODO: (you) - Make sure your first release matches v1.0.0 so it auto-releases! ]]
        version = "v1.*",
    }
)

table.insert(
    plugins,
    {
        "ColinKennedy/mcp.nvim",
        version = "v1.*",
    }
)

-- table.insert(
--     plugins,
--     {
--         "ColinKennedy/cmdparse.nvim",
--         version = "v1.*",
--     }
-- )

table.insert(
    plugins,
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          -- { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    }
)

table.insert(
    plugins,
    {
        "echasnovski/mini.doc"
    }
)

table.insert(
    plugins,
    {
        "ColinKennedy/mega.vimdoc",
        dependencies = { "echasnovski/mini.doc" },
    }
)

table.insert(
    plugins,
    {
        "ColinKennedy/mega.speedreader",
    }
)

-- table.insert(
--     plugins,
--     {
--         'echasnovski/mini.bracketed',
--         config = function()
--             require("mini.bracketed").setup()
--
--             vim.api.nvim_set_keymap('n', '<C-A-j>', '[t', { expr = true, silent = true })
--             vim.api.nvim_set_keymap('n', '<C-A-k>', ']t', { expr = true, silent = true })
--             vim.api.nvim_set_keymap('n', '<C-A-h>', '[T', { expr = true, silent = true })
--             vim.api.nvim_set_keymap('n', '<C-A-l>', ']T', { expr = true, silent = true })
--         end,
--     }
-- )

-- table.insert(
--     plugins,
--     {
--         "JellyApple102/easyread.nvim",
--         -- config = true,
--         config = function()
--             require('easyread').setup{
--                 hlgroupOptions = { bold = true },
--                 fileTypes = {'md', 'markdown'}
--             }
--         end,
--     }
-- )


-- table.insert(
--     plugins,
--     {
--       "karb94/neoscroll.nvim",
--       config = function ()
--         require('neoscroll').setup({
--             mappings = {                 -- Keys to be mapped to their corresponding default scrolling animation
--               '<C-u>', '<C-d>',
--               '<C-b>', '<C-f>',
--               '<C-y>', '<C-e>',
--               'zt', 'zz', 'zb',
--             },
--         })
--       end
--     }
-- )


-- table.insert(
--     plugins,
--     {
--         "ColinKennedy/vim-ninja-feet",
--         branch = "add_extra_visual_operators",
--     }
-- )

-- table.insert(
--     plugins,
--     {
--       'deparr/tairiki.nvim',
--       lazy = false,
--       priority = 1000, -- only necessary if you use tairiki as default theme
--       config = function()
--         require('tairiki').setup {
--           -- optional configuration here
--         }
--         require('tairiki').load() -- only necessary to use as default theme, has same behavior as ':colorscheme tairiki'
--       end,
--     }
-- )
--
--
-- table.insert(
--     plugins,
--     {
--         "w0ng/vim-hybrid",
--     }
-- )

-- table.insert(
--     plugins,
--     {
--         "oguzbilgic/vim-gdiff",
--     }
-- )

-- table.insert(
--     plugins,
--     {
--       'pwntester/octo.nvim',
--       dependencies = {
--         'nvim-lua/plenary.nvim',
--         'nvim-telescope/telescope.nvim',
--         -- OR 'ibhagwan/fzf-lua',
--         'nvim-tree/nvim-web-devicons',
--       },
--       config = function ()
--         require"octo".setup()
--       end
--     }
-- )

table.insert(
    plugins,
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            vim.cmd[[set termguicolors]]
            require'colorizer'.setup()
        end
    }
)


-- table.insert(
--     plugins,
--     {
--       "folke/snacks.nvim",
--       priority = 1000,
--       lazy = false,
--       opts = function()
--         -- Toggle the profiler
--         Snacks.toggle.profiler():map("<leader>pp")
--         -- Toggle the profiler highlights
--         Snacks.toggle.profiler_highlights():map("<leader>ph")
--       end
--       --   -- your configuration comes here
--       --   -- or leave it empty to use the default settings
--       --   -- refer to the configuration section below
--       --   bigfile = { enabled = true },
--       --   notifier = { enabled = true },
--       --   quickfile = { enabled = true },
--       --   statuscolumn = { enabled = true },
--       --   words = { enabled = true },
--       -- },
--     }
-- )

table.insert(
    plugins,
    {
        "shortcuts/no-neck-pain.nvim",
        version = "*",
    }
)

table.insert(
    plugins,
    -- lazy.nvim
    {
        "chrisgrieser/nvim-tinygit",
        dependencies = "stevearc/dressing.nvim",
    }
)

extend(plugins, require("my_custom.plugins.manifest.appearance"))
extend(plugins, require("my_custom.plugins.manifest.debugging"))
extend(plugins, require("my_custom.plugins.manifest.lsp"))
extend(plugins, require("my_custom.plugins.manifest.movement"))
extend(plugins, require("my_custom.plugins.manifest.quick_fix"))
extend(plugins, require("my_custom.plugins.manifest.text_object"))
extend(plugins, require("my_custom.plugins.manifest.workflow"))
extend(plugins, require("my_custom.plugins.manifest.workflow_usd"))

-- ``root`` e.g. ~/personal/.config/nvim/bundle"
local configuration = { root = vim.g.vim_home .. "/bundle" }


-- vim.g.plugin_template_configuration = {logging = {level = "debug", use_file = true}}
--
-- table.insert(
--     plugins,
--     {
--         'ColinKennedy/nvim-best-practices-plugin-template',
--         -- cmd = "PluginTemplate",
--         directory = "/home/selecaoone/repositories/personal/.config/nvim/bundle/nvim-best-practices-plugin-template",
--     }
-- )
--
-- table.insert(
--     plugins,
--     {
--       "rbong/vim-flog",
--       lazy = true,
--       cmd = { "Flog", "Flogsplit", "Floggit" },
--       dependencies = {
--         "tpope/vim-fugitive",
--       },
--     }
-- )

-- table.insert(plugins, { 'stevearc/profile.nvim' })



require("lazy").setup(plugins, configuration)

require("my_custom.start.auto_commands")
require("my_custom.start.command")
require("my_custom.start.global_confirm")
require("my_custom.start.initialization")
require("my_custom.start.remap")
require("my_custom.start.setting")
require("my_custom.start.lsp_diagnostics")
require("my_custom.start.saver").initialize()
require("my_custom.utilities.quick_fix_selection_fix").initialize()
vim.cmd("source " .. vim.g.vim_home .. "/plugin/miscellaneous_commands.vim")

-- NOTE: Requires https://github.com/shortcuts/no-neck-pain.nvim
pcall(function() vim.cmd[[NoNeckPain]] end)

-- vim.schedule(
--     function()
--         local profile = require("profile")
--         print('running')
--
--         profile.start("*")
--
--         local options = {}
--
--         for index=1,1 do
--             vim.tbl_extend("force", options, { {foo={another=8}} })
--             -- vim.tbl_deep_extend("force", options, { {foo={another=8}} })
--         end
--
--         profile.export("out.json")
--     end
-- )

