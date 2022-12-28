local map = vim.keymap.set
local fzf_user = require('user/plugins/fzf')

-- =============================================================================
-- Project (config.projects[i]) entry model
--
-- * not tracked in VCS, table must be created by user
-- * all fields are required*
--
--[[

config.projects = {
    {
        id: string|number       unique, short, or single alphanumeric id
                                    e.g, id = 'a', id = 4
        name: string            project name can be called in user commands:
                                    :ProjectFiles <name>
                                    :ProjectContents <name> <search_keyword>
        label: string           label to display in Fzf `prompt`
        path: string            project directory / cwd
        ignore: string          ripgrep ignore glob (--glob)
                                    e.g, '"!{.git,node_modules}/**"'
    },
}

--]]

local config = require('user/projects/config')


-- =============================================================================
-- Tables

local M = {}

-- To expose in vim.g global
-- To be used in user fzf functions
local user_projects = {}

-- Populate for user_command completion
local project_names = {}


-- =============================================================================
-- User Projects Keymaps
--
-- Usage:
--
-- <C-p>            search files: project main
-- <leader>ph       search files: $HOME
-- <leader>p1       search files: project 1
-- <leader>p2       search files: project 2
--
-- <leader>rp       search file contents: project main
-- <leader>rh       search file contents: $HOME
-- <leader>r1       search file contents: project 1
-- <leader>r2       search file contents: project 2

function M.setup(cfg)
    cfg = cfg or {}

    if vim.g.user_projects_enabled and not cfg.refresh then
        return
    end

    if cfg.refresh then
        vim.notify('Refreshed user_projects keymaps', vim.log.levels.INFO)
    end

    for _, project in ipairs(config.projects) do
        local id = project.id
        local name = project.name

        -- Populate global and local tables

        user_projects[name] = project
        table.insert(project_names, name)

        local lhs_search_files = name == config.primary_names.main
            and '<C-p>'
            or '<leader>p' .. id

        -- Bind: Search files

        map('n', lhs_search_files, function()
            if name == config.primary_names.home then
                fzf_user.open_fzf_files()
            else
                fzf_user.search_project_file(name)
            end
        end, { noremap = true, silent = true })

        -- Bind: Search file contents

        map('n', '<leader>r' .. id, function()
            fzf_user.search_file_contents(name)
        end, { noremap = true, silent = true })

        -- Bind: Search file contents (Visual)

        map('v', '<leader>r' .. id, function()
            -- Yank visual selection to `v` register
            vim.api.nvim_feedkeys('"vy', 'nx', true)

            fzf_user.search_file_contents(name, vim.fn.getreg('v'))
        end, { noremap = true })
    end

    -- Globals

    vim.g.user_projects_enabled = true
    vim.g.user_projects = user_projects
end

return M
