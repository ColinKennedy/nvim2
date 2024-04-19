## Compile ASCII To Binary Spell File
<!-- Reference: https://stackoverflow.com/a/41583025/3626104 -->
```sh
python3 ./combine.py
```

```vim
:execute "mkspell! " . expand("%:p:h") . "/en-strict"
:execute "mkspell! " . expand("%:p:h") . "/en-strict.utf-8.add"
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
- set spellsuggest to a file with built-in thesaurus options
- Remove words that I don't need

set spellcapcheck=[.?!]\_[\])'"\t ]\+,E.g.,I.e.

Vim has `:h SpellBad` to show misspelled words. You can replace these words with z= according to your `:h spellsuggest`. But that highlighting only applies to words that are misspelled. What if the word that you want to replace is correctly spelled but you want to replace it with another word? How could you highlight that word to indicate "This word may be correct but there's a spelling suggestion that can be applied on this word". Ideally it'd be like `SpellSuggest` highlight group that I can control. Anyone know if there's a performant way to do that?


### Missing words
re-apply
unindent
indentation


### Thesaurus
Check my files for useful words

difficult -> hard
control -> drive
equate -> equals
flow -> goes

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
- Is there a way to visualize if a word has a spelling suggestion?
- Check if I can reorder flags
- Try out https://github.com/kamykn/spelunker.vim
- Check out https://github.com/psliwka/vim-dirtytalk
- https://github.com/ron89/thesaurus_query.vim
- https://www.gutenberg.org/files/3202/files/
- https://github.com/rhysd/vim-grammarous



#### Plugin Idea
- Add a "full" dictionary and make it swappable
- Adds setlocal spell if the buffer has a compatible treesitter parser
- Combiner script on start-up that you can turn on / off
- Add spell options for code variable(s)?
- Bundles cmp + thesaurus options
- Spell level switching (relaxed, strict)
- Spell categories - including variable names, too?
