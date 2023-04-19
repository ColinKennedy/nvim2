-- Don't wrap lines in USD files. Big USD files tend to define array data on
-- a single line. Those lines can be massive. By calling `vim.opt.wrap` (akak
-- `:set nowrap`) we can move right over those big lines.
--
vim.opt.wrap = false
