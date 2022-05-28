let mapleader=' '

" Command Mode
nnoremap , :
vnoremap , :
nnoremap : ,
vnoremap : ,

" Navigation - Text
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
nnoremap Y y$
nnoremap <Leader>e %

" Navigation - Wrapped lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Navigation - Windows / Buffers
nnoremap <C-h> gT
nnoremap <C-l> gt
nnoremap <silent> <Leader><Tab> :b#<CR>

noremap <silent> <C-Up>    :res +1<CR>
noremap <silent> <C-Down>  :res -1<CR>
noremap <silent> <C-Left>  :vertical resize -5<CR>
noremap <silent> <C-Right> :vertical resize +5<CR>

" Tab shifting - (keep selection)
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Visually select function block
nnoremap <Leader>vf va{V

" Search - unset highlight from last search pattern onEnter (carriage return)
nnoremap <silent> <CR> :nohlsearch<CR>

" Integrated Terminal to Normal mode
tnoremap <C-k> <C-\><C-n>

" Suspend Vim to open full shell prompt (write fg in shell to put V into foreground)
nnoremap <Leader>sh :sus<CR>

" Git [vim-fugitive]
nnoremap <silent><nowait> <Leader>gs :G<CR>
nnoremap <silent><nowait> <Leader>gd :Git diff<CR>

" Commenting
vmap <Leader>cc <Plug>Commentary
nmap <Leader>cc <Plug>CommentaryLine<CR>

" Comment shortcut like in VSCode
" this works because vim register <C-/> as <C-_>
vmap <C-_> <Plug>Commentary<Bar>gv
nmap <C-_> <Plug>CommentaryLine

" Retain "p" register when pasting over a selection
vnoremap <leader>p "_dP

" Quick vimrc refresh
nnoremap <Leader>sv :so ~/.vimrc<CR> <BAR> :echom '~/.vimrc reloaded'<CR>

" TODO Fix implicit? echo commands (flashing after echoing)
" nnoremap <silent> <Leader>rt :!tmux source-file %<CR>| :echom 'TMUXs reloaded'
" nnoremap <Leader>rt :!tmux source-file %<CR> | :echo '~/.tmux.conf reloaded'

" Filetypes
augroup bashalias
    autocmd!
    autocmd BufRead,BufNewFile *.aliases set filetype=sh
augroup END

" Defaults
" ==============================================================================

" Sign/LineNr Column
set relativenumber number
set fillchars=vert:▏

" Tabs
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set softtabstop=0

" Text
set copyindent autoindent
set ignorecase smartcase
set noshowmode
set showmatch

" Window
set hidden
set splitright
set splitbelow
set cmdheight=1
set shortmess+=c
set signcolumn=yes
set nofoldenable
set clipboard=unnamedplus

" Native autocomplete
set completeopt=menuone,noselect

" time out for key codes
" wait up to 100ms after Esc for special key
set timeoutlen=1000 ttimeoutlen=0
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast

" Some servers have issues with backup files, see #649 (COC)
set nobackup
set noswapfile
set nowritebackup
set updatetime=300
set laststatus=2

filetype plugin indent on

" Plugins
" ==============================================================================

" if !exists('g:vscode')
call plug#begin('~/.vim/plugged')

" Session
Plug 'tpope/vim-obsession'

" Search and Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vifm/vifm.vim'

" Completion and Linting
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim' 
" Plug 'hrsh7th/nvim-compe'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'

" Snippets
Plug 'honza/vim-snippets'
Plug 'hrsh7th/vim-vsnip'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Diagnostics
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" UI
Plug 'itchyny/lightline.vim'
Plug 'lukas-reineke/indent-blankline.nvim'

" Colorschemes
Plug 'norcalli/nvim-colorizer.lua'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'drewtempelmeyer/palenight.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'bluz71/vim-moonfly-colors'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'mhartington/oceanic-next'
Plug 'folke/tokyonight.nvim'

Plug 'marko-cerovac/material.nvim'
Plug 'shaunsingh/moonlight.nvim'
Plug 'arzg/vim-substrata'

" Helpers
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'

call plug#end()
" endif

" Themes - Colorschemes
" ==============================================================================

set termguicolors
set background=dark

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank
        \ { higroup='IncSearch', timeout=150 }
augroup END

augroup ColorSchemeOverride
    autocmd!
    autocmd ColorScheme * call HLOverride()
augroup END

function! HLOverride() abort
    " Common Groups
    " hi Normal                                 guibg=NONE ctermbg=NONE
    " hi SignColumn                             guibg=NONE ctermbg=NONE
    " hi LineNr                                 guibg=NONE ctermbg=NONE
    " hi CursorLineNr                           guibg=NONE ctermbg=NONE
    " hi EndOfBuffer                            guibg=NONE ctermbg=NONE

    " UI
    " IndentLine: neutral-grey,
    " LineNr: [#6272A4, #676E95, #595E7B] }
    " hi IndentBlanklineChar                    guifg=#424450 ctermfg=238
    hi CursorLineNr                             guifg=#c0caf5 ctermfg=0
    hi LineNr                                   guifg=#595E7B
    
    " Material - palenight
    " Markdown: { green: #1abc9c, yellowTan: #ecc48d, purple: #AB47BC }
    hi Normal                                   guifg=#c9d1d9
    hi markdownCode                             guifg=#ecc48d
    hi markdownCodeDelimiter                    guifg=#ecc48d
    hi link markdownListMarker                  Comment

    " Dracula
    " hi Todo                                   cterm=bold guifg=#8BE9FD guibg=none gui=bold term=bold

    " TokyoNight
    " hi Todo                                   guibg=NONE ctermbg=NONE guifg=#e0af68 ctermfg=11 gui=bold term=bold
    " hi link ALEWarningSign                    Todo
    " hi link ALEStyleWarningSign               Todo

    " Embark
    " hi Todo                                   guibg=NONE ctermbg=NONE 
    " hi GitGutterAdd                           guibg=NONE ctermbg=NONE 
    " hi GitGutterDelete                        guibg=NONE ctermbg=NONE 
    " hi GitGutterChange                        guibg=NONE ctermbg=NONE 
    " hi GitGutterChangeDelete                  guibg=NONE ctermbg=NONE 
    " hi ALEErrorSign                           guibg=NONE ctermbg=NONE 
    " hi ALEWarningSign                         guibg=NONE ctermbg=NONE 
    " hi LspDiagnosticsDefaultHint              guibg=NONE ctermbg=NONE
    " hi LspDiagnosticsDefaultError             guibg=NONE ctermbg=NONE
    " hi LspDiagnosticsDefaultWarning           guibg=NONE ctermbg=NONE
    " hi LspDiagnosticsDefaultInformation       guibg=NONE ctermbg=NONE
    " hi LineNr                                 guifg=#6272A4 ctermfg=61 
endfunction

" Theme: Palenight
let g:palenight_terminal_italics = 1

" Theme: TokyoNight [storm, night, day]
let g:tokyonight_style = "night"
" let g:tokyonight_transparent = 1

" Theme: Material nvim
" ['darker', 'lighter', 'palenight', 'oceanic' and 'deep ocean', 'moonlight']
" nnoremap <C-m> :lua require('material.functions').toggle_style()<CR>

let g:material_style = 'palenight'  
let g:material_variable_color = '#c9d1d9' " #b0b7bf, #c9d1d9
let g:material_custom_colors = { 'accent': '#c9d1d9' }

" Colorschemes: [
"   palenight, dracula, moonfly, nightfly, material
"   nord, onedark, embark, OceanicNext, tokyonight, substrata ]

if !exists('g:vscode')
    colorscheme material
endif

" Themes - Statusline
" ==============================================================================

" TODO: component_function with node compiler hook

" Statuslines: [
"   powerlineish, material_vim(req+theme), embark
"   wombat, deus, one, 16color, material, materia, palenight,
"   selenized_black(white, dark, light) ]
let g:lightline = {
    \   'colorscheme': 'embark',
    \   'active': {
    \     'left': [
    \       [ 'mode', 'paste' ],
    \       [ 'readonly', 'filename', 'modified' ],
    \       [ 'gitbranch' ] ],
    \     'right': [
    \       [ 'lineinfo' ], [ 'filetype' ], [ 'bufcounter'] ]
    \   },
    \   'inactive': {
    \     'left': [ [ 'filename', 'modified' ] ],
    \     'right': [ [ 'filetype' ] ],
    \   },
    \   'separator': { 'left': '', 'right': '' },
    \   'subseparator': { 'left': '', 'right': '' },
    \   'component_function': {
    \     'readonly': 'LightlineReadonly',
    \     'gitbranch': 'LightlineFugitive',
    \     'bufcounter': 'BufferCounter',
    \   },
    \ }

function! BufferCounter()
    let bufcount = len(getbufinfo({ 'buflisted':1 }))
    return bufcount > 1
        \ ? 'b: ' . bufcount
        \ : ''
endfunction

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

function! LightlineFugitive() abort
    if exists('*FugitiveHead')
        " match 'lastSegment' from 'branchName/inBetween/lastSegment'
        let pattern = '\v[^\/]+(\?=\/$|$)'
        let head = FugitiveHead()
        let branchLastSegment = matchstr(head, pattern)

        return len(head) > 0 && len(branchLastSegment) is# 0
            \ ? ' ' . head
            \ : len(branchLastSegment) > 0
                \ ? ' ' . branchLastSegment
                \ : ''
    endif
    return ''
endfunction

" Nvim LSP
" ==============================================================================

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" Nvim Compe
" ==============================================================================

inoremap <silent><expr> <C-e>   compe#complete()
inoremap <silent><expr> <CR>    compe#confirm('<CR>')
inoremap <silent><expr> <C-f>   compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>   compe#scroll({ 'delta': -4 })

lua <<EOF

    -- Colorizer

    require 'colorizer'.setup {
        'scss';
        'css';
        'javascript';
        'vim';
    }

    local cmp = require'cmp'

    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        mapping = {
            ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-e>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            -- ['<C-e>'] = cmp.mapping({
            --     i = cmp.mapping.abort(),
            --     c = cmp.mapping.close(),
            -- }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif vim.fn["vsnip#available"](1) == 1 then
                    vim.fn.feedkeys(t('<Plug>(vsnip-expand-or-jump)', ''))
                else
                    fallback()
                end
            end, {
              "i",
              "s"
            }),
            ['<S-Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif vim.fn["vsnip#jumpable"](-1) then
                    vim.fn.feedkeys(t('<Plug>(vsnip-jump-prev)', ''))
                else
                    fallback()
                end
            end,
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
        }, {
           { name = 'buffer' },
        })
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })

    -- Setup CMP lspconfig

    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- LSP Snippets

    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        }
    }

    -- Nvim autopairs

    require('nvim-autopairs').setup()
    local remap = vim.api.nvim_set_keymap
    local npairs = require('nvim-autopairs')

    -- Treesitter

    -- TODO TS text-objects
    -- TODO select function
    -- TODO select object
    -- TODO incrementally expand selection

    require'nvim-treesitter.configs'.setup {
        highlight = {
            enable = true,
            -- disable = { 'scss' }
        },
        indent = {
            enable = true
        },
        autotag = {
            enable = true,
        },
        playground = {
            enable = false,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
            keybindings = {
                toggle_query_editor = 'o',
                toggle_hl_groups = 'i',
                toggle_injected_languages = 't',
                toggle_anonymous_nodes = 'a',
                toggle_language_display = 'I',
                focus_language = 'f',
                unfocus_language = 'F',
                update = 'R',
                goto_node = '<cr>',
                show_help = '?',
            },
        },
        query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = {"BufWrite", "CursorHold"},
        },
    }

    -- Diagnostics :: Native

    vim.diagnostic.config({
        float = {
            focusable = false,
            prefix = function(diagnostic)
                if diagnostic.code ~= nil then
                    return string.format('(%s) ', type(diagnostic.code) == 'number'
                        and diagnostic.source
                        or diagnostic.code
                    )
                else 
                    return string.format('(%s) ', diagnostic.source)
                end
            end
        }
    })

    vim.o.updatetime = 300
    vim.api.nvim_create_autocmd('CursorHold', {
        desc = 'Show floating inline diagnostic',
        callback = function()
            vim.diagnostic.open_float()
        end
    })

    local signs = { Error = "■ ", Warn = "● ", Hint = "● ", Info = "ⓘ " }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
    -- Diagnostics :: Trouble.nvim

    require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }

    vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>Trouble<cr>",
      {silent = true, noremap = true}
    )

    -- [Linting, Formatting] :: Null-ls

    local nls = require('null-ls')
    local nls_formatting = nls.builtins.formatting
    local nls_diagnostics = nls.builtins.diagnostics

    nls.setup({
        debug = true,
        on_attach = function(client)
            if client.resolved_capabilities.document_formatting then

                vim.api.nvim_create_augroup('lsp_formatting', {})

                vim.api.nvim_create_autocmd('BufWritePre', {
                    desc = 'Auto-format current buffer on (before) save',
                    group = 'lsp_formatting',
                    callback = function()
                        vim.lsp.buf.formatting_sync(nil, 1000)
                    end
                })
            end
        end,
        sources = {
            nls_formatting.prettierd.with({
                disabled_filetypes = { "markdown" },
            }),
            nls_diagnostics.eslint_d,
        },
    })

    vim.api.nvim_set_keymap("n", "<leader>fe", "mF:%!eslint_d --stdin --fix-to-stdout<CR>`F",
      {noremap = true, silent = true}
    )
    vim.api.nvim_set_keymap("v", "<leader>fe", ":!eslint_d --stdin --fix-to-stdout<CR>gv",
      {noremap = true, silent = true}
    )

    -- LSP

    local lsp = require'lspconfig'
    local util = require'lspconfig/util'

    -- TODO: fix on_attach highlight for JSON
    -- temporary fix: exclude `*.stories.ts` in tsconfig.json
    -- @see volar #568

    vim.api.nvim_create_augroup('lsp_document_highlight', {})

    vim.api.nvim_create_autocmd('CursorHold', {
        desc = 'LSP highlight symbol / references in view',
        group = 'lsp_document_highlight',
        callback = function()
            vim.lsp.buf.document_highlight()
        end
    })

    vim.api.nvim_create_autocmd('CursorMoved', {
        desc = 'LSP clear symbol / references highlight in view',
        group = 'lsp_document_highlight',
        callback = function()
            vim.lsp.buf.clear_references()
        end
    })

    lsp.cssls.setup {
        capabilities = capabilities,
    }

    lsp.tsserver.setup {
        capabilities = capabilities,
        on_attach = function(client)
            -- use null-ls instead
            client.resolved_capabilities.document_formatting = false
        end
    }

    lsp.vimls.setup {
        capabilities = capabilities,
    }

    local v_get_typescript_server_path = function(root_dir)
        local project_root = util.find_node_modules_ancestor(root_dir)

        local local_tsserverlib = project_root ~= nil and util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js')
        local global_tsserverlib = '/home/ng/.nvm/versions/node/v16.14.0/lib/node_modules/typescript/lib/tsserverlibrary.js'

        if local_tsserverlib and util.path.exists(local_tsserverlib) then
            return local_tsserverlib
        else
            return global_tsserverlib
        end
    end

    local v_on_new_config = function(new_config, new_root_dir)
        if
            new_config.init_options
            and new_config.init_options.typescript
            and new_config.init_options.typescript.serverPath == ''
        then
            new_config.init_options.typescript.serverPath = v_get_typescript_server_path(new_root_dir)
        end
    end

    local v_on_attach = function(client)
        -- use null-ls formatter instead
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end

    lsp.volar.setup {
        cmd = { "volar-server", "--stdio" },
        on_attach = v_on_attach,
        filetypes = { 'vue' },
        init_options = {
            languageFeatures = {
                callHierarchy = true,
                codeAction = true,
                codeLens = true,
                completion = {
                    defaultAttrNameCase = "kebabCase",
                    defaultTagNameCase = "both"
                },
                definition = true,
                diagnostics = true,
                documentHighlight = true,
                documentLink = true,
                hover = true,
                references = true,
                rename = true,
                renameFileRefactoring = true,
                schemaRequestService = true,
                semanticTokens = false,
                signatureHelp = true,
                typeDefinition = true
            },
            documentFeatures = {
                documentColor = true,
                documentFormatting = {
                    defaultPrintWidth = 80
                },
                documentSymbol = true,
                foldingRange = true,
                linkedEditingRange = true,
                selectionRange = true
            },
            typescript = {
                serverPath = ''
            }
        },
        settings = {
            volar = {
                codeLens = {
                  references = true,
                  pugTools = true,
                  scriptSetupTools = true,
                },
            }
        },
        on_new_config = on_new_config,
        root_dir = util.root_pattern('header.php', 'package.json', 'style.css', 'webpack.config.js')
    }

    lsp.intelephense.setup {
        capabilities = capabilities,
        settings = {
            intelephense = {
                stubs = {
                    -- Default stubs
                    -- TODO: move to lua table
                    "apache",
                    "bcmath",
                    "bz2",
                    "calendar",
                    "com_dotnet",
                    "Core",
                    "ctype",
                    "curl",
                    "date",
                    "dba",
                    "dom",
                    "enchant",
                    "exif",
                    "FFI",
                    "fileinfo",
                    "filter",
                    "fpm",
                    "ftp",
                    "gd",
                    "gettext",
                    "gmp",
                    "hash",
                    "iconv",
                    "imap",
                    "intl",
                    "json",
                    "ldap",
                    "libxml",
                    "mbstring",
                    "meta",
                    "mysqli",
                    "oci8",
                    "odbc",
                    "openssl",
                    "pcntl",
                    "pcre",
                    "PDO",
                    "pdo_ibm",
                    "pdo_mysql",
                    "pdo_pgsql",
                    "pdo_sqlite",
                    "pgsql",
                    "Phar",
                    "posix",
                    "pspell",
                    "readline",
                    "Reflection",
                    "session",
                    "shmop",
                    "SimpleXML",
                    "snmp",
                    "soap",
                    "sockets",
                    "sodium",
                    "SPL",
                    "sqlite3",
                    "standard",
                    "superglobals",
                    "sysvmsg",
                    "sysvsem",
                    "sysvshm",
                    "tidy",
                    "tokenizer",
                    "xml",
                    "xmlreader",
                    "xmlrpc",
                    "xmlwriter",
                    "xsl",
                    "Zend OPcache",
                    "zip",
                    "zlib",
                    
                    -- Custom stub
                    "wordpress",
                }
            }
        },
        root_dir = util.root_pattern(".git", "docker-compose.yml", "robots.txt", 'wp-config.php')
    }
