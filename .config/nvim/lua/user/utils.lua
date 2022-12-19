local M = {}

-- ============================================================================
-- Helpers

function M.reload_init()
    vim.cmd('so ~/.config/nvim/init.lua')
    vim.notify('Nvim configuration reloaded!', vim.log.levels.INFO)
end

function M.vcount_navigate(direction)
    return vim.v.count == 0 and ('g' .. direction) or direction
end

-- =============================================================================
-- Builtins - Search

-- Search without jump on:
--
-- 1) cword -- or
-- 2) visual selection
--
-- origin: http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
function M.search_in_place()
    local word = vim.fn.expand('<cword>')

    if vim.fn.mode() == 'v' then
        -- Note: feedkeys() and getreg() execution behavior
        --
        -- Using feedkeys() with only {mode} = 'n' causes the "previous"ly yanked
        -- value to be returned after running getreg() instead of the "latest"
        -- yank (making it seem like an async exec order), adding 'x'
        -- flag aligns the expected execution behavior
        --
        -- link: https://github.com/neovim/neovim/issues/13781
        -- link: https://vi.stackexchange.com/questions/24367/unexpected-behavior-with-feedkeys
        vim.api.nvim_feedkeys('"vy', 'nx', true)
        word = vim.fn.getreg('v')
    end

    vim.fn.setreg('/', string.format('%s', word))
    vim.opt.hlsearch = true
end

return M
