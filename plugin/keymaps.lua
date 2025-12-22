-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
vim.keymap.set('n', '<Leader>w', '<Cmd>write<CR>', { desc = 'Save' })
vim.keymap.set('n', '<Leader>a', ':keepjumps normal! ggVG<CR>', { desc = 'Select all' })

vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set({ 'n', 'x' }, '<Leader>p', '"+p', { desc = 'Paste from clipboard' })

vim.keymap.set({ 'n', 'x' }, 'x', '"_x', { desc = 'Delete without register' })
vim.keymap.set({ 'n', 'x' }, '<A-d>', '"_d', { desc = 'Delete without register' })
vim.keymap.set({ 'n', 'x' }, '<A-c>', '"_c', { desc = 'Change without register' })

vim.keymap.set('n', '<A-k>', '<Cmd>m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('n', '<A-j>', '<Cmd>m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })

vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

vim.keymap.set(
  'n',
  '<Leader>u',
  function()
    require('undotree').open({
      command = 'bo 30vnew',
    })
  end,
  { desc = 'Undotree' }
)

local terminal = require('washbin.float-term')
vim.keymap.set({ 'n', 't' }, '<C-t>', terminal.toggle, { desc = 'Floating terminal' })

local zoom = require('washbin.zoom')
vim.keymap.set('n', '<Leader>z', zoom.toggle, { desc = 'Zoom window' })
