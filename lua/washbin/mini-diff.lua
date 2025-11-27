require('mini.diff').setup()

vim.keymap.set('n', '<Leader>t', MiniDiff.toggle_overlay, { desc = 'Toggle diff overlay' })
