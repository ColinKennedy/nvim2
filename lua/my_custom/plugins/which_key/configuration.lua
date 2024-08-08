local which_key = require("which-key")

which_key.add(
    {
        mode = "n",
        {"<leader>c", group = "+file prefix"},
        {"<leader>d", group = "+[d]ebug prefix"},
        {"<leader>dg", group = "+[d]ebug lo[g] prefix"},
        {"<leader>g", group = "+[g]it prefix"},
        {"<leader>i", group = "+[i]nsert prefix"},
        {"<leader>r", group = "+[r]un prefix"},
        {"<leader>s", group = "+[m]isc prefix"},
        {"<leader>t", group = "+[t]oggle prefix"},

        {"<Space>", group = "Space Sitching Mappings"},
        {"<Space>S", group = "[S]witcher aerial.nvim windows"},
    }
)

which_key.setup {
    plugins = {
        registers = false, -- Don't show your registers on " in NORMAL or <C-r> in INSERT mode
        presets = {
            motions = false,
            text_objects = false,
            operators = false,
        }
    }
}
