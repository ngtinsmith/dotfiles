require('nvim-treesitter').setup {
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    ensure_installed = {
        'css', 'graphql', 'html', 'javascript',
        'lua', 'php', 'scss', 'svelte', 'tsx',
        'typescript', 'vue',
    },
}

require('nvim-treesitter-textobjects').setup {
    select = {
        enable = true,
        lookahead = true,
        keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
        },
        selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
            ['@class.outer'] = '<c-v>',
        },
        include_surrounding_whitespace = true,
    },
    swap = {
        enable = true,
        swap_next = {
            ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
            ['<leader>A'] = '@parameter.inner',
        },
    },
}
