-- User Command
-- vim.api.nvim_create_user_command({name}, {command}, {opts})
vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', { desc = 'Source local vimrc' })

vim.api.nvim_create_user_command(
  'H',
  function(opts) vim.cmd('tab help ' .. opts.args) end,
  { nargs = 1, complete = 'help', desc = 'Open help but in new tab' }
)

vim.api.nvim_create_user_command(
  'M',
  function(opts) vim.cmd('tab Man ' .. opts.args) end,
  { nargs = '+', complete = 'shellcmd', desc = 'Open Man but in new tab' }
)
