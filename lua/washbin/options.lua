vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
-- Set completeopt to have a better completion experience
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- disable netrw / For NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
