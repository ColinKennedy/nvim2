--- Set up Hydra submodes.
---
---@module 'my_custom.plugins.hydra.configuration'
---

local Hydra = require("hydra")

local debug_hint = [[
 Movement
 _h_: Move out  _j_: Skip over  _l_: Move into _<Space>: Continue

 _q_: Exit
]]

Hydra({
    name = "Debugging",
    hint = debug_hint,
    config = {
        color = "pink",
        hint = {
            float_opts = { border = "rounded" },
            position = "top-right",
        },
        invoke_on_body = true,
    },
    mode = { "n", "x" },
    body = "<Space>D",
    heads = {
        { "h", "<cmd>DapStepOut<CR>", { silent = true, desc = "Move out of the current function call." } },
        { "j", "<cmd>DapStepOver<CR>", { silent = true, desc = "Skip over the current line." } },
        { "l", "<cmd>DapStepInto<CR>", { silent = true, desc = "Move into a function call." } },
        { "<Space>", "<cmd>DapContinue<CR>", { silent = true, desc = "Continue to the next breakpoint." } },
        { "q", nil, { exit = true, nowait = true, desc = "Exit." } },
    },
})
