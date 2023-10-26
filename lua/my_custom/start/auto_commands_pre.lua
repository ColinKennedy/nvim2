local vim_closing = false
local tasks = {}


local function _kill_task(task)
    tasks[task] = nil
end


local function _has_tasks()
  return next(tasks)
end


local function _handle_progress(err, msg, info)
    -- See: https://microsoft.github.io/language-server-protocol/specifications/specification-current/#progress
    if vim_closing then
        return
    end

    local task = msg.token
    local value = msg.value

    if not task then
      -- Notification missing required token??
      return
    end

    tasks[task] = true

    if value.kind == "end" then
        _kill_task(task)
    end

    if not _has_tasks() then
        vim.api.nvim_exec_autocmds("User", {pattern = "LspComplete"})

        return
    end
end


local old_handler = vim.lsp.handlers["$/progress"]

vim.lsp.handlers["$/progress"] = function(...)
    old_handler(...)
    _handle_progress(...)
end


local group = vim.api.nvim_create_augroup("LspCustomGroup", { clear = true })

vim.api.nvim_create_autocmd(
    "User",
    { callback = function() end, group = group, pattern = "LspComplete" }
)
