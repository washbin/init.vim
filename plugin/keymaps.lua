-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
vim.keymap.set('n', '<Leader>w', '<Cmd>write<CR>', { desc = 'Save' })

vim.keymap.set({ 'n', 'x' }, 'cp', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set({ 'n', 'x' }, 'cv', '"+p', { desc = 'Paste from clipboard' })
vim.keymap.set({ 'n', 'x' }, 'x', '"_x', { desc = 'delete without register' })
vim.keymap.set('n', '<Leader>a', ':keepjumps normal! ggVG<CR>', { desc = 'Select all' })

vim.keymap.set('n', '<A-k>', '<Cmd>m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('n', '<A-j>', '<Cmd>m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('v', '<A-k>', "<Cmd>m '<-2<CR>gv=gv", { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', "<Cmd>m '>+1<CR>gv=gv", { desc = 'Move line down' })

vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, { desc = 'show diagnostic in floating win' })
