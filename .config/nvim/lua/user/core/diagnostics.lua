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
    }
})
