vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 1 -- mimic number and relativenumber on same column

vim.o.ignorecase = true -- make search case insensitive
vim.o.smartcase = true -- make search case insensitive only on all low caps

vim.o.inccommand = 'split' -- show little split preview pane of live replacements

vim.o.breakindent = true -- indent to same pos after line wrap
vim.o.linebreak = true -- don't start wrapping in the middle of word

vim.o.tabstop = 2 -- view tab as ? spaces
vim.o.shiftwidth = 2 -- indent ? spaces on >> and <<
vim.o.expandtab = true -- expand tabs to appropriate spaces

vim.o.winborder = 'rounded' -- border style for floating windows

vim.o.laststatus = 3 -- 1 status line for all windows

vim.o.cursorline = true

vim.o.updatetime = 250 -- set for faster CursorHold event
