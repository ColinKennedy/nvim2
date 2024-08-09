local which_key = require("which-key")

which_key.add(
    {
        mode = "n",
        {"<leader>c", group = "+file prefix"},
        {"<leader>d", group = "+[d]ebug prefix"},
        {"<leader>dg", group = "+[d]ebug lo[g] prefix"},
        {"<leader>g", group = "+[g]it prefix"},
        {"<leader>ga", group = "+[g]it [a]dd prefix"},
        {"<leader>gc", group = "+[g]it [c]heckout prefix"},
        {"<leader>gd", group = "+[g]it [d]iff prefix"},
        {"<leader>gp", group = "+[g]it [p]ush/[p]ull prefix"},
        {"<leader>gr", group = "+[g]it [r]eset prefix"},
        {"<leader>gs", group = "+[g]it [s]tash prefix"},
        {"<leader>i", group = "+[i]nsert prefix"},
        {"<leader>r", group = "+[r]un prefix"},
        {"<leader>ri", group = "+[r]efactor [i]nline prefix"},
        {"<leader>rt", group = "+[t]oggle [t]est prefix"},
        {"<leader>s", group = "+misc prefix"},
        {"<leader>t", group = "+[t]oggle prefix"},
        {"<leader>tn", group = "+[t]oggle [n]eotest prefix"},

        {"<Space>", group = "Space Sitching Mappings"},
        {"<Space>G", group = "[G]it related"},
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
