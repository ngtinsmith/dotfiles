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
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
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
tnoremap kk <C-\><C-n>

" Suspend Vim to open full shell prompt (write fg in shell to put V into foreground)
nnoremap <Leader>sh :sus<CR>

" Git [vim-fugitive]
nnoremap <silent><nowait> <Leader>gs :G<CR> 

" Commenting
vmap <Leader>cc <Plug>Commentary
nmap <Leader>cc <Plug>CommentaryLine<CR>

" Quick vimrc refresh
nnoremap <Leader>sv :so ~/.vimrc<CR> <BAR> :echo '~/.vimrc reloaded'<CR>

" TODO: Fix unintended execution of other echo commands (flashing after echoing)
" nnoremap <silent> <Leader>rt :!tmux source-file %<CR>| :echom 'TMUXs reloaded'
" nnoremap <Leader>rt :!tmux source-file %<CR> | :echo '~/.tmux.conf reloaded'

" Filetypes
augroup bashalias
    autocmd BufRead,BufNewFile *.aliases set filetype=sh
augroup END


" ====================================================== */
" General Settings
" ====================================================== */

" Hybrid line number
set relativenumber number

" Tabs
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=0

" Some servers have issues with backup files, see #649 (COC)
set nobackup
set nowritebackup
set noswapfile

" Indents
set autoindent copyindent

" Search casing
set ignorecase smartcase

set noshowmode
set showmatch
set hidden
set splitright
set splitbelow
set clipboard=unnamedplus
    
" Nvim native autocomplete
set completeopt=menuone,noinsert

" time out for key codes
" wait up to 100ms after Esc for special key
set timeoutlen=1000 ttimeoutlen=0
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast

filetype plugin indent on


" ====================================================== */
" Plugins
" ====================================================== */

call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'ayu-theme/ayu-vim' 
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'drewtempelmeyer/palenight.vim'
Plug 'cocopon/iceberg.vim'
Plug 'kaicataldo/material.vim'
Plug 'flrnprz/plastic.vim'
Plug 'morhetz/gruvbox'

Plug 'nanotech/jellybeans.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'
Plug 'rakr/vim-one'
Plug 'chuling/ci_dark'

" Session
Plug 'tpope/vim-obsession'

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Syntax highlighting
Plug 'dense-analysis/ale'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'cakebaker/scss-syntax.vim'

" Search and List
Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'

" Code completion - COC
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'elzr/vim-json'

" Code completion - Native nvim-lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Snippets
" Plug 'mattn/emmet-vim'
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Utils
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tmsvg/pear-tree'
Plug 'elzr/vim-json'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Statusline
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

call plug#end()


" ====================================================== */
" Themes - Colorschemes
" ====================================================== */

" True colors
set termguicolors
set background=dark

augroup FgOverride
    autocmd!
    autocmd ColorScheme * highlight Normal cterm=NONE ctermbg=17 gui=NONE guifg=#ffffff
augroup END

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END

" Theme: Ayu
" Variants: [ light, dark, mirage ]
let ayucolor='mirage'

" Theme: Palenight
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
let g:palenight_terminal_italics = 1

" Theme: Material
" Variants: [
"   default, palenight, ocean, lighter, darker
"   default-community, palenight-community, ocean-community, lighter-community,
"   darker-community
" ]
let g:material_terminal_italics = 1
let g:material_theme_style = 'default'

" Colorschemes: [
"   ayu, dracula, palenight, iceberg, material, plastic, gruvbox,
"   jellybeans, nord, onedark, base16-default-dark, one, ci_dark,
" ]
colorscheme palenight

" Background transparency
hi Normal guibg=NONE ctermbg=NONE

" Gutter transparency
hi SignColumn guibg=NONE ctermbg=NONE 

" Vim cursor (for some terminals | pipe <==> block)
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Optional reset cursor on start:
augroup myCmds
    au!
    autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END


" ====================================================== */
" Themes - Statusline
" ====================================================== */

set laststatus=2
" TODO: component_function with node compiler hook

