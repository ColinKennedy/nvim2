- Do this + set conceallevel=1 to conceal stuff
; (
;    (
;       (list) @capture
;       (#offset! @capture 0 1 0 -1)
;    )
;    (#set! conceal "…")
; )

- add LSP for C++, Python, and C++ USD, and C++ Qt
 - LSP auto-complete
 - Python
  - USD?
 - C++
  - CMake compile_commands.json
  - USD
  - General
 - add deferred event call so that the plugins aren't loaded by default
  - NvChad uses ``event = "InsertEnter"``

- Add Hunspell - To improve spell checking word variants

- Follow-up
 - Typing "D" for a docstring in a real file is frustrating because cmp takes control away when new  LSP entries are added
  - https://github.com/hrsh7th/nvim-cmp/issues/1597


- language server stuff
 - project cd
 - auto-completion
 - other settings?

- Consider these completion sources
 - https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources#miscellaneous
  - https://github.com/rcarriga/cmp-dap
  - https://github.com/JMarkin/cmp-diag-codes
  - https://github.com/paopaol/cmp-doxygen
  - https://github.com/hrsh7th/cmp-nvim-lua
  - https://github.com/KadoBOT/cmp-pluginsA - Maybe???
  - https://github.com/ray-x/cmp-treesitter
  - https://github.com/uga-rosa/cmp-dynamic
 - https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
 - https://github.com/lukas-reineke/cmp-rg


https://github.com/williamboman/mason.nvim/blob/b54d4e3171cc9735de915dbb97e987fb1f05dad9/lua/mason/mappings/language.lua#L22
