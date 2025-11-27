vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>quit<CR>', { desc = 'Use q to close window' })
vim.cmd('wincmd L')
