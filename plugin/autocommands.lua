-- Auto Command
-- vim.api.nvim_create_autocmd({event}, {opts})

local user_ui_group = vim.api.nvim_create_augroup('UserUI', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = user_ui_group,
  desc = 'Highlight on yank',
  callback = function() vim.hl.on_yank({ higroup = 'Visual', timeout = 200 }) end,
})

vim.api.nvim_create_autocmd('WinLeave', {
  group = user_ui_group,
  desc = 'Show absolute number when leaving window',
  callback = function()
    if vim.wo.relativenumber then vim.wo.relativenumber = false end
  end,
})

vim.api.nvim_create_autocmd('WinEnter', {
  group = user_ui_group,
  desc = 'Show hybrid number when entering window',
  callback = function()
    if vim.wo.number then vim.wo.relativenumber = true end
  end,
})

vim.api.nvim_create_autocmd('WinEnter', {
  group = user_ui_group,
  desc = 'Set cursor line on entering a window',
  callback = function() vim.wo.cursorline = true end,
})

vim.api.nvim_create_autocmd('WinLeave', {
  group = user_ui_group,
  desc = 'Remove cursorline when leaving window',
  callback = function() vim.wo.cursorline = false end,
})
