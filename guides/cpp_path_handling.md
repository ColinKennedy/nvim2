From: https://www.reddit.com/r/neovim/comments/1h53req/comment/m06nljo/
```lua
local function select_from_lst(args, prompt)
    vim.validate {
        args = { args, { 'string', 'table' } },
        prompt = { prompt, 'string', true },
    }

    prompt = prompt or 'Select file: '
    local cwd = vim.pesc(vim.uv.cwd() .. '/')
    if #args > 1 then
        vim.ui.select(
            args,
            { prompt = prompt },
            vim.schedule_wrap(function(choice)
                if choice then
                    vim.cmd.edit((choice:gsub(cwd, '')))
                end
            end)
        )
    elseif #args == 1 then
        vim.cmd.edit((args[1]:gsub(cwd, '')))
    else
        vim.notify('No file found', vim.log.levels.WARN)
    end
end

vim.api.nvim_buf_create_user_command(0, 'Alternate', function(opts)
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)

    -- NOTE: ignore scratch buffers
    if filename == '' and vim.bo[bufnr].buftype ~= '' then
        return
    end

    if vim.fn.filereadable(filename) == 1 then
        filename = vim.uv.fs_realpath(filename)
    end

    local candidates = {}
    local alternates = vim.g.alternates or {}

    if not alternates[filename] or opts.bang then
        local extensions = {
            c = { 'h' },
            h = { 'c' },
            cc = { 'hpp', 'hxx' },
            cpp = { 'hpp', 'hxx' },
            cxx = { 'hpp', 'hxx' },
            hpp = { 'cpp', 'cxx', 'cc' },
            hxx = { 'cpp', 'cxx', 'cc' },
        }
        local bn = vim.fs.basename(filename)
        local ext = bn:match '^.+%.(.+)$' or ''
        local name_no_ext = bn:gsub('%.' .. ext .. '$', '')
        local alternat_dict = {}
        for _, path in ipairs(vim.split(vim.bo.path, ',')) do
            if path ~= '' and vim.fn.isdirectory(path) == 1 then
                for item, itype in vim.fs.dir(path, {}) do
                    if itype == 'file' then
                        local iext = item:match '^.+%.(.+)$' or ''
                        if
                            name_no_ext == (item:gsub('%.' .. iext .. '$', ''))
                            and vim.list_contains(extensions[ext] or {}, iext)
                            and not alternat_dict[vim.fs.joinpath(path, item)]
                        then
                            table.insert(candidates, vim.fs.joinpath(path, item))
                            alternat_dict[vim.fs.joinpath(path, item)] = true
                        end
                    end
                end
            end
        end

        if #candidates > 0 then
            alternates[filename] = candidates
            vim.g.alternates = alternates
        end
    else
        candidates = alternates[filename]
    end

    select_from_lst(candidates, 'Alternate: ')
end, { nargs = 0, desc = 'Alternate between files', bang = true })

This is a simplify version of the mapping that I have in my config files. Also assuming you also use a compile_commands.json you can populate the path using the flags in there

local function inc_parser(args)
    local includes = {}
    local include = false
    for _, arg in pairs(args) do
        if arg == '-isystem' or arg == '-I' or arg == '/I' then
            include = true
        elseif include then
            table.insert(includes, arg)
            include = false
        elseif arg:match '^[-/]I' then
            table.insert(includes, vim.trim(arg:gsub('^[-/]I', '')))
        elseif arg:match '^%-isystem' then
            table.insert(includes, vim.trim(arg:gsub('^%-isystem', '')))
        end
    end
    return includes
end

local compile_commands = vim.fs.find('compile_commands.json', { upward = true, type = 'file' })[1]
if compile_commands then
    local data = table.concat(vim.fn.readfile(compile_commands), '\n')
    local ok, json = pcall(vim.json.decode, data)
    if ok then
        local bufname = vim.api.nvim_buf_get_name(0)
        local buf_basename = vim.fs.basename(bufname)
        for _, source in pairs(json) do
            local source_name = source.file
            if not source.file:match '[/\\]' then
                source_name = vim.fs.joinpath((source.directory:gsub('\\', '/')), source.file)
            end
            local source_basename = vim.fs.basename(source_name)
            if
                source_name == bufname
                or source_basename:gsub('%.cpp$', '.hpp') == buf_basename
                or source_basename:gsub('%.c$', '.h') == buf_basename
            then
                local args
                if source.arguments then
                    args = source.arguments
                elseif source.command then
                    args = vim.split(source.command, ' ')
                end
                local flags = vim.list_slice(args, 2, #args)
                local includes = inc_parser(flags)
                vim.bo.path = vim.bo.path .. ',' .. table.concat(includes, ',')
                break
            end
        end
    end
end
```
