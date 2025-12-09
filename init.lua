-- default Leader is \
vim.g.mapleader = ' '

vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/mfussenegger/nvim-lint' },
  { src = 'https://github.com/stevearc/conform.nvim' },
})

require('tokyonight').setup({
  on_highlights = function(hl, c)
    hl.WinSeparator = {
      fg = c.blue,
      bold = true,
    }
  end,
})
vim.cmd('colorscheme tokyonight-storm')

require('washbin.treesitter')

require('mini.pairs').setup()

require('mini.notify').setup()
vim.notify = require('mini.notify').make_notify()

require('mini.icons').setup()
MiniIcons.tweak_lsp_kind() -- for icons in mini.completion

require('mini.statusline').setup()
require('mini.cmdline').setup()

require('washbin.conform')
require('washbin.nvim-lint')
require('washbin.mini-completion')

require('washbin.mini-files')
require('washbin.mini-diff')

require('washbin.mini-pick')
require('washbin.mini-clue')
