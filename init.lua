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


local packages = require("my_custom.plugins.appearance").packages

for _, plugin in pairs(packages)
do
    table.insert(plugins, plugin)
end

local packages = require("my_custom.plugins.movement").packages

for _, plugin in pairs(packages)
do
    table.insert(plugins, plugin)
end

local packages = require("my_custom.plugins.text_object").packages

for _, plugin in pairs(packages)
do
    table.insert(plugins, plugin)
end

local packages = require("my_custom.plugins.workflow").packages

for _, plugin in pairs(packages)
do
    table.insert(plugins, plugin)
end

local packages = require("my_custom.plugins.lsp").packages

for _, plugin in pairs(packages)
do
    table.insert(plugins, plugin)
end

local configuration = {
    root = "~/personal/.config/nvim/bundle",
    performance = {
        rtp = {
	    disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
	    }
	}
    }
}

-- plugins = {
--     {
--         "L3MON4D3/LuaSnip",
--         config = function()
--             -- -- require("luasnip.loaders.from_snipmate").lazy_load(
--             -- --     { paths = "./snippets" }
--             -- -- )
--             -- -- TODO: See if I can lazy_load here, later
--             -- require("luasnip.loaders.from_lua").load(
--             --     { paths = "./snippets" }
--             -- )
--             --
--             -- local ls = require("luasnip")
--             -- local s = ls.s
--             -- local t = ls.t
--             --
--
--             local ls = require("luasnip")
--             local s = ls.s
--             local types = require("luasnip.util.types")
--             local t =ls.t
--
--             ls.config.set_config(
--                 -- TODO: Revisit these settings later
--                 {
--                     history = true,
--                     updateevents = "TextChanged,TextChangedI",  -- Allow snippets to update as you type
--                     enable_autosnippets = true,
--                     ext_opts = {
--                         [types.choiceNode] = {
--                             active= {
--                                 virt_text = { { "<-", "Error"} }
--                             },
--                         },
--                     },
--                 }
--             )
--
--             ls.snippets = {
--                 all = {
--                     s("something", t("blah"))
--                 },
--                 python = {
--                     s("something", t("blah"))
--                 }
--             }
--
--             -- TODO: Remove later
--             vim.keymap.set(
--                 {"i", "s"},
--                 "<C-k>",
--                 function()
--                     if ls.expand_or_jumpable()
--                     then
--                         -- print("EXPANDING")
--                         ls.expand_or_jump()
--                     end
--                 end,
--                 {silent=true}
--             )
--         end,
--         -- follow latest release.
--         version = "1.*",
--     },
-- }

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
