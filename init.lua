require("my_custom.speed_up")

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





local plugins = {
    -- TODO: Consider getting this stuff to work
    -- -- Treesitter stuff
    -- {
    --     "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    -- },
    -- {
    --     "nvim-treesitter/playground",
    --     cmd = "TSPlaygroundToggle",
    -- },
}


local packages = require("my_custom.appearance").packages

for _, plugin in pairs(packages)
do
    table.insert(plugins, plugin)
end

local packages = require("my_custom.movement").packages

for _, plugin in pairs(packages)
do
    table.insert(plugins, plugin)
end

local packages = require("my_custom.text_object").packages

for _, plugin in pairs(packages)
do
    table.insert(plugins, plugin)
end

local packages = require("my_custom.workflow").packages

for _, plugin in pairs(packages)
do
    table.insert(plugins, plugin)
end

local configuration = {
    root = "~/personal/.config/nvim/bundle",
}

require("lazy").setup(plugins, configuration)

require("my_custom.remap")
require("my_custom.initialization")
require("my_custom.setting")

-- TODO: Make this a better file path, later
vim.cmd[[source ~/personal/.config/nvim/plugin/syntax_fix.vim]]
-- TODO: Make this a better file path, later
vim.cmd[[source ~/personal/.config/nvim/plugin/global_confirm.vim]]
-- TODO: Make this a better file path, later
vim.cmd[[source ~/personal/.config/nvim/plugin/miscellaneous_commands.vim]]
