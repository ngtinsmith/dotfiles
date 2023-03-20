require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Session

    use { 'rmagatti/auto-session',
        config = function()
            require('auto-session').setup {
                log_level = 'error',
                auto_session_suppress_dirs = { '~/', '~/projects', '~/Downloads', '/' },
            }
        end,
        pre_save_cmds = {
            function()
                print('pre save cmds')
            end,
            function()
                require('neo-tree').close('filesystem')
            end
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

    use { 'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use { 'lukas-reineke/indent-blankline.nvim', }

    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
            {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                's1n7ax/nvim-window-picker',
                tag = 'v1.*',
                config = function()
                    require 'window-picker'.setup({
                        autoselect_one = true,
                        include_current = false,
                        filter_rules = {
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },

                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { 'terminal', 'quickfix' },
                            },
                        },
                        other_win_hl_color = '#e35e4f',
                    })
                end,
            }
        }
    }

    -- FZF

    use { 'ibhagwan/fzf-lua',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    -- Docs

    use({ 'iamcco/markdown-preview.nvim',
        run = 'cd app && npm install',
        setup = function() vim.g.mkdp_filetypes = { 'markdown' } end,
        ft = { 'markdown' }
    })

    -- LSP

    use 'neovim/nvim-lspconfig'
    use 'folke/neodev.nvim'

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

    -- Utils

    use { 'nvim-lua/plenary.nvim' }
    use { 'jose-elias-alvarez/null-ls.nvim' }
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
end)
