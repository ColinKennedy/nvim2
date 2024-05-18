## Compile ASCII To Binary Spell File
<!-- Reference: https://stackoverflow.com/a/41583025/3626104 -->
```vim
:execute "py3file " . expand("%:p:h") . "/combine.py" | execute "mkspell! " . expand("%:p:h") . "/en-strict" | execute "mkspell! " . expand("%:p:h") . "/en-strict.utf-8.add"
```

## Important Files
- en-strict.utf-8.add - Define words here so that they will be colored with
  suggestion highlighting
- strict_thesaurus.txt - Define the word to replace and its suggested alternative here


## Convert Binary Spell File to ASCII
<!-- Reference: https://vi.stackexchange.com/a/5422/16073 -->
```sh
spelldump
```


# Reference: https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en/en_US.aff
# https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en/en_US.dic
# https://manpages.ubuntu.com/manpages/focal/man5/hunspell.5.html


## TODO
- set spellsuggest to a file with built-in thesaurus options
- Remove words that I don't need


### Missing words
re-apply
unindent
indentation


### Thesaurus
TODO Figure this out

Measuring complexity
- https://github.com/thoughtbot/complexity
- https://github.com/tsproisl/textcomplexity
https://medium.com/analytics-vidhya/visualising-text-complexity-with-readability-formulas-c86474efc730

https://www.lumoslearning.com/llwp/free-text-complexity-analysis.html
Readability Grade Levels
Flesch-Kincaid Grade Level	-0.7
Gunning Fog Index	3.2
Coleman-Liau Index	-0.4
SMOG Index	3.1
Automated Readability Index	-2.1
FORCAST Grade Level	5.0
Powers Sumner Kearl Grade	3.8
Rix Readability	1
Raygor Readability	0
Fry Readability


### TODO
- Try out https://github.com/kamykn/spelunker.vim
- Check out https://github.com/psliwka/vim-dirtytalk
- https://github.com/ron89/thesaurus_query.vim
- https://www.gutenberg.org/files/3202/files/
- https://github.com/rhysd/vim-grammarous
