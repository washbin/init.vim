-- Auto Command
-- vim.api.nvim_create_autocmd({event}, {opts})

local user_cmds = vim.api.nvim_create_augroup('user_cmds', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = user_cmds,
  desc = 'Highlight on yank',
  callback = function(event) vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 }) end,
})

local numbertoggle = vim.api.nvim_create_augroup('numbertoggle', { clear = true })

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave', 'FocusLost' }, {
  group = numbertoggle,
  desc = 'Show absolute number when leaving window',
  callback = function(event)
    vim.opt_local.relativenumber = false
    vim.opt_local.number = true
  end,
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'FocusGained' }, {
  group = numbertoggle,
  desc = 'Show hybrid number when entering window',
  callback = function(event)
    vim.opt_local.relativenumber = true
    vim.opt_local.number = true
  end,
})

local cursorline = vim.api.nvim_create_augroup('cursorline', { clear = true })

vim.api.nvim_create_autocmd('WinEnter', {
  group = cursorline,
  desc = 'Set cursor line on entering a window',
  callback = function(event) vim.opt_local.cursorline = true end,
})

vim.api.nvim_create_autocmd('WinLeave', {
  group = cursorline,
  desc = 'Remove cursorline when leaving window',
  callback = function(event) vim.opt_local.cursorline = false end,
})
