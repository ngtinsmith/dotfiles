require('catppuccin').setup({
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
})

require('tokyonight').setup({
    style = 'night', -- night. storm, day, moon
})

-- ============================================================================
-- Colorscheme

vim.opt.background = 'dark'
vim.g.material_style = 'palenight'

vim.cmd.colorscheme 'catppuccin'
