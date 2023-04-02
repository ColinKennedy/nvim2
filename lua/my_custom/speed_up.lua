-- Reference: https://alpha2phi.medium.com/neovim-for-beginners-performance-95687714c236
local plugins_to_disable = {
    "gzip",
    "health",
    "man",
    "matchit",
    "matchparen",
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
