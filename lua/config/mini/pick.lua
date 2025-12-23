require('mini.pick').setup()

vim.keymap.set('n', '<Leader>f', '<Cmd>Pick files<CR>', { desc = 'Files' })
vim.keymap.set('n', '<Leader>/', '<Cmd>Pick grep_live<CR>', { desc = 'Live Grep' })
vim.keymap.set('n', '<Leader>b', '<Cmd>Pick buffers<CR>', { desc = 'Buffers' })
vim.keymap.set('n', '<Leader>?', '<Cmd>Pick help<CR>', { desc = 'Help' })
