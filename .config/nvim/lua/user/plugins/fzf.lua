local home_path = os.getenv('HOME')
local fzf = require('fzf-lua')

local M = {}

M.base_ignore = '"!{.git,node_modules,build,dist}/**"'

function M.open_fzf_buffers()
    fzf.buffers({
        prompt = 'Buffers: ',
        fzf_opts = {
            ['--reverse'] = '',
            ['--inline-info'] = '',
            ['--tiebreak'] = 'length',
        }
    })
end

function M.open_fzf_files()
    fzf.files({
        prompt = 'Files: ',
        fzf_opts = {
            ['--reverse'] = '',
            ['--inline-info'] = '',
        }
    })
end

--- Search files in project path
--
-- @param #string project_name - Project name in `vim.g.user_projects` table
function M.search_project_file(project_name)
    local project = vim.g.user_projects[project_name]

    if not project then
        vim.notify(
            string.format('"%s" doesn\'t exist in `vim.g.user_projects` global', project_name),
            vim.log.levels.ERROR
        )

        return
    end

    local rg_ignore = string.format('--glob %s', project.ignore)
    local rg_files = string.format('--hidden --files -- %s', project.path)
    local rg_args = string.format('%s %s', rg_ignore, rg_files)
    local rg_command = string.format('rg --no-require-git %s', rg_args)

    fzf.fzf_exec(rg_command, {
        prompt = string.format('Files (%s): ', project.label),
        actions = fzf.defaults.actions.files,
        fzf_opts = {
            ['--with-nth'] = '-3..',
            ['--reverse'] = '',
            ['--inline-info'] = '',
        },
        fn_transform = function(line)
            return string.gsub(line, home_path or '', '~')
        end
    })
end

--- Search file contents in project path
--
-- @param #string project_name - Project name in `vim.g.user_projects` table
-- @param #string search_keyword - String to search
function M.search_file_contents(project_name, search_keyword)
    local project = vim.g.user_projects[project_name]

    if not project then
        vim.notify(
            string.format('"%s" doesn\'t exist in `vim.g.user_projects` global', project_name),
            vim.log.levels.ERROR
        )

        return
    end

    local rg_ignore = string.format('--glob %s', project.ignore)
    local rg_args = {
        '--column',
        '--line-number',
        '--no-heading',
        '--color=always',
        '--smart-case',
        '--hidden',
        rg_ignore,
    }

    local rg_command = string.format('rg %s', table.concat(rg_args, ' '))

    fzf.fzf_live(function(query)
        -- pre-escape parenthesis for shell command
        local escaped_query_parens = vim.fn.escape(query, '{}[]()')

        return rg_command .. ' -- ' .. vim.fn.shellescape(escaped_query_parens)
    end, {
        query = search_keyword,
        cwd = project.path,
        prompt = string.format('Grep %s: ', project.path),
        actions = fzf.defaults.actions.files,
        file_icons = true,
        color_icons = true,
        previewer = 'builtin',
        fzf_opts = {
            ['--phony'] = '',
            ['--reverse'] = '',
            ['--inline-info'] = '',
        },
    })
end

return M
