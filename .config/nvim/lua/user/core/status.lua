local M = {}
_G.Status = M

---@return {name:string, text:string, texthl:string}[]
function M.get_signs()
  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  return vim.tbl_map(function(sign)
    return vim.fn.sign_getdefined(sign.name)[1]
  end, vim.fn.sign_getplaced(buf, { group = '*', lnum = vim.v.lnum })[1].signs)
end

function M.column()
  local sign, git_sign
  for _, s in ipairs(M.get_signs()) do
    if s.name:find('GitSign') then
      git_sign = s
    else
      sign = s
    end
  end
  local components = {
    sign and ('%#' .. sign.texthl .. '#' .. sign.text .. '%*') or ' ',
    [[%=]],
    [[%{&nu?(&rnu&&v:relnum?v:relnum:v:lnum):''} ]],
    git_sign and ('%#' .. git_sign.texthl .. '#' .. git_sign.text .. '%*') or '  ',
  }
  return table.concat(components, '')
end

-- [END] GitSign Reddit: [Gist] Statuscolumn: Separate Diagnostics and Gitsigns

-- vim.opt.numberwidth = 4
-- vim.opt.statuscolumn = '%=%{v:relnum?v:relnum:v:lnum} %s'
-- vim.opt.statuscolumn = [[%!v:lua.Status.column()]]
-- vim.opt.statuscolumn = [[%!v:lua.get_statuscol()]]
-- vim.opt.statuscolumn = '%#LineNr#%=%{v:lnum==line(".")?"":v:lnum}%#CursorLineNr#%{v:lnum==line(".")?v:lnum:""}%## '
-- vim.opt.statuscolumn = '%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . " " : v:lnum) : ""}%=%s'

return M

-- vim.notify('status.lua loaded', vim.log.levels.INFO)