" Statuslines: [
"   ayu_dark, ayu_mirage, powerlineish, material_vim(req+theme),
"   wombat, deus, one, 16color, material, materia, palenight,
"   selenized_black(white, dark, light)
" ]
let g:lightline = {
    \   'colorscheme': 'deus',
    \   'active': {
    \     'left': [
    \       [ 'mode', 'paste' ],
    \       [ 'readonly', 'filename', 'modified' ],
    \       [ 'gitbranch' ] ],
    \     'right': [
    \       [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos',  'linter_ok' ],
    \       [ 'lineinfo' ],
    \       [ 'filetype' ],
    \       [ 'bufcounter'] ]
    \   },
    \   'inactive': {
    \     'left': [ [ 'filename', 'modified' ] ],
    \     'right': [ [ 'filetype' ] ],
    \   },
    \   'separator': {
    \     'left': '', 'right': '' 
    \   },
    \   'subseparator': {
    \     'left': '', 'right': ''
    \   },
    \   'component_function': {
    \     'readonly': 'LightlineReadonly',
    \     'gitbranch': 'LightlineFugitive',
    \     'bufcounter': 'BufferCounter'
    \   }
    \ }

let g:lightline.component_expand = {
  \   'linter_checking': 'lightline#ale#checking',
  \   'linter_infos': 'lightline#ale#infos',
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \   'linter_ok': 'lightline#ale#ok',
  \ }

let g:lightline.component_type = {
  \   'linter_checking': 'right',
  \   'linter_infos': 'right',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'right',
  \ }

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

function! BufferCounter()
    let bufcount = len(getbufinfo({'buflisted':1}))
    if (bufcount > 1)
        return 'b: ' .bufcount
    endif
    return ''
endfunction

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
    if exists('*FugitiveHead')
        let branch = FugitiveHead()
        return branch !=# '' ? ' '.branch : ''
    endif
    return ''
endfunction


" ====================================================== */
" Nvim LSP
" ====================================================== */

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>


" ====================================================== */
" Completion nvim
"
" @todo attach via loop
" ====================================================== */

lua <<EOF

    local lsp = require'nvim_lsp'

    lsp.vuels.setup{
        on_attach=require'completion'.on_attach
    }

    lsp.cssls.setup{
        on_attach=require'completion'.on_attach
    }

    lsp.tsserver.setup{
        on_attach=require'completion'.on_attach
    }

    lsp.vimls.setup{
        on_attach=require'completion'.on_attach
    }

EOF

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

" let g:completion_matching_strategy_list = ['exact', 'fuzzy']
let g:completion_trigger_on_delete = 1
let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_sorting = "none"
let g:completion_matching_ignore_case = 1
let g:completion_chain_complete_list = {
    \   'default' : {
    \     'default': [
    \       {'complete_items': ['lsp', 'snippet', 'buffers']},
    \       {'mode': '<c-p>'},
    \       {'mode': '<c-n>'}],
    \     'comment': [
    \       {'complete_items': ['buffers']}],
    \     'string': [],
    \   }
    \ }

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

imap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'
smap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'


" ====================================================== */
" Linting (ALE)
" ====================================================== */

let b:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
    \   'vue': [ 'prettier', 'eslint'],
    \   'javascript': ['prettier']
    \ }

let b:ale_linters = ['eslint', 'vls', 'tsserver']
let b:ale_linter_aliases = ['javascript', 'vue', 'typescript']


" ====================================================== */
" Syntax
" ====================================================== */

" Vim JavaScript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" Codeblock Folding
" augroup javascript_folding
"     au!
"     au FileType javascript setlocal foldmethod=syntax
" augroup END
set nofoldenable

" posva/vim-vue
" Options: ['detect_on_enter', 'scss', []]
let g:vue_pre_processors = ['scss']


" ====================================================== */
" COC
" ====================================================== */

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
 " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"     \ pumvisible() ? "\<C-n>" :
"     \ <SID>check_back_space() ? "\<TAB>" :
"     \ coc#refresh()
      
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
"     inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"     inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" nnoremap <silent> gh :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"     if (index(['vim','help'], &filetype) >= 0)
"         execute 'h '.expand('<cword>')
"     else
"         call CocAction('doHover')
"     endif
" endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>ld :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>le :<C-u>CocList extensions<cr>

" Plugin - Vetur (required workspace resolution)
nnoremap <Leader>lw :echo g:WorkspaceFolders<CR>


" ====================================================== */
" Markdown
"
" TODO: assess usage 
" ====================================================== */

" Vim Markdown
let g:vim_markdown_folding_disabled = 1 " disable header folding
let g:vim_markdown_conceal = 0 " do not use conceal feature, the implementation is not so good

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" Disable quote concealing in JSON files
let g:vim_json_conceal = 0
let g:vim_json_syntax_conceal = 0

" markdown fenced code block languages
let g:markdown_fenced_languages = [
    \ 'html', 'css', 'javascript', 'js=javascript',
    \ 'typescript', 'sass', 'php', 'vim', 'yaml', 'python', 'bash=sh'
    \ ]
