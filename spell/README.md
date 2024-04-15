## Compile ASCII To Binary Spell File
<!-- Reference: https://stackoverflow.com/a/41583025/3626104 -->
```sh
python3 ./combine.py
```

```vim
:execute "mkspell! " . expand("%:p:h") . "/en-strict"
```

Or together

```vim
:execute "python3 " . expand("%:p:h") . "/combine.py" | execute "mkspell! " . expand("%:p:h") . "/en-strict"
```


## Convert Binary Spell File to ASCII
<!-- Reference: https://vi.stackexchange.com/a/5422/16073 -->
```sh
spelldump
```


TODO Add these spell types
ly
ed
s
es
capitalization
y -> ies

's onto words
Allowing lower case of something upper (e.g. USD -> usd)

- ing (e.g. do -> doing)


## Cool Moments
Modifies -> Changes
