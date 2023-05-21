- Change af / if to match preceding comment lines. For God's sake
 - https://github.com/nvim-treesitter/nvim-treesitter-textobjects/discussions/452
- `if` doesn't work? Why?
- Add ``super`` Lua snippet (use treesitter)

- Add ``did`` support. See ``require("nvim-treesitter.configs").setup``

- aerial.nvim - don't resize when you move your cursor left / right


Possibly interesting Neogen stuff, from the documentation
```
- `template.annotation_convention` (default: check the language default configurations)
  Change the annotation convention to use with the language.
- `template.use_default_comment` (default: `true`)
  Prepend any template line with the default comment for the filetype
- `template.position` (`fun(node: userdata, type: string):(number,number)?`)
  Provide an absolute position for the annotation.
  If return values are `nil`, use default position
- `template.append`
  If you want to customize the position of the annotation
- `template.append.child_name`
  What child node to use for appending the annotation
- `template.append.position` (`before/after`)
  Relative positioning with `child_name`
- `template.<convention_name>` (replace `<convention_name>` with an annotation convention)
  Template for an annotation convention.
  To know more about how to create your own template, go here:
  https://github.com/danymat/neogen/blob/main/docs/adding-languages.md#default-generator
```
