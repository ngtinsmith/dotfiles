local M = {}

local base_ignore = '"!**/{.git,.yarn,.github,.hygen,.vscode,node_modules,build,dist}/**"'
local base_ignore_files = '"!{yarn.lock,package-lock.json,pnpm-lock.yaml}"'

M.primary_names = {
    home = 'home',
    main = 'main',
}

-- TODO: use path as label
M.projects = {
    {
        id = 'h',
        name = M.primary_names.home,
        label = 'Home',
        path = '~',
        ignore = base_ignore,
        ignore_files = base_ignore_files
    },
    {
        id = 1,
        name = 'nvim',
        label = '~/.config/nvim',
        path = '~/.config/nvim',
        ignore = base_ignore,
        ignore_files = base_ignore_files
    },
}

return M
