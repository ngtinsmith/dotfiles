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
nnoremap <silent> <Leader>sp :vs<CR>

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

" Commenting
vmap <Leader>cc <Plug>Commentary
nmap <Leader>cc <Plug>CommentaryLine<CR>

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

" ==============================================================================
" Defaults

" Hybrid line number
set relativenumber number

" Tabs
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=0

set autoindent copyindent
set ignorecase smartcase
set noshowmode
set showmatch
set hidden
set splitright
set splitbelow
set cmdheight=1
set shortmess+=c
set signcolumn=yes
set nofoldenable
set clipboard=unnamedplus

set redrawtime=8000
" set regexpengine=1

" Native autocomplete
set completeopt=menuone,noinsert

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

" ==============================================================================
" Plugins

call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'drewtempelmeyer/palenight.vim'
Plug 'kaicataldo/material.vim'
Plug 'flrnprz/plastic.vim'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'franbach/miramare'
Plug 'bluz71/vim-moonfly-colors'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'tomasiser/vim-code-dark'

" Session
Plug 'tpope/vim-obsession'

" Search and Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vifm/vifm.vim'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'

" Completion and Linting
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'

" Snippets
Plug 'honza/vim-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Utils
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tmsvg/pear-tree'

Plug 'lukas-reineke/format.nvim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Statusline
Plug 'itchyny/lightline.vim'

call plug#end()

" ==============================================================================
" Themes - Colorschemes

" True colors
set termguicolors
set background=dark

" augroup FgOverride
"     autocmd!
"     autocmd ColorScheme * highlight
"         \ Normal cterm=NONE ctermbg=17 gui=NONE guifg=#ffffff
" augroup END

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank
        \ { higroup='IncSearch', timeout=150 }
augroup END

" Theme: Palenight
let g:palenight_terminal_italics = 1

" Theme: Material
" Variants: [
"   default, palenight, ocean, lighter, darker
"   (default|palenight|ocean|lighter|darker)-community ]
let g:material_terminal_italics = 1
let g:material_theme_style = 'default'

" Colorschemes: [
"   palenight, material, dracula, gruvbox, codedark, moonfly, nightfly
"   jellybeans, nord, onedark, one, embark, miramare ]
colorscheme embark

" Indent Markers
let g:indentLine_char = '⎸'

" Overrides
hi Normal       guibg=NONE ctermbg=NONE
hi SignColumn   guibg=NONE ctermbg=NONE
hi LineNr       guibg=NONE ctermbg=NONE
hi CursorLineNr guibg=NONE ctermbg=NONE

" ==============================================================================
" Themes - Statusline

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

" ==============================================================================
" Nvim LSP

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" LSP Configs
lua <<EOF
    local lsp = require'lspconfig'
    local util = require 'lspconfig/util'

    lsp.cssls.setup {}
    lsp.tsserver.setup {}
    lsp.vimls.setup {}
    lsp.vuels.setup {
        settings = {
            vetur = {
                format = {
                    defaultFormatter = {
                        html = "none",
                        js = "prettier",
                    }
                },
                validation = {
                    template = true,
                    script = true,
                    style = true,
                },
                experimental = {
                    templateInterpolationService = false
                },
            }
        },
        root_dir = util.root_pattern("header.php", "package.json", "style.css")
    }
    lsp.intelephense.setup {
        cmd = { "./node_modules/.bin/intelephense", "--stdio" },
        settings = {
            intelephense = {
                stubs = {
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
                    "wordpress",
                }
            }
        },
        root_dir = util.root_pattern(".git", "docker-compose.yml", "robots.txt")
    }
EOF

" ==============================================================================
" Completion

" Use completion-nvim in every buffer
augroup Completion
    autocmd!
    autocmd BufEnter * lua require'completion'.on_attach()
augroup END

let g:completion_matching_strategy_list = ['exact', 'fuzzy', 'substring']
let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_sorting = "none"
let g:completion_matching_ignore_case = 1
let g:completion_chain_complete_list = {
    \   'default': {
    \     'default': [
    \       {'complete_items': ['lsp', 'snippet', 'buffers']},
    \       {'mode': '<c-p>'},
    \       {'mode': '<c-n>'}],
    \     'comment': [
    \       {'complete_items': ['buffers']}],
    \     'string': [
    \       {'complete_items': ['path']}],
    \   }
    \ }

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ==============================================================================
" Linting (ALE)

