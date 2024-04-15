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


# Reference: https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en/en_US.aff
# https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en/en_US.dic
# https://manpages.ubuntu.com/manpages/focal/man5/hunspell.5.html


## TODO
### Missing words
isn't
re-apply
we'll
we'd


### Thesaurus
TODO Figure this out
Get thesaurus results for
- Integrate
- relies -> needs
- generate -> create
- miscellaneous -> various
- previously -> in the past
Modifies -> Changes
large -> big


### TODO - Check if I can reorder flags
