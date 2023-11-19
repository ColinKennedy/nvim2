-- Reference: https://alpha2phi.medium.com/neovim-for-beginners-performance-95687714c236
local plugins_to_disable = {
    "gzip",
    "health",
    "man",
    "matchit",
    -- "matchparen",  -- I like being able to see matching parentheses
    "netrw",
    "netrwPlugin",
    "remote_plugins",  -- This is a name for the runtime/plugin/rplugin.vim file
    "shada_plugin",
    "spellfile_plugin",
    "tarPlugin",
    "2html_plugin",  -- This is a name for the runtime/plugin/tohtml.vim file
    "tutor_mode_plugin",  -- This is a name for the runtime/plugin/tutor.vim file
    "zipPlugin",
}

for _, name in pairs(plugins_to_disable)
do
    vim.g["loaded_" .. name] = 1
end


-- Disable some default providers
--
-- Note:
--     The python provider is needed for the
--     https://github.com/gelguy/wilder.nvim plug-in.
--
--     But I hope this provider can be removed in the future because loading it
--     is quite slow.
--
for _, provider in ipairs { "node", "perl", "ruby" } do
-- for _, provider in ipairs { "node", "perl", "ruby" } do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end