let b:ale_disable_lsp = 1
let g:ale_completion_enabled = 0
let g:ale_sign_error = '■'
let g:ale_sign_warning = '●'

" let g:ale_fix_on_save = 1
let g:ale_fixers = { 'vue': ['eslint'] }
let g:ale_linters_explicit = 1
let g:ale_linters = {
    \   'javascript': ['eslint', 'tsserver'],
    \   'vue': ['eslint', 'vls'],
    \   'php': ['php', 'langserver']
    \ }
    " \   'php': ['php', 'langserver', 'intelephense']
let g:ale_php_langserver_executable = $HOME.'/.config/composer/vendor/bin/php-language-server.php'
let g:ale_php_langserver_use_global = 1
" let g:ale_php_intelephense_use_global = 0
" let g:ale_php_intelephense_executable = './node_modules/.bin/intelephense'
" let g:ale_php_intelephense_config = { 'stubs': [ 'wordpress' ], 'files': { 'associations': ['*.php'] }, 'trace': { 'server': 'verbose' } }

" ==============================================================================
" Formatting

" TODO fix runtime error when starting Vim session with a non *.vue file
"      `../nvim/runtime/lua/vim/lsp/buf.lua:142: attempt to index a nil value`
"      [active bug]: https://github.com/neovim/neovim/issues/12865
" TODO check for tsserver LSP update with support for ...buf.formatting_sync()
"       { ...`FormattinOptions` } param

" Vue formatter via Vetur formatter config
autocmd BufWritePre *.vue call FormatVue()
function FormatVue()
    " (1) - prettier fmt via Vetur config
    lua vim.lsp.buf.formatting_sync(nil, 1000)
    " (2) - eslint --fix
    FormatWrite
endfunction

augroup Format
    autocmd!
    autocmd BufWritePre *.js FormatWrite
augroup END

lua <<EOF
    require "format".setup {
        ["*"] = {
            { cmd = {"sed -i 's/[ \t]*$//'"} } -- remove trailing whitespace
        },
        vue = {
            { cmd = { "./node_modules/.bin/eslint --fix" } }
        },
        javascript = {
            { cmd = {"prettier -w"} }
        },
    }
EOF

" ==============================================================================
" Syntax

" Native Vim embedded syntax highlighting
let g:vimsyn_embed = 'l'

" Polyglot - vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" Polyglot - vim-vue
" Options: ['detect_on_enter', 'scss', []]
let g:vue_pre_processors = ['scss']

" ==============================================================================
" Markdown

let g:markdown_fenced_languages = [
    \  'html', 'css', 'sass', 'scss', 'javascript', 'js=javascript',
    \  'typescript', 'php', 'vim', 'yaml', 'python', 'bash=sh' ]

" Polyglot - vim-json
let g:vim_json_conceal = 0
let g:vim_json_syntax_conceal = 0

" Polyglot - vim-markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" ==============================================================================
" FZF
"
" <M-j> down
" <M-k> up

let g:fzf_preview_window = 'right:40%'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'yoffset': 0.85 } }

nnoremap <silent> <Leader>d     :Buffers<CR>
nnoremap <silent> <Leader>bd    :BufMultiDel<CR>
nnoremap <silent> <Leader>hh    :Files<CR>

" Hide status line
if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif

" ==============================================================================
" FZF - Custom Commands

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
  \ call fzf#vim#files($HOME, {
  \   'options': [
  \     '--prompt', "Files: [HOME]: ",
  \     '--reverse',
  \     '--inline-info',
  \   ]
  \ }, <bang>0)

" ==============================================================================
" FZF - Files command generator
" project array = g:tbl_projects[] (defined in my custom plugin
" ~/.config/nvim/plugin/myplugin.vim)

" (1) - `Project` command with custom directory `n` as arg
"
" :Project 0 (primary)
" :Project 1 (addt'l)
" :Project n (addt'l ...n)

command! -bang -nargs=1 Project
  \ call fzf#vim#files(g:tbl_projects[<q-args>]['path'], {
  \   'options': [
  \     '--prompt', '[Files > '. g:tbl_projects[<q-args>]['label'] .']: ',
  \     '--reverse',
  \     '--inline-info',
  \   ]
  \ }, <bang>0)

