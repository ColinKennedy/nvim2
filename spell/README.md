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
re-apply
isn't
e.g. isn't working
doesn't
unindent
indentation


### Thesaurus
TODO Figure this out
Get thesaurus results for
- Integrate
- content -> data
- relies -> needs
- generate -> create
- miscellaneous -> various
- agnostic -> unaware
- extract -> get
- responsible for -> meant for
- encountered -> found
- previously -> in the past
- generic -> general
Modifies -> Changes
large -> big


### TODO
- Check if I can reorder flags
- Try out https://github.com/kamykn/spelunker.vim
- Check out https://github.com/psliwka/vim-dirtytalk
- https://github.com/ron89/thesaurus_query.vim
- https://www.gutenberg.org/files/3202/files/
- https://github.com/rhysd/vim-grammarous


#### Plugin Idea
- Adds setlocal spell if the buffer has a compatible treesitter parser
- Combiner script on start-up that you can turn on / off
- Add spell options for code variable(s)?
- Bundles cmp + thesaurus options
