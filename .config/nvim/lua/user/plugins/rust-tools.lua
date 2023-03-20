local lsp_user = require('user/plugins/lsp')
local rust_tools = require('rust-tools')
local map = vim.keymap.set

rust_tools.setup({
    server = {
        on_attach = function(client, bufnr)
            lsp_user.on_attach(client, bufnr)
            local bufopts = { buffer = bufnr }

            map('n', '<leader>ch', rust_tools.hover_actions.hover_actions, bufopts)
            map('n', '<Leader>ca', rust_tools.code_action_group.code_action_group, bufopts)
        end,
    },
    tools = {
        -- TODO: remove when issues/309 is fixed
        inlay_hints = {
            auto = false
        }
    }
})
