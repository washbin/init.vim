-- default Leader is \
vim.g.mapleader = ' '

vim.cmd('packadd nvim.undotree')
vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/mfussenegger/nvim-lint' },
  { src = 'https://github.com/stevearc/conform.nvim' },
})

require('config')