function s:FZFDefineFilesCmd() abort
    for i in range(0, len(g:tbl_projects))
        if (i == 0) 
            " index 0 = HOME - so we skip it
            continue
        elseif (i == 1)
            " index 1 = PRIMARY so we map it to <C-p>
            execute 'nnoremap <silent> <C-p> :Project ' . i . '<CR>'
        else
            " Map reference projects to <Leader>p{n}
            execute 'nnoremap <silent> <Leader>p'. (i-1) .' :Project '. (i-1) .'<CR>'
        endif
    endfor
endfunction

" (2) - Generate remaps on enter
augroup FZFFilesCmd
    autocmd!
    " autocmd VimEnter * call s:FZFDefineFilesCmd() | call s:MapRgFileContents()
    autocmd VimEnter * call s:FZFDefineFilesCmd() 
augroup END

" function! s:FZFCommands() abort
"     s:FZFDefineFilesCmd()
"     s:MapRgFileContents()
" endfunction

" FZF RG2

command! -bang -nargs=? RgFileContents
    \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g ". g:tbl_projects[<args>[0]]['ignore'] .' '.shellescape(<args>[1]), 1, {
    \   'dir': g:tbl_projects[<args>[0]]['path'],
    \   'options': ['--reverse', '--inline-info', '--height', '20%']
    \ }, <bang>0)

function! s:MapRgFileContents() abort
    for i in range(0, len(g:tbl_projects) - 1)
        if (i == 0) 
            " index 0 = HOME - so we skip it
            execute 'nnoremap <silent> <Leader>rh :RgFileContents [' . i . ', ""]'
            execute 'vnoremap <silent> <Leader>rh y \| :RgFileContents [' . i . ', "<C-r>""]'
        elseif (i == 1)
            " index 1 = PRIMARY so we map it to <C-p>
            execute 'nnoremap <silent> <C-p> :Project ' . (i-1) . '<CR>'
        else
            " Map reference projects to <Leader>p{n}
            execute 'nnoremap <silent> <Leader>p' . (i-1) . ' :Project ' . (i-1) . '<CR>'
        endif
    endfor
endfunction

" ==============================================================================
" FZF - search files contents (via ripgrep)

nnoremap <Leader>rp :RgProjectContents
vnoremap <Leader>rp y \| :RgProjectContents <C-r>"
nnoremap <Leader>rh :RgFileContentsHome
vnoremap <Leader>rh y \| :RgFileContentsHome <C-r>"

" File Contents => Project [project_root]
command! -bang -nargs=* RgProjectContents
    \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g " .g:user_proj_ign_0. ' '.shellescape(<q-args>), 1, {
    \   'dir': g:user_proj_0,
    \   'options': ['--reverse', '--inline-info', '--height', '20%']
    \ }, <bang>0)

" File Contents => Home [home]
command! -bang -nargs=* RgFileContentsHome
    \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden -g " .g:user_home_ign. ' '.shellescape(<q-args>), 1, {
    \   'dir': '~',
    \   'options': ['--reverse', '--inline-info']
    \ }, <bang>0)

" ==============================================================================
" FZF - Search file contents - custom projects

nnoremap <Leader>r1 :RgProjectContents1
vnoremap <Leader>r1 y \| :RgProjectContents1 <C-r>"
nnoremap <Leader>r2 :RgProjectContents2
vnoremap <Leader>r2 y \| :RgProjectContents2 <C-r>"
nnoremap <Leader>r3 :RgProjectContents3
vnoremap <Leader>r3 y \| :RgProjectContents3 <C-r>"

command! -bang -nargs=* RgProjectContents1
    \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g " .g:user_proj_ign_1. ' '.shellescape(<q-args>), 1, {
    \   'dir': g:user_proj_1,
    \   'options': ['--reverse', '--inline-info', '--height', '20%']
    \ }, <bang>0)

command! -bang -nargs=* RgProjectContents2
    \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g " .g:user_proj_ign_2. ' '.shellescape(<q-args>), 1, {
    \   'dir': g:user_proj_2,
    \   'options': ['--reverse', '--inline-info', '--height', '20%']
    \ }, <bang>0)

command! -bang -nargs=* RgProjectContents3
    \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g " .g:user_proj_ign_3. ' '.shellescape(<q-args>), 1, {
    \   'dir': g:user_proj_3,
    \   'options': ['--reverse', '--inline-info', '--height', '20%']
    \ }, <bang>0)

" ==============================================================================
" FZF - Delete Buffers
"
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

" ==============================================================================
" Quick Search - star(*)

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

" EOF
