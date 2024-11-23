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
