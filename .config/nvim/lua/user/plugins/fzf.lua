local fzf = require('fzf-lua')

local M = {}

function M.search_project_file(project)
    local rg_ignore = string.format('--glob %s', project.ignore)
    local rg_files = string.format('--hidden --files -- %s', project.path)
    local rg_args = string.format('%s %s', rg_ignore, rg_files)
    local rg_command = string.format('rg --no-require-git %s', rg_args)

    fzf.fzf_exec(rg_command, {
        fzf_opts = {
            ['--with-nth'] = '-3..',
            ['--reverse'] = '',
            ['--inline-info'] = '',
        },
        actions = fzf.defaults.actions.files
    })
end

function M.search_file_contents(project, keyword)
    local path = project.path
    local _keyword = keyword ~= nil and keyword:len() > 0
        and keyword
        or ''

    local rg_ignore = string.format('--glob %s', project.ignore)
    local rg_content_pattern = string.format('"%s"', _keyword)

    local rg_args = {
        '--column',
        '--line-number',
        '--no-heading',
        '--color=always',
        '--smart-case',
        '--hidden',
        rg_ignore,
    }

    local rg_command = string.format(
        'rg %s %s %s',
        table.concat(rg_args, ' '),
        rg_content_pattern,
        path
    )

    fzf.fzf_exec(rg_command, {
        prompt = string.format('%s: ', path),
        fzf_opts = {
            ['--phony'] = '',
            ['--reverse'] = '',
            ['--inline-info'] = '',
        },
        actions = fzf.defaults.actions.files
    })
end

return M
