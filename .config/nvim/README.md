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
            │   ├── diagnostics.lua
            │   └── options.lua
            ├── plugins
            │   ├── cmp.lua
            │   ├── fzf.lua
            │   ├── init.lua
            │   ├── lsp.lua
            │   ├── lualine.lua
            │   ├── neo-tree.lua
            │   ├── null-ls.lua
            │   ├── packer.lua
            │   ├── rust-tools.lua
            │   └── treesitter.lua
            └── projects
                ├── commands.lua
                ├── config.lua
                └── keymaps.lua
