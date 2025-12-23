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

require('config.mini.files')
require('config.mini.diff')

require('config.mini.pick')
require('config.mini.clue')
