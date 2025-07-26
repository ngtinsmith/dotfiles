local tab_width = 4

-- Sign/LineNr Column
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs
vim.opt.expandtab = true
vim.opt.tabstop = tab_width
vim.opt.softtabstop = tab_width
vim.opt.shiftwidth = tab_width
vim.opt.softtabstop = 0

-- Text
vim.opt.copyindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true

-- Window
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.shortmess:append('c')
vim.opt.laststatus = 3
vim.opt.signcolumn = 'number'
vim.opt.clipboard = 'unnamedplus'

-- Native autocomplete
vim.opt.completeopt = { 'menuone', 'noselect' }

-- time out for key codes
-- wait up to 1000 ms after Esc for special key
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.listchars = 'tab:>-,trail:~,extends:>,precedes:<,space:.'

-- Sessions
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
