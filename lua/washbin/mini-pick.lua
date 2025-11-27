require('mini.pick').setup()

vim.keymap.set('n', '<Leader>ff', '<Cmd>Pick files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<Leader>fg', '<Cmd>Pick grep_live<CR>', { desc = 'Live Grep' })
vim.keymap.set('n', '<Leader>fb', '<Cmd>Pick buffers<CR>', { desc = 'Find buffers' })
vim.keymap.set('n', '<Leader>fh', '<Cmd>Pick help<CR>', { desc = 'Find help' })
