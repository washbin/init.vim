require('mini.diff').setup({
  view = {
    style = 'number',
  },
})

vim.keymap.set('n', '<Leader>t', MiniDiff.toggle_overlay, { desc = 'MiniDiff overlay' })
