-- TODO: replace with lazydev
require('neodev').setup({})

local cmp = require('cmp_nvim_lsp')
local capabilities = cmp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- =============================================================================
-- Enable borders for hover/signature help

vim.lsp.config('*', {
    capabilities = capabilities,
    -- This adds rounded borders to ALL floating windows (hover, signature, etc.)
    window = {
        hover = { border = 'rounded' },
        signature_help = { border = 'rounded' },
    },
})

-- =============================================================================
-- Keymaps

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        if client.server_capabilities.renameProvider then
            vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { buffer = args.buf, silent = true })
        end
    end,
})

-- =============================================================================
-- Servers

local uname = vim.loop.os_uname().sysname
local lua_ls_cmd = uname == 'Darwin'
    -- installed via brew
    and 'lua-language-server'
    -- built from source
    or vim.fn.fnamemodify('~/lua-language-server/bin/lua-language-server', ':p')

local servers = {
    cssls = {},
    tailwindcss = {},
    eslint = {},
    emmet_language_server = {},
    svelte = {},
    volar = {},
    vimls = {},
    lua_ls = {
        cmd = { lua_ls_cmd },
        filetypes = { 'lua' },
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = {
                    globals = { 'vim' },
                    neededFileStatus = { ['codestyle-check'] = 'Any' }
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                    -- help lua_ls find .editorconfig
                    userConfigSearch = true,
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
-- Setup Servers

for server, config in pairs(servers) do
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end
