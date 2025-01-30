local map = vim.keymap.set
local utils = require('user/utils')
local fzf_user = require('user/plugins/fzf')


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

-- Navigation - Quickfix List
-- map('n', '<C-j>', ':<CR><C-w>n')
-- map('n', '<C-k>', ':<CR><C-w>p')

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

local bufopts = { silent = true }

local conform_fmt = function()
    local buf = vim.api.nvim_get_current_buf()
    require("conform").format({ bufnr = buf, async = true })
end

map('n', 'gD', vim.lsp.buf.declaration, bufopts)
map('n', 'gd', vim.lsp.buf.definition, bufopts)
map('n', 'gh', vim.lsp.buf.hover, bufopts)
map('n', 'gi', vim.lsp.buf.implementation, bufopts)
map('n', 'gr', vim.lsp.buf.references, bufopts)
map('n', 'g0', vim.lsp.buf.document_symbol, bufopts)
map('n', 'gW', vim.lsp.buf.workspace_symbol, bufopts)
map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
map('n', 'gl', vim.diagnostic.open_float, bufopts)
map('n', '[d', vim.diagnostic.goto_prev, bufopts)
map('n', ']d', vim.diagnostic.goto_next, bufopts)
map('n', '<leader>td', vim.lsp.buf.type_definition, bufopts)
map('n', '<leader>ca', ':FzfLua lsp_code_actions<CR>', bufopts)
map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
map('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)

map('n', '<leader>f', conform_fmt, bufopts)
map('v', '<leader>f', ':Format<CR>', bufopts) -- conform custom `:Format`
-- map('v', '<leader>f', conform_fmt, bufopts)

-- =============================================================================
-- Searching

map('n', '<C-f>', utils.search_in_place)
map('v', '<C-f>', utils.search_in_place)
map('x', '*', utils.search_in_place)


-- ============================================================================
-- FZF

map('n', '<Leader>d', fzf_user.open_fzf_buffers)
map('n', '<Leader>hh', fzf_user.open_fzf_files)
