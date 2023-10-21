--- Set up the treesitter nodes for the Python language.
---
--- Reference: https://github.com/Wansmer/treesj/issues/108
---
---@module 'my_custom.plugins.treesj.configuration'
---

local lang_utils = require("treesj.langs.utils")
local options = {
    join = { space_in_brackets = false },
    split = { last_separator = true },
}

require("treesj").setup({
    max_join_length = 150,
    use_default_keymaps = false,
    langs = {
        python = {
            argument_list = lang_utils.set_preset_for_args(options),
            assignment = { target_nodes = { "list", "set", "tuple", "dictionary" } },
            call = { target_nodes = { "argument_list" } },
            dictionary = lang_utils.set_preset_for_dict(options),
            list = lang_utils.set_preset_for_list(options),
            parameters = lang_utils.set_preset_for_args(options),
            set = lang_utils.set_preset_for_list(options),
            tuple = lang_utils.set_preset_for_list(options),
        },
    },
})

-- A fallback configuration in case the language is unsupported.
--
-- Reference: https://github.com/Wansmer/treesj/discussions/19
--
local callback = function()
    local options_ = {
        desc = "[s]plit [a]rgument list",
        buffer = true,
    }

    local languages = require("treesj.langs")["presets"]

    if languages[vim.bo.filetype] then
        vim.keymap.set("n", "<leader>sa", "<cmd>TSJToggle<CR>", options_)
    else
        -- This fallback requires https://github.com/FooSoft/vim-argwrap
        vim.keymap.set("n", "<leader>sa", "<cmd>ArgWrap<CR>", options_)
    end
end

-- Redefine the <leader>sa command depending on the filetype
-- If the filetype isn't supported by "Wansmer/treesj", this should give you a fallback.
--
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = "*", callback = callback })

-- We need to call this for the first time, for the current file
callback()
