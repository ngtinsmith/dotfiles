require('neodev').setup({})

local lspconfig = require('lspconfig')
local cmp = require('cmp_nvim_lsp')
local capabilities = cmp.default_capabilities()

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

local M = {}

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
    volar = {
        -- Vue 3
    },
    vimls = {},
    lua_ls = {
        cmd = { lua_ls_cmd },
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
                        quote_style = 'double',
                        keep_one_space_between_table_and_bracket = 'true',
                    },
                },
            },
        },
    },
    -- vuels = {
    --     -- Vue 2
    --     on_attach = function(client)
    --         --[[
    --             # Enable Vetur's special *.vue formatter

    --             This line below is required if you:
    --             - want to format using Nvim's native `vim.lsp.buf.formatting**()`
    --             - want to use Vetur's formatting config in `settings.vetur.format {...}`
    --             - want to defer to eslint(_d) to fix only the <template> using eslint-fix
    --         --]]
    --         client.resolved_capabilities.document_formatting = true

    --         -- TODO: fix sync blocking on format
    --         vim.api.nvim_exec([[
    --             augroup VueFmt
    --                 autocmd!
    --                 autocmd BufWritePre *.vue lua vim.lsp.buf.formatting_sync(nil, 1000)
    --             augroup END
    --         ]], true)
    --     end,
    --     capabilities = capabilities,
    --     settings = {
    --         vetur = {
    --             completion = {
    --                 autoImport = true,
    --                 useScaffoldSnippets = true
    --             },
    --             format = {
    --                 defaultFormatter = {
    --                     html = 'none',
    --                     js = 'prettier',
    --                     ts = 'prettier',
    --                 },
    --                 scriptInitialIndent = true,
    --                 styleInitialIndent = true
    --             },
    --             validation = {
    --                 template = true,
    --                 script = true,
    --                 style = true,
    --                 templateProps = true,
    --                 interpolation = true
    --             },
    --             -- experimental = {
    --             --     templateInterpolationService = true
    --             -- }
    --         }
    --     },
    --     root_dir = lspconfig.util.root_pattern("header.php", "package.json", "style.css", 'webpack.config.js')
    -- },
}

-- =============================================================================
-- LSP Hooks

M.on_attach = function(client)
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    if client.server_capabilities.renameProvider then
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { silent = true })
    end
end


local create_default_config = function()
    return {
        capabilities = capabilities,
        on_attach = M.on_attach
    }
end

-- =============================================================================
-- Setup Servers

for server, config in pairs(servers) do
    local _config = vim.tbl_deep_extend('force', config, create_default_config())

    lspconfig[server].setup(_config)
end

return M
