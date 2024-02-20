;;extends

(definition_list (list_item (term) @python_docstring_block_title
  (#any-of? @python_docstring_block_title
    "Args:"
    "Example:"
    "Examples:"
    "Important:"
    "Note:"
    "Raises:"
    "References:"
    "Returns:"
    "Returns:"
    "See Also:"
    "Todo:"
    "Warning:"
    "Warnings:"
    "Yields:"
  )))
