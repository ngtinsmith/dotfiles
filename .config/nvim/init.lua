-- # Modules

require('user/plugins')
require('user/colors')
require('user/keymaps')
require('user/core/autocmd')
require('user/core/options')

-- # Dotfiles
-- used for diffview.nvim
-- TODO: find how to set in bare repo

vim.env.GIT_WORK_TREE = vim.fn.expand('~')
vim.env.GIT_DIR = vim.fn.expand('~/.cfg')