EOF


" Indent Markers
" ==============================================================================

let g:indent_blankline_char = '▏'
let g:indent_blankline_space_char = ' '

" TODO: move to ftplugin
" TODO: find *.md formatter
augroup FileTypeTextwidth
	autocmd!
	autocmd FileType markdown set textwidth=80
augroup END


" Syntax
" ==============================================================================

" Native Vim embedded syntax highlighting
let g:vimsyn_embed = 'l'

" Polyglot - vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" Polyglot - vim-vue
" Options: ['detect_on_enter', 'scss', []]
let g:vue_pre_processors = ['scss']

" Markdown
" ==============================================================================

let g:markdown_fenced_languages = [
    \  'html', 'css', 'sass', 'scss', 'javascript', 'js=javascript',
    \  'typescript', 'php', 'vim', 'yaml', 'python', 'bash=sh' ]

" Polyglot - vim-json
let g:vim_json_conceal = 0
let g:vim_json_syntax_conceal = 0

" Polyglot - vim-markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" FZF
" ==============================================================================
"
" <C-p> up
" <C-n> down
" <Tab> select/deselect

let g:fzf_preview_window = 'right:40%'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.7, 'yoffset': 0.7 } }

nnoremap <silent> <Leader>d     :Buffers<CR>
nnoremap <silent> <Leader>bd    :BufMultiDel<CR>
nnoremap <silent> <Leader>hh    :Files<CR>

