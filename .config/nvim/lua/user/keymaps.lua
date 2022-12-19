local map = vim.keymap.set
local utils = require('user/utils')
local fzf_user = require('user/plugins/fzf')
local fzf_lua = require('fzf-lua')


-- =============================================================================
-- Defaults

vim.g.mapleader = ' '

-- Reload config
map('n', '<Leader>sv', utils.reload_init)

-- Command Mode
map('n', ',', ':')
map('v', ',', ':')
map('n', ':', ',')
map('v', ':', ',')

-- Navigation - Text
map('n', 'H', '^')
map('n', 'L', '$')
map('v', 'H', '^')
map('v', 'L', '$')
map('n', '<Leader>e', '%')

-- Navigation - Wrapped lines
local nav_opts = { silent = true, expr = true }

map('n', 'j', function() return utils.vcount_navigate('j') end, nav_opts)
map('n', 'k', function() return utils.vcount_navigate('k') end, nav_opts)
map('v', 'j', function() return utils.vcount_navigate('j') end, nav_opts)
map('v', 'k', function() return utils.vcount_navigate('k') end, nav_opts)

-- Navigation - Windows / Buffers
map('n', '<C-h>', 'gT')
map('n', '<C-l>', 'gt')
map('n', '<Leader><Tab>', ':b#<CR>', { silent = true })

-- Split - Resize
map('', '<C-Up>', ':res +1<CR>', { silent = true })
map('', '<C-Down>', ':res -1<CR>', { silent = true })
map('', '<C-Left>', ':vertical resize -5<CR>', { silent = true })
map('', '<C-Right>', ':vertical resize +5<CR>', { silent = true })

-- Tab shifting - (keep selection)
map('n', '<Tab>', '>>')
map('n', '<S-Tab>', '<<')
map('v', '<Tab>', '>gv')
map('v', '<S-Tab>', '<gv')

-- Visually select function block
map('n', '<Leader>vf', 'va{V')

-- Search - unset highlight from last search pattern onEnter (carriage return)
map('n', '<CR>', ':nohlsearch<CR>', { silent = true })

-- Integrated Terminal to Normal mode
map('t', '<C-k>', '<C-\\><C-n>')

-- Suspend Vim to open full shell prompt
-- (write fg in shell to put V into foreground)
map('n', '<Leader>sh>', ':sus<CR>')

-- Comment keymap like in VSCode
-- this works because vim registers <C-/> as <C-_>
-- plugin: comment.nvim
map('n', '<C-_>', 'gcc', { remap = true })
map('v', '<C-_>', 'gc', { remap = true })

-- Retain "p" register when pasting over a selection
map('v', '<Leader>p', '_dP')


-- =============================================================================
-- LSP

map('n', 'gd', vim.lsp.buf.definition, { silent = true })
map('n', 'gh', vim.lsp.buf.hover, { silent = true })
map('n', 'gD', vim.lsp.buf.implementation, { silent = true })
map('n', '1gD', vim.lsp.buf.type_definition, { silent = true })
map('n', 'gr', vim.lsp.buf.references, { silent = true })
map('n', 'g0', vim.lsp.buf.document_symbol, { silent = true })
map('n', 'gW', vim.lsp.buf.workspace_symbol, { silent = true })


-- ============================================================================
-- FZF

map('n', '<Leader>d', function()
    fzf_lua.buffers({
        prompt = 'BUFFERS: ',
        fzf_opts = {
            ['--reverse'] = '',
            ['--inline-info'] = '',
            ['--tiebreak'] = 'length',
        }
    })
end)

map('n', '<Leader>hh', function()
    fzf_lua.files({
        prompt = 'FILES: ',
        fzf_opts = {
            ['--reverse'] = '',
            ['--inline-info'] = '',
        }
    })
end)


-- =============================================================================
-- Searching

map('n', '<C-f>', utils.search_in_place)
map('v', '<C-f>', utils.search_in_place)
map('x', '*', utils.search_in_place)


-- ============================================================================-
-- Projects

local ignore_glob = '"!{.git,node_modules}/**"'

map('n', '<C-p>', function()
    fzf_user.search_project_file({
        path = '~/.config/nvim',
        ignore = ignore_glob
    })
end)

map('n', '<Leader>rp', function()
    fzf_user.search_file_contents({
        path = '~/.config/nvim/lua',
        ignore = ignore_glob
    }, 'local ')
end)
