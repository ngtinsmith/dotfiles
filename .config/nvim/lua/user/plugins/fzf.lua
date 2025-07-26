local home_path = os.getenv('HOME')
local fzf = require('fzf-lua')

-- TODO: fzf configure code_actions previewer and
-- window config
require('fzf-lua').setup({
    lsp = {
        code_actions = {
            previewer = false,
            -- preview_pager = [[ delta --hunk-header-style="omit" --file-style="omit" --width=$FZF_PREVIEW_COLUMNS ]],
            winopts = {
                border = 'rounded',
                preview = {
                    scrollbar = false,
                    layout = 'vertical',
                    width = 0.5,
                    height = 0.5,
                    vertical = 'down:75%',
                }
            }
        }
    }
})

local M = {}

M.base_ignore = '"!**/{.git,.yarn,.github,.hygen,.vscode,node_modules,build,dist}/**"'
M.base_ignore_files = '"!{yarn.lock,package-lock.json}"'

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

function M.create_ignored_globs(folders, files)
    folders = folders or M.base_ignore
    files = files or M.base_ignore_files

    local folders_glob = string.format('-g %s', folders)
    local files_glob = string.format('-g %s', files)

    return string.format('%s %s', folders_glob, files_glob)
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

    local rg_ignore = M.create_ignored_globs(project.ignore, project.ignore_files)
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

    local rg_ignore = M.create_ignored_globs(project.ignore, project.ignore_files)
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
