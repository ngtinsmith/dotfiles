local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local yank = augroup('yank_highlight', { clear = true })
local lua_modules = augroup('lua_modules', { clear = true })
local aliases_filetype = augroup('aliases_filetype', { clear = true })
local git_bare_dots = augroup('git_bare_dots', { clear = true })

autocmd('TextYankPost', {
    group = yank,
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 150
        })
    end
})

autocmd('BufWritePost', {
    group = lua_modules,
    desc = 'Source lua files onChange and re-compile packer',
    pattern = '*.lua',
    callback = function(args)
        dofile(args.file)
        require('packer').compile()
    end,
})


autocmd({ 'BufRead', 'BufNewFile' }, {
    group = aliases_filetype,
    pattern = '*.aliases',
    callback = function()
        vim.opt.filetype = 'sh'
    end,
})

autocmd({ 'BufRead' }, {
    group = git_bare_dots,
    desc = [[
        Set default git work tree and dir to `~/.dotfiles` bare repo.
        Useful for diffview and gitsigns plugins when working with dotfiles changes
    ]],
    pattern = '*.lua',
    callback = function()
        local git_work_tree = vim.env.GIT_WORK_TREE
        local git_dir = vim.env.GIT_DIR

        if git_work_tree == nil and git_dir == nil then
            vim.env.GIT_WORK_TREE = vim.fn.expand('~')
            vim.env.GIT_DIR = vim.fn.expand('~/.dotfiles')
        end
    end,
})
