-- Auto Command
-- vim.api.nvim_create_autocmd({event}, {opts})

local user_cmds = vim.api.nvim_create_augroup('user_cmds', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'man' },
  group = user_cmds,
  desc = 'Use q to close the window',
  command = 'nnoremap <buffer> q <cmd>quit<cr>',
})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = user_cmds,
  desc = 'Highlight on yank',
  callback = function(event) vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 }) end,
})

local cursorline = vim.api.nvim_create_augroup('cursorline', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  group = cursorline,
  desc = 'Set cursor line on entering a window',
  callback = function(event) vim.cmd('setlocal cursorline') end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  group = cursorline,
  desc = 'Remove cursorline when leaving window',
  callback = function(event) vim.cmd('setlocal nocursorline') end,
})
