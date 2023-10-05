local M = {}

function M.add_bin_folder_to_path()
    local filer = require("my_custom.utilities.filer")

    local install_root = filer.join_path(
        {
            vim.g.vim_home,
            "mason_packages",
            vim.loop.os_uname().sysname,
        }
    )

    local bin_directory = filer.join_path({install_root, "bin"})

    local current_path_variable = os.getenv("PATH")

    for _, path in current_path_variable:gmatch("[^:]+")
    do
        if bin_directory == path
        then
            -- The `bin_directory` already exists. It would be redundant to add
            -- it to $PATH twice so we just end this function early.
            --
            print("STOP")

            return
        end
    end


    -- Add the "bin" folder to $PATH so other plug-ins can use it
    vim.fn.setenv(
        "PATH",
        filer.join_os_paths({bin_directory, current_path_variable})
    )
end

return M
