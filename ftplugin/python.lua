-- Set up Vim so it is able to parse Python tracebacks. This command uses
-- a ``$VIMHOME/compiler/python.vim``, assuming it exists (which it should,
-- I wrote it).
--
vim.cmd[[
if !exists("current_compiler")
  compiler python
endif
]]

-- Give a sensible default when running ``make`` so that ``:Make`` (from
--
-- https://github.com/tpope/vim-dispatch) knows how to process Python files.
--
-- It's not technically "correct" to have a ``:make`` call immediately run unittests
-- but you don't normally call ``:make`` / ``:Make`` in Python so it's ours to use.
--
vim.o.makeprg = "python -m unittest discover"
