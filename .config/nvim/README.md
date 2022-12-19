# Structure

    tree --filesfirst -I plugin ~/.config/nvim

    ├── init.lua
    ├── README.md
    ├── after
    │   └── syntax
    │       └── php.vim
    └── lua
        └── user
            ├── colors.lua
            ├── keymaps.lua
            ├── utils.lua
            ├── core
            │   ├── autocmd.lua
            │   └── options.lua
            └── plugins
                ├── cmp.lua
                ├── fzf.lua
                ├── init.lua
                ├── lsp.lua
                ├── lualine.lua
                ├── null-ls.lua
                ├── packer.lua
                └── treesitter.lua

