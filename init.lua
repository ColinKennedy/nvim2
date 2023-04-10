require("my_custom.start.speed_up")

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

extend(plugins, require("my_custom.plugins.manifest.appearance"))
extend(plugins, require("my_custom.plugins.manifest.movement"))
extend(plugins, require("my_custom.plugins.manifest.text_object"))
extend(plugins, require("my_custom.plugins.manifest.workflow"))
extend(plugins, require("my_custom.plugins.manifest.lsp"))

-- ``root`` e.g. ~/personal/.config/nvim/bundle"
local configuration = { root = filer.get_current_directory() .. "/bundle" }

require("lazy").setup(plugins, configuration)

require("my_custom.start.remap")
require("my_custom.start.initialization")
require("my_custom.start.setting")

-- TODO: Make this a better file path, later
vim.cmd[[source ~/personal/.config/nvim/plugin/syntax_fix.vim]]
-- TODO: Make this a better file path, later
vim.cmd[[source ~/personal/.config/nvim/plugin/global_confirm.vim]]
-- TODO: Make this a better file path, later
vim.cmd[[source ~/personal/.config/nvim/plugin/miscellaneous_commands.vim]]


-- TODO: Remove this, later. Add as a plugin, probably
vim.cmd[[so ~/personal/.config/nvim/theme.lua]]
-- vim.cmd[[so /tmp/generated_colors2.vim]]
