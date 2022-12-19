local lspconfig = require('lspconfig')
local cmp = require('cmp_nvim_lsp')

require('neodev').setup({})

-- =============================================================================
-- Enable borders for hover/signature help

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = 'rounded' }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help, { border = 'rounded' }
)

-- =============================================================================
-- LSP Servers

local servers = {
    cssls = {},
    tsserver = {},
    vimls = {},
    volar = {},
    rust_analyzer = {},
    sumneko_lua = {
        cmd = { vim.fn.fnamemodify('~/lua-language-server/bin/lua-language-server', ':p') },
        filetypes = { 'lua' },
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    globals = { 'vim' },
                    neededFileStatus = {
                        ['codestyle-check'] = 'Any'
                    }
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
                format = {
                    enable = true,
                    defaultConfig = {
                        indent_style = 'space',
                        indent_size = '4',
                        quote_style = 'single',
                        keep_one_space_between_table_and_bracket = 'true',
                    },
                },
            },
        },
    },
}

-- =============================================================================
-- LSP Hooks

local create_default_config = function()
    local capabilities = cmp.default_capabilities()
    local on_attach = function(client, bufnr)
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        if client.supports_method('textDocument/formatting') then
            local lsp_formatting = vim.api.nvim_create_augroup('LspFormatting', {})

            vim.api.nvim_clear_autocmds({ group = lsp_formatting, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
                desc = 'Auto-format current buffer on (before) save',
                group = lsp_formatting,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end

        if client.server_capabilities.renameProvider then
            vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { silent = true })
        end
    end

    return {
        capabilities = capabilities,
        on_attach = on_attach
    }
end

-- =============================================================================
-- Setup Servers

for server, config in pairs(servers) do
    local _config = vim.tbl_deep_extend('force', config, create_default_config())

    lspconfig[server].setup(_config)
end