" Hide status line
if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif

" FZF - Custom Commands
" ==============================================================================

" Cmd override [:Buffers]
command! -bang -nargs=0 Buffers
  \ call fzf#vim#buffers({
  \   'options': [
  \     '--reverse',
  \     '--inline-info',
  \     '--prompt', 'BUFFERS: ',
  \     '--pointer', '⯈',
  \     '--tiebreak', 'length'
  \   ]
  \ }, <bang>0)

" Cmd override [:Files]
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(empty(<q-args>) ? $HOME : <q-args>, {
  \   'options': [
  \     '--prompt', empty(<q-args>) ? "Files: ~/ " : fnamemodify(<q-args>, ':p:~') . ' ',
  \     '--reverse',
  \     '--inline-info',
  \   ]
  \ }, <bang>0)

" FZF - Files command generator
" ==============================================================================
" g:tbl_projects - defined in my custom plugin @ ~/.config/nvim/plugin/user.vim
"
" :Project main
" :Project 1
" :Project 2
" :Project N

command! -nargs=* -bang -complete=dir Project call OpenProjectFile(<q-args>, <bang>0)
command! -nargs=* -bang -complete=dir ProjectContents call SearchFileContents(<bang>0, <f-args>)

function! OpenProjectFile(project, fullscreen)
    let path = g:tbl_projects[a:project]['path']
    let label = g:tbl_projects[a:project]['label']
    let ignore = g:tbl_projects[a:project]['ignore']

    let rg_path = '--files --hidden ' .path
    let rg_ignore = '--glob ' .ignore
    let rg_args = rg_ignore. ' ' .rg_path

    let command_fmt = 'rg --no-require-git ' .rg_args. ' -- %s || true'
    " TODO: use path as shellescape param
    let initial_command = printf(command_fmt, shellescape(a:project))
    let reload_command = printf(command_fmt, '{q}')

    let spec = {
        \ 'source': initial_command,
        \ 'dir': path,
        \ 'options': [
        \   '--with-nth', '-3..',
        \   '--reverse',
        \   '--inline-info',
        \   '--prompt', path. ' ',
        \   '--bind', 'change:reload:'.reload_command
        \ ]}

    call fzf#run(fzf#wrap(spec), a:fullscreen)
