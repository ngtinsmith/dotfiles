local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- =============================================================================

local yank = augroup('yank_highlight', { clear = true })

autocmd('TextYankPost', {
    group = yank,
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 150
        })
    end
})

-- =============================================================================

local lua_modules = augroup('lua_modules', { clear = true })

autocmd('BufWritePost', {
    group = lua_modules,
    desc = 'Source lua files onChange and re-compile packer',
    pattern = '*.lua',
    callback = function(args)
        dofile(args.file)
        require('packer').compile()
    end,
})

-- =============================================================================

local aliases_filetype = augroup('aliases_filetype', { clear = true })

autocmd({ 'BufRead', 'BufNewFile' }, {
    group = aliases_filetype,
    pattern = '*.aliases',
    callback = function()
        vim.opt.filetype = 'sh'
    end,
})
