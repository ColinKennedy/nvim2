-- load gitsigns only when a git file is opened
vim.api.nvim_create_autocmd(
    { "BufRead" },
    {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
            vim.fn.system("git -C " .. vim.fn.expand "%:p:h" .. " rev-parse")
            if vim.v.shell_error == 0 then
                vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                vim.schedule(function()
                    require("lazy").load { plugins = { "gitsigns.nvim" } }
                end)
            end
        end
    }
)

-- Make deleted lines a bit easier to see
vim.api.nvim_set_hl(0, "GitSignsDelete", {fg="#cc6666", ctermfg=167})
