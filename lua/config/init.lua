-- Configure external packages

require('tokyonight').setup({
  on_highlights = function(hl, c)
    hl.WinSeparator = {
      fg = c.blue,
      bold = true,
    }
  end,
})
vim.cmd('colorscheme tokyonight-storm')

require('config.treesitter')
require('config.conform')
require('config.nvim-lint')
require('config.mini')
