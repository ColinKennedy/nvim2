local protected_window = require("my_custom.utilities.protected_window")

-- Make it so the quick-fix window will always display the quick-fix buffer
protected_window.register_window_and_buffer(
    vim.api.nvim_get_current_win(),
    vim.fn.bufnr()
)
