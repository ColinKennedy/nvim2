vim.schedule(
    function()
        vim.cmd[[TSInstall! python]]
        vim.cmd[[TSInstall! cpp]]
    end
)
