local fzf_user = require('user/plugins/fzf')
local keymaps = require('user/projects/keymaps')

-- Usage:
--
-- :ProjectFiles main
-- :ProjectFiles home (syn fzf :Files)
-- :ProjectFiles 1
-- :ProjectFiles N

vim.api.nvim_create_user_command(
    'ProjectFiles',
    function(opts)
        fzf_user.search_project_file(opts.args)
    end,
    {
        nargs = 1,
        bang = true,
        complete = function() return vim.g.user_project_names end,
    }
)

-- Usage:
--
-- :ProjectContents main const
-- :ProjectContents main require('fz
-- :ProjectContents home ('red')

vim.api.nvim_create_user_command(
    'ProjectContents',
    function(opts)
        fzf_user.search_file_contents(opts.args)
    end,
    {
        nargs = '*',
        bang = true,
        complete = function() return vim.g.user_project_names end,
    }
)

-- Usage:
--
-- :ProjectsRefresh

vim.api.nvim_create_user_command(
    'ProjectsRefresh',
    function()
        keymaps.setup({ refresh = true })
    end,
    {
        nargs = 0,
        bang = true,
    }
)
