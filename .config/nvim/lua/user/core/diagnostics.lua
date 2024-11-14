local icons = {
    s = '◼',
    c = '⏺',
    t = '▲',
}

vim.diagnostic.config({
    float = {
        focusable = false,
        prefix = function(diagnostic)
            if diagnostic.code ~= nil then
                return string.format('(%s) ', type(diagnostic.code) == 'number'
                    and diagnostic.source
                    or diagnostic.code
                )
            else
                return string.format('(%s) ', diagnostic.source)
            end
        end
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.s,
            [vim.diagnostic.severity.WARN] = icons.t,
            [vim.diagnostic.severity.HINT] = icons.c,
            [vim.diagnostic.severity.INFO] = icons.c,
        },
    },
})
