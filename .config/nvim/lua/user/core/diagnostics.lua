local icons = {
    square = '◼', -- U+25FC
    circle = '●', -- U+25CB
    triangle = '▲', -- U+25B2
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
            [vim.diagnostic.severity.ERROR] = icons.square,
            [vim.diagnostic.severity.WARN] = icons.triangle,
            [vim.diagnostic.severity.HINT] = icons.circle,
            [vim.diagnostic.severity.INFO] = icons.circle,
        },
    },
})
