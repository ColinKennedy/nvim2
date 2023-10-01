local async = require("gitsigns.async")
local git = require("gitsigns.git")
local run_diff = require("gitsigns.diff")
local gitsigns_cache = require("gitsigns.cache")
local gitsigns_hunks = require("gitsigns.hunks")
local cache = gitsigns_cache.cache
local util = require("gitsigns.util")
local void = require("gitsigns.async").void


local M = {}


local _find_next_path = function(current, paths)
    local recommended_next_index = nil
    local index = 0

    for _, path in ipairs(paths)
    do
        if current <= path
        then
            recommended_next_index = index + 1

            break
        end

        index = index + 1
    end

    local length = #paths

    if recommended_next_index == nil and index == length
    then
        return paths[1]  -- Recommend the start of `paths` again
    end

    -- Wrap to the start of `paths` if `recommended_next_index` is at the end
    -- We `+ 1` because Lua array indices start at one
    --
    next_index = (recommended_next_index % length) + 1

    return paths[next_index]
end


local _get_real_relative_path = function(text)
    local match = text:gmatch(".*->%s*(.*)")()

    if match
    then
        return match
    else
        return text
    end
end


-- TODO: BUG - doesn't work when some files are renamed
local _get_path_hunks = function(repository)
    local output = {}

    local os_separator = package.config:sub(1, 1)

    for _, relative_path in ipairs(repository:files_changed())
    do
        local relative_path = _get_real_relative_path(relative_path)
        local absolute_path = repository.toplevel .. os_separator .. relative_path
        local stat = vim.loop.fs_stat(absolute_path)

        if stat and stat.type == 'file' then
            local text = repository:get_show_text(':0:' .. relative_path)

            async.scheduler()

            local hunks = run_diff(text, util.file_lines(absolute_path))

            if hunks and not vim.tbl_isempty(hunks)
            then
                output[absolute_path] = hunks
            end
        end
    end

    return output
end


local _get_sorted_keys = function(data)
    local output = {}

    for path, _ in pairs(data)
    do
        table.insert(output, path)
    end

    table.sort(output)

    return output
end


local _go_to_hunk_current_buffer = function(hunk, opts)
    local row = opts.forwards and hunk.added.start or hunk.vend

    if row == 0 then
        row = 1
    end

    vim.cmd([[ normal! m' ]])
    vim.api.nvim_win_set_cursor(0, { row, 0 })
end


local _go_to_first_hunk_in_path = function(path, hunks, opts)
    vim.cmd(":edit " .. path)

    local line = 0
    local hunk, _ = gitsigns_hunks.find_nearest_hunk(line, hunks, opts.forwards, opts.wrap)

    if hunk == nil
    then
        return
    end

    _go_to_hunk_current_buffer(hunk, opts)
end


local _go_to_first_known_hunk = function(path_hunks)
    local path, hunks = pairs(path_hunks)(path_hunks)
    local opts = {}
    opts.forwards = true
    opts.wraps = false

    _go_to_first_hunk_in_path(path, hunks, opts)
end


local _populate_repository = function(directory)
    local repositories = {}

    if vim.tbl_isempty(cache)
    then
        vim.api.nvim_err_writeln(
            'Directory "'
            .. directory
            .. '" is not in a git repository.'
        )

        return nil
    end

    for _, buffer_cache in pairs(cache)
    do
        local repository = buffer_cache.git_obj.repo

        if not repositories[repository.gitdir]
        then
            repositories[repository.gitdir] = repository
        end
    end

    local repository = git.Repo.new(directory)

    if not repositories[repository.gitdir] then
        repositories[repository.gitdir] = repository
    end

    return repository
end


local next_hunk_or_file = void(
    function(opts)
        local current_directory = vim.loop.cwd()
        local repository = _populate_repository(current_directory)

        if not repository
        then
            return
        end

        local path_hunks = _get_path_hunks(repository)

        local current_path = vim.api.nvim_buf_get_name(0)  -- 0 == current buffer

        if current_path == ""
        then
            -- Occurs if the user is in an unnamed buffer. Go to the first known hunk
            _go_to_first_known_hunk(path_hunks)

            return
        end

        if path_hunks[current_path] ~= nil
        then
            local current_line = vim.api.nvim_win_get_cursor(0)[1]

            local hunk, index = gitsigns_hunks.find_nearest_hunk(
                current_line,
                path_hunks[current_path],
                opts.forwards,
                opts.wrap
            )

            if hunk ~= nil
            then
                _go_to_hunk_current_buffer(hunk, opts)
            else
                local paths = _get_sorted_keys(path_hunks)
                local next_path = _find_next_path(current_path, paths)

                if not next_path
                then
                    vim.api.nvim_err_writeln(
                        'Path "'
                        .. current_path
                        .. '" could not be used to find a new, next path from "'
                        .. vim.inspect(paths)
                        .. '" paths.'
                    )

                    return
                end

                _go_to_first_hunk_in_path(next_path, path_hunks[next_path], opts)
            end
        end
    end
)


M.next_hunk = function()
    local opts = {}
    opts.forwards = true
    opts.wraps = false
    next_hunk_or_file(opts)
end


M.previous_hunk = function()
    local opts = {}
    opts.forwards = false
    opts.wraps = false
    next_hunk_or_file(opts)
end


return M
