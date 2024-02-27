local filer = require("my_custom.utilities.filer")

local install_root = filer.join_path(
    { vim.g.vim_home, "mason_packages", vim.loop.os_uname().sysname }
)

require("mason").setup({ install_root_dir = install_root })
