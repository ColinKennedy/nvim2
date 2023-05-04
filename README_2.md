- Fix luasnip issues

[null-ls] failed to run generator: ...1/colin-k/nvim2/bundle/null-ls.nvim/lua/null-ls/loop.lua:237: failed to create temp file: EROFS: read-only file system: /path/to/read/only/site-packages/pyblish_lite/.null-ls_559820_window.py

- Pretty sure this stuff breaks but it'd be good to at least check it out again
 - https://github.com/hrsh7th/cmp-cmdline

- Pressing w should scroll up in the terminal(?)


- neogen has some issues
 - raises is parsed incorrectly, in Python


- Auto completion work
 --- Python LSPs
 - C++ LSPs
  --- Jumpy (CMake enabled projects)
  --- General
  - USD
   - Maybe clangd is better? ccls keeps reporting incorrect information
    - it's better if I use explicit types. But ``auto`` is great. Need it.
    - maybe I can compile clangd with mason, but with an older version so that GLIBC works
