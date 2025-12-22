-- Credit: Mahesh C. Regmi (Handsome Devops 20XX)
local M = {}

function M.toggle()
  local t = vim.t
  if t.zoomed then
    vim.cmd(t.zoom_winrestcmd)
    t.zoomed = false
  else
    t.zoom_winrestcmd = vim.fn.winrestcmd()
    vim.cmd('resize')
    vim.cmd('vertical resize')
    t.zoomed = true
  end
end

return M
