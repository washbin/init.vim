local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch',
    'stable',
    'https://github.com/echasnovski/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Safely execute immediately
now(function()
  vim.o.termguicolors = true
  vim.cmd('colorscheme randomhue')
end)
now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()
end)
now(function() require('mini.tabline').setup() end)
now(function() require('mini.statusline').setup() end)

-- Safely execute later
later(function() require('mini.pairs').setup() end)
later(function() require('mini.diff').setup() end)
later(function() require('mini.files').setup() end)
later(function() require('mini.completion').setup() end)
later(function()
  require('mini.pick').setup()
  vim.keymap.set('n', '<leader>ff', '<Cmd>Pick files<CR>', { desc = 'Find files in Telescope' })
  vim.keymap.set('n', '<leader>fg', '<Cmd>Pick grep_live<CR>', { desc = 'Grep in Telescope' })
  vim.keymap.set('n', '<leader>fb', '<Cmd>Pick buffers<CR>', { desc = 'Find buffers in Telescope' })
  vim.keymap.set('n', '<leader>fh', '<Cmd>Pick help<CR>', { desc = 'Find help in Telescope' })
end)
later(function() require('user.clue') end)

-- Use external plugins with `add()`
now(function()
  -- Add to current session (install if absent)
  add('nvim-tree/nvim-web-devicons')
  require('nvim-web-devicons').setup()
end)

now(function()
  -- Supply dependencies near target plugin
  add({ source = 'neovim/nvim-lspconfig', depends = { 'williamboman/mason.nvim' } })
  require('user.lsp')
end)

later(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    -- Use 'master' while monitoring updates in 'main'
    checkout = 'master',
    monitor = 'main',
    -- Perform action after every checkout
    hooks = {
      post_checkout = function() vim.cmd('TSUpdate') end,
    },
  })
  require('user.treesitter')
end)

later(function()
  add('github/copilot.vim')
  vim.api.nvim_exec([[
        " Copilot keybind
        imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
        let g:copilot_no_tab_map = v:true
        ]])
end)
