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

" Quickfix List
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen 50
    else
        cclose
    endif
endfunction

nnoremap <silent> <leader>q :call ToggleQuickFix()<CR>
nnoremap <silent> <C-j> :cprev<CR>
nnoremap <silent> <C-k> :cnext<CR>

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

call plug#begin('~/.vim/plugged')

" Session
Plug 'tpope/vim-obsession'

" Search and Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vifm/vifm.vim'

" Completion and Linting
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" Snippets
Plug 'honza/vim-snippets'
Plug 'hrsh7th/vim-vsnip'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Helpers
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'

" Format
Plug 'lukas-reineke/format.nvim'
Plug 'mhartington/formatter.nvim'

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

call plug#end()

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
colorscheme material

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

" TODO organize as lua conf

lua <<EOF

    -- Colorizer

    require 'colorizer'.setup {
        'scss';
        'css';
        'javascript';
        'vim';
    }

    -- QuickFix List

    do
        local method = "textDocument/publishDiagnostics"
        local default_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, method, result, client_id, bufnr, config)
            default_handler(err, method, result, client_id, bufnr, config)
            local diagnostics = vim.lsp.diagnostic.get_all()
            local qflist = {}
            for bufnr, diagnostic in pairs(diagnostics) do
                for _, d in ipairs(diagnostic) do
                  d.bufnr = bufnr
                  d.lnum = d.range.start.line + 1
                  d.col = d.range.start.character + 1
                  d.text = d.message
                  table.insert(qflist, d)
                end
            end
            vim.lsp.util.set_qflist(qflist)
        end
    end

    -- Completion (compe)

    require'compe'.setup {
        enabled = true;
        autocomplete = true;
        debug = false;
        min_length = 1;
        preselect = 'always';
        throttle_time = 80;
        source_timeout = 200;
        resolve_timeout = 800;
        incomplete_delay = 400;
        max_abbr_width = 100;
        max_kind_width = 100;
        max_menu_width = 100;
        documentation = {
          border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
          winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
          max_width = 120,
          min_width = 60,
          max_height = math.floor(vim.o.lines * 0.3),
          min_height = 1,
        };

        source = {
          path = true;
          buffer = true;
          calc = true;
          nvim_lsp = true;
          nvim_lua = true;
          vsnip = true;
          ultisnips = true;
          luasnip = true;
        };
    }

    -- Use (s-)tab to:
    --- move to prev/next item in completion menuone
    --- jump to prev/next snippet's placeholder

    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local check_back_space = function()
        local col = vim.fn.col('.') - 1
        if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            return true
        else
            return false
        end
    end

    _G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t "<C-n>"
        elseif vim.fn.call("vsnip#available", {1}) == 1 then
            return t "<Plug>(vsnip-expand-or-jump)"
        elseif check_back_space() then
            return t "<Tab>"
        else
            return vim.fn['compe#complete']()
        end
    end

    _G.s_tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t "<C-p>"
        elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
            return t "<Plug>(vsnip-jump-prev)"
        else
            return t "<S-Tab>"
        end
    end

    vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
    vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
    vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
    vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

    -- LSP Snippets

    local capabilities = vim.lsp.protocol.make_client_capabilities()
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

    -- skip it, if you use another global object
    _G.MUtils= {}

    vim.g.completion_confirm_key = ""
    MUtils.completion_confirm=function()
        if vim.fn.pumvisible() ~= 0  then
            if vim.fn.complete_info()["selected"] ~= -1 then
                return vim.fn["compe#confirm"](npairs.esc("<cr>"))
            else
                return npairs.esc("<cr>")
            end
        else
            return npairs.autopairs_cr()
        end
    end

    remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

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

    -- LSP

    local lsp = require'lspconfig'
    local util = require 'lspconfig/util'

    lsp.cssls.setup {
        capabilities = capabilities,
    }

    lsp.tsserver.setup {
        capabilities = capabilities,
    }

    lsp.vimls.setup {
        capabilities = capabilities,
    }

    lsp.vuels.setup {
        on_attach = function(client)
            --[[
                # Enable Vetur's special *.vue formatter

                This line below is required if you:
                - want to format using Nvim's native `vim.lsp.buf.formatting**()`
                - want to use Vetur's formatting config in `settings.vetur.format {...}`
                - want to defer to eslint(_d) to fix only the <template> using eslint-fix
            --]]
            client.resolved_capabilities.document_formatting = true

            -- TODO: fix sync blocking on format
            vim.api.nvim_exec([[
                augroup VueFmt
                    autocmd!
                    autocmd BufWritePre *.vue lua vim.lsp.buf.formatting_sync(nil, 1000)
                augroup END
            ]], true)
        end,
        capabilities = capabilities,
        settings = {
            vetur = {
                completion = {
                    autoImport = true,
                    useScaffoldSnippets = true
                },
                format = {
                    defaultFormatter = {
                        html = "none",
                        js = "prettier",
                        ts = "prettier",
                    }
                },
                validation = {
                    template = true,
                    script = true,
                    style = true,
                    templateProps = true,
                    interpolation = true
                },
                experimental = {
                    templateInterpolationService = true
                }
            }
        },
        root_dir = util.root_pattern("header.php", "package.json", "style.css", 'webpack.config.js')
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
let g:indent_blankline_char = '▏'
let g:indent_blankline_space_char = ' '

" Linting (ALE)
" ==============================================================================

let b:ale_disable_lsp = 1
let g:ale_completion_enabled = 0
let g:ale_sign_error = '■'
let g:ale_sign_warning = '●'

let g:ale_fix_on_save = 1
let g:ale_fixers = { 'vue': ['eslint'] }

let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_typescript_eslint_executable = 'eslint_d'
let g:ale_vue_eslint_executable = 'eslint_d'

let g:ale_linters_explicit = 1
let g:ale_linters = {
    \   'typescript': ['eslint', 'tsserver'],
    \   'javascript': ['eslint', 'tsserver'],
    \   'vue': ['eslint', 'vls'],
    \   'php': ['php']
    \ }

" Formatting
" ==============================================================================

" Vue formatter via Vetur formatter config

" Prettier doesn't support mixed HTML/PHP so we just use this instead
nnoremap <silent> <leader>fs <cmd>lua vim.lsp.buf.formatting_sync(nil, 1000)<CR>:w<CR>
nnoremap <silent> <leader>fw :FormatWrite<CR>:w<CR>

" TODO: move to ftplugin
" TODO: find *.md formatter
augroup FileTypeTextwidth
	autocmd!
	autocmd FileType markdown set textwidth=80
augroup END

lua <<EOF
    local filetypes = {}
    local prettier_filetypes = {
        'javascript',
        'typescript',
        'scss',
        'css',
        'html',
    }
    local prettier_formatter = function()
        return {
            exe = "prettier",
            args = {
                '--stdin-filepath',
                vim.api.nvim_buf_get_name(0),
            },
            stdin = true
        }
    end
    
    for i, ft in ipairs(prettier_filetypes) do
        filetypes[ft] = { prettier_formatter }
    end

    require('formatter').setup({
        logging = false,
        filetype = filetypes
    })
EOF

augroup WebFmt
    autocmd!
    autocmd BufWritePre *.js,*.ts,*.html FormatWrite
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

function! SearchFileContents(fullscreen, project, k='') abort
    let path = g:tbl_projects[a:project]['path']
    let label = g:tbl_projects[a:project]['label']
    let ignore = g:tbl_projects[a:project]['ignore']
    let search_keyword = empty(a:k) ? '' : a:k

    let rg_ignore = '-g ' . ignore
    let rg_command = 'rg --column --line-number --no-heading --color=always --smart-case --hidden ' .rg_ignore. ' -- %s || true'

    let initial_command = printf(rg_command, shellescape(search_keyword))
    let reload_command = printf(rg_command, '{q}')
    echom initial_command

    let spec = {
        \ 'source': initial_command,
        \ 'dir': path,
        \ 'options': [
        \   '--reverse',
        \   '--inline-info',
        \   '--prompt', path. ' ',
        \   '--query', search_keyword,
        \   '--bind', 'change:reload:'.reload_command
        \ ]}

    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction


" TODO: Find 'DRY'er solution to this remap

nnoremap <Leader>rh :ProjectContents home<CR>
vnoremap <Leader>rh y \| :ProjectContents home <C-r>=escape('<C-r>"', ' \{}[]()')<CR>

nnoremap <Leader>r1 :ProjectContents nest<CR>
vnoremap <Leader>r1 y \| :ProjectContents nest <C-r>=escape('<C-r>"', ' \{}[]()')<CR>

nnoremap <Leader>r2 :ProjectContents tsreddit<CR>
vnoremap <Leader>r2 y \| :ProjectContents tsreddit <C-r>=escape('<C-r>"', ' \{}[]()')<CR>

nnoremap <Leader>r3 :ProjectContents ergonode<CR>
vnoremap <Leader>r3 y \| :ProjectContents ergonode <C-r>=escape('<C-r>"', ' \{}[]()')<CR>

nnoremap <Leader>r4 :ProjectContents directus<CR>
vnoremap <Leader>r4 y \| :ProjectContents directus <C-r>=escape('<C-r>"', ' \{}[]()')<CR>

" <C-r><C-r>a
let @b='"Vim''s quote handling is a little tricky"'

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
