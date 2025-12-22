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

require('mini.pairs').setup()

require('mini.notify').setup()
vim.notify = require('mini.notify').make_notify()

require('mini.icons').setup()
MiniIcons.tweak_lsp_kind() -- for icons in mini.completion
require('mini.completion').setup()

require('mini.statusline').setup()
require('mini.cmdline').setup()

require('mini.ai').setup()
require('mini.surround').setup()

require('config.conform')
require('config.nvim-lint')

require('config.mini-files')
require('config.mini-diff')

require('config.mini-pick')
require('config.mini-clue')
