require('mini.files').setup()

local minifiles_toggle = function(...)
  if not MiniFiles.close() then MiniFiles.open(...) end
end

vim.keymap.set('n', '<Leader>e', minifiles_toggle, { desc = 'Toggle MiniFiles' })
