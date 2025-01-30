local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path,
        })
        vim.cmd([[packadd packer.nvim]])
        return true
    end

    return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }

    -- Session

    use {
        'rmagatti/auto-session',
        config = function()
            require('auto-session').setup {
                log_level = 'error',
                suppress_dirs = { '~/', '~/projects', '~/Downloads', '/' },
            }
        end,
        pre_save_cmds = {
            function()
                require('neo-tree').close('filesystem')
            end,
            function()
                vim.cmd.normal({ ':DiffviewClose<CR>', bang = true })
            end,
        },
        cwd_change_handling = {
            post_cwd_changed_hook = function()
                require('lualine').refresh()
            end,
        },
    }

    -- Colorscheme

    use { 'catppuccin/nvim', as = 'catppuccin' }
    use { 'nyoom-engineering/oxocarbon.nvim' }
    use { 'folke/tokyonight.nvim' }
    use { 'marko-cerovac/material.nvim' }

    -- UI

    use 'nvim-tree/nvim-web-devicons'
    use { 'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use { 'lukas-reineke/indent-blankline.nvim', }

    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
        },
        config = function()
            vim.keymap.set('n', '<C-b>', ':Neotree toggle action=show<CR>', { silent = true })

            require("neo-tree").setup({
                filesystem = {
                    follow_current_file = {
                        enabled = true,
                        leave_dirs_open = true,
                    },
                },
            })
        end
    }

    use {
        'luukvbaal/statuscol.nvim',
        config = function()
            local builtin = require('statuscol.builtin')

            require('statuscol').setup({
                relculright = true,
                ft_ignore = { 'neo-tree', 'neotree', 'DiffviewFiles' },
                segments = {
                    {
                        sign = {
                            namespace = { 'diagnostic/signs' }
                        },
                        click = 'v:lua.ScSa'
                    },
                    {
                        text = { builtin.lnumfunc, ' ' },
                        click = 'v:lua.ScLa',
                    },
                    {
                        sign = { namespace = { 'gitsigns' } },
                        click = 'v:lua.ScSa'
                    },
                }
            })
        end
    }

    -- FZF

    use { 'ibhagwan/fzf-lua',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    -- Docs

    use {
        'toppair/peek.nvim',
        run = 'deno task --quiet build:fast',
        config = function()
            require('peek').setup()
            vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
            vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
        end,
    }

    -- LSP

    use 'neovim/nvim-lspconfig'
    use 'folke/neodev.nvim'
    use {
        'pmizio/typescript-tools.nvim',
        requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
        config = function()
            require('typescript-tools').setup {
                settings = {
                    tsserver_plugins = {
                        '@vue/typescript-plugin',
                    },
                },
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
            }
        end,
    }

    -- Rust

    use 'simrat39/rust-tools.nvim'
    use 'mfussenegger/nvim-dap'

    -- Completion

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- Completion - Snippets

    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- Treesitter

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }

    -- Git

    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }
    use 'lewis6991/gitsigns.nvim'

    -- Utils

    use { 'nvim-lua/plenary.nvim' }
    use { 'nvimtools/none-ls.nvim' }
    use {
        'kylechui/nvim-surround',
        tag = '*', -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use { 'windwp/nvim-ts-autotag' }
    use { 'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup {}
        end
    }

    use { 'https://gitlab.com/schrieveslaach/sonarlint.nvim' }

    use 'JoosepAlviste/nvim-ts-context-commentstring'

    use {
        'Exafunction/codeium.vim',
        config = function()
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
            vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
        end
    }
    if packer_bootstrap then
        require('packer').sync()
    end
end)
