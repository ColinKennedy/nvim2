vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- The default comment options for C++ are annoying. e.g. a line like this
--
-- void foo();  // some comment<cursor here>
--
-- If you press <CR>, Neovim does this
--
-- void foo();  // some comment
--              // <cursor here>
--
-- The code below will stop this behavior
--
-- Reference: https://www.reddit.com/r/neovim/comments/16gja40/comment/k082gi8/?utm_source=share&utm_medium=web2x&context=3
--
vim.opt_local.formatoptions:remove({ "r" })
