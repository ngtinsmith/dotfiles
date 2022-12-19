local nls = require('null-ls')
local nls_formatting = nls.builtins.formatting
local nls_diagnostics = nls.builtins.diagnostics


nls.setup({
    sources = {
        nls_formatting.prettierd.with({
            disabled_filetypes = { 'markdown' },
        }),
        nls_diagnostics.eslint_d,
    },
})