let g:markdown_syntax_conceal = 0

" support front matter of various format
let g:vim_markdown_frontmatter = 1          " for YAML format
let g:vim_markdown_toml_frontmatter = 1     " for TOML format
let g:vim_markdown_json_frontmatter = 1     " for JSON format

" Pandoc
let g:pandoc#syntax#conceal#use = 0


" ====================================================== */
" FZF
"
" <M-j> down
" <M-k> up
" ====================================================== */

let g:fzf_preview_window = 'right:40%'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'yoffset': 0.85 } }

nnoremap <silent> <Leader>d     :Buffers<CR>
nnoremap <silent> <Leader>bd    :BufMultiDel<CR>
nnoremap <silent> <C-p>         :ProjectFiles<CR>
nnoremap <silent> <Leader>p1    :ProjectFiles1<CR>
nnoremap <silent> <Leader>p2    :ProjectFiles2<CR>
nnoremap <silent> <Leader>hh    :Files<CR>

" Hide status line
if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif


" ====================================================== */
" FZF - Custom Commands
"
" TODO: convert fzf calls to reusable functions
" ====================================================== */

" Cmd override [:Buffers]
command! -bang -nargs=0 Buffers
  \ call fzf#vim#buffers({
    \   'options': [
    \     '--reverse',
    \     '--inline-info',
    \     '--prompt', 'BUFFERS: ',
    \     '--pointer', '⯈'
    \   ]
  \ }, <bang>0)

" Cmd override [:Files]
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {
  \   'options': ['--reverse', '--inline-info']
  \ }, <bang>0)

" Search project files
command! -bang ProjectFiles
  \ call fzf#vim#files(g:usr_proj, {
  \   'options': ['--reverse', '--inline-info' ]
  \ }, <bang>0)

" Search project files
command! -bang ProjectFiles1
  \ call fzf#vim#files(g:usr_proj_1, {
  \   'options': ['--reverse', '--inline-info' ]
  \ }, <bang>0)

" Search project files
command! -bang ProjectFiles2
  \ call fzf#vim#files(g:usr_proj_2, {
  \   'options': ['--reverse', '--inline-info' ]
  \ }, <bang>0)


" ====================================================== */
" FZF - search files contents (via ripgrep)
" ====================================================== */

nnoremap <Leader>rp :RgProjectContents 
vnoremap <Leader>rp y \| :RgProjectContents <C-r>"

nnoremap <Leader>rh :RgFileContentsHome 
vnoremap <Leader>rh y \| :RgFileContentsHome <C-r>"

" File Contents => Project [project_root]
command! -bang -nargs=* RgProjectContents
    \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g " .g:usr_proj_ign. ' '.shellescape(<q-args>), 1, {
    \   'dir': g:usr_proj,
    \   'options': ['--reverse', '--inline-info', '--height', '20%']
    \ }, <bang>0)

" File Contents => Home [home]
command! -bang -nargs=* RgFileContentsHome
    \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden -g " .g:usr_home_ign. ' '.shellescape(<q-args>), 1, {
    \   'dir': '~',
    \   'options': ['--reverse', '--inline-info']
    \ }, <bang>0)


" ====================================================== */
" FZF - Search file contents - custom projects
" ====================================================== */

nnoremap <Leader>r1 :RgProjectContents1 
vnoremap <Leader>r1 y \| :RgProjectContents1 <C-r>"

nnoremap <Leader>r2 :RgProjectContents2 
vnoremap <Leader>r2 y \| :RgProjectContents2 <C-r>"

command! -bang -nargs=* RgProjectContents1
    \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g " .g:usr_proj_ign_1. ' '.shellescape(<q-args>), 1, {
    \   'dir': g:usr_proj_1,
    \   'options': ['--reverse', '--inline-info', '--height', '20%']
    \ }, <bang>0)

command! -bang -nargs=* RgProjectContents2
    \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g " .g:usr_proj_ign_2. ' '.shellescape(<q-args>), 1, {
    \   'dir': g:usr_proj_2,
    \   'options': ['--reverse', '--inline-info', '--height', '20%']
    \ }, <bang>0)


" ====================================================== */
" FZF - Delete Buffers
"
" <Tab> to select
" <CR>  to confirm / delete
" ====================================================== */

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


" ====================================================== */
" Search - via Visual Star(*) Search
"
" http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
" ====================================================== */

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

" recursively vimgrep for word under cursor or selection if you hit leader-star
if maparg('<leader>*', 'n') == ''
  nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
endif
if maparg('<leader>*', 'v') == ''
  vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>
endif

" EOF
