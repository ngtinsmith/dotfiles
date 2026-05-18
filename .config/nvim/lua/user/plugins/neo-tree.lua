vim.keymap.set('n', '<C-b>', ':Neotree toggle action=show<CR>', { silent = true })

require('neo-tree').setup({
    filesystem = {
        follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
        },
    },
})
