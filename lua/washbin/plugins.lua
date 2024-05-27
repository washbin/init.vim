local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch',
    'main',
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
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()
end)
now(function() require('mini.tabline').setup() end)
now(function() require('mini.statusline').setup() end)

-- Safely execute later
later(function() require('mini.pairs').setup() end)
later(function()
  require('mini.pick').setup()
  vim.keymap.set('n', '<leader>ff', '<Cmd>Pick files<CR>', { desc = 'Find files' })
  vim.keymap.set('n', '<leader>fg', '<Cmd>Pick grep_live<CR>', { desc = 'Live Grep' })
  vim.keymap.set('n', '<leader>fb', '<Cmd>Pick buffers<CR>', { desc = 'Find buffers' })
  vim.keymap.set('n', '<leader>fh', '<Cmd>Pick help<CR>', { desc = 'Find help' })
end)
later(function() require('mini.diff').setup() end)
later(function() require('mini.completion').setup() end)
-- later(function() require('mini.indentscope').setup() end)
later(function() require('mini.files').setup() end)
later(function() require('washbin.clue') end)

-- Use external plugins with `add()`
now(function()
  vim.o.termguicolors = true
  add('folke/tokyonight.nvim')
  vim.cmd('colorscheme tokyonight')
end)

now(function()
  -- Add to current session (install if absent)
  add('nvim-tree/nvim-web-devicons')
  require('nvim-web-devicons').setup()
end)

now(function()
  add('neovim/nvim-lspconfig')
  require('washbin.lsp')
  require('washbin.servers')
end)

later(function()
  add('mfussenegger/nvim-lint')
  require('lint').linters_by_ft = {
    markdown = { 'vale' },
  }
  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    callback = function()
      -- try_lint without arguments runs the linters defined in `linters_by_ft`
      -- for the current filetype
      require('lint').try_lint()

      -- You can call `try_lint` with a linter name or a list of names to always
      -- run specific linters, independent of the `linters_by_ft` configuration
      require('lint').try_lint('cspell')
    end,
  })
end)
later(function()
  add('stevearc/conform.nvim')
  require('conform').setup({
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform will run multiple formatters sequentially
      python = { 'isort', 'black' },
      -- Use a sub-list to run only the first available formatter
      javascript = { { 'prettierd', 'prettier' } },
    },
  })
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function(args) require('conform').format({ bufnr = args.buf }) end,
  })
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
  require('washbin.treesitter')
end)

later(function()
  add('github/copilot.vim')
  vim.api.nvim_exec(
    [[
        " Copilot keybind
        imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
        let g:copilot_no_tab_map = v:true
        ]],
    false
  )
end)
