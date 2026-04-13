-- Core

require('user/plugins')
require('user/colors')
require('user/keymaps')
require('user/core/autocmd')
require('user/core/options')
require('user/core/diagnostics')
require('user/core/status')

-- Projects

require('user/projects/keymaps').setup()
require('user/projects/commands')
