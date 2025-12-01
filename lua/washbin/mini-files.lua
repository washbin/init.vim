require('mini.files').setup()

local minifiles_toggle = function(...)
  if not MiniFiles.close() then MiniFiles.open(...) end
end

vim.keymap.set('n', '<Leader>e', minifiles_toggle, { desc = 'Toggle MiniFiles' })
vim.keymap.set(
  'n',
  '<Leader>l',
  function() minifiles_toggle(vim.api.nvim_buf_get_name(0)) end,
  { desc = 'lookup current directory in minifiles' }
)
