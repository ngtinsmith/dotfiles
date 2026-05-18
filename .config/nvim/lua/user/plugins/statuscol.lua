local builtin = require('statuscol.builtin')

require('statuscol').setup({
    relculright = true,
    ft_ignore = { 'neo-tree', 'neotree', 'DiffviewFiles' },
    segments = {
        {
            sign = {
                namespace = { 'diagnostic/signs' },
            },
            click = 'v:lua.ScSa',
        },
        {
            text = { builtin.lnumfunc, ' ' },
            click = 'v:lua.ScLa',
        },
        {
            sign = { namespace = { 'gitsigns' } },
            click = 'v:lua.ScSa',
        },
    },
})
