local install_root = vim.fs.joinpath(
    vim.g.vim_home, "mason_packages", vim.loop.os_uname().sysname
)

require("mason").setup({ install_root_dir = install_root })
