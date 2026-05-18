require('auto-session').setup({
    log_level = 'error',
    suppress_dirs = { '~/', '~/projects', '~/Downloads', '/' },
    pre_save_cmds = {
        function()
            require('neo-tree').close('filesystem')
        end,
        function()
            vim.cmd.normal({ ':DiffviewClose<CR>', bang = true })
        end,
    },
    cwd_change_handling = {
        post_cwd_changed_hook = function()
            require('lualine').refresh()
        end,
    },
})