endfunction

function! SearchFileContents(fullscreen, project, keyword='') abort
    let path = g:tbl_projects[a:project]['path']
    let label = g:tbl_projects[a:project]['label']
    let ignore = g:tbl_projects[a:project]['ignore']
    let search_keyword = empty(a:keyword) ? '' : a:keyword

    let rg_ignore = '-g ' . ignore
    let rg_command = 'rg --column --line-number --no-heading --color=always --smart-case --hidden ' .rg_ignore. ' -- %s || true'

    let initial_command = printf(rg_command, shellescape(search_keyword))
    let reload_command = printf(rg_command, '{q}')
    echom initial_command

    let spec = {
        \ 'source': initial_command,
        \ 'dir': path,
        \ 'options': [
        \   '--phony',
        \   '--reverse',
        \   '--inline-info',
        \   '--prompt', path. ' ',
        \   '--query', search_keyword,
        \   '--bind', 'change:reload:'.reload_command
        \ ]}

    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction


" FZF - Delete Buffers
" ==============================================================================
" <Tab> to select
" <CR>  to confirm / delete

" Delete multiple buffers
command! BufMultiDel call fzf#run(fzf#wrap({
    \   'source': s:list_buffers(),
    \   'sink*': { lines -> s:delete_buffers(lines) },
    \   'options': [
    \     '--multi',
    \     '--bind', 'ctrl-a:select-all+accept',
    \     '--prompt', 'BUFFERS [DELETE]: ',
    \     '--marker', ' ✔',
    \     '--pointer', '=>'
    \   ]
    \ }))

function! s:list_buffers()
    redir => list
    silent ls
    redir END
    return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
    execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

" Quick Search - star(*)
" ==============================================================================

" Search visually selected (without jump using vim-visual-star-search)
nnoremap <silent> <C-f> viw:<C-u>call <SID>VSetSearch('/')<CR>:set hls<CR><Esc>

" Search func from visual-star-search
" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" With jump
" xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
" xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" Without jump
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>:set hls<CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>:set hls<CR>

" recursively vimgrep for word under cursor or selection if you hit leader-star
if maparg('<leader>*', 'n') == ''
  nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
endif
if maparg('<leader>*', 'v') == ''
  vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>
endif

" Insert date/time
nnoremap <F5> "=strftime("%c")<CR>p
inoremap <F5> <C-R>=strftime("%c")<CR>

" Rename symbol (YMMV on LSP support)
nnoremap <F2> <cmd>lua vim.lsp.buf.rename()<CR>



" EOF
