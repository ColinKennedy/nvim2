local which_key = require("which-key")

which_key.add(
    {
        mode = "n",
        {"<leader>c", group = "+file prefix", icon="󰈔"},
        {"<leader>d", group = "+[d]ebug prefix", icon=""},
        {"<leader>dg", group = "+[d]ebug lo[g] prefix", icon="󰈔"},
        {"<leader>g", group = "+[g]it prefix", icon=""},
        {"<leader>ga", group = "+[g]it [a]dd prefix", icon=""},
        {"<leader>gc", group = "+[g]it [c]heckout prefix", icon="󰸞"},
        {"<leader>gd", group = "+[g]it [d]iff prefix", icon=""},
        {"<leader>gp", group = "+[g]it [p]ush/[p]ull prefix", icon="󰓂"},
        {"<leader>gr", group = "+[g]it [r]eset prefix", icon="󰕍"},
        {"<leader>gs", group = "+[g]it [s]tash prefix", icon=""},
        {"<leader>i", group = "+[i]nsert prefix", icon="󱔕"},
        {"<leader>r", group = "+[r]un prefix", icon="󰑮"},
        {"<leader>ri", group = "+[r]efactor [i]nline prefix", icon=""},
        {"<leader>rt", group = "+[t]oggle [t]est prefix", icon="󰙨"},
        {"<leader>s", group = "+misc prefix", icon=""},
        {"<leader>t", group = "+[t]oggle prefix", icon="󰔡"},
        {"<leader>tn", group = "+[t]oggle [n]eotest prefix", icon="󱨦"},

        {"<Space>", group = "Space Stitching Mappings", icon="󰯉"},
        {"<Space>G", group = "[G]it related", icon=""},
        {"<Space>S", group = "[S]witcher aerial.nvim windows", icon=""},
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
