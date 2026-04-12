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

--- Search files in project path
--
-- @param #string project_name - Project name in `vim.g.user_projects` table
function M.search_project_file(project_name)
    local project = vim.g.user_projects[project_name]
    if not project then return end

    local path = project.path:gsub('^~', os.getenv('HOME'))

    fzf.files({
        cwd = path,
        prompt = string.format('%s> ', project.label or project.name),
        -- We pass the flags as a string; fzf-lua handles the execution
        cmd = string.format('rg --files --hidden --no-require-git -g %s -g %s',
            project.ignore, project.ignore_files),
        fzf_opts = {
            ['--tiebreak'] = 'length',
            -- TODO: c-g doesn't work
            ['--bind'] = 'ctrl-g:toggle-fuzzy',
        },
        -- This prevents the "multiprocess" error while keeping icons
        file_icons = true,
        color_icons = true,
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

    -- Build your ignore globs as separate args
    local rg_ignore = {}
    if project.ignore then
        vim.list_extend(rg_ignore, { '-g', project.ignore })
    end
    if project.ignore_files then
        vim.list_extend(rg_ignore, { '-g', project.ignore_files })
    end

    fzf.live_grep({
        -- Let fzf-lua handle the core live_grep behavior
        cmd = 'rg',
        cwd = project.path,
        prompt = string.format('%s: ', project.path),
        query = search_keyword,
        -- Merge in your custom ripgrep args
        rg_opts = table.concat({
            '--column',
            '--line-number',
            '--no-heading',
            '--color=always',
            '--smart-case',
            '--hidden',
            unpack(rg_ignore),
        }, ' '),
        actions = fzf.defaults.actions.files,
        file_icons = true,
        color_icons = true,
        previewer = 'builtin',
        -- fzf_opts from your old setup
        fzf_opts = {
            ['--reverse'] = '',
            ['--inline-info'] = '',
        },
    })
end

return M
