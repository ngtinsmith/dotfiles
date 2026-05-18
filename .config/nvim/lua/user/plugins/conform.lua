require('conform').setup({
    formatters_by_ft = {
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        vue = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        json = { 'prettier' },
        svg = { 'prettier_svg' },
    },
    formatters = {
        prettier_svg = {
            command = 'prettier',
            args = function(_, ctx)
                return { '--parser', 'html', '--stdin-filepath', ctx.filename }
            end,
            stdin = true,
        },
    },
    default_format_opts = {
        lsp_format = 'fallback',
    },
})

vim.api.nvim_create_user_command('Format', function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, end_line:len() },
        }
    end
    require('conform').format({ async = true, lsp_format = 'fallback', range = range })
end, { range = true })
