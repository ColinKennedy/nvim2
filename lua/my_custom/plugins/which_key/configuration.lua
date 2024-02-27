local which_key = require("which-key")

which_key.setup {
    ignore_missing = true,
    triggers_blacklist = {
        c = {"%", ">"},  -- Prevent mappings like %s/ from popping up
    },
    plugins = {
        presets = {
            motions = false,
            text_objects = false,
            operators = false,
        }
    }
}

which_key.register(
    {
        ["<leader>"] = {
            c = "+file-ish prefix",
            d = {
                name = "+debug prefix",
                ["<Space>"] = "Continue through the debugger to the next breakpoint.",
                ["-"] = "Restart the current debug session.",
                ["="] = "Disconnect from a remote DAP session.",
                ["_"] = "Kill the current debug session.",
                b = "Set a breakpoint (and remember it even when we re-open the file).",
                d = "[d]o [d]ebugger.",
                g = {
                    name = "+debu[g] lo[g] prefix",
                    e = "Open the [d]ebu[g] [e]dit file.",
                    t = "Set [d]ebu[g] to [t]race level logging.",
                },
                h = "Move out of the current function call.",
                j = "Skip over the current line.",
                l = "Move into a function call.",
                z = "[d]ebugger [z]oom toggle (full-screen or minimize the window).",
            },
            f = "[f]ind text using hop-mode",
            i = {
                name = "+insert prefix",
                d = "[i]nsert auto-[d]ocstring.",
            },
            r = "+run prefix",
            s = {
                name = "+misc prefix",
                a = { "[s]plit [a]rgument list" },
            },
        },
        ["<space>"] = {
            name = "Space Switching Mappings",
            A = "Show [A]rgs list",
            B = "Show [B]uffers list",
            D = "[D]ebugging interactive mode",
            E = "[E]dit a new project root file",
            G = "[G]it interactive mode",
            L = "[L]ines searcher (current file)",
            S = {
                name = "[S]witcher aerial.nvim windows",
                A = "[S]witch [N]avigation",
                S = "[S]witch [S]idebar",
                O = "[S]ymbols [O]utliner (LSP)",
            },
            T = "Create a [T]erminal on the bottom of the current window.",
            W = "Open [W]orkspace (NvimTree)",
            Z = "[Z]oxide's interative pwd switcher",
            c = {
                name = "+LSP [c]ode prefix",
                a = "Run [c]ode [a]ction",
            },
            e = "Find and [e]dit a file starting from `:pwd`.",
            q = "Switch to [q]uickfix window, if open",
            w = {
                name = "+workspace LSP prefix",
                a = "LSP [w]orkspace [a]dd",
                l = "LSP [w]orkspace [l]ist",
                r = "LSP [w]orkspace [r]remove",
            },
        },
    }
)
