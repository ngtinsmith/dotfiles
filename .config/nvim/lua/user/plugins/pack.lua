local gh = function(repo)
    return 'https://github.com/' .. repo
end

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        if name == 'peek.nvim' and (kind == 'install' or kind == 'update') then
            vim.system({ 'deno', 'task', '--quiet', 'build:fast' }, { cwd = ev.data.path }):wait()
        end

        if name == 'nvim-treesitter' and kind == 'install' then
            vim.cmd.packadd('nvim-treesitter')
            vim.cmd.TSUpdate()
        end
    end,
})

vim.pack.add({
    gh('nvim-lua/plenary.nvim'),
    gh('nvim-tree/nvim-web-devicons'),
    gh('MunifTanjim/nui.nvim'),

    gh('rmagatti/auto-session'),

    { src = gh('catppuccin/nvim'), name = 'catppuccin' },
    gh('nyoom-engineering/oxocarbon.nvim'),
    gh('folke/tokyonight.nvim'),
    gh('marko-cerovac/material.nvim'),

    gh('nvim-lualine/lualine.nvim'),
    gh('lukas-reineke/indent-blankline.nvim'),

    { src = gh('nvim-neo-tree/neo-tree.nvim'), version = 'v3.x' },
    gh('luukvbaal/statuscol.nvim'),

    gh('ibhagwan/fzf-lua'),

    gh('toppair/peek.nvim'),

    gh('neovim/nvim-lspconfig'),
    gh('folke/neodev.nvim'),
    gh('pmizio/typescript-tools.nvim'),

    gh('hrsh7th/cmp-nvim-lsp'),
    gh('hrsh7th/cmp-buffer'),
    gh('hrsh7th/cmp-path'),
    gh('hrsh7th/cmp-cmdline'),
    gh('hrsh7th/nvim-cmp'),
    gh('hrsh7th/cmp-vsnip'),
    gh('hrsh7th/vim-vsnip'),

    { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },
    { src = gh('nvim-treesitter/nvim-treesitter-textobjects'), version = 'main' },

    gh('sindrets/diffview.nvim'),
    gh('lewis6991/gitsigns.nvim'),

    gh('mfussenegger/nvim-lint'),
    gh('stevearc/conform.nvim'),
    gh('kylechui/nvim-surround'),
    gh('windwp/nvim-ts-autotag'),
    gh('windwp/nvim-autopairs'),
    gh('JoosepAlviste/nvim-ts-context-commentstring'),
}, { confirm = false })
