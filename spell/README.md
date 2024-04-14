## Compile ASCII To Binary Spell File
<!-- Reference: https://stackoverflow.com/a/41583025/3626104 -->
```vim
:execute "python3 " . expand("%:p:h") . "/combine.py" | execute "mkspell! " . expand("%:p:h") . "/en-strict"
```


## Convert Binary Spell File to ASCII
<!-- Reference: https://vi.stackexchange.com/a/5422/16073 -->
```sh
spelldump
```


ly
ed
s
es
capitalization
y -> ies
