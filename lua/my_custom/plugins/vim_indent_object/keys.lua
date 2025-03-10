return {
    {
        "aI",
        ':<C-u>cal HandleTextObjectMapping(0, 1, 0, [line("."), line("."), col("."), col(".")])<CR>',
        mode = "o",
        desc = "Select [a]round lines of same + outer [I]ndentation, spanning whitespace.",
        silent = true,
    },
    {
        "aI",
        ':<C-u>cal HandleTextObjectMapping(0, 1, 1, [line("."), line("."), col("."), col(".")])<CR>',
        mode = "v",
        desc = "Select [a]round lines of same + outer [I]ndentation, spanning whitespace.",
        silent = true,
    },
    {
        "ai",
        ':<C-u>cal HandleTextObjectMapping(0, 0, 0, [line("."), line("."), col("."), col(".")])<CR>',
        mode = "o",
        desc = "Select [a]round lines of same + outer [I]ndentation, stopping at whitespace.",
        silent = true,
    },
    {
        "ai",
        ':<C-u>cal HandleTextObjectMapping(0, 0, 1, [line("."), line("."), col("."), col(".")])<CR>',
        mode = "v",
        desc = "Select [a]round lines of same + outer [I]ndentation, stopping at whitespace.",
        silent = true,
    },
    {
        "iI",
        ':<C-u>cal HandleTextObjectMapping(1, 1, 0, [line("."), line("."), col("."), col(".")])<CR>',
        mode = "o",
        desc = "Select [i]nside lines of same [I]ndentation, spanning whitespace.",
        silent = true,
    },
    {
        "iI",
        ':<C-u>cal HandleTextObjectMapping(1, 1, 1, [line("\'<"), line("\'>"), col("\'<"), col("\'>")])<CR><Esc>gv',
        mode = "v",
        desc = "Select [i]nside lines of same [I]ndentation, spanning whitespace.",
        silent = true,
    },
    {
        "ii",
        ':<C-u>cal HandleTextObjectMapping(1, 0, 0, [line("."), line("."), col("."), col(".")])<CR>',
        mode = "o",
        desc = "Select [i]nside lines of same [I]ndentation, stopping at whitespace.",
        silent = true,
    },
    {
        "ii",
        ':<C-u>cal HandleTextObjectMapping(1, 0, 1, [line("\'<"), line("\'>"), col("\'<"), col("\'>")])<CR><Esc>gv',
        mode = "v",
        desc = "Select [i]nside lines of same [I]ndentation, stopping at whitespace.",
        silent = true,
    },
}
