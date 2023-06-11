-- A fallback configuration in case the language is unsupported.
--
-- Reference: https://github.com/Wansmer/treesj/discussions/19
--
local langs = require("treesj.langs")["presets"]

local callback = function()
    local options = { buffer = true }
    if langs[vim.bo.filetype] then
        vim.keymap.set(
            "n",
            "<leader>sa",
            function()
                require("treesj").toggle()
            end,
            options
        )
    else
        -- This fallback requires https://github.com/FooSoft/vim-argwrap
        vim.keymap.set("n", "<leader>sa", "<Cmd>ArgWrap<CR>", options)
    end
end

-- Redefine the <leader>sa command depending on the filetype
-- If the filetype isn't supported by "Wansmer/treesj", this should give you a fallback.
--
vim.api.nvim_create_autocmd({"FileType"}, {pattern="*", callback=callback})

-- Set up the treesitter nodes for the Python language.
--
-- Reference: https://github.com/Wansmer/treesj/issues/108
--
local lang_utils = require("treesj.langs.utils")
local options = {
    join = { space_in_brackets = false },
    split = { last_separator = true },
}

require("treesj").setup(
    {
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
            }
        }
    }
)
