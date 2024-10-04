local toggle_current_directory = function()
    local current_directory = vim.fn.getcwd()
    vim.cmd("NvimTreeToggle " .. current_directory)
end

-- termguicolors was already set elsewhere. But I'll keep it commented here
-- just so that we remember to do it in case that changes in the future.
--
-- set termguicolors to enable highlight groups
--
-- vim.opt.termguicolors = true

-- Empty setup using defaults
require("nvim-tree").setup()

vim.api.nvim_create_user_command(
    "PwdNvimTreeToggle",
    toggle_current_directory,
    {nargs=0}
)
